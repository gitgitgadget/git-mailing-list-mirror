Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B95F208D0
	for <e@80x24.org>; Mon, 21 Aug 2017 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbdHURU3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 13:20:29 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:37637 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbdHURU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 13:20:29 -0400
Received: by mail-wr0-f176.google.com with SMTP id z91so103229675wrc.4
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 10:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MzBPDANfRxlzC/ZQ/1quqD9SwC7zxg8OWdJ7xOX2aTY=;
        b=jbXPa+FfdBX08O4Tea7ABgxs0EQtzN928ktWRnwmEXiBD0ZUA1MXBAL71fhYuuwES/
         i5eQ4DwEOrvaeABNCT+KafcSBM9/L31hwqVGmlvDSghxkToMJzjFiDoXysuleuo6mwpN
         qZErujbswqOkouZ2zatPgJjZ+/nIbZ5N+zWDl4HkguO5g55clkkNHfavqtLhoVIxdCkL
         Fk6UYu79jmX0l4yZX6KfGIZw3bSeCLMqO63AOybtTgSHVR25Y8hOkECDM1WxzPFtDcbI
         fsM1/Zk7sH3saSWwTxFnISg1j83+pxlPz8COCyM73Kp80myabR4rdr5Vn45hFgQ2tjhT
         VsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MzBPDANfRxlzC/ZQ/1quqD9SwC7zxg8OWdJ7xOX2aTY=;
        b=rnL28tmb9mikoVazCj1JWOdlAzFy8pxAI1gIWbw18YO86XuvRZ7RMUG9bl4CefOpTc
         LhbnnbtoGnTYdsyZnx7UaCxc0f4N54sSA7g5O7k/U5/Qi/ScA+DOGUCeQgXAAvrbZY7R
         bbsP3AMTCsrJsr3KC6IKmsIyGDYrJ5G1yoKOBKMa5Spdftx8vA7mc5df47Dd3+hP7Xnw
         zUqdKbldMnrLQzXQQuOyLrp1VqDil0WliWIXQtmU4EAk80Rjd9XbYN0Ui5QNiWJxfI/2
         pIxN5J31qFc4KfmBoWWJYnToE8GS3xYzhV58HaOzR6JhEUU3agOlolWfyZDmeZ4noJrn
         2Liw==
X-Gm-Message-State: AHYfb5hph89xBKyTggMusRjFo87hiXfu1eF8cBtIVHBasoOF7pYLA4Mt
        jIoL5HcO7/FHMw==
X-Received: by 10.28.238.19 with SMTP id m19mr212615wmh.94.1503336027780;
        Mon, 21 Aug 2017 10:20:27 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 90sm9905018wrs.18.2017.08.21.10.20.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 10:20:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pull: respect submodule update configuration
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com>
Date:   Mon, 21 Aug 2017 19:20:25 +0200
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <85ED93BC-1E27-4B8D-856D-090C6860BAB0@gmail.com>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com> <20170818220431.22157-1-sbeller@google.com> <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com> <20170821162056.GB1618@book.hvoigt.net> <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Aug 2017, at 18:55, Stefan Beller <sbeller@google.com> wrote:
> 
> On Mon, Aug 21, 2017 at 9:20 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> 
>>> So I am a bit curious to learn which part of this change you dislike
>>> and why.
>> 
>> I am also curious. Isn't this the same strategy we are using in other
>> places?
>> 
> 
> I dislike it because the UX feels crude.  When reading the documentation,
> it seems to me as if submodule.<name> can be one of the following
> 
>    (none, checkout, rebase, merge, !<custom-command>)
> 
> This is perfect for "submodule-update", whose primary goal is
> to update submodules *somehow*. However other commands
> 
>    git rebase --recurse
>    git merge --recurse
>    git checkout --recurse
> 
> have a different primary mode of operation (note how their name
> is one of the modes from the set above), so it may get confusing
> for a user.
> 
> 'none'  and '!<custom-command>' seem like they would be okay
> for any of the commands above but then:
> 
>    git config submodule.<name>.update "!..."
>    git reset --hard --recurse
>    git status
>    # submodule is reported, because "!..." did not 'reset'.
> 
> Anyway. That dislike is just a minor gut feeling about the UX/UI
> being horrible. I wrote the patch to keep the conversation going,
> and if it fixes Lars problem, let's take it for now.

Well, I need just a way to disable certain Submodules completely.
If you show me how "git config --local submodule.sub.active false"
works then I don't need this patch.

I tried to make it work here:
https://public-inbox.org/git/89AB8AA3-8E19-46BA-B169-D1EA4CF4ABE7@gmail.com/

Thanks,
Lars
