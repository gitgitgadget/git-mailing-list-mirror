Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7127C1F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeAFAzV (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:55:21 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37568 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753424AbeAFAzM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:55:12 -0500
Received: by mail-wm0-f51.google.com with SMTP id f140so5291591wmd.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 16:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M4ipvXFHyClDM9rm+paVjkLSnIYYg7RGWUU/PcwqZvY=;
        b=D8Ej3IGKRf3be5NcP8J5qplOzbvlfj12xvnFskUtEDxk2j1bbGvGl85qIzPTXu+mPX
         9YW2p00gnYk6nR/ExFwceotu6Xg7afvDZtRvD7FyFUPriCnrDnPKx323g/d24ECietAp
         4ch5sEOuxvmqQYvfRS/mkaJpqEI8ESgy3aSu53oFwmOzqWQuNkdamZYApQZTojwCP/D8
         g5kf8vHU5UCd70AgAVXM+UpHvnYy5Z5TRPI4dhq5GJE0qcuAkv8dctUo2A18BJRONNya
         ReJROg2Kmz2TDZDlLn4kQvXlLnl4cQwzSSptuunF4+KxPH79Asq13KzJdi0bTgm5+Xe7
         aQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M4ipvXFHyClDM9rm+paVjkLSnIYYg7RGWUU/PcwqZvY=;
        b=PFrbZ0WoaVGDXZNxFmwRBUCReQuZ7v1tnO/yMhLs21FnlDYjM354L6sbYn13VkMWYl
         hpvV8NQfRu+b4UAepY2RxyK+YIpaMd9qp7L4NWn2+4fMjkF5tIT8jgJkij42f5jYG6xW
         Gykpl9Ine3s44LTejJx/Wsn+uMnnsmAzUptwVwWnJyvvUGoRbHuiduy8pXsOMgMc8Q5B
         S1F3Yq5rPC3j/1vnT91DWbBFygWKkmv3fUsOSOZetpcVMD8OmdE0oN45vTnPxrR+KUR0
         FlfqN/rBEkqXbqH3xQG/J3T7bjyq0Adab7sorE9gf8g8f/kZMdshhxxA57oNxKwHuzuU
         +TpQ==
X-Gm-Message-State: AKGB3mKjM9fVHFl4yLz/Pb8qFn9IEfPuTNdtIWSl/1l2v/FU5sEHjvQY
        n89LNAsCB6WMNkpfktTAJd8=
X-Google-Smtp-Source: ACJfBov5jxORqeGOCrjx5uwMFqOtXEig3oQnLEwXcxa7GIaO87D3bdH6X+Djrrn/PIuRABNtyhpOWA==
X-Received: by 10.28.59.69 with SMTP id i66mr4051968wma.3.1515200111434;
        Fri, 05 Jan 2018 16:55:11 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB58F5.dip0.t-ipconnect.de. [93.219.88.245])
        by smtp.gmail.com with ESMTPSA id q196sm7925439wmb.22.2018.01.05.16.55.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jan 2018 16:55:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/5] convert_to_git(): checksafe becomes an integer
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqincfao1b.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 6 Jan 2018 01:55:09 +0100
Cc:     tboegi@web.de, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>, lars.schneider@autodesk.com,
        git@vger.kernel.org, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <02B54B51-5347-49D3-A932-0641611A3CE1@gmail.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com> <20171231080552.22258-1-tboegi@web.de> <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com> <xmqqincfao1b.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Jan 2018, at 00:22, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 31 Dec 2017, at 09:05, tboegi@web.de wrote:
>>>=20
>>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>>=20
>>> When calling convert_to_git(), the checksafe parameter has been used =
to
>>> check if commit would give a non-roundtrip conversion of EOL.
>>>=20
>>> When checksafe was introduced, 3 values had been in use:
>>> SAFE_CRLF_FALSE: no warning
>>> SAFE_CRLF_FAIL:  reject the commit if EOL do not roundtrip
>>> SAFE_CRLF_WARN:  warn the user if EOL do not roundtrip
>>=20
>> In general, I really like the direction as this simplifies
>> my patch later on in 5/5. However, I see a few problems:
>> ...
>=20
> Yes, this looks like a sensible way to go.  I saw Torsten's v3 for
> 1/5 but will end up queuing v2b, as I suspect 5/5 would need to be
> adjusted for the change between the two versions.

I just send out my v3 which integrates the latest version of Torsten's
patch into my series:

=
https://public-inbox.org/git/20180106004808.77513-1-lars.schneider@autodes=
k.com/

Please note: I did not rebase my series. Therefore, there is a small
conflict with 86ff70a0f0 (convert: tighten the safe autocrlf handling, =
2017-11-26)
because has_cr_in_index() was renamed to has_crlf_in_index().

@Junio: What do you prefer in these cases? A rebased series or the =
conflict?

Thanks,
Lars=
