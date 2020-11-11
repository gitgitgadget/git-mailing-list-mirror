Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F104CC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991E02074B
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 16:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKKQJ3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Nov 2020 11:09:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:45124 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKKQJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 11:09:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0ABG9Kl1033055
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 11 Nov 2020 11:09:21 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'James Knight'" <james.d.knight@live.com>
References: <20201111095420.1446-1-avarab@gmail.com> <20201111095420.1446-3-avarab@gmail.com>
In-Reply-To: <20201111095420.1446-3-avarab@gmail.com>
Subject: RE: [PATCH 2/2] config.mak.uname: remove unused NEEDS_SSL_WITH_CURL flag
Date:   Wed, 11 Nov 2020 11:09:14 -0500
Message-ID: <012701d6b845$03bde880$0b39b980$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI65rKnRZv7H5ZMm4Sq5UB8kjuF3QFAvDOrqPC2EtA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 11, 2020 4:54 AM, Ævar Arnfjörð Bjarmason wrote:
> The NEEDS_SSL_WITH_CURL flag was still being set in one case, but hasn't
> existed since 23c4bbe28e6 ("build: link with curl-defined linker flags", 2018-
> 11-03). Remove it, and a comment which referred to it. See 6c109904bc8
> ("Port to HP NonStop", 2012-09-19) for the initial addition of the comment.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  config.mak.uname | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/config.mak.uname b/config.mak.uname index
> 8d7b96f8b9b..5b30a9154ac 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -541,11 +541,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	# removing the directory at OS releases J06.21 and L17.02.
>  	# Default to the older rm until those two releases are deprecated.
>  	RM = /bin/rm -f
> -	# As detected by './configure'.
> -	# Missdetected, hence commented out, see below.
> -	#NO_CURL = YesPlease
> -	# Added manually, see above.
> -	NEEDS_SSL_WITH_CURL = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	HAVE_DEV_TTY = YesPlease
>  	HAVE_LIBCHARSET_H = YesPlease
> --
> 2.29.2.222.g5d2a92d10f8

This should be fine. We will test when rolled in, but I can't see an issue here. Sadly, I can't remove the junk above those deletions yet.

Thanks,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



