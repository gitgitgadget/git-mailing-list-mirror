Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434791F461
	for <e@80x24.org>; Tue, 14 May 2019 17:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfENRBL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 13:01:11 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52179 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENRBL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 13:01:11 -0400
Received: by mail-it1-f193.google.com with SMTP id s3so6205554itk.1
        for <git@vger.kernel.org>; Tue, 14 May 2019 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OaSgiiQxvJM6yjV+FBF8HO4IRsz2uo4vD7F3db7r07I=;
        b=EK5vvvL+QoNT55AQ6ze/0XiMTbfRHCC3ScCrTbEc+AxH7C7syzCdCsyHlTSPEPJ2Bv
         WM3rAIiBJpSTd1hxeCKnzdtQVbDZk7DeHAavvQWslNCVZ1uvtH3lkvAhByuEr+KCAYFz
         K6R+eDHbE1oZUpp8TrP/30+Re4sJuykK5da/YQ/chrC6EMS89u1QPd5+LbPwn0HIYye4
         05g02hbHoFtLy1cJDOM8qFPUqLOnJ3s0Xor01KEfYLYeDNHX0FioWV5KIbAsjiU7GGjS
         4hKhqkmKm3EqEvxQnipLKyO9UYYZu7OePs7wVUM96HW2oKgE81NB/ytSBG5BXhNGqlS3
         JUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OaSgiiQxvJM6yjV+FBF8HO4IRsz2uo4vD7F3db7r07I=;
        b=aztjeIm40CDtLPMf/VdQzKS65Ykeqv53OKo50L1SS6FfC7fDrGgPmJzxFpCfi+Kjq7
         dqLE6V+/hzCJ/iMJmODv7h1BP7btK6WpXZLXX9lGuGrKjeSwm1agnl75Fk6WqBEM6BRH
         TICYoQqabUUQDJhJorSgC+xSjA8YvH0n/on+YZj4Hc+c4wmLS2gsooFfpn1+KVX3LJSP
         y/2iQ7Dr1y4pAuHfPJ9yh4BNrIVH0C0WqooUfdDo7hKuHHPrwDiZjLwfu/adOR3NXFbX
         p5SAwRgo1BNJJ2oU+QQkZT0DG2HqF+sOGG/Wrpyx/M+yV5B2SdprB1gbIlx4MwTv+Wgw
         O0sg==
X-Gm-Message-State: APjAAAXRlS//zRIVXmO9SYOEfdCwTqmjfBFL863jG1x3RI9TznDA8UQ/
        kb8O6WxtjOHB8d0rilb9ueg=
X-Google-Smtp-Source: APXvYqxMBIP4I6YwDV6/nzFi97EFMj/2dUs/wnaG2pKEBDE3JeM0M6siUluKpjut/e/YqEOLhczeUg==
X-Received: by 2002:a24:5512:: with SMTP id e18mr4303062itb.112.1557853270596;
        Tue, 14 May 2019 10:01:10 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id h191sm1821936ith.5.2019.05.14.10.01.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 10:01:09 -0700 (PDT)
Date:   Tue, 14 May 2019 13:01:07 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 2/2] format-patch: teach format.notes config option
Message-ID: <20190514170107.GA4151@archbookpro.localdomain>
References: <cover.1557327652.git.liu.denton@gmail.com>
 <cover.1557513353.git.liu.denton@gmail.com>
 <df864c4adf4dcab5f959007f87b1c4d0eafecb52.1557513353.git.liu.denton@gmail.com>
 <xmqqimufdqey.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimufdqey.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, May 13, 2019 at 11:44:21AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > @@ -864,6 +866,20 @@ static int git_format_config(const char *var, const char *value, void *cb)
> >  			from = NULL;
> >  		return 0;
> >  	}
> > +	if (!strcmp(var, "format.notes")) {
> > +		struct strbuf buf = STRBUF_INIT;
> > +
> > +		rev->show_notes = 1;
> > +		if (!strcmp(value, "standard")) {
> > +			rev->notes_opt.use_default_notes = 1;
> > +		} else {
> > +			strbuf_addstr(&buf, value);
> > +			expand_notes_ref(&buf);
> > +			string_list_append(&rev->notes_opt.extra_notes_refs,
> > +					strbuf_detach(&buf, NULL));
> > +		}
> > +		return 0;
> > +	}
> 
> Unlike the command line option parser, this does not seem to touch
> rev->show_notes_given at all.  Intended?  I am wondering how well
> this implementation meshes with what 66b2ed09 ("Fix "log" family not
> to be too agressive about showing notes", 2010-01-20) wanted to do,
> which 894a9d33 ("Support showing notes from more than one notes
> tree", 2010-03-12) later extended.

This was intended but I'm not 100% sure that it's correct.

From what I could gleam from reading the code, `show_notes_given` is
only used by the `cmd_log_init` function, which is not called by
format-patch. As a result, I opted to not set that flag since it's not
really "given" in the sense that a user didn't explicitly pass in a
command-line option indicating they wanted notes.

> 
> > +test_expect_success 'format-patch notes output control' '
> > +	git notes add -m "notes config message" HEAD &&
> > +	test_when_finished git notes remove HEAD &&
> > +
> > +	git format-patch -1 --stdout >out &&
> > +	! grep "notes config message" out &&
> > +	git format-patch -1 --stdout --notes >out &&
> > +	grep "notes config message" out &&
> > +	git format-patch -1 --stdout --no-notes >out &&
> > +	! grep "notes config message" out &&
> > +	git format-patch -1 --stdout --notes --no-notes >out &&
> > +	! grep "notes config message" out &&
> > +	git format-patch -1 --stdout --no-notes --notes >out &&
> > +	grep "notes config message" out &&
> > +
> > +	test_config format.notes standard &&
> 
> I think we tend to spell these things "default".
> 
> Alternatively, the format.notes configuration can be "bool or text",
> and make the variable set to 'true' mean "show notes, using the
> default ref".

I think I'l go with this approach.

> 
> > +	git format-patch -1 --stdout >out &&
> > +	grep "notes config message" out &&
> > +	git format-patch -1 --stdout --notes >out &&
> > +	grep "notes config message" out &&
> > +	git format-patch -1 --stdout --no-notes >out &&
> > +	! grep "notes config message" out &&
> > +	git format-patch -1 --stdout --notes --no-notes >out &&
> > +	! grep "notes config message" out &&
> > +	git format-patch -1 --stdout --no-notes --notes >out &&
> > +	grep "notes config message" out
> > +'
> 
> OK.
> 
> > +test_expect_success 'format-patch with multiple notes refs' '
> > +	git notes --ref note1 add -m "this is note 1" HEAD &&
> > +	test_when_finished git notes --ref note1 remove HEAD &&
> > +	git notes --ref note2 add -m "this is note 2" HEAD &&
> > +	test_when_finished git notes --ref note2 remove HEAD &&
> > + ...
> > +	git format-patch -1 --stdout --notes=note1 --notes=note2 >out &&
> > +	grep "this is note 1" out &&
> > +	grep "this is note 2" out &&
> 
> Do we promise the order in which these two lines appear in the output?

According to the code, the order is stable. However, I just read through
the documentation and I realised that the ablility to provide multiple
notes refs is undocumented.

In a future reroll, I'll document the fact that --notes can be provided
multiple times.

> 
> > +	test_config format.notes note1 &&
> > +	git format-patch -1 --stdout >out &&
> > +	grep "this is note 1" out &&
> > +	! grep "this is note 2" out &&
> > +	git format-patch -1 --stdout --no-notes >out &&
> > +	! grep "this is note 1" out &&
> > +	! grep "this is note 2" out &&
> > +	git format-patch -1 --stdout --notes=note2 >out &&
> > +	grep "this is note 1" out &&
> > +	grep "this is note 2" out &&
> 
> So format.notes say note1 but the command line explicitly asks it
> wants note from note2, but the command still gives from note1
> anyway.
> 
> > +	git format-patch -1 --stdout --no-notes --notes=note2 >out &&
> > +	! grep "this is note 1" out &&
> > +	grep "this is note 2" out &&
> 
> And there is a way to work it around, i.e. clear everything
> configured with --no-notes and then name the one you want from the
> command line.
> 
> I am not sure if the above is consistent with how our options and
> configurations interact in general.  Shouldn't the --notes=note2
> alone in the earlier example cancel format.notes=note1 configured?

I borrowed this behaviour from how format.to behaves. In format-patch,
`--to` gives a recipient that is used _in addition_ to any format.to
variables. `--no-to` can override this. I made format.notes behave
similarly.

> 
> > +	git config --add format.notes note2 &&
> > +	git format-patch -1 --stdout >out &&
> > +	grep "this is note 1" out &&
> > +	grep "this is note 2" out &&
> > +	git format-patch -1 --stdout --no-notes >out &&
> > +	! grep "this is note 1" out &&
> > +	! grep "this is note 2" out
> > +'
> > +
> >  echo "fatal: --name-only does not make sense" > expect.name-only
> >  echo "fatal: --name-status does not make sense" > expect.name-status
> >  echo "fatal: --check does not make sense" > expect.check
