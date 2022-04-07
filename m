Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCE9C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 11:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiDGLwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 07:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbiDGLwC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 07:52:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC18D7
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649332194;
        bh=wzjtn/AwIDk4v9TMNP3/+3HgnlhO0+36aFmRuY5mSB0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JuIFf6lHVCx7rW0Rp9oilyAcmWo632HOQNvOH8RYEzz+SE2687P3Kmi06rS1uJ5iV
         QWqoVV1yRUitseerTbYFQZINR3kgr3W1Q3ocDgGmh6wHcSq/gtq1lpKSYBaZGwf52Q
         ndG+u7y4ZEqFB7MCYec/ms/jjYmUQoUkQjt993hY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.255.204] ([89.1.214.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzfG-1nT2h93aza-00R4Fa; Thu, 07
 Apr 2022 13:49:53 +0200
Date:   Thu, 7 Apr 2022 13:49:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Markus Vervier <markus.vervier@x41-dsec.de>, git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
In-Reply-To: <Yk3UAz3sn9KhMnyf@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2204071344210.347@tvgsbejvaqbjf.bet>
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de> <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2204061620110.379@tvgsbejvaqbjf.bet> <Yk3UAz3sn9KhMnyf@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZIPv9KURJ/AKNpP3ZiiQ77tSRZBWeFupcT8L+vvBcBqdJ4U9/7z
 tkQE8GpvtBQ3yPABjJDJWX1cipxPX7MJVIYfUGWs/6Xdh/ou1IyuU+o7r9D4Oem/PsNZQ/H
 LVSxlLUlU9m92ScZ4T0oHjoBtbbf2BzG1kTMUXtSl1hP8j5Ctlpr+2ncR8I+7pJ9PPGF+Tl
 mJTh3lRNuN3hoiSVjJTww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ar6Ba2nlTHw=:EotVJBvd1+v+mzM/WeJfnY
 8+32ENBUqjuO3SbIJ1KTZYrh7YaXHwA9tz4M+AU4vtwK52jeeITq1h40xCmIo8q2W7e8VOAQt
 1aB3e54qf0Nar3eo2d8bi7/qW6OTwxAL5UpYdxlSOPVqKgDFTLedzYZyOrksB7N3elXymRwDI
 xMH/pCZlQIctLLKwON45otLhWo1qW7fYyUj6HhDRq67jQMiIkkguPEALetcBTeqLeAQAmIG0h
 F4eJEjxJwgNZVDtwMC/WYGbLH+GsnoeViIR2yKGJ/5JSvgf5u8oQLTeO4kD76LMoRElyNxNEW
 Yo9981dijcJDJ2v+ormhjLulDgpiGwycMc+KDY6nPZxT6AIk0yA7Wd9ZL8cbMp6iK5OSctq7b
 5ZbUjB+JOAGm3denQ4atND5lpKnav01Ev23PtnhooME7YVmT0Xtjaiz948iFHqL9g4vW6cPIN
 PC1jKV5PkUhlbpWw7fmEBL/c50Vp2+bmsro+JuyBxB2+tZ/yEae2TCCjlIQHQ9Vn2uYSPTXxI
 /JjTFig4J6z+Dx/Z+fVMN0eIv9TcldcIWyK84rDr7ZN7y4xpuwLj+sxeN9dYBcnI/2riYu7Q9
 zUP6wuNuyvMWnZHHt0r1k6dKkuUriIUsxq5WMvdxZIVipi/UgultUsfHyZmGcOVJjuMc34bzi
 zSQqqvuPH39JFpM3wNM965oCnyE2VAmZqHZt6aTt2jroUaFCvpa/aeYPPfYzefQrI/NblWyoD
 R7fWdOQYjpyHvUYy+MANCp7NG27l9kyNd8xBHQnM0SxN015AOUaW4aPlDx9M+67cFWK1MoWVz
 xVTHetpQ7rbwV8Skp5lb0GFWgi5uiBG53BUyH4IYFZcMaOFbxFpQjE5oILad0Cu2UB2PS3/rg
 TbHuh2D6kpn6uFyydlT46atG+2RDcMaovXZSlrnX75EjVQ6y+w5NIndNjyfapzVsViQXmYx/t
 T6c6ej1ZrArrFlnpug3QShFNVG7tC4gKsRlQCW1gf7EuJ5A/nMUk//vSYK3u+JyYIS/ce8GiI
 ucOOhSDYV/JjjFIdWbqUGkB7hFo2G9cl4mmehoaekxASSUzsDYBlA8GY0UFEfGDaLczQOrrWG
 JPeFnMMeFgRzeI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Theodore,

On Wed, 6 Apr 2022, Theodore Ts'o wrote:

> On Wed, Apr 06, 2022 at 05:08:37PM +0200, Johannes Schindelin wrote:
> > I have fixed Git for Windows' Coverity build and started to sift throu=
gh
> > the 154 new defects reported as of v2.36.0-rc0.
> >
> > Sadly, there is now a new class of overwhelming false positives: Cover=
ity
> > claims that "strbuf_addstr does not [NUL-]terminate", which is of cour=
se
> > false.
>
> It should be possible to suppress this by uploading a Coverity model
> file.  See[1] for more details:
>
> [1] https://community.synopsys.com/s/article/practical-example-of-coveri=
ty-function-model

Right, I know about this, my apologies for being too succinct. For the
record, here is how we submit the Coverity builds in Git for Windows:

https://github.com/git-for-windows/build-extra/blob/bea0c37bdc3737843b7808=
269b077b30e51c67fb/please.sh#L1793-L1925

Unfortunately, you cannot see the model file because that is not provided
per build, but globally for the entire project. Here is the model file we
currently use:

=2D- snip --
/* modelfile for git */

char strbuf_slopbuf[64];

void *malloc(size_t);
void *calloc(size_t, size_t);
void *realloc(void *, size_t);
void free(void *);

void *xrealloc(void *ptr, size_t size)
{
	void *ret =3D realloc(ptr, size);
	if (!ret) __coverity_panic__();
	return ret;
}

void *xmalloc(size_t size)
{
	void *mem =3D malloc(size);
	if (!mem) __coverity_panic__();
	return mem;
}

void xcalloc(size_t num, size_t size)
{
	void *ret =3D calloc(num, size);
	if (!ret)  __coverity_panic__();
	return ret;
}

void usage(const char *err) {
  __coverity_panic__();
}

void usagef(const char *err, ...) {
  __coverity_panic__();
}

void die(const char *err, ...)  {
  __coverity_panic__();
}

void die_errno(const char *err, ...) {
  __coverity_panic__();
}
=2D- snap --

I _guess_ we could "help" Coverity by providing some alternative
implementation of `strbuf_add()` that does not use `memcpy()` but instead
a loop that explicitly NUL-terminates the string.

But it feels wrong to do that because that would weaken the analysis
because Coverity would not actually analyze the code that is executed
anymore.

> I've suppressed a similar issue by using the attribute __nonstring,
> but I don't think that will work for git, because strbuf->buf really
> *is* a NUL-terminated string, where as in ext4 we have some fields
> which are designed to be NUL padded, but it is *not* guaranteed to be
> NUL-terminated:
>
> #ifndef __nonstring
> #ifdef __has_attribute
> #if __has_attribute(__nonstring__)
> #define __nonstring                    __attribute__((__nonstring__))
> #else
> #define __nonstring
> #endif /* __has_attribute(__nonstring__) */
> #else
> # define __nonstring
> #endif /* __has_attribute */
> #endif /* __nonstring */
>
> struct ext2_super_block {
>        ...
> /*068*/	__u8	s_uuid[16] __nonstring;		/* 128-bit uuid for volume */
> /*078*/	__u8	s_volume_name[EXT2_LABEL_LEN] __nonstring;	/* volume name *=
/
>        ...
> };
>
> (This is needed to suppress warnings by Clang as well.)
>
> Using __nonstring will result in attempts to use s_volume_name in "C"
> string context to give a warning, which is why this isn't right for
> strbuf->buf.

Correct. I guess we could fool around with the model file until those
false positives are gone, but I have to admit that I cannot justify the
time to work on this.

Ciao,
Johannes
