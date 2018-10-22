Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89811F453
	for <e@80x24.org>; Mon, 22 Oct 2018 17:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeJWCJS (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 22:09:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40081 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJWCJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 22:09:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so38801256edd.7
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mjU21LsTSWDE/0gaGJDVDHiBT5kctRiTSWNWRR05Ano=;
        b=aDSlGnwMHWLdh3l6QnENhSfAMBNJVpsI5EAr1J2rwnhZ2bo6HagUcq8S8nJFdYhXy/
         n8ol26hpv/VYUf+lMkxNQQSgHWWiFVCAnkwF0ogA01j0h/0KYQbw7VFo9iccueuSPal+
         B5ImPJ7FGy5SPR3pINdA2Uv8uy3l15WiHHKt+LztX/uRtqrKWQtX5BAUiteW4iEcaAGS
         6tCpJbjn7tI/uWwtlCad7qi5II90wLk58DNl9oYsPUuv+/Hat5AT2wRt79NmGISCm+QK
         z4A/guRv0gQKYUOmz8T3lZC5vG4iKMSosDSMBIReie74crF13AhlknZU+nrseJ7s/QJ4
         w/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mjU21LsTSWDE/0gaGJDVDHiBT5kctRiTSWNWRR05Ano=;
        b=Nsi0u2RrRjLjsfSDXLMuu8Z28uxsSgTNeLHeR4dHQ8KaazJnmBZJHeymCINvg8aUJg
         QhAdSeUYlPjGGDMB0M5+hc4eCyn2WFZX7sf3ydwu3Dj3+Xswb0umbSt/HqlhKZtQ9EqI
         qTzB210A7rB6lQ6Od8ll8HVqd46RYSjG6bCirL9WKB4TGBeGs3C4Pba07vd7p8D1uGSi
         FBAPPuBZDRF8oa1E5Lu3KQWvsJedVhcQUnl93PwnRP4uJBtswb2MbjpC3JMjPbNe9dGV
         CIHrvMqLZn3GEDBiI9ixMpM4Ohw72YLY33aoFRjFuiMcfzi3oUmPE8tQzfa1KrScOY3R
         YoLg==
X-Gm-Message-State: AGRZ1gJupxFBPHo0gGVpOsORE3cbnssqmXTZ208bxcrnVaqk+UaOnj0M
        c9B2eCiWEFN06K834gXyFtE=
X-Google-Smtp-Source: AJdET5cZnbySE1FM6t3dU6vh3xcaPx1vUOA/Dnq40j3gB4UGJz3N+xR6saJN5qqWqS+ZzBcOxy70qQ==
X-Received: by 2002:a50:f298:: with SMTP id f24-v6mr4313793edm.233.1540230587626;
        Mon, 22 Oct 2018 10:49:47 -0700 (PDT)
Received: from szeder.dev (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id b26-v6sm10854888edw.0.2018.10.22.10.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 10:49:46 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:49:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] completion: fix __gitcomp_builtin no longer consider
 extra options
Message-ID: <20181022174944.GH30222@szeder.dev>
References: <20181021083731.8009-1-pclouds@gmail.com>
 <xmqqr2giwsep.fsf@gitster-ct.c.googlers.com>
 <CACsJy8B-NtKb1sk_CxwB-bffMsy+nDGL2-MpkScBF5vvGHFBjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8B-NtKb1sk_CxwB-bffMsy+nDGL2-MpkScBF5vvGHFBjA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 04:34:16PM +0200, Duy Nguyen wrote:
> On Mon, Oct 22, 2018 at 5:51 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> >
> > > __gitcomp_builtin() has the main completion list provided by
> > >
> > >     git xxx --git-completion-helper
> > >
> > > but the caller can also add extra options that is not provided by
> > > --git-completion-helper. The only call site that does this is "git
> > > difftool" completion.
> > >
> > > This support is broken by b221b5ab9b (completion: collapse extra
> > > --no-.. options - 2018-06-06), which adds a special value "--" to mark
> > > that the rest of the options can be hidden by default. The commit
> > > forgets the fact that extra options are appended after
> > > "$(git xxx --git-completion-helper)", i.e. after this "--", and will
> > > be incorrectly hidden as well.
> > >
> > > Prepend the extra options before "$(git xxx --git-completion-helper)"
> > > to avoid this.
> >
> > Thanks for a clear analysis.  How did you find it?  Got annoyed that
> > completion of difftool got broken, or discovered while trying to
> > apply the same trick as difftool completion uses to another one and
> > seeing that the technique does not work?
> 
> I was fixing format-patch completion and was surprised it did not work
> as expected. Never really used difftool myself :P I only found out
> about it when I asked myself "why wasn't this breakage found earlier?"

Erm...  maybe because there are no tests covering the combination of
extra options and '--no-..' options in 't9902-completion.sh'?

(Hint, hint... :)

