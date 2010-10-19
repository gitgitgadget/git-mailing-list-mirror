From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG] git repack fails if .git/objects/pack is on a separate partition
Date: Tue, 19 Oct 2010 08:59:42 +0200
Message-ID: <201010190859.43098.trast@student.ethz.ch>
References: <1287469706023-5649732.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Oct 19 09:00:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P86BA-0007k7-Ml
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 09:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459Ab0JSHAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 03:00:04 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:6979 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758044Ab0JSHAD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 03:00:03 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 19 Oct
 2010 09:00:01 +0200
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 19 Oct
 2010 08:59:45 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc8-32-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1287469706023-5649732.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159308>

Marat Radchenko wrote:
> fatal: unable to rename temporary pack file: Invalid cross-device link
> error: failed to run repack
> 
> Reason:
> write_pack_file in builtin/pack-objects.c first writes tmp file in
> "pack/tmp_pack_XXXXXX". 

What's your git version?  Since 8b4eb6b (Do not perform
cross-directory renames when creating packs, 2008-09-22), which was
first released in 1.6.0.3 and 1.6.1, it should only create and rename
files within the pack/ subdirectory.  Which is what you are implying
in the above snippet, but this should never result in a cross-device
rename, so maybe I'm missing something.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
