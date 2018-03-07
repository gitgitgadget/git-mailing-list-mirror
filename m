Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9DC1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbeCGWtL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:49:11 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35138 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeCGWtK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:49:10 -0500
Received: by mail-wr0-f180.google.com with SMTP id l43so3811380wrc.2
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DHa87+kFYiPIcouhcLgrMWMSLtnNRprap8GgbQAE2l8=;
        b=HeZlZEXfnabPFbmp2+BeJmksP+2y6sIcDfWBEH0XsoKDEsJ5nsdh2nO8J78NMrQwJi
         0C22XmcuN/kvHkhYoEcQ5NUhAHh7TtciaDdI5vID2jwi1VIZ4G43zw+fIfW8n61OdZtr
         R/hMhwyFnUbO/3ws7OKzBU4KBkYjg2YCSR2SqSUDdovPQLhA/rJDedFKdK5vh9iMnnlw
         8M6eX1OyWw9R2VVR0ddudOuVzdVIhmvVifixUasIpGypyRZP8tz2EF0FocmE6B7PumMJ
         EFknk/MGGrYfKQO7OVx0b8qglVR2bL0yughhg7LwnxRiJeWfHGaaohIaBYYjNPYFHOz9
         djzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DHa87+kFYiPIcouhcLgrMWMSLtnNRprap8GgbQAE2l8=;
        b=hPTUfJ+YXtmLGQ0RjJqdQ7JEBgyGtrv+i6Bc6r31IJb3QKC9D4KXEFYZlh2Es4KLIr
         9qN8+sHQMvdwk2E+ef3Rs4saVEFB7gxRi7etQwkNu9YuIJJymJlwbXLMI0leu9UFCm6G
         hTcPx2Xdhg1e7GdrQFYFFsw4UZJQ26uD5T+l6PGBfDxyp6sY9D/hBVrbOp32551YohJ2
         TnjMTn2WK9NfyNwuBYcA9uglMG1A4Su4vvogIqIXPGaysw2fj1Tawqb8vOxFpVtvKqyV
         XcxqZoWVSPAePQBAsr259+s77B9lGvoMDTY6/DRH3TR01pLretVXnIofJIboahQnlmxA
         7NBw==
X-Gm-Message-State: APf1xPCwjSNAitE4BqA6pTGOX323iwn5VMMLNtB/qMANAQ3H9jNGp8CU
        uRBIJbqEWMNifD/y5bcJ3yU=
X-Google-Smtp-Source: AG47ELvCpwjRiTpe6+MA6au0XzqoULty0bRGZV+gPVAdk1kQ6YA1tjRrrQlDfyFmwSfd5eWtIu/Qhg==
X-Received: by 10.223.179.82 with SMTP id k18mr20800293wrd.173.1520462949712;
        Wed, 07 Mar 2018 14:49:09 -0800 (PST)
Received: from [10.6.133.146] (135.red-80-28-119.staticip.rima-tde.net. [80.28.119.135])
        by smtp.gmail.com with ESMTPSA id r70sm20948695wmg.40.2018.03.07.14.49.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Mar 2018 14:49:09 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqa7vjzfcp.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 7 Mar 2018 23:49:08 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <766B302C-446B-4730-A5D9-909C6FCF6A84@gmail.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-8-lars.schneider@autodesk.com> <xmqqr2ovzmwo.fsf@gitster-ct.c.googlers.com> <B001E8E2-9C98-4136-87A3-4425C50E90DB@gmail.com> <xmqqa7vjzfcp.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Mar 2018, at 23:32, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> I also would have liked to advise "UTF-16" instead of "UTF16" as
>> you suggested. However, that required a few more lines and I wanted
>> to keep the change to a minimum. I feel this could be added in a
>> follow up patch.
> 
> I'd say the whole upcase thing belongs to such a follow-up patch if
> that is the case.
> 
>>> On the other hand, if we are not enforcing such a policy decision
>>> but merely explaining a way to work around this check, then it may
>>> be better to give a variant with the smaller difference from the
>>> original (i.e. without up-casing).
>> 
>> See example mentioned above: "Utf-16". How would you handle that?
> 
> Dropping LE suffix from "Utf-16LE" or "Utf16LE" would yield "Utf-16"
> or "Utf16" if the advise message does not force policy, or "UTF-16"
> in the canoical form if it does.  Is there a problem?

In the case of has_prohibited_utf_bom() you are right as we are 
dropping the BE/LE suffix in the advise. However, look at the 
is_missing_required_utf_bom() advise. Here we *add* BE/LE.

At this point I thought it would make sense to make the advised
encoding name uppercase in both situations. OK with you?

- Lars




