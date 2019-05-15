Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9591F461
	for <e@80x24.org>; Wed, 15 May 2019 08:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEOIgs (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 04:36:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:58393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfEOIgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 04:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557909405;
        bh=Hirr1sgOwzBOW25oBL8pocoiI23r6BR25eEP+01f0Hc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OW8CQwrR0D13q4Qkfzz29ZG1bfrm9WIu7mAngvDBzyCjfDYus2F+H7mxznpdcoBHn
         ctEruETysz25zBgdRsigP3Fk1y8hijj8LrLaFQZubdpM0KjgNdSpfvIGNU/yDhqpdD
         1KAyU9b4KEz/sOGzzXMmipvccDcILKNVUlkblC44=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1hJgWd1Zhi-007FZW; Wed, 15
 May 2019 10:36:45 +0200
Date:   Wed, 15 May 2019 10:36:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t5616: refactor packfile replacement
In-Reply-To: <991a3aa27dd7fe67adbed2e03502790932b5059c.1557868134.git.jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1905151032500.44@tvgsbejvaqbjf.bet>
References: <cover.1557868134.git.jonathantanmy@google.com> <991a3aa27dd7fe67adbed2e03502790932b5059c.1557868134.git.jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Nl/kCN+kjBrc6CE6em+NZXY6qE8Ux2ZJIo7xp6xDvRHiobpC5CH
 NGX6DCtIuzk1XEbgyarSrO6TYJc8/o7xA0eF6UpIpMtDxEBFN4QJ1V8NSc1ZzyoYDGlsL4w
 1GL8/0Wl9O6Dof877e7vrYDhWfJFiOUFgNZsusmwqk09VLQhSdFpUWhb46jF5tnMKf5EegG
 nKrQGqDtkGdyKlxxQ9oJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6kyfp/RcqhE=:LDl8xZpn2+Gi62pM6f0kBT
 /1HCQ01pQ03CcFpTvqy5l3PIXVxNhtBTglZvGLrmNyM+Kctsqz+IQuoTxG+pOdfsiJqL4QCab
 qUWJWoA6QkLr1pdTKkMwa5dZjXSRUUx60HFRQweLiV2SwYIJd8+8Qqi0mlEMKu4y1oR50Vnte
 F+1e/Wo+OD5IZOlfD8L0HibpUyeM1nOM2VPm9umEoPc3WXYGFGQSBy3NayrSq4n+rXqKF19m1
 dfj5lYOYtpxykrzAPD/wbf/MrF36lYkUe1XfAtPhk1IdwTgdrj4y73arqt7xoPOUN86twgl2J
 zMf15vPFUYJYF47Hh7T0z+qBHbayh4ZGPboQgl9DrmCINNIMWuYAbT8q4jELBcEI1dVSDC261
 aIikpUgz2xxvwbAdKC0/q6A+J4QT3d33UhNg3mYBO36ZlpISVEvuVesObrZaX0szP8i/QtOhF
 HqmylKbBisxrs7IC4i+Z8cZbIxNIXYoFr64Vfm/DVm/aK33YeQJQfd0he7nkCaa7hEAMHlL3J
 QKtrLhexbM3OVrNblH5rdj5CYUBx8ozx2l+7EFyNAMu8mFgrDoT30xBkA2I6frZU19HTGyWS8
 jJka+5VX78eN3EEa33uJ0jkHtCuVg7ucrm20pELvptfiG4IOK5skGnqNgx9fjHpKRo9fiVoa/
 705PCWnkOld6BlfOqKHjvl64qbBhUCKA0mKHEszu/AO5hdmHVFGjP9OVTHQLolHGyI065Udod
 mUdQLGSgThocUD8CG4wIqffppRnhLF0i1CkBAOjth+k4Mc6VThxrnzA47wBMtLcLZ+mQVvqvr
 YUwEQ2TIbri1dIl1fgLN2Y8dQ104I48kYI2rxb49tvGko2D5Foa8qw3RXWmnTjvb2C9gv1Jwi
 xXbh1ese1+lq71OCDkzpS1qU3f7Xm2MxJFtMFxlOZkJCVSIuWi/B2atIu2ZUiPIluS+754uKO
 60NK+JbL5gQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 14 May 2019, Jonathan Tan wrote:

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 9a8f9886b3..7cc0c71556 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -244,11 +244,25 @@ test_expect_success 'fetch what is specified on CL=
I even if already promised' '
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>
> -# Converts bytes into a form suitable for inclusion in a sed command. F=
or
> -# example, "printf 'ab\r\n' | hex_unpack" results in '\x61\x62\x0d\x0a'=
.
> -sed_escape () {
> -	perl -e '$/ =3D undef; $input =3D <>; print unpack("H2" x length($inpu=
t), $input)' |
> -		sed 's/\(..\)/\\x\1/g'
> +# Converts bytes into their hexadecimal representation. For example,
> +# "printf 'ab\r\n' | hex_unpack" results in '61620d0a'.
> +hex_unpack () {
> +	perl -e '$/ =3D undef; $input =3D <>; print unpack("H2" x length($inpu=
t), $input)'
> +}
> +
> +# Inserts $1 at the start of the string and every 2 characters thereaft=
er.
> +intersperse () {
> +	sed 's/\(..\)/'$1'\1/g'
> +}
> +
> +# Create a one-time-sed command to replace the existing packfile with $=
1.
> +replace_packfile () {
> +	# The protocol requires that the packfile be sent in sideband 1, hence
> +	# the extra \x01 byte at the beginning.
> +	printf "1,/packfile/!c %04x\\\\x01%s0000" \
> +		"$(($(wc -c <$1) + 5))" \
> +		"$(hex_unpack <$1 | intersperse '\\x')" \
> +		>"$HTTPD_ROOT_PATH/one-time-sed"
>  }

Urgh. This is not a problem *this* patch introduces, but why on Earth do
we have to do complicated computations in shell code using an unholy mix
of complex sed and Perl invocations, making things fragile and slow? We do
have such a nice facility is the t/test-tool helper...

The refactoring itself looks correct to me, of course.

Thanks,
Dscho

>
>  test_expect_success 'upon cloning, check that all refs point to objects=
' '
> @@ -270,10 +284,7 @@ test_expect_success 'upon cloning, check that all r=
efs point to objects' '
>  	# Replace the existing packfile with the crafted one. The protocol
>  	# requires that the packfile be sent in sideband 1, hence the extra
>  	# \x01 byte at the beginning.
> -	printf "1,/packfile/!c %04x\\\\x01%s0000" \
> -		"$(($(wc -c <incomplete.pack) + 5))" \
> -		"$(sed_escape <incomplete.pack)" \
> -		>"$HTTPD_ROOT_PATH/one-time-sed" &&
> +	replace_packfile incomplete.pack &&
>
>  	# Use protocol v2 because the sed command looks for the "packfile"
>  	# section header.
> @@ -313,10 +324,7 @@ test_expect_success 'when partial cloning, tolerate=
 server not sending target of
>  	# Replace the existing packfile with the crafted one. The protocol
>  	# requires that the packfile be sent in sideband 1, hence the extra
>  	# \x01 byte at the beginning.
> -	printf "1,/packfile/!c %04x\\\\x01%s0000" \
> -		"$(($(wc -c <incomplete.pack) + 5))" \
> -		"$(sed_escape <incomplete.pack)" \
> -		>"$HTTPD_ROOT_PATH/one-time-sed" &&
> +	replace_packfile incomplete.pack &&
>
>  	# Use protocol v2 because the sed command looks for the "packfile"
>  	# section header.
> --
> 2.21.0.1020.gf2820cf01a-goog
>
>
