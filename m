Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C64C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 14:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AB5206D5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 14:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="D0bQwfRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgEFOd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 10:33:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:33289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgEFOdz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 10:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588775628;
        bh=qtwDkGU63dn2yQSGkcYGr982z5Mhrucac7rLYh2kaaE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=D0bQwfRzTfgnGUE8RwlV7eLnLlvUv7FdWclWwmWaZT9y0wfJ/uMyV9NSih0CBDWPF
         K4auhi1pynt809ncf3+/mTo7ymT3tJQPSP7BtVPAUSWZ1Kd/9Mvj6JqZgWnWO7kQ8E
         8P8A1DObieDzAbcs1XMpYo3h3HU+vg3KEGSa5ts8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([89.1.213.224]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1iwC1J3ClZ-00hRRA; Wed, 06
 May 2020 16:33:48 +0200
Date:   Wed, 6 May 2020 16:33:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
In-Reply-To: <20200506134659.GA75901@Carlos-MBP>
Message-ID: <nycvar.QRO.7.76.6.2005061624050.56@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com> <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com> <20200504174636.GG86805@Carlos-MBP> <20200504232511.GB29599@danh.dev>
 <xmqqlfm7cj7s.fsf@gitster.c.googlers.com> <20200506073045.GA52959@Carlos-MBP> <nycvar.QRO.7.76.6.2005061447010.56@tvgsbejvaqbjf.bet> <20200506134659.GA75901@Carlos-MBP>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2099862193-1588775628=:56"
X-Provags-ID: V03:K1:yBcONTfUVep39mP2FodMepU0ZW82pXyonH9CfPVhsJR7F1fDCOM
 QwXl40RGRRmQhkobxXZY0vTnPlc2LfMT832PvHWJrlI2B8HvGO3L5wkLnFDyZR1Oi8Oa+3z
 5jp8Avhz5MKAGmyeUWBpRE/9evfklCxVlDe9rboGXtrv/28w7wUakOqRqc1uM5e4lAaHMJg
 BLGzM536vHkJ/VIigzFJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vX1Go6D3vkQ=:V4HJgZNjYE5YYOeclYc5ra
 zqya1gEhJZDJ/aYtdIJs4vRLJAfqUcd6iGWBe+yAffp2VsxwlMZHFG0wRY461Dp2H5R21rDhc
 3I9xN20YL7oBJYm6Bs0Xu0nYvSidREa4QPADHiS+bzWq3yDfTMbzW7xGwxzYcsixpLxsPZyzL
 3Pxa3a9Sp5cGZjZSmnaS6de2dhBIj8yp2XIO0Ripmemu1CO7VY/sU2zOEiXTAlGuZfkDwzwYY
 wMI1etW+btxThwFjB79xhvGiFD/m0o/TUo2Gb8LNmUVecUhD7Db6Gq7xGBjphyz5+LL//itG5
 AE6gyttmHSdoTcdqKfSa26Bht25Wrvj4F4mMVE4qen9nbFVJHy36np/HIHVz7+T11Hsvkg6z0
 lcBoKNQCOQwJ19uYEpIZUCA2Cn0nY1tu0rBISB5DNQ3xlz6QZerUejsJOC9G2ZQsk8xLepoBX
 HJINaRatXgV0TcCmSaMZvVCFm1LCFBxabXaWuMGcBlVglLlsuIhT+jvuq97Z4Huzu0w+vYPLN
 k5D3hjGpSvvnvKr0KHk3mdfoIuIjFSgMSuXFUQv3vemu0jKjvjwwlVe/bBnqXm6LvlAxttCw+
 ptusD3iqosGFG3z2ZjKsMb69tq4oKR7bbvuMU7z+khj2jVh1F6jzDDlWQrLhWXILMCxc98s2Z
 hMqScuOyXCH5Hlor5VnzGoCK3BTVCALPa9iC+Cwezo1su2N6M0eGVMdqWdF/IBMBOq8rrv4ke
 XnTe/X7XF4Y9hBGa/LaniePUoZsJAAF7TZNv5Pa7J5zUW7Bcnz9algG41Q4smX2A7QtOGnBoD
 eRbFfhn32c+8Sax5QzE2OsXFqPu/AEYU2V5qF6h7sDULWTc0eXXFgVVLX9WoIX1wE49JCDAg6
 6lqBqJ/mFAnFq87ENpyp7YhML+TEpxLQpsOcEot9YuU4RCPk6kT9JMrxbOsaYkUBI7QBeyBLy
 5WEogwg6H61TlUuctCgikoNjFm2bvzU5XWG+K86AL5tKwFE3OxeiQvIZy5GIHMYpwNMFHQ7kL
 tTkkWS26DxAL0K63hALM5CdSPvT+vfWdXy8BfUWfk+zLhm6I+Kb+TP/50ipuh3xishk3crEd0
 WMNd9IqMKDSVT4ghv4zSvpVqau2rpd1sv0IJ4jbW1iJycjykC9yB1pLuzg/3QyeiSitHnhiFv
 f+ebISGa4/F58q9rkxsAMVFwa5GR+19Cp+IoWGQ75frJoj9OJViLSsbfI6QCqhkipu7g4LMc5
 xDKS74zd2LanbnMzv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2099862193-1588775628=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Wed, 6 May 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> On Wed, May 06, 2020 at 02:54:38PM +0200, Johannes Schindelin wrote:
> > On Wed, 6 May 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > > index 1b221951a8..a8f8e4106b 100644
> > > --- a/t/test-lib.sh
> > > +++ b/t/test-lib.sh
> > > @@ -676,15 +676,9 @@ die () {
> > >  }
> > >
> > >  file_lineno () {
> > > -	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || retur=
n 0
> > > -	local i
> > > -	for i in ${!BASH_SOURCE[*]}
> > > -	do
> > > -		case $i,"${BASH_SOURCE[$i]##*/}" in
> > > -		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; ret=
urn;;
> > > -		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]=
}: ${1+$1: }"; return;;
> > > -		esac
> > > -	done
> > > +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" || return 0
> > > +
> > > +	echo "$0:$LINENO: ${1+$1: }"
> >
> > That suppresses the error all right.
> >
> > Unfortunately, it completely breaks the feature. At that point, `$LINE=
NO`
> > is either unset (e.g. in `dash`) or it contains the number of the line
> > _containing the `echo`. That is totally useless information at this po=
int,
> > we want the line number of the caller.
>
> that seems like a bug in dash, which NetBSD sh doesn't have, as LINENO
> wouldn't be unset.

And your patch makes this a real problem as you no longer skip the `echo`
in the non-Bash case.

That's what I wanted to point out: this needs to be fixed.

> > Try this, for example:
> >
> > ```
> > #!/bin/sh
> >
> > file_lineno () {
> > 	echo "$0:$LINENO: hello"
> > }
> >
> > file_lineno
> > ```
> >
> > When you run this, it will print `4`. What we want is `7`.
>
> so you need instead :
>
> ```
> #!/bin/sh
>
> file_lineno () {
> 	echo "$0:$1: hello"
> }
>
> file_lineno $LINENO

No.

Please understand what the intention of the current (Bash-specific) code
is: in case that there is a failure, it needs to print out the file and
line number of the actual statement that caused that problem.

Take this example:

	test_expect_success 'For Carlo' '
		false
	'

Obviously, this will fail, and it will print out an error message. What we
want here is that the file that contains that `test_expect_success` and
the actual line number of this call are printed.

Your suggestion would be to clutter each and every such call with
`$LINENO`, like so:

	test_expect_success $LINENO 'For Carlo' '

I don't think that is sensible an idea.

Besides, it would _still_ not work, for parameterized functions that call
`test_expect_success` and that are defined in `lib-<whatever>.sh`.

Example:

	# in t/lib-whatever.sh
	super_repetitive_test () {
		test_expect_success "first $1" '
			...
		'

		test_expect_success "second $1" '
			...
		'

		...

		test_expect_success "gazillionth $1" '
			...
		'
	}

	# in t/t1234-actual-caller.sh
	. lib-whatever.sh

	super_repetitive_test hello
	super_repetitive_test world
	super_repetitive_test good-bye
	super_repetitive_test dreams

We will not want to print out the line number of the call in
t/lib-whatever.sh. That is what your proposal would amount to, unless you
want to clutter even the `super_repetitive_test` calles, which would fly
even less.

> > Even worse, as `$0` does _not_ contain `test-lib.sh` at this point,
> > the printed information is totally bogus.
>
> not sure I understand what you mean here, at least when runnning with ba=
sh
> the original code shows $0 correctly as t????.sh when I tried to force a
> failure to test.

Yes, $0 shows the correct file. But since the line number that is printed
is from a totally different file, the combination <file>:<lineno> is
completely and utterly bogus. Misleading. Less than useless.

Ciao,
Dscho

--8323328-2099862193-1588775628=:56--
