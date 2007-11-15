From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t7501-commit: Add test for git commit <file> with dirty
 index.
Date: Thu, 15 Nov 2007 15:55:46 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711151554430.30886@racer.site>
References: <Pine.LNX.4.64.0711150038020.4362@racer.site>
 <1195138198-24511-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-500591077-1195142146=:30886"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 16:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ish4y-0008KA-R4
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 16:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbXKOP4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 10:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757912AbXKOP4Q
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 10:56:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:48097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756541AbXKOP4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 10:56:16 -0500
Received: (qmail invoked by alias); 15 Nov 2007 15:56:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 15 Nov 2007 16:56:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Iqv4tFaHILuDqoUK6nuAHeD82aNJvO7uUIMxbJU
	pVRFZw7kUyzsO+
X-X-Sender: gene099@racer.site
In-Reply-To: <1195138198-24511-1-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65130>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-500591077-1195142146=:30886
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 15 Nov 2007, Kristian Høgsberg wrote:

> ---
>  t/t7501-commit.sh |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 5aed3de..3627d9f 100644
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -259,4 +259,14 @@ test_expect_success 'amend commit to fix author' '
>  	diff expected current
>  
>  '
> +
> +test_expect_success 'git commit <file> with dirty index' '
> +	echo tacocat > elif &&
> +	echo tehlulz > chz &&
> +	git add chz &&
> +	git commit elif -m "tacocat is a palindrome" &&
> +	git show --stat | grep elif &&
> +	git diff --cached | grep chz
> +'
> +	

Funny... I have something similar, but with a fix for builtin-commit ;-)  
Will send out in a minute.

Ciao,
Dscho

---1463811741-500591077-1195142146=:30886--
