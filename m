Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF58208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeHFU3j (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 16:29:39 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37775 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHFU3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 16:29:39 -0400
Received: by mail-yb0-f193.google.com with SMTP id r3-v6so5658148ybo.4
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsBYuD0McsK6YQX8g8ZpMoPVM2xuc9A1WtVv4DnKjqM=;
        b=ZN1/PWkb6eCUqJIBUp5lyhLGjoT4y7Aq6KUrDB5cYVeTA9H89KBtHAUDlgOxqd/NVw
         ZDt6HYWBVHDitcJJq/H+srtHcg//pK/rFNA3aqXHe7UUKjhsChjHtw0pWlDs3urCiwpn
         tDqjCbE4CquhcOcNAgGg4h65CnMuEeAjIHR3TO4/CyoMMyax+QjwPBKfevOHfAYCATMD
         bOdtLsBfk9at82tLSZkeI2QPZjO5J0n+uz1gG8/XZVEBWUkzp1Veb6GGKB8u4PMhP4sz
         iTu5M2iVlkhnu23LSCCY6G+F+mFinE/KodA2b1GGoFIcDqVG/1rNEJxYmnX/b9Z0vFJc
         GLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsBYuD0McsK6YQX8g8ZpMoPVM2xuc9A1WtVv4DnKjqM=;
        b=JWeR9A3ULC5gW0f43C7U592Ai8wNC4gv5My2ZzGDED2qkisZGmq6Y5JCZaoYhujKK2
         wfg9b7fbH9V+PAm6W8hh/eZF5ckNN/hzMKom3mr0ICrfUs+IIF3UvA6QASSSHYVXieTz
         tfFjVFZiR3evfJIaFlpASUROhn/oo43qbYm896+7Ck6qPIua1QItBwQt2wxGiK/cABf5
         YSD6bq5nKdPCokRXmVOa09dU0QyFxIhAzhtMKiAipkBHvooh4mjJ7yUYL8izRfbc2VIN
         1QqI1YVhyGdQpBKG92UOJakZ4Mx3JjMAHkyErc1HNjI5tizsPU90g2lsLRY1yo0Wb2LR
         6deQ==
X-Gm-Message-State: AOUpUlEipt79R7KJwfdSV9adbaMpIHmAL+QXO2KrWSm+pYAbsnVHgySI
        XgDRXCz++US4cBiXff/sXXqsJW3SWoHbno5Ti+ND5Q==
X-Google-Smtp-Source: AAOMgpcDxS5f/RAyNH5d72hIWKYFHrn8m2WTN7+6eMliFeZaww63/AtYOzjaKPRFfZ7U0tRnnKN/rtuTIbakR3iv6Qk=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr6330795ybm.307.1533579561924;
 Mon, 06 Aug 2018 11:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-7-ao2@ao2.it>
 <xmqqd0v01trp.fsf@gitster-ct.c.googlers.com> <20180803130334.3979eedb0733c609815e9fd5@ao2.it>
 <xmqqbmajzadt.fsf@gitster-ct.c.googlers.com> <20180806125828.66fc99ef0b118e26e0b3e60d@ao2.it>
In-Reply-To: <20180806125828.66fc99ef0b118e26e0b3e60d@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Aug 2018 11:19:10 -0700
Message-ID: <CAGZ79kbXtQP+Q+xCn5f6CO5Wk_3dbHeEVgny4jGnTwwW0j_LSw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/12] submodule--helper: add a '--stage' option to
 the 'config' sub command
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The consistency I was referring to is merely in the mechanism used to
> deal with .gitmodules: by always using "submodule--helper config".
>
> As a side argument: in some previous discussion Stefan mentioned the
> possibility that, in the future, he may be interested to explore
> different locations for submodules configuration, like a special ref,
> to prevent .gitmodules from being in the working tree at all, not even
> for writing submodule configuration.
>
> Having an opaque "stage submodule configuration" operation would
> prepare for that too, but as I said this is not my immediate goal.
>

Thanks for demonstrating that this will be easy to achieve in the future!

> Having said that I can drop patches 06/07 if this can help moving things
> forward; or if I had some success in convincing you I can improve the
> user interface (any advice?) and the commit message.
>

I think dropping the patches would be a good idea,
given that this is not your immediate goal.

Thanks,
Stefan
