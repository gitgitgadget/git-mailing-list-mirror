Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23ADB1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 14:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeI0UmL (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 16:42:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36188 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeI0UmK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 16:42:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10-v6so2862112wrp.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tH1vw7yzOWo2y275RsOuHZjxNYKDhJwpetoc+uiRH+w=;
        b=i82xur/PKSE/ii9C8ONQmfpt7i8aaHO7foENTp+EwelzXl6v8WrlPbDTmuglmS2pmZ
         irUf1/kDkxUFxw3bnybhPBvlpkh68aTE4Eg7MVq6Fak1uHamEsPfxsA0ALYazR1syqbD
         raxaUgroS/fM7r24AKRDu8LuQhIdoIN7Y2whssiwz+R7/nday/yIdP86ZyyedwrgeNmB
         FiCBSlduT48+fZLM1RgVEiKwcCYFIKsqQ0wJpzzP3Si5alocxw7g9nvpoDEB2BONt92+
         6L0dGmm04a+VsocoOx2X43ImEB/pRCNzrRQ0OdJlA95lHqgkmeZCbyiqOYU+zd1SKGMi
         H+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tH1vw7yzOWo2y275RsOuHZjxNYKDhJwpetoc+uiRH+w=;
        b=K6lbbBjZa6SnfB26P4jI6wXslaZFr5t6oZaxMEGd3TsyKdJudP6CN9XT7rgaZtujHM
         BTqFkQjOHgu5djVwfQh7PEXPncgoEVlj6c4Rtu7i1VqKWp9Q3d0qDTj/X4LckgakBSdW
         EJW3QugIPAjwVY55Fl6H7AhwcxpVSCnxtvibgQZvCNYuLUCg/IxSvf1Tzff9td36/GR8
         /Qx2ucVptePrWfig4necvUrgD+M/wWqy/rSJJoZTbDg6mWbRUBeIDfra++2L5hO1LFt+
         7ytsgBLqAbDP/trwBcDxa5Nd2/VkNE1XioNsGBbV2w2myk5CI3R6elvgBDbVmt1/KB/0
         mByg==
X-Gm-Message-State: ABuFfojM46pn5WjVABB7s716JvrtR7h8SYreNEYCtrDL4AyKP/jGWsGj
        Wdqb9tiQK/cX5CfEy+T5qK4=
X-Google-Smtp-Source: ACcGV61qM1TBXAjuwxU3/x8EjwsrpimUZR+tBG/lPLOGrwGtY3jAleqXjhXcuFOjcOo0mIgrdo5lPg==
X-Received: by 2002:adf:afdd:: with SMTP id y29-v6mr5195703wrd.176.1538058218707;
        Thu, 27 Sep 2018 07:23:38 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id f6-v6sm1878792wrr.68.2018.09.27.07.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:23:37 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:23:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Fix the racy split index problem
Message-ID: <20180927142336.GJ27036@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <871s9fjbcb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s9fjbcb.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 03:53:24PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Sep 27 2018, SZEDER Gábor wrote:
> 
> > This is the second attempt to fix the racy split index problem, which
> > causes occasional failures in several random test scripts when run
> > with 'GIT_TEST_SPLIT_INDEX=yes'.  The important details are in patches
> > 1 and 5 (corresponding to v1's 3 and 5).
> 
> Thanks. I'm running the same sorts of tests I noted in
> https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/ on
> this. The fix Jeff had that you noted in
> https://public-inbox.org/git/20180906151439.GA8016@localhost/ is now in
> "master".
> 
> I take it your
> https://github.com/szeder/git/commits/racy-split-index-fix is the same
> as this submission?

Yes.

> Anyway, I'm testing that cherry-picked on top of the
> latest master.
> 
> Unfortunate that we couldn't get the isolated test you made in
> https://public-inbox.org/git/20180907034942.GA10370@localhost/

Nah, that's not an isolated test case, that's only a somewhat
narrowed-down, but rather reliable reproduction recipe while I still
had no idea what was going on :)

The _real_ isolated test is the last test in t1701, that's what it
eventually boiled down to.

> but I
> don't see how it could be added without some very liberal
> getenv("GIT_TEST_blahblah"), so it's probably best to not add it,
> particularly with the C rewrite of git-stash in-flight.
> 
> I'll report back when I have enough test data to say how these patches
> affect the intermittent test failures under GIT_TEST_SPLIT_INDEX=yes.
