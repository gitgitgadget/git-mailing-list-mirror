From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] builtin-apply.c: Skip filenames without enough components
Date: Sun, 17 Jan 2010 03:44:34 +0100
Organization: SUSE Labs
Message-ID: <201001170344.34525.agruen@suse.de>
References: <201001170305.10793.agruen@suse.de> <7vr5ppa2st.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 03:47:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWLAy-0000rh-Nk
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 03:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab0AQCpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 21:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138Ab0AQCpQ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 21:45:16 -0500
Received: from cantor.suse.de ([195.135.220.2]:43609 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293Ab0AQCpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 21:45:14 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id A81C15362F;
	Sun, 17 Jan 2010 03:45:11 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vr5ppa2st.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137270>

On Sunday 17 January 2010 03:22:10 am Junio C Hamano wrote:
> Tests?

Sure if you think it's worth a regression test ... "git apply -p2" of the 
following patch fails with "fatal: git diff header lacks filename information 
when removing 2 leading pathname components (line 6)" with the fix, and 
creates b/f without:

	diff --git a/f b/f
	new file mode 100644
	index 0000000..6a69f92
	--- /dev/null
	+++ b/f
	@@ -0,0 +1 @@
	+f

(Some earlier versions of git failed with "fatal: git apply: bad git-diff - 
inconsistent new filename on line 5" in this case.)

Andreas
