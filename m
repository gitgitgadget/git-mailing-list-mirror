Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4911F424
	for <e@80x24.org>; Tue,  3 Apr 2018 09:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754852AbeDCJyq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 05:54:46 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:46986 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754784AbeDCJyp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 05:54:45 -0400
Received: by mail-pl0-f52.google.com with SMTP id 59-v6so5407990plc.13
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hxzOFqhgqXleE33TC6ldA+3mfjLYp+jAFORv6guIH9I=;
        b=d9pkoszuUW64jKx6EO6c7sO11t+tja4mgdYPVvy1WpyG4ANkhA6vrWadwrYmHOYOqF
         /kSi+1o/ec7ovwzrAO3hHrA7zYWdpt3f+WdXRYTaRUhG/BA28oeuJI4jC/kSxqGHtW3p
         GJcCGUPDM9vU6W2U1O2ZetPaRuKdYpdZAKjWQ1jiYX31JeD8T8fwnPM4FVt0/6nmTItf
         xCv0BBEc4ex3x0tS42yrCRlhO5ICAF98peKOvd41kGCdOEWjNa5d3NwswYx55dHtvcrn
         OGNruFXPfXtQ4mA+CyviGxsTsIrf4mt9JsI5e/oi0zKaj1A+pSAw4jkN8QZFoVc1JBX1
         RqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hxzOFqhgqXleE33TC6ldA+3mfjLYp+jAFORv6guIH9I=;
        b=T21iYZs2SqfcoBaYzWKggCsJhoXEiO/X6fdHfEmOPwGGyFDAr+XaBXn5otomlyvwSK
         gsmxo0UGJ1vdBs5K1xwMAPLh1rn987TCd6mlGvnNnh81kEfUr64/4LX+PbXgc7tjJfDx
         aFROIR9wWnG8gymAj+2uXxObr77/eEvvxt67tMkp1ZMyeWWgumDfFq25SA9ULEoR+zRh
         g/nMOP9nJsYcAbsaXsc/k1hlK1TNJXJI0HiJ4tGuhoPky374J0xnyn9oeCDetW0P0Mav
         TpT0UGBb5GFyhMS2F0yHT63+PMKb5FC8cTrAsF9Ee+1jFihb/PGY3ARjGCccF0F0HrkG
         Iy1A==
X-Gm-Message-State: AElRT7FnbSfPYgKTExHbMNNYbLyJ7y6YyH5sHpDDRWRl1+JOQ8cUrf69
        xuU0vdwWmJurqm0i2EkvnnQ=
X-Google-Smtp-Source: AIpwx49QS8Vq792qhlbd60BqidLRy+7RUmQ9jWTVtGsyY3O7MWq9GK2GimRNiOE+KpfNJOBzotLcrw==
X-Received: by 10.98.253.22 with SMTP id p22mr10013282pfh.217.1522749284457;
        Tue, 03 Apr 2018 02:54:44 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p3sm3952077pga.45.2018.04.03.02.54.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Apr 2018 02:54:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180104192604.GA27528@sigill.intra.peff.net>
Date:   Tue, 3 Apr 2018 11:54:33 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: 7bit
Message-Id: <091D90DC-DAA2-4338-AAFA-01CB75807992@gmail.com>
References: <20171221190909.62995-1-git@jeffhostetler.com> <20171221190909.62995-2-git@jeffhostetler.com> <20171221204356.GA58971@aiede.mtv.corp.google.com> <xmqq3742tyho.fsf@gitster.mtv.corp.google.com> <20171224143318.GC23648@sigill.intra.peff.net> <xmqq1sjgoyph.fsf@gitster.mtv.corp.google.com> <20180104192604.GA27528@sigill.intra.peff.net>
To:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Jan 2018, at 20:26, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Dec 27, 2017 at 09:41:30AM -0800, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>> 
>>> I, too, had a funny feeling about calling this "core". But I didn't have
>>> a better name, as I'm not sure what other place we have for config
>>> options that cross many command boundaries. "diff" and "status" don't
>>> seem quite right to me. While you can argue they are subsystems, it
>>> seems too easy for users to confuse them with the commands of the same
>>> names.
>>> 
>>> Maybe there should be a "ui.*" config hierarchy for these kinds of
>>> cross-command interface options?
>> 
>> I had an impression that ui.* was primarily pretty-printing,
>> colouring and things of such nature.
> 
> I didn't think we had a "ui.*" so far. We have "color.ui" and
> "column.ui", but I think that's it.
> 
> At any rate, my intent was to consider this a "ui" issue, in that we are
> deciding how the ahead/behind hints should be shown to the user.
> 
>> I do not think it is such a
>> bad idea to honor a status.frotz variable that affects how (e.g. to
>> what degree of detailedness) status on frotz are reported in Git
>> subcommands other than 'git status' if they report the same sort of
>> information on 'frotz' that 'git status' makes.
> 
> Is ahead/behind uniquely attached to git-status? IOW, could this be called
> "branch.aheadbehind" and git-status respects it? It seems like putting
> it in status introduces a weird asymmetry.
> 
> I buy the argument more that "status" here is not "this is a git-status
> config option", but "this config section encompasses various things
> about the status of a repository reported by many commands". But then
> it's kind of funny to have many of the existing options there that
> really are specific to git-status.
> 
> In can be both of those things, of course, but then it becomes less
> clear to the user which config options affect which command.
> 
> I dunno. It is probably not _that_ big a deal, and I can live with it
> wherever. But Git has a reputation for having inconsistencies and weird
> asymmetries in its UI, so I like to give some thought to squashing them
> preemptively.

What is the state of this series? I can't find it in git/git nor in 
git-for-windows/git. I think Stolee mentioned the config in
his Git Merge talk [1] and I was about to test it/roll it out :-)

- Lars


[1] https://youtu.be/oOMzi983Qmw

