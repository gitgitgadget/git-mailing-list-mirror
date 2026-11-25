Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616429;
	b=2xc3Dxeo8fSc7egrFE5w+wLPVyi0j55q9UmmyTIEjEcKBwf4qx8cOHqu7kuNvWEMLEtb
	 gQhKUK75IVdsSleUHKFwdw5hqNbyP9MF/+H7dOsvKzdjzTdI1lU9phS6d4QKcklBtNV4Z
	 15qJ2Ts+AwcOdz10dxJ7Ww6vgnu7R3grabHf8FiveVcNfug9Ke7WkAEiG89IbwW6WCXGQ
	 27aho27OcQ7BopEnf5/YYyLfZgcGeEUxhx2QcSLDd5g1nSs59wJlg2dFJsN8toRPuPVDY
	 AWS81jQM6Kn0ZPLvNTJDIDhlbqpvKAmofJl3bO8FwyG/EBVKtp1590yG2Nzrzuvop/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616429;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport:Content-Transfer-Encoding;
	bh=d2Y9mnG6pAcE4m13CZJrnE1oylaqOAnOw2XrKNP2VuA=;
	b=ZistRarvFeAabrxohUVFsyxEpY7+U32+Bmc1YxJ1Lmz9V1ibdcc76puXLuz1vwdPWM0u
	 gtbQvTPXbG28xwaTJdNAXrX6Q+CMYtVzpzy8rJNQo4DzBehss3Z0UQirar4kpqbBhkCxN
	 FJjfmXC6CpLxrq3BIhVnwYF0O46Zb10JJgnkmPXCuRpNxGDnHfCHOuD9Am+Gbr3Q2rxJS
	 3n9MjowJE5TXFfSgHemJfUX9jVPy78C8rcGzZA4xUIX98RBV7gKQaFNLQ1txrAl21n2Xv
	 71OzOCfNkV5T4pmn7+A3ijV2UM1PEYalO/12HCMgGzd7SvpLh6Tg19nGbYVC5UHpkDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="gcP/pkE8";
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52161606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52161606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gcP/pkE8
DKIM2-Signature:  i=1; m=1; t=1795616426;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:uZfGyXZc2vEmex4RVOVZsW7osp2A
   3N6Q9ge4cC8dA4On+8nGlDwPS1jJ/xsvxeSnsRwtDR0wXlWw4mufwMuwhmANxYjJ/Irx8cjoEE7
   iixeKoGbQAdw2spzT0Y2IP4bcomvfEfjbzgChVAWSlWU3cB4jIzt8XDcDgOGuUseua6Z5Xmg1Lo
   cghY9flQ5E0Nvt15PnTVpNfv1c7f2zhx3rE8mnICZTkyggJ8lvW61LSXmz/niptHRP3H8KrnDNJ
   2doV6vhJYx7umjx3pJc3Ios33Axgd68GgPvEvwy8jNRnam0ezyKFcAD5KppafoO0pAEPtyqp/Zf
   v5TyB8qFMpSRPQ==;
Message-Instance:  m=1;
 h=sha256:
   ThCHWgIh3/jAxxfGkcRvS6nwyMSGZKwENAamcCOSSfQ=:
   ylDp6pvw43xyftAnc+fduFNT02XQSf6FZMH8Ly7LMao=,
  sha512:
   LbokKLrjTkgcSgsiJMfshNzUPyguRh0Lm2QCFcahiXeVHkKSRQdZBuysxQil7fTQpl1gicNv3LOTwgtyQGpbcw==:
   lTX/ihpE8QXhgUDI34knPgExduGV4OFp2E70cPh/nasE2coePDnNpPXkpTltNfj9VvBgo4hhyEq9JNqsS63VjQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795616423; x=1796221223;
	i=johannes.schindelin@gmx.de;
	bh=d2Y9mnG6pAcE4m13CZJrnE1oylaqOAnOw2XrKNP2VuA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gcP/pkE8dXtZy7YMCgkMiTlsMeTZq+NWxBb6buS1cgzZFnwtPmdsAcyi7r4yV7u2
	 91KpHjRK70g+ChPNg3dsJzTDxPxxSwmf02JgyVdHcpU0LvcfNuKqKrrkE2UfFyDsc
	 c4kSjgIvKwttMnJ+v0u1jeQQsuul+YFu9T2KSPqgW+H4X6IwqxVXstKeLiDiG6q4E
	 9SdbOCk7ZChmweQA1bDzyNHGiNTv1zEUndLONVvFAtT/MVRhPTcyR/sGhZYPucyAq
	 jWY8JnlDbcKMO20m+3VLAbIfNRtR39Gqx5YPyCc9VRJi/6oO8COJk6FhmnHTbO07r
	 eYHPPfJ61henGrbxnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1yQg451Oxm-00t6D0; Wed, 25
 Nov 2026 15:20:23 +0100
Date: Wed, 25 Nov 2026 15:20:16 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: phillip.wood@dunelm.org.uk
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
    Harald Nordgren <haraldnordgren@gmail.com>, 
    Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [PATCH v2 3/5] wrapper: avoid byte-count overflow in
 write_in_full()
In-Reply-To: <2cf35f82-9477-4ef8-bbbd-42fd06d487ea@gmail.com>
Message-ID: <3b2f0d79-c1a3-6b70-54ea-64983d3b446b@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com> <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com> <b24520c50dc1ccc079ce6194b9ff9028e38e1b2b.1795472027.git.gitgitgadget@gmail.com> <2cf35f82-9477-4ef8-bbbd-42fd06d487ea@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:iE4VwxOe/1z0JesPB8mUXg7g5sngqLcDxH7KRnjGWVWxJaddnZJ
 TXZV7COEkMpYuU195JytSNCHkLzjXTM9I2pUfa1OeigMxwZxXQbvIQMkV/zJOnMBS9z7uUN
 zYdueqhaQG7YuRdpiemtHPK29u9bUttbyB1pk7WfG9rVoCvJ6f80aG08eXBZVIw9K7S4jp4
 ZlmarrE4hDl2Txb7zEylA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wEgYo+7phbo=;sqLiSbmruEOtyqAej4YtGI0BfAE
 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
 bXfDBqtEfc8Ug7BqWl+XrY=
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Tue, 24 Nov 2026, Phillip Wood wrote:

> On 23/11/2026 22:13, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > Accumulating the output count in `write_in_full()` can overflow becaus=
e
> > it counts via a `ssize_t` variable which can overflow for valid `size_=
t`
> > sizes passed as input.
> >=20
> > Since this function either completes the requested count or fails,
> > callers already know how many bytes were written on success. Let's jus=
t
> > return status instead, so the total transfer size need not fit in
> > `ssize_t`.
>=20
> This makes perfect sense and the changes in this patch all look good. Lo=
oking
> at how the callers of write_in_full() use the return value, there are a =
few we
> might want to tweak.
>=20
> In config.c write_section() and write_pair() both return the result of
> write_in_full(). All of the callers of those functions are only interest=
ed in
> whether the return value was negative, so there is no problem with the c=
hange
> in behavior, but we might want to change the return value to an int to m=
atch
> the new prototype of write_in_full().
>=20
> In entry.c:write_entry() and parallel-checkout.c:write_pc_item_to_fd() w=
e're
> still using a ssize_t to store the return value even though it is now an=
 int.
>=20
> In odb/streaming.c:odb_stream_blob_to_fd() we're also storing the return=
 value
> in a ssize_t. Unlike the cases above we can simply avoid storing the val=
ue at
> all.
>=20
> One final note - in refs.c:transaction_hook_feed_stdin(),
> sequencer.c:pipe_from_strbuf() and transport.c:pre_push_hook_feed_stdin(=
)
> we're storing the result in an int and then checking if it is negative, =
so
> this patch actually fixes potential bugs in those callers.

Great call-out! I adjusted the callers accordingly.

Thank you,
Johannes

> Thanks
>=20
> Phillip
>=20
>=20
>=20
> > Pointed out by Coverity.
> >=20
> > Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Assisted-by: GPT-6.1
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   Makefile                        |  1 +
> >   imap-send.c                     |  2 +-
> >   notes-merge.c                   | 13 ++--------
> >   t/meson.build                   |  1 +
> >   t/unit-tests/u-reftable-stack.c |  2 +-
> >   t/unit-tests/u-wrapper.c        | 42 +++++++++++++++++++++++++++++++=
++
> >   wrapper.c                       |  6 ++---
> >   wrapper.h                       |  7 ++++--
> >   8 files changed, 55 insertions(+), 19 deletions(-)
> >   create mode 100644 t/unit-tests/u-wrapper.c
> >=20
> > diff --git a/Makefile b/Makefile
> > index 4c84eea6e2..0687eb82d3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1564,6 +1564,7 @@ CLAR_TEST_SUITES +=3D u-strvec
> >   CLAR_TEST_SUITES +=3D u-trailer
> >   CLAR_TEST_SUITES +=3D u-urlmatch-normalization
> >   CLAR_TEST_SUITES +=3D u-utf8-width
> > +CLAR_TEST_SUITES +=3D u-wrapper
> >   CLAR_TEST_PROG =3D $(UNIT_TEST_BIN)/unit-tests$(X)
> >   CLAR_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUI=
TES))
> >   CLAR_TEST_OBJS +=3D $(UNIT_TEST_DIR)/clar/clar.o
> > diff --git a/imap-send.c b/imap-send.c
> > index bf1d2cf74d..dccc2264de 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -392,7 +392,7 @@ static int socket_write(struct imap_socket *sock, =
const
> > char *buf, int len)
> >    	n =3D SSL_write(sock->ssl, buf, len);
> >   	else
> >   #endif
> > -		n =3D write_in_full(sock->fd[1], buf, len);
> > +		n =3D write_in_full(sock->fd[1], buf, len) < 0 ? -1 : len;
> >    if (n !=3D len) {
> >     socket_perror("write", sock, n);
> >     close(sock->fd[0]);
> > diff --git a/notes-merge.c b/notes-merge.c
> > index d361e70a48..991490a187 100644
> > --- a/notes-merge.c
> > +++ b/notes-merge.c
> > @@ -319,17 +319,8 @@ static void write_buf_to_worktree(const struct
> > object_id *obj,
> >  =20
> >    fd =3D xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
> >   -	while (size > 0) {
> > -		ssize_t ret =3D write_in_full(fd, buf, size);
> > -		if (ret < 0) {
> > -			/* Ignore epipe */
> > -			if (errno =3D=3D EPIPE)
> > -				break;
> > -			die_errno("notes-merge");
> > -		}
> > -		size -=3D ret;
> > -		buf +=3D ret;
> > -	}
> > +	if (write_in_full(fd, buf, size) < 0 && errno !=3D EPIPE)
> > +		die_errno("notes-merge");
> >  =20
> >    close(fd);
> >    free(path);
> > diff --git a/t/meson.build b/t/meson.build
> > index 1cf1d95f70..8938d4eb47 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -27,6 +27,7 @@ clar_test_suites =3D [
> >     'unit-tests/u-trailer.c',
> >     'unit-tests/u-urlmatch-normalization.c',
> >     'unit-tests/u-utf8-width.c',
> > +  'unit-tests/u-wrapper.c',
> > ]
> >  =20
> >   clar_sources =3D [
> > diff --git a/t/unit-tests/u-reftable-stack.c
> > b/t/unit-tests/u-reftable-stack.c
> > index b6f1c6cc52..3e19f0466a 100644
> > --- a/t/unit-tests/u-reftable-stack.c
> > +++ b/t/unit-tests/u-reftable-stack.c
> > @@ -86,7 +86,7 @@ void test_reftable_stack__read_file(void)
> >  =20
> >    cl_assert(fd > 0);
> >    n =3D write_in_full(fd, out, strlen(out));
> > -	cl_assert_equal_i(n, strlen(out));
> > +	cl_assert_equal_i(n, 0);
> >    err =3D close(fd);
> >    cl_assert(err >=3D 0);
> >   diff --git a/t/unit-tests/u-wrapper.c b/t/unit-tests/u-wrapper.c
> > new file mode 100644
> > index 0000000000..713ac0df92
> > --- /dev/null
> > +++ b/t/unit-tests/u-wrapper.c
> > @@ -0,0 +1,42 @@
> > +#include "unit-test.h"
> > +#include "tempfile.h"
> > +
> > +static struct tempfile *file;
> > +static char data[128 * 1024], actual[sizeof(data)];
> > +
> > +void test_wrapper__initialize(void)
> > +{
> > +	file =3D mks_tempfile("wrapper-test-XXXXXX");
> > +	cl_assert(file !=3D NULL);
> > +	for (size_t i =3D 0; i < sizeof(data); i++)
> > +		data[i] =3D i % 127;
> > +	memset(actual, 0, sizeof(actual));
> > +}
> > +
> > +void test_wrapper__cleanup(void)
> > +{
> > +	delete_tempfile(&file);
> > +}
> > +
> > +void test_wrapper__write_in_full(void)
> > +{
> > +	int fd =3D get_tempfile_fd(file);
> > +
> > +	cl_assert_equal_i(write_in_full(fd, data, sizeof(data)), 0);
> > +	cl_assert(lseek(fd, 0, SEEK_SET) =3D=3D 0);
> > +	cl_assert(read_in_full(fd, actual, sizeof(actual)) =3D=3D
> > +		  (ssize_t)sizeof(actual));
> > +	cl_assert(!memcmp(data, actual, sizeof(data)));
> > +}
> > +
> > +void test_wrapper__write_in_full_empty(void)
> > +{
> > +	cl_assert_equal_i(write_in_full(-1, NULL, 0), 0);
> > +}
> > +
> > +void test_wrapper__write_in_full_error(void)
> > +{
> > +	errno =3D 0;
> > +	cl_assert_equal_i(write_in_full(-1, data, 1), -1);
> > +	cl_assert_equal_i(errno, EBADF);
> > +}
> > diff --git a/wrapper.c b/wrapper.c
> > index 05a9cd369c..87e1b4bfd2 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -302,10 +302,9 @@ ssize_t read_in_full(int fd, void *buf, size_t co=
unt)
> >   	return total;
> >   }
> >  =20
> > -ssize_t write_in_full(int fd, const void *buf, size_t count)
> > +int write_in_full(int fd, const void *buf, size_t count)
> >   {
> >   	const char *p =3D buf;
> > -	ssize_t total =3D 0;
> >  =20
> >    while (count > 0) {
> >   		ssize_t written =3D xwrite(fd, p, count);
> > @@ -317,10 +316,9 @@ ssize_t write_in_full(int fd, const void *buf, si=
ze_t
> > count)
> >     }
> >     count -=3D written;
> >     p +=3D written;
> > -		total +=3D written;
> >    }
> >   -	return total;
> > +	return 0;
> >   }
> >  =20
> >   ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
> > diff --git a/wrapper.h b/wrapper.h
> > index a6287d7f4d..726c5c2f6b 100644
> > --- a/wrapper.h
> > +++ b/wrapper.h
> > @@ -45,7 +45,10 @@ int git_mkstemps_mode(char *pattern, int suffix_len=
, int
> > mode);
> >   int git_mkstemp_mode(char *pattern, int mode);
> >  =20
> >   ssize_t read_in_full(int fd, void *buf, size_t count);
> > -ssize_t write_in_full(int fd, const void *buf, size_t count);
> > +
> > +/* Return 0 on a complete write, or -1 with errno set on failure. */
> > +int write_in_full(int fd, const void *buf, size_t count);
> > +
> >   ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)=
;
> >  =20
> >   /*
> > @@ -57,7 +60,7 @@ ssize_t pread_in_full(int fd, void *buf, size_t coun=
t,
> > off_t offset);
> >   */
> >   ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt);
> >  =20
> > -static inline ssize_t write_str_in_full(int fd, const char *str)
> > +static inline int write_str_in_full(int fd, const char *str)
> >   {
> >   	return write_in_full(fd, str, strlen(str));
> >   }
>=20
>=20
