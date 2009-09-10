From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/4] reset: add test cases for "--merge-dirty" option
Date: Thu, 10 Sep 2009 18:14:04 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909101757530.28290@iabervon.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.13214.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 00:14:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlru9-0001qE-9e
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 00:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbZIJWOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 18:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbZIJWOD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 18:14:03 -0400
Received: from iabervon.org ([66.92.72.58]:33187 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbZIJWOC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 18:14:02 -0400
Received: (qmail 17919 invoked by uid 1000); 10 Sep 2009 22:14:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Sep 2009 22:14:04 -0000
In-Reply-To: <20090910202333.3722.13214.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128153>

On Thu, 10 Sep 2009, Christian Couder wrote:

    This shows that with the "--merge-dirty" option, 

  changes that are both in the work tree and the index are kept

    in the work tree after the reset (but discarded in the index). As with 
    the "--merge" option, 

  changes that are in both the work tree and the index are discarded

    after the reset.

I'm lost here.

If you have:

         working index HEAD target
version     B      B     A     A

You get:

         working index HEAD target
--m-d       B      A     A     A
--merge     A      A     A     A

?

> ---
>  t/t7110-reset-merge.sh |   54 +++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> index 45714ae..1e6d634 100755
> --- a/t/t7110-reset-merge.sh
> +++ b/t/t7110-reset-merge.sh
> @@ -19,7 +19,7 @@ test_expect_success 'creating initial files' '
>       git commit -m "Initial commit"
>  '
>  
> -test_expect_success 'ok with changes in file not changed by reset' '
> +test_expect_success '--merge: ok if changes in file not touched by reset' '

Should probably have the "--merge: " from the beginning, since you're 
adding the test in this series anyway. That would make the diff come out 
clearer.

	-Daniel
*This .sig left intentionally blank*
