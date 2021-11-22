Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF4C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 11:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhKVLuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:50:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:46945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239414AbhKVLun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 06:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637581650;
        bh=1prYYZ2PMAY8WntV8AGOP3AA4iZa93ch2151KudVago=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YiFdt5yOycjUhCqWJ0MRj2xRt181gH01Qf3q1oX2b9V/YLyqltoji//96nDLNmoKg
         hYwCl+DFlbpDjkrlcEkqTAIxPx0zNDLXaOArMi4/G3HJb9gibBCyJuKzl4d1OfJOQp
         HyxHaoL7yQpFBRth/HxDE+nbo+44zFHwxJ+JBrj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1mqYZd1aFH-00GJZb; Mon, 22
 Nov 2021 12:47:30 +0100
Date:   Mon, 22 Nov 2021 12:47:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99
 support
In-Reply-To: <20211114212437.1466695-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2111221245460.63@tvgsbejvaqbjf.bet>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net> <20211114212437.1466695-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BwqqhNH42l9ZvNAEMYaVLQxXhpFbwYkqbG26saGBr6VmI3RncrK
 p4yNxfnr7QomF+i74xWlILEGCCvpei/H6Vs1bYqJhcyCWmpxbYONns5rKPiUD36NH2yJ9He
 h+11nVaTdB+qf2DsVtd+InDQ9v8BlRo8EA4dZFNuJlZvSYMgOLT6hdkpr0FX2bXmRADp2KK
 cowC2aetQjsr6UYBQUYBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eczT+CJZ0V8=:94arGuHO60ua61sywdBGWO
 lKb+pnMIlwBG8Pai0UJq93O5QMpAoQw9VESiDpALYQlyZL2VqDc2+n9MNX0v1NsihhK/QCMm5
 T42BhkyjBSlrzhD8eHECqS7P9465tNSVABDINZqAFMkwXLGdKJTugH4bR0TLnvCdUXznpfKls
 0Eg9Cuc+nM84jTUI28xkqcCtR2nPAKAL8gN4SbS/nEJunFzDa5yh1iRZDtE/zz9tUaRdSrE+L
 I5sWfVl15MXMccLSkCRwD+vB7ZyI7394RMphYBpIjy4PvLA6wVdv5RLyLgFIx1+TqCXMsk3X7
 zgVs8XjRitXkX9Sh6tkIPmtK6LCyIloVRR4/HIjXeky+uS+THpCN0Osr9tZ/fOR/FpU7q1RqM
 W0ZhIXeo/JIuy1qeRdZbyvIsksuzG2MGhXvcyUnkg7Sy5vyDCb9Rukby7iPEBgurVQSzP4ubR
 xtHT9D9ywsQUmQarYNqwKqqX4TLwKIGgXAbbU5ndGemyNZ1Wpr8Lm137v5wy5sHX+z9Uj50gn
 9IqyLC+8sFI3yRdaBl/XYp8GJgPxgBHBfXSsm/Y9NCKsxWIxZ+DTuHj9CS6qKzDLJwX4fr0U3
 6b04P0uQE7UDF/ZzdaNwiZaQVNvIjm9wh1w6ln+8LNGKVyGk5I2aqu++Di9jHwhDa+NTzuPoa
 NG4I5GbeVEcHY7pjZxxNGhkbAIIaGTSoHlF/3Xg9JalJ5y2eLoTcXQI4l3vY1IDHdEE8mby9q
 yYkA7Fgj1UHjgwmaWzUVnB9eYTqpQ54YQBoiBOBZSXia+bOQWycsx2KnlIhOS/5YkRXAfpGoB
 R12FLpCO/k4yLZOqltDq2vvvuYVwS0IxQveNRzjAYMSEQ8EGWPOG0HyN0OKWCfkPB6BsMSaW+
 rdyd3kNShSyf6/WUrsQQNe+iug4GO59itd2xDy+rPR9EDk4qB/gecvlOXG66uxHZDG8k9CPi8
 EEhV56PFgSXeg9FQ+HTKsLS1Wxl3Kd6LkNvfDEHBKO9LgfHpDIl0hoUF6A1d4gqCw5ogrbU3g
 g64lboGZ1+PttRAUq6hcLhVAtVjEcAXhYISGGMwPhGRJxde8iY7eyrvySEhMTr5SphKqKKTix
 NU3XW8vzHHbgnw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sun, 14 Nov 2021, brian m. carlson wrote:

> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index fd1399c440..91e8525fa9 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -208,7 +208,7 @@ endif()
>  if(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
>  	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
>  	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
> -	add_compile_options(/MP)
> +	add_compile_options(/MP /std:c11)
>  endif()
>
>  #default behaviour

If we do this, we also need the following patch, to ensure that
`FLEX_ARRAY` is once again defined in a way that is acceptable for MS
Visual C:

=2D- snipsnap --
commit 9043470c19170643d1f74d6767a0df5d72e6c35c
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Mon Nov 22 12:39:40 2021 +0100

    fixup??? git-compat-util: add a test balloon for C99 support

    This seems to be required to define `FLEX_ARRAY` in a manner that MSVC
    in C11 mode accepts.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/git-compat-util.h b/git-compat-util.h
index cba8ad260043..fcde3588172f 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -45,7 +45,7 @@
 /*
  * See if our compiler is known to support flexible array members.
  */
-#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >=3D 199901L) && (!def=
ined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
+#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >=3D 199901L) && !defi=
ned(_MSC_VER) && (!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
 # define FLEX_ARRAY /* empty */
 #elif defined(__GNUC__)
 # if (__GNUC__ >=3D 3)
