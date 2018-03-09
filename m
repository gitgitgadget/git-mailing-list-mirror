Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6562D1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932068AbeCIRCx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:02:53 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35669 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCIRCw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:02:52 -0500
Received: by mail-pl0-f66.google.com with SMTP id w22-v6so5547881pll.2
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vKqty4dyPpAYqo6ekz/5dr60c8Qn8gdw/hm+SsOCNOI=;
        b=GRI23xYCJDZkl0sPnbYNavZ7TuKge4IcGxlrm0Q483lXoLSvhumw1C5MHcj342MHft
         qyV1HPamgXfvpxPYR3ETo8/+ld7qpALDpklCfFbLfNfbLHxCsp1LZn64/vpQye+CYeqN
         wwlhNcPwwbOner2nOJ9mQc/cbIWoJYEkZiiHheAmmqLkxkLM8vP8sanvFBCSV5kWtt2N
         uP3nOZg2T+qP0Vx0uoF4AeSsH2tmKV8zxBM2IrYHXoYuPZx+MUjtNbEnLNP2yTZa9mg6
         aOTRRHOVtJ1zuL98ASSUMZ7Alklt1Zl141tsAnAeFV4SVUatkoaY9G2bL7EsDKIU2cDG
         oShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vKqty4dyPpAYqo6ekz/5dr60c8Qn8gdw/hm+SsOCNOI=;
        b=Up53MhuRHCyaiEMV9fltBCuavXL0VN3002fVCh0fvx53wmF5yUPGkJqQX0vHkgyCDi
         xx5eabP0RHfpe+StWtOjwxsxTbnAFXsnuGgtbnxcK5NnLC7RadLnQ6FzN3WWeTy0viej
         jkCRs5/QyQtN+CsAm1AGoOPPCcdaUg+wiba+uNRVnPFxMxPGhhymBzG7yPLceekrWEBq
         kGwfetyXklit3uygA6dhfRIBYvSPwSVaF7DfMehSIr8l1TbC4h5kLUIffbPJOkWkn0bM
         oBHsfC0aidMXYaVFgc67qaQC3PigZJluo5ybGHwSFlBO0DxmAUYF7cZlnAloFgOP9URt
         R07g==
X-Gm-Message-State: APf1xPDvCNUGQF1ZWX+Yv83pGOXlpOX72+tfJu5j2Ma0rV9b6AC55qQL
        pfObS/Up083BdpIvmM087SE=
X-Google-Smtp-Source: AG47ELuClN0pt/CI6CX6e42z/MaElShEXKyUBi3FlPKp8rbhJsohqjyfyCMsNQs7uMqv/6fEe/Y3GQ==
X-Received: by 2002:a17:902:341:: with SMTP id 59-v6mr27811328pld.64.1520614972201;
        Fri, 09 Mar 2018 09:02:52 -0800 (PST)
Received: from remr90mpm73.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 2sm4011236pfo.70.2018.03.09.09.02.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Mar 2018 09:02:51 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cTsRufRNZbKJS-02fvbtaLB30FO3Em6HR_LZrsK+CfOjw@mail.gmail.com>
Date:   Fri, 9 Mar 2018 18:02:46 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <43D0E2A3-E265-4503-9E2D-4058437A8FCA@gmail.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-8-lars.schneider@autodesk.com> <CAPig+cTsRufRNZbKJS-02fvbtaLB30FO3Em6HR_LZrsK+CfOjw@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Mar 2018, at 19:04, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Wed, Mar 7, 2018 at 12:30 PM,  <lars.schneider@autodesk.com> wrote:
>> Check that new content is valid with respect to the user defined
>> 'working-tree-encoding' attribute.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/convert.c b/convert.c
>> @@ -266,6 +266,58 @@ static int will_convert_lf_to_crlf(size_t len, =
struct text_stat *stats,
>> +static int validate_encoding(const char *path, const char *enc,
>> +                     const char *data, size_t len, int die_on_error)
>> +{
>> +       /* We only check for UTF here as UTF?? can be an alias for =
UTF-?? */
>> +       if (startscase_with(enc, "UTF")) {
>> +               /*
>> +                * Check for detectable errors in UTF encodings
>> +                */
>> +               if (has_prohibited_utf_bom(enc, data, len)) {
>> +                       const char *error_msg =3D _(
>> +                               "BOM is prohibited in '%s' if encoded =
as %s");
>> +                       /*
>> +                        * This advice is shown for UTF-??BE and =
UTF-??LE encodings.
>> +                        * We cut off the last two characters of the =
encoding name
>> +                        # to generate the encoding name suitable for =
BOMs.
>=20
> s/#/*/

Of course!


>> diff --git a/t/t0028-working-tree-encoding.sh =
b/t/t0028-working-tree-encoding.sh
>> @@ -62,6 +62,46 @@ test_expect_success 'check =
$GIT_DIR/info/attributes support' '
>> for i in 16 32
>> do
>> +       test_expect_success "check prohibited UTF-${i} BOM" '
>> +               test_when_finished "git reset --hard HEAD" &&
>> +
>> +               echo "*.utf${i}be text =
working-tree-encoding=3Dutf-${i}be" >>.gitattributes &&
>> +               echo "*.utf${i}le text =
working-tree-encoding=3Dutf-${i}le" >>.gitattributes &&
>=20
> v10 is checking only hyphenated lowercase encoding name; earlier
> versions checked uppercase. For better coverage, it would be nice to
> check several combinations: all uppercase, all lowercase, mixed case,
> hyphenated, not hyphenated.
>=20
> I'm not suggesting running all the tests repeatedly but rather just
> varying the format of the encoding name in these tests you're adding.
> For instance, the above could instead be:
>=20
>    echo "*.utf${i}be text working-tree-encoding=3DUTF-${i}be" =
>>.gitattributes &&
>    echo "*.utf${i}le text working-tree-encoding=3Dutf${i}LE" =
>>.gitattributes &&
>=20
> or something.

The casing is a good idea - I will do that. I don't want to do =
"hyphenated, not=20
hyphenated" as this would make the tests fail on macOS (and I believe on =
Windows).


Thanks,
Lars=
