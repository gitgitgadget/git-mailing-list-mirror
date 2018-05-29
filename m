Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58A311F42D
	for <e@80x24.org>; Tue, 29 May 2018 18:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965936AbeE2SEx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 14:04:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36906 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965697AbeE2SEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 14:04:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id l1-v6so43079531wmb.2
        for <git@vger.kernel.org>; Tue, 29 May 2018 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcBYoe4Z5VyIWDaBybjiGxEfTrteq1uG0uSwSv41y+c=;
        b=jKirAEGw+8GML0dMX8dCaFOSV/4NuLYLwol8xT8O09am0Gy1To7ShgofxuQ8PKpVlU
         D48XRs596Wu3ZQR4UZ9so7av82yvJkPzs4LNNZcJqo0CUiPSXDl25iIe10qi4pFKWu6f
         vVGuiFcd8xX4ec9lEYfGt9iLXnxOAh8nwJm53I4p0410uHZhiPrfNHHBY8MKN75JBoE2
         R6mHZmQTDdx6GhEa8tGCTh4PBs0HlwNosrsbG/fWDJ3ZtmOVsKBbbIzjHb9JzUlc8eji
         Iar3/NiYjm39iZBjuOU7NBeFbgvCJYFBaK8uZdFsoN1V5Vm4Z05miGOa+4+ItKnbqR/6
         O0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcBYoe4Z5VyIWDaBybjiGxEfTrteq1uG0uSwSv41y+c=;
        b=L6sT1aOajWk41MvV8T/SSKVQRUHa9BaQIMoOf2YOjGQoMvt9IEm/fvrWvemRhFdrq8
         E/Er9IFN4xO6ZhK5NUh8WI4ZPWx87IBbw8t1vGTddjr7O8tVyt8/J9azDD5sWC0JoE0y
         Ieeddiy47P3aNym46ZvodJkM9PXow5vnVzudMcuojh0m72c3jGV8C35vSOY8r9tPgbb4
         iEDWw0Iy8/sPYsASsuFnuLFV4zfmO7E96uskr6KUNWZ373fZdTg2dbybCCv/Dw9v3MLq
         TYjvaMqP/lhJIfCTjgvkS9/HZtJ5W/iyu6jvdZ5zIoMzUElr0g8pVQ/53KssrTOARZyn
         ok9w==
X-Gm-Message-State: ALKqPwepjP5+6Ca/3yAO2F8sJS4zMUT7gR2dcWfeZJ10KMkYstYOiiKw
        sW9mACITzYnnx4selxgxpcXh/lI3
X-Google-Smtp-Source: ADUXVKJ6Vnlk6mDt0CLtKtLRy/hqNEIZgNGRya67CTcoBHHYTcBoK/J+DTlcD31YoPkkx+L3mKN2jA==
X-Received: by 2002:a1c:b807:: with SMTP id i7-v6mr12147807wmf.126.1527617077272;
        Tue, 29 May 2018 11:04:37 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m58-v6sm14449417wrf.61.2018.05.29.11.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 11:04:36 -0700 (PDT)
Date:   Tue, 29 May 2018 19:05:11 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/1] SubmittingPatches: not git-security@googlegroups.com
Message-ID: <20180529180511.GA26159@hank.intra.tgummerer.com>
References: <20180527140433.32277-1-t.gummerer@gmail.com>
 <20180527153418.GG207547@aiede.svl.corp.google.com>
 <20180527210822.GB8868@hank.intra.tgummerer.com>
 <xmqqbmd0lc11.fsf@gitster-ct.c.googlers.com>
 <20180529180203.GC8868@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529180203.GC8868@hank.intra.tgummerer.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/29, Thomas Gummerer wrote:
> On 05/28, Junio C Hamano wrote:
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> > 
> > > Yeah sorry, that's what I meant.
> > > https://public-inbox.org/git/20180308150820.22588-1-avarab@gmail.com/
> > > is the reference I meant to put there.
> > >
> > > How about something like the below?  This is tested with asciidoc
> > > 8.6.10 and asciidoctor 1.5.6.2.  I'm also happy to squash the two
> > > patches into one if that's preferred.
> > >
> > 
> > If the discussion in the proposed log message needs to be updated
> > anyway, it is a good opportunity to make them into a single patch,
> > as they share exactly the same objective.
> 
> This was mostly a clarification of the note I added after the '---',
> but I'm happy to just make this one patch either way.
> 
> > This is a tangent, but the use of footnote below looks a but
> > curious.  How would {1} reference pick which :1: to use?  The
> > closest preceding one?
> 
> Tbh I didn't look at the docs for doing this, but just used the same
> syntax as we're already using and tried it with both asciidoc and
> asciidoctor.  And yes it seems like it always picks the preceeding
> one.
> 
> > As this appears on a page that already has other footnotes attached
> > to an adjacent paragraph, I am wondering if they should be made into
> > a part of the same numbering sequence.
> 
> I have now actually looked at the docs, and this numbering has nothing
> to do with the footnote format, but rather is used to substitute the
> attribute that's specified in the curly braces with the text that's
> after :<attribute>: [1].  This initially confused me a bit.  Maybe it
> would be nicer to give the attributes names instead of just numbers?
> As we keep adding footnotes, that would be less likely to produce
> conflicts between the different attributes I think.
> 
> I'm also adding brian to the cc list, as he first converted this to
> AsciiDoc for opinions.

Now really adding the CC, I failed earlier.  Sorry about the noise.

> [1]: https://asciidoctor.org/docs/asciidoc-syntax-quick-reference/#attributes-and-substitutions
