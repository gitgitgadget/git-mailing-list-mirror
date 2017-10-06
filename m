Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2582036B
	for <e@80x24.org>; Fri,  6 Oct 2017 07:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdJFH7M (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 03:59:12 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:46088 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdJFH7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 03:59:11 -0400
Received: by mail-vk0-f42.google.com with SMTP id o191so7743560vkd.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5oMjqvB2vNco3G/ZzbkSWsHBgiRR3BrdSpDKUl2FIdc=;
        b=l8tnkr56fga5MsRuHUFXTNdgXLpHwHFCNEl9Adx1Tpof+ZEPsuChffsgjOqd8GehGU
         P1mVg1iZ+5xwlSFB2RndjMYuRuF62yvgNllOMFMXQTcFgNPeXQQ2Rk85wpIpvFYcWKnU
         9JopNLd44MiEe4Xo7RkiInbbz/vaMyq9weqS2OxLa+VX+C8JLfsPmTBP4TZ/xaSQ06+P
         FKFnNL3EVOTWLsUb6N/2z9mBfNWC+gU7BFmtDHIV4jimXNzSOcbHZFV6OGXo348Ot4Vj
         VIbs50+CBo2hTAnD/8VYM74SxM/2f6w3Mxqr/OUgy7wbvscwH4Wm1JKfx/V+095NTN+Q
         ykaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5oMjqvB2vNco3G/ZzbkSWsHBgiRR3BrdSpDKUl2FIdc=;
        b=KWdoe0THfPiBXaYVsUT7ASgJTKY4nsnGnVVrkXmU4uRB/wpPDU8LsG4fK47Rsqpgxb
         unRuTDPaox3NNYsJEdBLV34xtjpJc0TuRm90p0D3O72aEI8eFv8NcpcAVsmsE5gPSXrU
         FEyj2NHdmXN1F6wIRlvJ6n8hHDrw1ej2BWuvXcHd5E06dFSaq6CmKkRlXH+rKqzkwyAY
         rXoT7driRmNHFKSE+TvdoQX14O/Qpv9attJawXw78lny3gPhVizeiKUUc4lwK4bQlhRC
         ffpSLANF1ExoSTUjvGoTjE3T7gzl4erNOFtwe1d3OHldsIF2Lt4ykeoDHL7lAWGBg4Aj
         1hbA==
X-Gm-Message-State: AMCzsaVC92OU7xSJ6Azf/VwnXw0Fyod/cE0jeuexQy8+gbJVIQ1OOzof
        NpE2wA+juDYfoXjtF4SeGhBM22vm0oLPjvzIECM=
X-Google-Smtp-Source: AOwi7QAGP5mFYrrNNYCPdtC54IOImHNGuiANOeal5/uxbkmqCx4V2OlEYLdCHBTYOpYJaBbJDtLFL5/cgMlfzT820Ns=
X-Received: by 10.31.186.71 with SMTP id k68mr537969vkf.98.1507276750429; Fri,
 06 Oct 2017 00:59:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.16.157 with HTTP; Fri, 6 Oct 2017 00:58:49 -0700 (PDT)
In-Reply-To: <20171006060542.llx4golnkuxksy7z@sigill.intra.peff.net>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
 <20171005104407.65948-3-lars.schneider@autodesk.com> <20171005112355.lsoqxybgsovpqriy@sigill.intra.peff.net>
 <xmqqlgkoyk8n.fsf@gitster.mtv.corp.google.com> <20171006045640.vihagnlnuximzmjs@sigill.intra.peff.net>
 <xmqqd160x16i.fsf@gitster.mtv.corp.google.com> <20171006060542.llx4golnkuxksy7z@sigill.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 6 Oct 2017 16:58:49 +0900
X-Google-Sender-Auth: 0dEg7V7fgP2k6NOCXwo6TyC9C3c
Message-ID: <CAPc5daU4K3=-qhOiMx73oyCX7tGCv87L4uB9pu3M2C90s2sLMg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] entry.c: check if file exists after checkout
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2017 at 3:05 PM, Jeff King <peff@peff.net> wrote:
>
>> Because we cannot quite tell between the two cases (one is error--we
>> wrote or we thought we wrote, but we cannot find it, the other is
>> dubious--somebody was racing with us in the filesystem), I think it
>> is reasonable to err on the safer side, even though an error abort
>> while doing "as we know we wrote the thing that match the index, we
>> might as well lstat and mark the cache entry as up-to-date" might be
>> a bit irritating.
>
> OK. I can live with that line of thought.

Still that, or any other, line of thought we follow to declare that it
is a good change should be recorded in the log ;-)
