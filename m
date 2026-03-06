Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994C33556D
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763607; cv=pass; b=tcILbHDr95dRXLPDnmnPbduYNY+OLwSMjWB41Rh6hAFXRMnrIzKP2Yhn7Bn7e/QfG8TPUznXuwUhacI1jdqAucq0+0IgTOfepnfj8lssGDqAUdylLIitJJZbCXvVohhnPFUl3GQZn7FkxkJCb8MgEJpdX6304pIzBp2bQWinCQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763607; c=relaxed/simple;
	bh=rzSd5cekBZYtifepF9w2RtGgohPFfU2Jxqqki5kqxuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RX6AByVHzLeaiAO7ekg15d7NPrY6ieIezh1L5Hm55JNNXg6Wst2ruJsrb10ei60mIgebPOC1tXHbdfseKkWa7luEthO7D/MT1mej4X+Niio0Ssw+8Hja5m33C7Q2WpWeabo2pFoqPxgl2hlElD1kMmcwX4ir4IB7dsRDe1XzzgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFM3/0Y3; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFM3/0Y3"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6610bd5f322so3884756a12.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 18:20:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772763602; cv=none;
        d=google.com; s=arc-20240605;
        b=hl+OWlSv2+kLPRF5Dht0OIFbJM77uJJgpI2wmihc4uPfg+VN2ctbySuAB7owJxJiNd
         qigmKY2ikHGWPIocIYPqJ6f+2FFk/42x/oLtpbw86bzbx0hjw6fTiY5AOGUjQq9/nmW2
         NuIqtsjOMwiqpJPCHvC+f+ZpsfGn635ZA+QEcGhELcVc7y+mHNefAjo06WwHhnzcetfR
         +EEfcSlRilZdAHZF9XBcGlk20jY/m2TrNimNeonxAWf/u3GkT2hoa2njODFasZCZlAPP
         3b8+cSMMh5ZcGQIli8izaw+HA65f10U7DYVUFNXIDMdEKrU6aFBQQXKtl0nRfMM5kTIH
         a/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4GFeMiyOnus08fTFMxiamevqDOwMKWMLNnIMUSG7Im8=;
        fh=jMc30gLc/3HbAXTNv+LNb0oaOvMomeqB0RBKIFqlclw=;
        b=gNHEKLwcdbDuXBx6rjjFzLzDcfOWBL0oeSubb0fgp8w4AptyqxpALoiUL7k8EmV8cs
         BMB5CStMtnxch5jMxplUrgLNbGjrHmSmxlW6etuVjH5wcNEIuouR/mZPKOlQ2H17fZSm
         0RhlG50WMMd5oEfea8jqDlrN95hQjc0ZQDXh8ugV7fzRFYPfdN7rk1iwwSvvKYJRSL5X
         KwszS5+BCVsnDD+4giJE0GxT61ZmxpGH0U7JXziMPWtFui7WN8kCRKs1R0NLGFpsaM3X
         KXXv52brFFOwK7TB3ePuig9NtzUXV7SNxdX4/nVemSbj92F/Z1lBJzeDTS4qonpghiqi
         y7PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772763602; x=1773368402; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GFeMiyOnus08fTFMxiamevqDOwMKWMLNnIMUSG7Im8=;
        b=XFM3/0Y3fbjXE++Bn6IJ0otN280ruKHO9rSvIImTDJguK4MeixmCq35/7dDARXAwhC
         HJX/5xcBEOYFhfBQ32hVvhhbXhMmE6dxhwCVYG//r1inmiDDHI+3IFeNsVUdRnaGBvs+
         E0lzFtNwkPgJyCgc7fRRP63oI+JV5QF9RKZydBn6bQHEnK+v7jQ+bf0iIr+cNz00n1dA
         HOSKc1HmBQXNZnttby2zGmDCi2NHu8Vdl6jA8258rM7/g6GGh3mrfMPMl6CTp+KnV3m9
         DV9ubKFk75AYeAxwrZjb+/e+s8x+tFW5tZGzxONS/1RWfuP3nMMPzlzfAEhQVLmWpqu2
         sKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772763602; x=1773368402;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4GFeMiyOnus08fTFMxiamevqDOwMKWMLNnIMUSG7Im8=;
        b=ka+QNI/FCRFKJoBaH6mbRq+gyONot7Baizwijnw5D23WpnJ18gO7tzqJIxEmkxDq0R
         FhqfI3x3WluRU9Mlc2wZ++o5J0O/L19d09JssUYR3R49j717F6RO5Z+N2JCM1Yn8+KWJ
         b9fw6oEw7qjK15sWYHEU1OUXzVWdgYsHyFsGQLJK6egCRqZHGsjHVml0c2+wkP5IfoCY
         tAtuwjpbt8UDD4Iijhb3sjAOZvytztgNsmBj6N5pht62YpF92/u7ZWj+0mFCSjqLF0MZ
         HCE2U90oOEOAk3DlBCXUF7kkC5we9gFpKmp2/SL7F2XNvFc6/vlxcxRZMJTW+OHkrC3F
         1dKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzNUMjxX26E/JsTLcvNHuAT6qp5Vi+GWLfzrmGm7xxVPTMrC+aEuGySi2ezJ9Oc2G9efY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkseXhlgMwrESCqDLFeyy7SuVfbT/zsFFzcGZzriI7oadxu8ca
	jYLb6Ryu72FuWpLxTNuhdQjyKKnnKcQrzb/x2Fio9NuDglmgcd9SMMV29LorXMZD7O4sxmVJHUB
	M/3HwQDbU0rIF31ILa3yL8p11jW88sx6+luZSzhY=
X-Gm-Gg: ATEYQzx0C0Ru8+ADUtroxPOXStSA1n/8ezNhg+V2QFhS6d4FG7hdVflI7JuE5NKi3Uk
	ZOfmcnUCJ3U7SH8lMb0VgKEO1LyvcDVPfNEYPuFRYJzm/mmBSzirFIfDc3U1aVlzCIrc08E71RS
	kMP5ReDRoOW+IGqbbYG2UOEItABxes0+URFBgi6NYIZVeIo116oPadxIZQ9g4bmNnMgv3Xt6jaV
	gapZrJx12AAnHUpFK89UdusJ+9uxBGyPGfFIUtZual5BolXBZ8fCkhjuozzaLPEKqcBoG9NhX+P
	pcZ+msxSjgH9cxN2R9Lb7qxBaMQLhAWc8kNMUjO79NPw7Xty+iI1w2wPMRIbcprR1l2jzd4GJlR
	aKdUslkPyNXF+t0h6EaqVXvVif5lTasDBvlE=
X-Received: by 2002:a05:6402:5191:b0:660:a4ad:1685 with SMTP id
 4fb4d7f45d1cf-6619d4e3905mr177801a12.18.1772763602501; Thu, 05 Mar 2026
 18:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
 <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net> <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
 <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net> <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>
In-Reply-To: <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>
From: Ivan Ivanov <qmastery16@gmail.com>
Date: Fri, 6 Mar 2026 05:19:50 +0300
X-Gm-Features: AaiRm51iXMnDJY4GnqDkyMEvEnoeuTQsqbDfkGRmi-7FaTSVWY1rOJYjtGSLGMU
Message-ID: <CAAaskFCNCE9tgoYOLQYJRjxreFjyw0jpvBkxADXJtwHYRx50rQ@mail.gmail.com>
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Ivan Ivanov <qmastery16@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I.e. test 5564 "t5564-http-proxy.out" output may be interesting:
(during that I got asked "Password for
'http://proxuser@127.0.0.1:5564" on a prompt, after pressing enter the
tests continued to the next ones)

not ok 5 - clone can prompt for proxy password
#
#        test_when_finished "rm -rf clone" &&
#        test_config_global http.proxy http://proxuser@$HTTPD_DEST &&
#        set_askpass nobody proxpass &&
#        GIT_TRACE_CURL=3D$PWD/trace git clone $HTTPD_URL/smart/repo.git cl=
one &&
#        expect_askpass pass proxuser
#

checking prerequisite: SOCKS_PROXY

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-SOCKS_PROXY" &&
(
    cd "$TRASH_DIRECTORY/prereq-test-dir-SOCKS_PROXY" &&
    test_have_prereq PERL &&
    start_socks "$TRASH_DIRECTORY/%30.sock"

)
prerequisite SOCKS_PROXY ok
expecting success of 5564.6 'clone via Unix socket':
    test_when_finished "rm -rf clone" &&
    test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
        {
            GIT_TRACE_CURL=3D$PWD/trace \
            GIT_TRACE_CURL_COMPONENTS=3Dsocks \
            git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
            grep -i "SOCKS4 request granted" trace
        } ||
        old_libcurl_error err
    }

=3D=3D Info: [SOCKS] SOCKS4 request granted.

On Fri, Mar 6, 2026 at 5:14=E2=80=AFAM Ivan Ivanov <qmastery16@gmail.com> w=
rote:
>
> Brian, thank you very much for checking my logs: indeed, unfortunately
> my system is Arch-based so we can't compare it directly with
> Debian/rules. Thank you for an idea about /dev/shm , although I would
> like to clarify that while it *might* be what is failing this
> particular test - the causes of failure at .out files are different as
> we could see by the prior 0300/0301/0302 and some future tests (could
> share more logs if needed). But the external appearance of these
> errors (Username/Password prompts) is similar to a user and that may
> indicate some common pattern between the problems, i.e. maybe there is
> some extra shell precaution needed on some systems (although I'm a bit
> puzzled why my distro's packager seemingly didn't have such an issue).
> I am still trying to build with skipping as few tests as possible, at
> the moment I have to skip the following: t0300 t0301 t0302 t5003 t5411
> t5540 t5541 t5550 t5551 t5559 t5563 t5564 (adding them to
> GIT_SKIP_TESTS one-by-one, maybe there'd be more)
