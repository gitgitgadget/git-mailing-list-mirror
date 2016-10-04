Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D610F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbcJDRHL (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:07:11 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34186 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbcJDRHK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:07:10 -0400
Received: by mail-oi0-f47.google.com with SMTP id n132so177619776oih.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lKPqxiMLNh3n8jEtcmduxh9/aPVl4AJQWpz4Yd3EIyM=;
        b=KtuZloEgDB4gAUoKrnwGqM/vhoy5OspKPZ2wLH1eGRJTrwq5WbY2Q7TEm2R5EYQQqO
         fUt1SzwBRn/bv5y/Zzkm4OGmdx68aoh5nR5eEcTX/ygnSm6dc33bJOvUqrFgv5LrTo+D
         JbXsBMr1vYNRxoIgIMuHzoPiZkKa744txhzvsdzMJWJWk2/+UagIYKwn2qS1E3rJ/You
         uRRwltaj7LUNhu3D1kjQJtlRhuZB55bH3B/PEkPL8r/bvIHF2MEZnnt3UKEAGXbwbKuZ
         nLwPYuhLkj3IxzpOaVySagfa9xMVuuPAblTJ2A4imjm7g1iiwzXQEH30I5daUDzc6DTS
         aUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lKPqxiMLNh3n8jEtcmduxh9/aPVl4AJQWpz4Yd3EIyM=;
        b=cIKCQjHt7xU5LIHL/APJ8mYDXA5+aEQSjV1uXelqcslfES2rnS4b7PzthiAt5J9hkj
         CnEF3EW/AzZmttWFIlpwwPATKuUmH46jRMFzWQ1scaxDXzMDs/aWilzNh8AtOt8LXoCX
         BfFS1dBu4r+Qzr6uAg6uJzEo5TLDQLdV0lJynvK9CvmTyq/QjV35lm5tVjgRYr2zxQjI
         LA92bmq3sdSmt8OZ6FbEvgG/h7iF8GmXf/BcG7lv1Vv/rugzrlGJWDxukql+4YMc1SXZ
         c+Cjk5xdtFXUhzzkYHa/ZGEdRMq6Dg/auClfHutNeh14ydtImJczA58mj3XJ4OvCHp3q
         46VQ==
X-Gm-Message-State: AA6/9RktgorY1oOIe3zZZ87EhlA7uYhr76Ko6DacWv9/Pq/D3GnokLEzsIjqBFi0Q9Rml+HxWgJ0dqoF4L5rdBaX
X-Received: by 10.157.60.154 with SMTP id z26mr3094775otc.91.1475600829512;
 Tue, 04 Oct 2016 10:07:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.250.67 with HTTP; Tue, 4 Oct 2016 10:07:09 -0700 (PDT)
In-Reply-To: <20161004113625.GB20309@book.hvoigt.net>
References: <57F29FEF.30700@game-point.net> <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
 <20161004113625.GB20309@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 10:07:09 -0700
Message-ID: <CAGZ79kZWtAU6YG4Qz9_Gwk2db5L2kPCCKrN+64hMYDovRjiLRw@mail.gmail.com>
Subject: Re: Reference a submodule branch instead of a commit
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeremy Morton <admin@game-point.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> We already have options to support these kinds of workflows. Look at the
> option '--remote' for 'git submodule update'.
>
> You then only have to commit the submodule if you do not want to see it
> as dirty locally, but you will always get the tip of a remote tracking
> branch when updating.

I wonder if we could make that convenient for users by not tracking
the submodule,
i.e.
* we have the information in the .gitmodules file
* the path itself is in the .gitignore
* no tree entry

Then you can update to the remote latest branch, without Git reporting
a dirty submodule locally, in fact it reports nothing for the submodule.

It sounds like a hack, but maybe it's worth looking into that when
people want to see that workflow.
