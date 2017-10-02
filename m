Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22438202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbdJBEOF (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:14:05 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:49087 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBEOE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:14:04 -0400
Received: by mail-pf0-f177.google.com with SMTP id n24so2335014pfk.5
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 21:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a82NlQiZpDbPHGOAXQaJsTsvSWs/rtfUkIDDcP6z9/M=;
        b=YdD9orh2Q5EyVIlsR8PVdUaaisz0nJEMnbKHYxAd40E1gDHQcqDQnUyCtSfOP9JJvQ
         QGNx21TnrP/76mOHCa1r27GpLI0OK8eB8w5rna8l1rbsTQF3YBKvl2vRYYZ2DrIjgdrM
         JTHBvVzIBoUOYPgkWp7s0Zvu1kA9hCVAWnmhiAczC0PGMDBiTN761KLjFe98+mJB1pkP
         MgIei3pn65aWQqIXYwIdh0NTiJ7UzqaM0y/Wjas4WhMMEl3eRQyh9Mjhj3hjy123bqvT
         LFttEfo44+4EyGOadHm/e2zTHMECjL0n99zCj+IrGoTIAlfn5ei6vjixeml1DwBTW/rE
         +FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a82NlQiZpDbPHGOAXQaJsTsvSWs/rtfUkIDDcP6z9/M=;
        b=U3OKP3eOSGiZe5CAIrQo+goAnQXo3wWYH6pit6+18vL8W7YiDtqGp/pITNLqW/RjRk
         yO3Fsv5efGilFYIG3GAA4oED6rimeIphI1wuYaCS955hONtbYbdZVm74Dq+xAa+oHToc
         Le1HbxA8qs3XODt4mmAiWSFi744+ciohSfgQLwCsyq6d2e8CLvF0jCySdPsRQ0NMw8h3
         ippMfWgs0WGPf5LFQMA3nTZTbfZysPJEsuAEhG3MOjYPAhhqgMTmzi2D5mwYEP828ZLv
         9XEB/CPKkhdBpgy08OxAdSlXQW0A02Q4HxCI7PE3coqLWwFpwIDQig1miMIxIKrribcK
         2zPQ==
X-Gm-Message-State: AHPjjUh9O0nRRg+9UNpHjRaKkMcBlrFIxaIpsfAZ+mlYQ5CrDqKZLrqH
        KDE/dwrft1g1uSfLN5QtFwdwlu43Ekyk2VvZfHA=
X-Google-Smtp-Source: AOwi7QCdGOd191EGWhPEv3p0ctGinl4PDvZ6iBldAvZqhJsh9hjp9GfEAxmsR70GJFMAH2qmuU7YrbO6meGVNQ2PbfI=
X-Received: by 10.101.81.135 with SMTP id h7mr11759843pgq.48.1506917643786;
 Sun, 01 Oct 2017 21:14:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 1 Oct 2017 21:14:03 -0700 (PDT)
In-Reply-To: <xmqqd166qkeg.fsf@gitster.mtv.corp.google.com>
References: <cover.1506862824.git.martin.agren@gmail.com> <d912e33a1395ff25c1496715d0a537858daa885a.1506862824.git.martin.agren@gmail.com>
 <xmqqd166qkeg.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 2 Oct 2017 06:14:03 +0200
Message-ID: <CAN0heSqPVpgYSfUpmiBaCVtZkMiqWC3rgzFcBu2TVr3m7Gq4UA@mail.gmail.com>
Subject: Re: [PATCH 09/11] read-cache: require flags for `write_locked_index()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 October 2017 at 05:49, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> ... Instead, require that one of the
>> flags is set. Adjust documentation and the assert we already have for
>> checking that we don't have too many flags. Add a macro `HAS_SINGLE_BIT`
>> (inspired by `HAS_MULTI_BITS`) to simplify this check and similar checks
>> in the future.
>
> I do not have a strong opinion against this approach, but if
> something can take only one of two values, wouldn't it make more
> sense to express it as a single boolean, I wonder.  Then there is no
> need to invent a cute HAS_SINGLE_BIT() macro, either.
>
> "commit and leave it open" cannot be expressed with such a scheme,
> but with the HAS_SINGLE_BIT() scheme it can't anyway, so...

I did briefly consider renaming `flags` to `commit` and re-#defining the
two flags to 0 and 1 (or even updating all the callers to use literal
zeros and ones). It felt a bit awkward to downgrade `flags` to a bool
-- normally we'd to the reverse change. But maybe I shouldn't have
rejected that so easily. If we have a feeling we won't need other flags
(or the "don't even close the file") any time soon, maybe it'd be good
to tighten things up a bit. Thanks for looking at these.
