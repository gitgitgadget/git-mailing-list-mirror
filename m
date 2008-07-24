From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Preserve cwd in setup_git_directory()
Date: Thu, 24 Jul 2008 08:50:16 +0200
Message-ID: <48882628.7030305@viscovery.net>
References: <20080724031441.GA26072@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Geoff Russell <geoffrey.russell@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 08:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLufZ-0005ts-Pk
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 08:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbYGXGuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 02:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbYGXGuW
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 02:50:22 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12805 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYGXGuV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 02:50:21 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLueX-00020D-22; Thu, 24 Jul 2008 08:50:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A7D486EF; Thu, 24 Jul 2008 08:50:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080724031441.GA26072@laptop>
X-Spam-Score: -1.8 (-)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_50=0.001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89840>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> --- a/setup.c
> +++ b/setup.c
> @@ -577,10 +577,14 @@ const char *setup_git_directory(void)
>  	/* If the work tree is not the default one, recompute prefix */
>  	if (inside_work_tree < 0) {
>  		static char buffer[PATH_MAX + 1];
> +		static char cwd[PATH_MAX + 1];
>  		char *rel;
> +		getcwd(cwd, PATH_MAX);

This needs an error check.

-- Hannes
