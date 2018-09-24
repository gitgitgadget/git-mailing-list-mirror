Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7EE1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 23:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeIYFZ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 01:25:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43351 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbeIYFZ3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Sep 2018 01:25:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 73CE021F37;
        Mon, 24 Sep 2018 19:20:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 24 Sep 2018 19:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=MBp+cl2arYBRuT/LtNOzpk02u3a3N
        r9/64t/Gv+Mulo=; b=PdLbT2xYrFeuL6jz5rXnl5f7o1OxnORK7JQEyCUu/Js0t
        QsoT8mBhItnMrQEKCZf0bSiWDOPz1g3NNwgBtby2wv/H6Wmks0AzmoENOLK55rtI
        ugGtnWJoML4abpKt9m1iouYYe5vnOg4wAW8Vhpif52TrzNDzUbHcRhwwQb/t/31H
        NM5fO+VGqUtwjq2R0kIpq/B1h89s08TbUbInxCyrEEU5xJ566y6592H5tXZ1sPhp
        Xnj9z/HToFXaHr7g+/mqRSKtmlGojN8XdcJkibagak4952Fo901UD79xYoruRgl9
        rhn1p/CqajIi5Lj5Dvtg2dM2k5+w0Ks5Mynv7bO/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MBp+cl
        2arYBRuT/LtNOzpk02u3a3Nr9/64t/Gv+Mulo=; b=a04qsnucxcHIQ7/aroKhh5
        wFWWyNE55vIilMLbbcgWVaJuSUZ0hFa6Q6g3s80+ifYScy1GB+Oy+oAydw2TEwEh
        s0ApJd2Un3Lj02qNGYymkU7APVdEOQtOTdVeQki4M13Xee7zMgxnpfo6LEkS/zuh
        i/eWngFFGV96ADLRhr15CK6AyE67106Q3GxkC0WeoWGKdTrfp+oF4nRjhdQriJU5
        nKsMY+rVawjmniqeqwsnkhBnUPCJEsCfQNaDWqBeI7SC7A3dw+GKAfUN94yzjTOw
        nCw9zUYGIsCHZpn87vMx0+sUd+0OI9abqaMDvpRkToJV75w3RUwW0rD8QzICa9EA
        ==
X-ME-Proxy: <xmx:VXGpWx9cb6-13rM7Kj3RMpOh8krWa1aenNiZoJIOUQOavdtHXg5TBg>
    <xmx:VXGpW_JIAzuZmj9Au9IYbRyA_2nNLJDKo_Vvd5byvuQ_4LmnbnyquA>
    <xmx:VXGpW-nInX2q8Ke3zgzJGODDF1F3TrfQCUxp0PqjyBU72WfllkBD5w>
    <xmx:VXGpW7P0Zgv4qGSZJAIoc6qBN1_9KWPSaMn0ptwDykx5CRXMCwCwNg>
    <xmx:VXGpW83o30RxpFDvxTcY5A884oRNjTvR2XooBPs8HbI3is1oYpcIvg>
    <xmx:VXGpW2YhE7US6z-j7bxEvuMbhrw7cacnQXvMc0_fhGJgz9-ytF8drw>
X-ME-Sender: <xms:VXGpWwcyLf8qNAbQBGsE-vM2EiDVMh85lEneexWLBMagBCiOjpilIg>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED986E47C8;
        Mon, 24 Sep 2018 19:20:52 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <87bm97rcih.fsf@evledraar.gmail.com>
 <20180908211436.GA31560@sigill.intra.peff.net>
 <ad56c575-1211-61d2-daed-5b0da61db738@ramsayjones.plus.com>
 <20180909023332.GA14762@sigill.intra.peff.net>
 <xmqqk1nrojpq.fsf@gitster-ct.c.googlers.com>
 <20180911205709.GA25828@sigill.intra.peff.net>
 <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
 <87efdik3ie.fsf@evledraar.gmail.com>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <087d2065-6ba0-87b7-2a6f-bf2726aef829@stason.org>
Date:   Mon, 24 Sep 2018 16:20:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87efdik3ie.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-24 02:08 PM, Ævar Arnfjörð Bjarmason wrote:
[...]

> Posting to this mailing list is generally how it's done

Thank you, Ævar, for clarifying that there is no issue tracker for the
git project.

> The best way to fix stuff in git that you can't interest others in is to
> do it yourself. Take a look at Documentation/SubmittingPatches in the
> git.git repository for how to do that.

Based on the initial rich discussion this post created I had a feeling
that there was a lot of interest. But you're correct, it's easier to
share one's thought and patches take a lot more effort and time.

> In particular, starting by clarifying the docs around this as I
> suggested upthread might be a good and easy start to your first
> contribution to git!

That's an excellent idea. Philip started the process and hopefully it
will lead to better documentation of the issue.

Thanks again.


-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
