Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845391F462
	for <e@80x24.org>; Fri, 24 May 2019 10:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbfEXKG5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 06:06:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51785 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390248AbfEXKG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 06:06:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so1315935wmb.1
        for <git@vger.kernel.org>; Fri, 24 May 2019 03:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BHlqkCxslV7GBhkCY4fbCxf/j3AKaTslmYmhRJF8YXk=;
        b=BcgPu6Ede5glyhMV+WCXL+7KOstvPDF7bzDnPjXYAhviEbjN4Mz8eMIDmsNdtd7Df0
         xi7zkFf5ZpeoaumFhNLF96txSaeJ46RHp4oxXOfm08zFsUwP5E6WPOVIEp6VbSrJuu6e
         TMo0FrweOpKF7BLufbQnal7jyzhw+GuuuzbFZ0dbjQ7HyRnZa33UVFlXZjh+4cn5oZu+
         7x/1VXcLcBJYQn0sdh6Vu7dveWIaDiYHtllHZtBNfSyuetcAndSjZujJoQ4keqfwuWQy
         Nj+sVeZ1xKlibAV1mmGur01ZnIrTvg99N0hmvXHvYcBsBAHPU6ifan64a5FWLKxwYHnc
         c1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BHlqkCxslV7GBhkCY4fbCxf/j3AKaTslmYmhRJF8YXk=;
        b=K2XTvFVPV+YM9h6co4HXfcYcM/aUJN7AjPNElfE5U7dUJWN+cRdFHLAQY7b3J2k0M7
         8+9D1NnylFNbfBn4VRvk5HQ3C36iPQdKKUZ2ZplC4aC9Zu+oXyYkTHjOl2KJQqqUq5xT
         4jo87aV/dMD4dEHC/a4XzDaWHvvcDOkkyldAf4+LOF70F/K4lnkZcEcKdPRBm2/ns9b6
         sbMumXj4W2eNM86Brg1w4gaGvNPKVkNSPGqqlLPesstt8sfy+xklGqOWvG2RBPh5esc3
         n++yR9dyLVKbrhAQybHSFJYYQyYAHKh4ulbpCR4q3q8eQSWl5REG4IQN7XjGXsCLZGUH
         p9tw==
X-Gm-Message-State: APjAAAWWGi0Z58TT1ElNHIP7iUNr0wbDyFVgfAVajH1CoWMN06VPuBFE
        VZpcZ6p+k/Bsi2gYrhmK3oo=
X-Google-Smtp-Source: APXvYqxA9+HRlpf2ueGkUQOOCrAy0/qYqJlHi6mQ4qIIRW8ssER+wkkWBm9kldGSFbFBJNdNn32bJA==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr15261002wmb.13.1558692415383;
        Fri, 24 May 2019 03:06:55 -0700 (PDT)
Received: from szeder.dev (x4db30b59.dyn.telefonica.de. [77.179.11.89])
        by smtp.gmail.com with ESMTPSA id u7sm3913937wmg.25.2019.05.24.03.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:06:54 -0700 (PDT)
Date:   Fri, 24 May 2019 12:06:53 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
Message-ID: <20190524100653.GF951@szeder.dev>
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
 <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com>
 <86blztq8ap.fsf@gmail.com>
 <87tvdkg7ld.fsf@evledraar.gmail.com>
 <20190523222031.GC951@szeder.dev>
 <f05405d7-c78d-a0e4-75a1-d623f977400a@gmail.com>
 <20190524093459.GE951@szeder.dev>
 <87o93sfahj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o93sfahj.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 11:49:28AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, May 24 2019, SZEDER Gábor wrote:
> 
> > On Thu, May 23, 2019 at 07:48:33PM -0400, Derrick Stolee wrote:
> >> On 5/23/2019 6:20 PM, SZEDER Gábor wrote:
> >> > On Thu, May 23, 2019 at 11:54:22PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >
> >> >> and since the commit graph doesn't include any commits outside of
> >> >> packs you'd miss any loose commits.
> >> >
> >> > No, the commit-graph includes loose commits as well.
> >>
> >> Depends on how you build the commit-graph.
> >
> > Yeah; I just didn't want to go into details, hoping that this short
> > reply will be enough to jog Ævar's memory to recall our earlier
> > discussion about this :)
> 
> To clarify (and I should have said) I meant it'll include only packed
> commits in the mode Karl Ostmo invoked it in, as Derrick points out.

No, even in that mode it will include loose objects as well, if it has
to; that's what the "and closes under reachability" part of Derrick's
reply means and that's what I showed in our earlier discussion at:

  https://public-inbox.org/git/20190322154943.GF22459@szeder.dev/


