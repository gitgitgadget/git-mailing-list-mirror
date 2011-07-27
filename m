From: "Theo Niessink" <theo@taletn.com>
Subject: Re: [PATCH] On Cygwin support both UNIX and DOS style path-names
Date: Wed, 27 Jul 2011 17:57:04 +0200
Message-ID: <FD5C22CB4AC2439D8151F6B7CD4B7CC9@martinic.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>, <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Jul 27 18:02:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6ZM-0007RZ-TX
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 18:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab1G0QCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 12:02:46 -0400
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:4448 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754724Ab1G0QCp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 12:02:45 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jul 2011 12:02:44 EDT
Received: from cpsps-ews23.kpnxchange.com ([10.94.84.189]) by cpsmtpb-ews01.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 27 Jul 2011 17:56:36 +0200
Received: from CPSMTPM-cmt107.kpnxchange.com ([195.121.3.23]) by cpsps-ews23.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Wed, 27 Jul 2011 17:56:36 +0200
Received: from pc0003 ([77.168.115.212]) by CPSMTPM-cmt107.kpnxchange.com with Microsoft SMTPSVC(7.0.6002.18264);
	 Wed, 27 Jul 2011 17:57:04 +0200
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcxMddSHIGr7ZFsvTKu2tGk3kMrQWw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
X-OriginalArrivalTime: 27 Jul 2011 15:57:04.0891 (UTC) FILETIME=[D49DFCB0:01CC4C75]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177981>

Pascal Obry wrote:
> In fact Cygwin supports both, so make Git agree with this.

Why not indeed, especially since both are already supported under MinGW.

> +#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
> +#define is_dir_sep(c) ((c) == '/' || (c) == '\\')

I think that by defining is_dir_sep you enable DOS/Windows style paths
throughout Git, so you might want to check compat/mingw.h for other, related
changes. You will probably at least want the MinGW version of
find_last_dir_sep as well, because the default find_last_dir_sep doesn't use
is_dir_sep.
