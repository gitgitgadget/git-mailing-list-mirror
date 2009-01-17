From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 06:23:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 06:24:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO3f9-0000jw-5l
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 06:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbZAQFWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 00:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbZAQFWj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 00:22:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:55956 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751187AbZAQFWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 00:22:39 -0500
Received: (qmail invoked by alias); 17 Jan 2009 05:22:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 17 Jan 2009 06:22:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HqLAVYC8HrCMCufWyaM0SycWhK2m/XFHxs5WpNn
	nbWT83IX1SffFM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106025>

Hi,

On Sat, 17 Jan 2009, Ray Chuan wrote:

> note: the test needs to chmod the test_repo.git folder so that
> apache/mod_dav can create .DAV folders in it for locking.

Is this supposed to explain ...

> @@ -51,17 +51,16 @@ test_expect_success 'clone remote repository' '
>  	git clone $HTTPD_URL/test_repo.git test_repo_clone
>  '
> 
> -test_expect_failure 'push to remote repository' '
> +test_expect_success 'push to remote repository' '
>  	cd "$ROOT_PATH"/test_repo_clone &&
>  	: >path2 &&
>  	git add path2 &&
>  	test_tick &&
>  	git commit -m path2 &&
> -	git push &&
> -	[ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
> +	git push origin master
>  '

... this removal?  I do not think this is a good change, as it removes 
a test that is actually pretty important.

BTW I do not understand at all what you mean by "we need to chmod".  Does 
the Apache instance not run with the current user's permissions?

Ciao,
Dscho
