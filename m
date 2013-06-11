From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v4 45/45] tests: update topology tests
Date: Mon, 10 Jun 2013 21:37:59 -0700
Message-ID: <CANiSa6iFYgkgXJ9SdkiOJc-iwfCxfsoU+Nfs5hjhx45Am=kixw@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-46-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 06:38:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmGLb-0002ov-6p
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 06:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab3FKEiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 00:38:02 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35234 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab3FKEiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 00:38:01 -0400
Received: by mail-wi0-f170.google.com with SMTP id ey16so3826779wid.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 21:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3+NZar3+ZFG621lizikcOk574gRU81QXPujZToqes+E=;
        b=A/pIZr4ReqStFlLqLxN6j8bSPBLj7AK6WM63aw48GztqrqBdrgMQmMldV5pJO5Yzu5
         lVN2uSha0GFr6caxgU6AFGqH3lyYHZwhZYQKzZ5GTb104hZU7P9ZFh+TnzXk7eq//i78
         FqQ/1OFBkjBaQhoGfS0UnS+QBj8vHBItBOkwgr9UxtykMb5gzp5tBgLpfeZVQoHIBKH0
         lZGZ1Ct1aSy7LmbkqxCl+E4HfcEuDKwLFs7HE1+06iNwjr8FYICEA1bGANYDpyArioRm
         HRj8ZU3izjCbyHYBPLMReaY1QaqIa9VxapB6fdcczjyHBZRgz/QEuocmQUoAhhS1zml3
         Illw==
X-Received: by 10.180.206.205 with SMTP id lq13mr50972wic.56.1370925479770;
 Mon, 10 Jun 2013 21:37:59 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Mon, 10 Jun 2013 21:37:59 -0700 (PDT)
In-Reply-To: <1370796057-25312-46-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227414>

On Sun, Jun 9, 2013 at 9:40 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t3425-rebase-topology-merges.sh | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
> index 5400a05..96cc479 100755
> --- a/t/t3425-rebase-topology-merges.sh
> +++ b/t/t3425-rebase-topology-merges.sh
> @@ -70,9 +70,8 @@ test_run_rebase () {
>                 test_linear_range "\'"$expected"\'" d..
>         "
>  }
> -#TODO: make order consistent across all flavors of rebase
> -test_run_rebase success 'e n o' ''
> -test_run_rebase success 'e n o' -m
> +test_run_rebase success 'n o e' ''
> +test_run_rebase success 'n o e' -m
>  test_run_rebase success 'n o e' -i

If you do end up re-sending the series on top of my series, I'd prefer
to see the end result having the first argument inlined, so these few
lines become simply:

test_run_rebase success ''
test_run_rebase success -m
test_run_rebase success -i
