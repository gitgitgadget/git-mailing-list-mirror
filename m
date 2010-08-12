From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH V5 16/17] Add tests for line history browser
Date: Thu, 12 Aug 2010 01:25:06 +0000
Message-ID: <AANLkTi=qvywaiwYpr7ZZ6Gf0i_curaLr0E8gRLD5WTK-@mail.gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
	<1281539022-31616-17-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 03:25:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjMXi-0001Rb-Rx
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 03:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758803Ab0HLBZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 21:25:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52002 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758681Ab0HLBZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 21:25:07 -0400
Received: by fxm13 with SMTP id 13so537831fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 18:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rjMscXjYw2lcjYECdolCbS9H1DLje8HtvuFzIj94vuI=;
        b=F8ioz9hthT/CfZWcB3sMzOSSv2JC3lG8mrffX03m1W+Rj8Dbb6cWIqyuBOJNYmQKq/
         ZUNiCAlLq4iV5wZCHKDtHR7cxFZctzknj93C9gUEZlimRNzs5IHAQatf9grb7R2LYrLh
         d4C+2IWUOrtsE3SRBAiDKn3ki8gXsO4YBvEoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Iq09/zG7GLXoUIGaPjgVuknxT3ycbmGW5CD+N4yY3L8DcRjiG5rjGBQxLKdxl4Z9Bq
         jtSBO+AlGloaJLaIen2HB9f+CAl288fRAr/pXs8omC6JhWpG2VUmHh2W3yArExFfZxhb
         800mmbq/kKAse/ZE81O1HagzCTJDuYZOCPpoI=
Received: by 10.223.109.2 with SMTP id h2mr20948156fap.95.1281576306148; Wed, 
	11 Aug 2010 18:25:06 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 18:25:06 -0700 (PDT)
In-Reply-To: <1281539022-31616-17-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153322>

On Wed, Aug 11, 2010 at 15:03, Bo Yang <struggleyb.nku@gmail.com> wrote=
:
> t/t4301-log-line-single-history.sh:
> =C2=A0test the linear line of history.
>
> t/t4302-log-line-merge-history.sh:
> =C2=A0test the case that there are merges in the history.

This is failing smoke tests on my smoker:
http://smoke.git.nix.is/app/projects/report_details/21

> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>

> +test_expect_success 'validate the path0 output.' '
> + =C2=A0 =C2=A0test_cmp current-path0 expected-path0
> +'

That gives me:

    $ diff -ru trash\
directory.t4301-log-line-single-history/{expected,current}-path0
    --- trash directory.t4301-log-line-single-history/expected-path0
     2010-08-12 01:20:18.000000000 +0000
    +++ trash directory.t4301-log-line-single-history/current-path0
2010-08-12 01:20:18.000000000 +0000
    @@ -6,8 +6,8 @@
     +++ b/path0
     @@ -1,6 +1,5 @@
      void func(){
    -       int a =3D 10;
    -       int b =3D 11;
    +       int a =3D 10;
    +       int b =3D 11;
     -      int c;
     -      c =3D 10 * (a + b);
     +      printf("%d", a - b);
    @@ -21,9 +21,9 @@
     +++ b/path0
     @@ -1,6 +1,6 @@
      void func(){
    -       int a =3D 10;
    -       int b =3D 11;
    -       int c;
    +       int a =3D 10;
    +       int b =3D 11;
    +       int c;
     -      c =3D a + b;
     +      c =3D 10 * (a + b);
      }
    @@ -40,8 +40,8 @@
     -      int b =3D 1;
     +      int a =3D 10;
     +      int b =3D 11;
    -       int c;
    -       c =3D a + b;
    +       int c;
    +       c =3D a + b;
      }

     Base commit


> [...]

More of these test fails, see the TAP output at the smoker.

> diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-mer=
ge-history.sh
> new file mode 100755
> index 0000000..1536cc4
> --- /dev/null

[...]

> +test_expect_success \
> + =C2=A0 =C2=A0'validate the output.' \
> + =C2=A0 =C2=A0'test_cmp current expected'

Gives:

    $ diff -ru trash\ directory.t4302-log-line-merge-history/{expected,=
current}
    --- trash directory.t4302-log-line-merge-history/expected
2010-08-12 01:21:47.000000000 +0000
    +++ trash directory.t4302-log-line-merge-history/current
2010-08-12 01:21:47.000000000 +0000
    @@ -3,7 +3,7 @@
     nontrivial merge found
     path0
     @@ 2,1 @@
    -       printf("hello earth and moon");
    +       printf("hello earth and moon");


     Change path0 in master

That's just a whitespace change, the diff goes away on diff -w.

> +test_expect_success \
> + =C2=A0 =C2=A0'validate the graph output.' \
> + =C2=A0 =C2=A0'test_cmp current-graph expected-graph'
> +

More whitespace changes:

    $ diff -ru trash\
directory.t4302-log-line-merge-history/{expected,current}-graph
    --- trash directory.t4302-log-line-merge-history/expected-graph
2010-08-12 01:23:53.000000000 +0000
    +++ trash directory.t4302-log-line-merge-history/current-graph
2010-08-12 01:23:53.000000000 +0000
    @@ -1,14 +1,14 @@
     *   Merge two branches
    -|\
    -| |
    +|\
    +| |
     | | nontrivial merge found
     | | path0
     | | @@ 2,1 @@
     | |    printf("hello earth and moon");
    -| |
    -| |
    +| |
    +| |
     | * Change path0 in master
    -| |
    +| |
     | | diff --git a/path0 b/path0
     | | index f628dea..bef7fa3 100644
     | | --- a/path0
    @@ -16,10 +16,10 @@
     | | @@ -2,1 +2,1 @@
     | | -  printf("hello");
     | | +  printf("hello earth");
    -| |
    +| |
     * | Change path0 in feature
    -|/
    -|
    +|/
    +|
     |   diff --git a/path0 b/path0
     |   index f628dea..a940ef6 100644
     |   --- a/path0
    @@ -27,9 +27,9 @@
     |   @@ -2,1 +2,1 @@
     |   -  printf("hello");
     |   +  print("hello moon");
    -|
    +|
     * Base commit
    -
    +
       diff --git a/path0 b/path0
       new file mode 100644
       index 0000000..f628dea
