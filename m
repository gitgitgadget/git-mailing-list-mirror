From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v0 2/3] t/t3400-rebase.sh: add more tests to help migrating git-rebase.sh to C
Date: Thu, 21 May 2009 03:22:28 -0700 (PDT)
Message-ID: <m3ab56kb7y.fsf@localhost.localdomain>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com>
	<1242899229-27603-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 12:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M75QA-0003la-Dm
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 12:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbZEUKW2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 06:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZEUKW2
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 06:22:28 -0400
Received: from mail-px0-f171.google.com ([209.85.216.171]:42989 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZEUKW1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 06:22:27 -0400
Received: by pxi1 with SMTP id 1so618154pxi.33
        for <git@vger.kernel.org>; Thu, 21 May 2009 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=nDod/PBKBAm1g+qhEAEY11XqDYDAyfW7N7WN2vkL0BE=;
        b=LtDfE9ViR9zXCcIYQmD9jQL9u80s//K1y0zXyL2bFtYa8MKXYKdeDEMfZWpoabfZhB
         OlIvdnFQe3q7LKQdHfqAJHvFcQxwEzo97NaeYi315FAGr7W0Famthq52EytNeQdAstom
         WshzwQC8o1l2B1DMPpnwYA3kJjyYc6i+gTbC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=QInF0Ru/S3qh1IXb2UA05MPooZ7vVDdDxj8WUtJolt7Ooo/bhc0HvIQw7BPN7Fq7bm
         iDm9kMegsQoyL3IEdBxMFYb2bYC8ZCqSabwB7vsqn+x7OmxoGgizmHd+qtch44fAVMov
         ndPVUFFmXdRlfdz3lxmYet0OMBoRxpydWlpZo=
Received: by 10.142.253.19 with SMTP id a19mr832441wfi.85.1242901349162;
        Thu, 21 May 2009 03:22:29 -0700 (PDT)
Received: from localhost.localdomain (abwg97.neoplus.adsl.tpnet.pl [83.8.230.97])
        by mx.google.com with ESMTPS id 30sm3058640wfd.21.2009.05.21.03.22.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 03:22:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4LALpo8013883;
	Thu, 21 May 2009 12:22:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4LALcLD013876;
	Thu, 21 May 2009 12:21:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1242899229-27603-2-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119669>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy    <pclouds@gmail.com> writes=
:

> These new tests make sure I don't miss any check being performed befo=
re
> rebase is proceeded (which is well tested by other tests)
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  t/t3400-rebase.sh |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>=20
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 6e391a3..37f86ab 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -41,9 +41,37 @@ test_expect_success \
>       git tag topic
>  '
> =20
> +test_expect_success 'rebase on dirty worktree' '
> +     echo dirty >> A &&
> +     ! git rebase master'

Shouldn't you use test_must_fail instead? From t/test-lib.sh
(paraphrasing):

  Writing this as "! git rebase master" is wrong, because
  the failure could be due to a segv.  We want a controlled failure.

> +
> +test_expect_success 'rebase on dirty cache' '
> +     git add  A &&
> +     ! git rebase master'
> +
>  test_expect_success 'rebase against master' '
> +     git reset HEAD &&
> +     git checkout -f &&
>       git rebase master'
> =20
> +test_expect_success 'rebase against master twice' '
> +	git rebase master 2>&1|grep "Current branch my-topic-branch is up t=
o date\\."
> +'

It would be more readable to split this line on '|', i.e.:

+test_expect_success 'rebase against master twice' '
+	git rebase master 2>&1 |
+	grep "Current branch my-topic-branch is up to date\\."
+'

I think we prefer to save output to a file, and compare this file with
expected output (using test_cmp).  Additionally you can check if the
message you want is in correct stream (is in STDERR, and STDOUT is
empty).

> +
> +test_expect_success 'rebase against master twice with --force' '
> +	git rebase --force-rebase master 2>&1|grep "Current branch my-topic=
-branch is up to date, rebase forced"
> +'
> +
> +test_expect_success 'rebase against master twice from another branch=
' '
> +	git checkout my-topic-branch^ &&
> +	git rebase master my-topic-branch 2>&1|grep "Current branch my-topi=
c-branch is up to date\\."
> +'
> +
> +test_expect_success 'rebase fast-forward to master' '
> +	git checkout my-topic-branch^ &&
> +	git rebase my-topic-branch 2>&1|grep "Fast-forwarded HEAD to my-top=
ic-branch"
> +'

Same as above.

> +
>  test_expect_success \
>      'the rebase operation should not have destroyed author informati=
on' \
>      '! (git log | grep "Author:" | grep "<>")'

Errrr... what?  Why git-log and not git-cat-file?  Why grep twice?
Additionally you do not check here that author is unchanged, only that
is not destroyed.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
