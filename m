From: Kevin Ballard <kevin@sb.org>
Subject: Spurious line insertion/deletion stats for binary file
Date: Tue, 12 Oct 2010 15:47:54 -0700
Message-ID: <8CFCE61F-591A-4B56-B701-D1A391FBB088@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 00:48:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ndd-0004Rd-Ek
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 00:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950Ab0JLWr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 18:47:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55204 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab0JLWr5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 18:47:57 -0400
Received: by pwi4 with SMTP id 4so55095pwi.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 15:47:56 -0700 (PDT)
Received: by 10.142.234.1 with SMTP id g1mr3924175wfh.332.1286923676779;
        Tue, 12 Oct 2010 15:47:56 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id t38sm10171802wfc.21.2010.10.12.15.47.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 15:47:56 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158887>

I just noticed something fairly odd when making a commit that changed a single binary file:

kevin> (develop +=)> git ci -m 'Replace binary file'
[develop c0c3b98] Replace binary file
 1 files changed, 8 insertions(+), 14 deletions(-)
 rewrite Resources/some_image.png (99%)

The commit results seem to be treating the binary file as text in order to give me insertion/deletion stats. This is quite obviously wrong. For this situation, a fairly simple solution would be to change that line to something like

 1 files changed, 2652 bytes removed

but the correct behavior is a bit less obvious when there are multiple files changed. Does anyone have a good suggestion for how to handle this case?

-Kevin Ballard