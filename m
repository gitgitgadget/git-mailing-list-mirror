From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 3/5] introduce GIT_WORK_TREE environment variable
Date: Sun, 18 Mar 2007 20:43:05 +0100
Message-ID: <20070318194305.GA30843@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx> <20070317144403.GC26290@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 20:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT1Hd-0005N2-Ch
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 20:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbXCRTnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 15:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933036AbXCRTnM
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 15:43:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:37398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933026AbXCRTnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 15:43:11 -0400
Received: (qmail invoked by alias); 18 Mar 2007 19:43:09 -0000
X-Provags-ID: V01U2FsdGVkX19IDSBVUPhIQbim/fQ2El8+dEBR5Y8vtByaJErsmt
	LXSNxysu3Xuv2S
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070317144403.GC26290@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42512>

Matthias Lederhofer <matled@gmx.net> wrote:
> diff --git a/setup.c b/setup.c
[..]
>  const char *setup_git_directory_gently(int *nongit_ok)
>  {
>  	static char cwd[PATH_MAX+1];
> @@ -199,21 +211,93 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	int len, offset;
>  
>  	/*
> -	 * If GIT_DIR is set explicitly, we're not going
> -	 * to do any discovery, but we still do repository
> -	 * validation.
> +	 * If GIT_DIR is set explicitly, we do repository validation
> +	 * and check for GIT_WORK_TREE as working tree.
>  	 */
>  	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
>  	if (gitdirenv) {
> +		const char *gitwt;
> +		char worktree[PATH_MAX+1], gitdir[PATH_MAX+1];
> +		int len;
                ^^^^^^^^
This is not really needed because there is already a variable len of
the same type.
