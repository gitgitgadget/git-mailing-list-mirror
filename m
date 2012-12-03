From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v7 p1 07/13] remote-testgit: remove irrelevant test
Date: Mon, 3 Dec 2012 18:13:21 -0500
Message-ID: <20121203231321.GA5098@padd.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
 <1354140669-23533-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 00:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TffCm-0007t1-TC
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 00:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab2LCXNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 18:13:25 -0500
Received: from honk.padd.com ([74.3.171.149]:60739 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab2LCXNY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 18:13:24 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id B7EF820DB;
	Mon,  3 Dec 2012 15:13:23 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 33CE922BC7; Mon,  3 Dec 2012 18:13:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1354140669-23533-8-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211062>

felipe.contreras@gmail.com wrote on Wed, 28 Nov 2012 23:11 +0100:
> This was only to cover a bug that was fixed in remote-testpy not to
> resurface.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5801-remote-helpers.sh | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index 2f7fc10..6801529 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -53,19 +53,6 @@ test_expect_success 'pushing to local repo' '
>  	compare_refs localclone HEAD server HEAD
>  '
>  
> -# Generally, skip this test.  It demonstrates a now-fixed race in
> -# git-remote-testgit, but is too slow to leave in for general use.
> -: test_expect_success 'racily pushing to local repo' '
> -	test_when_finished "rm -rf server2 localclone2" &&
> -	cp -R server server2 &&
> -	git clone "testgit::${PWD}/server2" localclone2 &&
> -	(cd localclone2 &&
> -	echo content >>file &&
> -	git commit -a -m three &&
> -	GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
> -	compare_refs localclone2 HEAD server2 HEAD
> -'
> -

Why does this cause problems?

If you're going to rip it out, please finish the job, and take
out the other two hunks that are needed to trigger this test.  See
7fb8e16 (git-remote-testgit: fix race when spawning fast-import,
2012-04-22).

		-- Pete
