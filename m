Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01AA31F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeAETBO (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:01:14 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43763 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeAETBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:01:00 -0500
Received: by mail-wr0-f193.google.com with SMTP id s13so2706232wra.10
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 11:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ypr8PxbKlRSd/Uk/+HywVvrD1aigZJ+oLtZnyjAYxhI=;
        b=pHFIgluRNqsgr206gEtPFZknBEN513q9LNqQ3xQBoE663Y0SxIu5gVafxtyj/raegH
         p37dltGxHEjAftddnO4qK5y/jGmPYSWJgVB5P0MGx4+fndWG8MBl1mf25zDC5LNtXt7e
         VXYgAym7mPF0lTVEuVQUlotBLIimrk23F2SjqqwBoCrYj1iQHf1GTplJ+e/1pCgbTRgG
         qNNkW+ZWNSlpCdT+Srzmwf+nq7pFak6zZz6XedVQMznEkzySjdFE81yDxFFRTW4/KAus
         XHi1S8mQehhZycL2RqL4uhD5MnmfsaFVA2RZEG81USJBWE8+gDOFP73REquBvn3CzMZk
         JxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ypr8PxbKlRSd/Uk/+HywVvrD1aigZJ+oLtZnyjAYxhI=;
        b=M3jaR9WQ0MBbf5TpV/CV7KNjYaayfUJxt7Mko2U5bs4fkmPmIZYpFuIO4HyjJNa8/S
         9P3vhj22cSVzWGmc6W6jDDGBi5YfUVIRKanMxe0+gX8K+1zrpoOnzVH9mcJxR5Er2HKF
         HPeh2Yxy5Z9zlWq3Uql+qVCEkwLoiHhwhJ77PUb+NhwvBGeRMywKXbn1HyWWnmRL1jqq
         1mWMJpyKMbhIl37UxyF0AcJPQBY/pM+pDvid7uXm2Dfw6ZyxL5Bde2na1kHnBIqGWqmY
         hbQwqTtLQSiDPhfmXIHdA0VHxx2Jwb7juTmM/hIbOlIoxWeF4fwlmxID+DYcIT7aP6kD
         yXJQ==
X-Gm-Message-State: AKGB3mIMdw0nuk0nPqJeg4jfhmzhSfHFsJOrvG25jI1HA3T+2Qkcwdzs
        o+KJla7VgCOkEAYfi05966E=
X-Google-Smtp-Source: ACJfBovOyBkvNK4ALSL3obLIyhVdWMtwbXLA7dmjcHZFm8b+3GUhW3KnNuT+1yiBm1dnxDF00lDM2A==
X-Received: by 10.223.128.164 with SMTP id 33mr3932570wrl.85.1515178859052;
        Fri, 05 Jan 2018 11:00:59 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d7sm8523375wrd.54.2018.01.05.11.00.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jan 2018 11:00:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/1] convert_to_git(): checksafe becomes int conv_flags
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180101215959.1460-1-tboegi@web.de>
Date:   Fri, 5 Jan 2018 20:00:57 +0100
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <B45F57FC-E798-4C8F-9C40-200944D86029@gmail.com>
References: <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com> <20180101215959.1460-1-tboegi@web.de>
To:     tboegi@web.de
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 01 Jan 2018, at 22:59, tboegi@web.de wrote:
>=20
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> When calling convert_to_git(), the checksafe parameter has been used =
to
> check if commit would give a non-roundtrip conversion of EOL.
>=20
> When checksafe was introduced, 3 values had been in use:
> SAFE_CRLF_FALSE: no warning
> SAFE_CRLF_FAIL:  reject the commit if EOL do not roundtrip
> SAFE_CRLF_WARN:  warn the user if EOL do not roundtrip
>=20
> Already today the integer value 0 is passed as the parameter checksafe
> instead of the correct enum value SAFE_CRLF_FALSE.
>=20
> Turn the whole call chain to use an integer with single bits, which
> can be extended in the next commits:
> - The global configuration variable safe_crlf is now conv_flags_eol.
> - The parameter checksafe is renamed into conv_flags.
>=20
> Helped-By: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> This is my suggestion.
> (1) The flag bits had been renamed.
> (2) The (theoretical ?) mix of WARN/FAIL is still there,
>    I am not sure if this is a real problem.
>=20
> (3) There are 2 reasons that CONV_EOL_RENORMALIZE is set.
>    Either in a renormalizing merge, or by running
>    git add --renormalize .
>    Therefor HASH_RENORMALIZE is not the same as CONV_EOL_RENORMALIZE.

Can you elaborate a bit? I am diving into the code but I am still =
confused.

I also noticed that the "flags" integer is potentially double booked =
with
the following values (see read-cache.c:add_to_index()):

#define ADD_CACHE_VERBOSE 1
#define ADD_CACHE_PRETEND 2
#define ADD_CACHE_IGNORE_ERRORS	4

#define HASH_WRITE_OBJECT 1
#define HASH_FORMAT_CHECK 2
#define HASH_RENORMALIZE  4

Is this intentional?=20

Thanks,
Lars


More context:
  =
https://public-inbox.org/git/96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.co=
m/
  (3) We kind of replicate some flags defined in cache.h:
     #define HASH_WRITE_OBJECT 1
     #define HASH_RENORMALIZE  4


