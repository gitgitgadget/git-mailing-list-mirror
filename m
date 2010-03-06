From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-http-backend: hook output not delivered to client
Date: Sat, 6 Mar 2010 14:30:31 -0800
Message-ID: <20100306223031.GG2529@spearce.org>
References: <3C07BFC0-BC5E-4901-A846-A337B5F1B8F4@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 23:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No2WF-0005DY-96
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 23:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab0CFWaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 17:30:35 -0500
Received: from mail-iw0-f202.google.com ([209.85.223.202]:56341 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab0CFWae (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 17:30:34 -0500
Received: by iwn40 with SMTP id 40so1282873iwn.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 14:30:34 -0800 (PST)
Received: by 10.231.161.143 with SMTP id r15mr162384ibx.62.1267914633951;
        Sat, 06 Mar 2010 14:30:33 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm2821695iwn.11.2010.03.06.14.30.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 14:30:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3C07BFC0-BC5E-4901-A846-A337B5F1B8F4@bjhargrave.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141623>

BJ Hargrave <bj@bjhargrave.com> wrote:
> I have compiled and installed git 1.7.0.1 on a RHEL4 box
... 
> So the push properly fails in both cases because the hook exits
> with a non-zero return code, but it seems there is a problem with
> git-http-backend not ferrying the hook output messages back to
> the client.

Yes, we know about this problem.

You need commit 466dbc42f5 ("receive-pack: Send internal errors over
side-band #2") on both the client and the server for hook messages
to work over HTTP.

This hasnt been released yet.  It is slated for 1.7.0.2.

-- 
Shawn.
