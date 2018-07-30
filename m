Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE941F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeG3W0G (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:26:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbeG3W0G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:26:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so14268200wre.6
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xoj7j4fdwyeFzx7eU1BUZ68v20A2nSg+lzyC9Mttyl8=;
        b=RqtAa/nhVa68IltCmi9gNA2htXdLBt3B30HZD2Be8CkQL5sjd2+5ffcywz/6rUuWNE
         uo2l5lW/n07LpC2eR02Kmc7ju9UIDwN+vAPZfCGBkkwj4mwfokYiYTpwXm2Jc7FpaWtu
         8JS1y/BHsv4L/CVq+rGGI/a75qoF/UJY3aIae7oU01UDhqQ2sqACyTyd9QLiCBkgU2Q/
         ev6z6JH2tqtXmSM/Vi0r3pklu6okO7HR1uNlyhpeekWfsL2LFn1G7YigxNCDvBPzC39y
         jYvnNh06JNB8uUUr0LLRt8TeGJRJHBkcZ8oAbhtGNQvVz11UkZEnvEmHhNsgJdIxn5Ti
         ZFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xoj7j4fdwyeFzx7eU1BUZ68v20A2nSg+lzyC9Mttyl8=;
        b=c3tWgBygnQAEXT3yueOtAWAEMQGkucsb7G/0ear5mEsOXwfPm3S2BY7FJ9ba4HYsgA
         nSERV891X0NXzvKCZV76ryok+A6OUu291DDhgB0V1ZZfPnlZNuG3fS4WFPjAACn9Kp02
         dXWbxIlj3bSCYmMzN3lEhaV2D2+jIU1y1MV7U74C5hI6eKAnDv5NBYNUXer/RcjlJeSW
         TXQLAQFPYuDrll6/dthOoMS1vUgS/YVY1ouGXyNmiaPcNSXTfNydzPnC8H9LjBc5ci2J
         pOvgUtIVvDIWqplePHsySEcTycemEW+c4w74ogEZkRtiLppwzfqIiJBTupUIRu4XY40f
         iPUQ==
X-Gm-Message-State: AOUpUlE/ABypEe00Z2U5vEpVPweExItITLvEaRmVCIGnYHul/cdZ+KNy
        0t94SmfXLt6O1wrR08VOtr10BnOf
X-Google-Smtp-Source: AAOMgpfOK3ZYOj2l6ml9anftsmUJ/V0cMRLC60vkGoaNcQbczTprhQOgFwJZ9uHvX3ZE/Cul9MLaGw==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr19099522wra.120.1532983759745;
        Mon, 30 Jul 2018 13:49:19 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id x7-v6sm22587156wrr.95.2018.07.30.13.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:49:18 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:49:18 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 00/11] rerere: handle nested conflicts
Message-ID: <20180730204918.GJ9955@hank.intra.tgummerer.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
 <xmqqpnz4hau1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnz4hau1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Thomas Gummerer (11):
> >   rerere: unify error messages when read_cache fails
> >   rerere: lowercase error messages
> >   rerere: wrap paths in output in sq
> >   rerere: mark strings for translation
> >   rerere: add documentation for conflict normalization
> >   rerere: fix crash when conflict goes unresolved
> >   rerere: only return whether a path has conflicts or not
> >   rerere: factor out handle_conflict function
> >   rerere: return strbuf from handle path
> >   rerere: teach rerere to handle nested conflicts
> >   rerere: recalculate conflict ID when unresolved conflict is committed
> 
> Even though I am not certain about the last two steps, everything
> before them looked trivially correct and good changes (well, the
> "strbuf" one's goodness obviously depends on the goodness of the
> last two, which are helped by it).
> 
> Sorry for taking so long before getting to the series.

No worries, I realize you are busy with a lot of other things.  Thanks
a lot for your review!
