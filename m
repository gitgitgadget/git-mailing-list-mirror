Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0EA1448DF
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033229; cv=none; b=mlnCWC4iG4B4zcqtmH06nHWB/b4iZePo+9YN/onurUImX7E8lrj6APzOGS57Du59Qd7sHonjzApiWiZoW+VDeBpzhuS9LlbdSGOih2lD+GwRkhN+lMk+frpsnAt78OK+XSCTWNaiwGTApS+5WThOyzm8HKM+xZ4j/m/xkWzZwr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033229; c=relaxed/simple;
	bh=q3XxIouay1WIlhAwIz7fbA0/o9qSn9hYgPyHsWDa9pM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N9rAhMqnbxWBFsAwDp7LCP/i1EDlF23H+OFC+dURGCqkdWv907WWCxxWC5b6offn9O7eDvCv1hxGQtLcSk43NiU/hjWz2jKTp9f2KMmUT/njKSTDJSpiarnYsCePLVeJfchqMIsnbRHwSsW91ubVRv2n6h40qJT2MTseijKRhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WasZc7Sa; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WasZc7Sa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728033215; x=1728638015;
	i=johannes.schindelin@gmx.de;
	bh=akaSm5uHLMD0A6b07W/a+cKmDCO5/H5+vBLA0LLtKp0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WasZc7SaO7dT+UpR8O4kEWs2EkfVckQ76f64alPsYIoB0+8EjftuJ6BE1yhx64dg
	 flL29qeHjlAnXmp+xpdbzfVETQvlmNkxj/W0dSXPYoTLhCGf7/W+BxwxsmBwgklTK
	 u/tyPhA9PtBWNPsB7FrBcq4EXw5WwjBTHtioP1z3OXaJYayMVKB8zGddf2+r46zW9
	 +vB+8o5AdmJ/Krz5Fee8IfjpOnuUXHqAOG/MUgLsskXGNO4H7WdpNhEaH0xpGVkMT
	 3GAN3D0snO9CIvLU2iQW0KA2gfZlT+A+LzcEJeikTJrULtZsTNOEcMLM+p7mL37Kw
	 KBVol+/ek7ENwhgCTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.169]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1sGyhF3vmh-00ac6k; Fri, 04
 Oct 2024 11:13:35 +0200
Date: Fri, 4 Oct 2024 11:13:34 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, 
    GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.47.0-rc1 test failure on cygwin
In-Reply-To: <Zv-HbT8qrM6IYKb4@pks.im>
Message-ID: <8718c5c4-1d0a-104b-eb39-6338ae9c5dbf@gmx.de>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com> <Zv9oIrKveu-JAGQM@pks.im> <Zv-HbT8qrM6IYKb4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LiOlmR5dOfuo5j+o+oJRrnOAaqMbuzMcJtRjVbge5pE94dgfwzj
 C8192xuNLXZnXkCc9xVgWNwytv1OajiVJlCryMzbscRYu7vi5qQrZa4YrE4IZZB2pLndTL4
 x7uiMZU60AYjYT/TE5NwSojMLZsENMXEFQWiQJjM1ROAOW/L7Vpf1BjcnlQvqdFeGj7HGPG
 NUFyrmp6kIYCIChvXabLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZBMYgggPTCc=;n+fpAtW4TlCWoUDuzz+6vmb7ef1
 TfpT1MnAvT8j8zHwvqlKxwbHKABy1c8CXYCqwAzxINHXllyCfWBtYH2Ckcmd7hYbyxp2pEvM0
 NfPC8GEqbLpC+E+q0jaZDZQakpcz7nd5fNI3wZ0wucCF9LlCDgfa6YFRsqKsGb4fNvtL0pdgz
 7Gy/zhJsqFRh7At6CvygtvpiXI6Okg7XdMmVUsaQ/T0f7pIEUt4F4PZVsM8Rq8Ml+RfoHJ4wB
 gU0FudsWCIV6XF0udjOcC6Qq8zscRYBFHqLjHZ3tlNqN04Rr+wtBEvDEk853Vi2WrzLyJHInH
 YFfDFSveGrxyoYfcT9BsXRoFFTh6kBtH0roR+qQqeoE/73PmaOpqR1a3xA8qSutmOkCPxshEQ
 Nwqa9PA+2vDkWmMpIFjcNpD/xejMzho+X/SWELBPs4QHCh/lGlehoATcMgZggtr+h0m+srpQt
 m21S6K43tYcLp4VOypx19WNLMf9Bsf8yPHXBimi1sJr7uuB0h9hmGORopd8fvK3vVqgmG81pV
 hKOMknkSFwYJLi5Pao9XMUsMWZgJAEq9BRbOi/blKhwKifhITKAgogy8P9h0L+5C47NOOWqPv
 m4N1U3Nq4AaTf6rRCOCq5rUphHtRh2HJnOZecWik7FnPpO6AIQyCKAVSpChfF9SOi0njqZGVy
 LN/mSwEzWAdvpV3hgjLf4cAUWeKlOXqovg1WuedWoqKmXDGNT0RFC4HGAru7ESHxKwbJwvp7r
 X5FtOoU78c5MS8TJHyb+es0K9spy/djYlG0hPxwpHPQYc7Uf7/wq8XuevlhL5Rpi0RHcvHj4u
 g8FuUSbxdkLM6xhQp2eu9iqw==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 4 Oct 2024, Patrick Steinhardt wrote:

> On Fri, Oct 04, 2024 at 05:59:30AM +0200, Patrick Steinhardt wrote:
> > On Fri, Oct 04, 2024 at 02:02:44AM +0100, Ramsay Jones wrote:
> > >
> > > Just a quick heads up: t0610-reftable-basics.sh test 47 (ref
> > > transaction: many concurrent writers) fails on cygwin. The tail end
> > > of the debug output for this test looks like:
> > >
> > [snip]
> > >
> > > t0610-reftable-basics.sh passed on 'rc0', but this test (and the
> > > timeout facility) is new in 'rc1'. I tried simply increasing the
> > > timeout (10 fold), but that didn't change the result. (I didn't
> > > really expect it to - the 'reftable: transaction prepare: I/O error'
> > > does not look timing related!).
> > >
> > > Again, just a heads up. (I can't look at it until tomorrow now; any
> > > ideas?)
> >
> > This failure is kind of known and discussed in [1]. Just to make it
> > explicit: this test failure doesn't really surface a regression, the
> > reftable code already failed for concurrent writes before. I fixed
> > that and added the test that is now flaky, as the fix itself is
> > seemingly only sufficient on Linux and macOS.
> >
> > I didn't yet have the time to look at whether I can fix it, but should
> > finally find the time to do so today.
>
> Hm, interestingly enough I cannot reproduce the issue on Cygwin myself,
> but I can reproduce the issue with MinGW. And in fact, the logs you have
> sent all indicate that we cannot acquire the lock, there is no sign of
> I/O errors here. So I guess you're running into timeout issues. Does the
> following patch fix this for you?
>
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 2d951c8ceb..b5cad805d4 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -455,10 +455,7 @@ test_expect_success 'ref transaction: many concurre=
nt writers' '
>  	git init repo &&
>  	(
>  		cd repo &&
> -		# Set a high timeout such that a busy CI machine will not abort
> -		# early. 10 seconds should hopefully be ample of time to make
> -		# this non-flaky.
> -		git config set reftable.lockTimeout 10000 &&
> +		git config set reftable.lockTimeout -1 &&
>  		test_commit --no-tag initial &&
>
>  		head=3D$(git rev-parse HEAD) &&

That looks plausible to me, as this test is exercising the POSIX emulation
layer of Cygwin much more than Git itself (and therefore I expect this
test case to take a really long time on Cygwin). If it turns out that this
works around the issue, I would propose to use something like this
instead:

		# Cygwin needs a slightly longer timeout
		if have_prereq !CYGWIN
		then
			git config set reftable.lockTimeout 10000
		else
			git config set reftable.lockTimeout 60000
		fi &&

> The issue on Win32 is different: we cannot commit the "tables.list" lock
> via rename(3P) because the target file may be open for reading by a
> concurrent process. I guess that Cygwin has proper POSIX semantics for
> rename(3P) and thus doesn't hit the same issue.

Indeed, this is where the symptom lies. I worked around it in Git for
Windows v2.47.0-rc1 via this patch:

=2D- snipsnap --
diff --git a/compat/mingw.c b/compat/mingw.c
index c1030e40f227..56db193d1360 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -784,6 +784,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	int fd, create =3D (oflags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXC=
L);
 	wchar_t wfilename[MAX_LONG_PATH];
 	open_fn_t open_fn;
+	int tries =3D 0;

 	va_start(args, oflags);
 	mode =3D va_arg(args, int);
@@ -813,7 +814,11 @@ int mingw_open (const char *filename, int oflags, ...=
)
 	else if (xutftowcs_long_path(wfilename, filename) < 0)
 		return -1;

-	fd =3D open_fn(wfilename, oflags, mode);
+	do {
+		fd =3D open_fn(wfilename, oflags, mode);
+	} while (fd < 0 && GetLastError() =3D=3D ERROR_SHARING_VIOLATION &&
+		 retry_ask_yes_no(&tries, "Opening '%s' failed because another "
+			"application accessed it. Try again?", filename));

 	if ((oflags & O_CREAT) && fd >=3D 0 && are_wsl_compatible_mode_bits_enab=
led()) {
 		_mode_t wsl_mode =3D S_IFREG | (mode&0777);
