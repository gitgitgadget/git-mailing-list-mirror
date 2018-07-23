Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B221F597
	for <e@80x24.org>; Mon, 23 Jul 2018 17:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbeGWSzl (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 14:55:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44629 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbeGWSzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 14:55:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so896193pgp.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XCX3DEEXtUtcmKWSZs+7XbqqK9PJyUuf6FxOyBWYEYk=;
        b=oeqgUjLgRBG/TLdv3rLv9knRSdiUB7nhNHa0V2FQTybpGi2eiMHrIS7hI9zFxlfk6N
         4DYC60M7CivCNUGvZYt2H1otpaAT+FamsZ0Io1GQIv0c/+jo1rMKmCaQy+CWMR6rhKxs
         GGud7orr6222m3JsTgCQvBuooIeKiN0A5oaSYE3dWoivdrN4dXhjOZpl8LN3dXHKnpiQ
         xpj8FQZRFTjh1MEGWmHteXU9abFZANtDnCjoUIyL32rS94v6QrDFVZT7GnJScTmJ4OBP
         SsSWfny5HoNIvSXcFC+YJj6GRi5iqQge0/O955OGE+5iYf1D8bfDtChsSsJfkBBWisBv
         YatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XCX3DEEXtUtcmKWSZs+7XbqqK9PJyUuf6FxOyBWYEYk=;
        b=KJZ407WgKJRMIMpuAzCC75XArnNUg7DweM4BX39gHKW/53wFmrvFZA1/6wuCAdWTSE
         l8th1nxKDn64cSibiNSasQvN3FiL1C7f68LXF8P7tcXGq3mgw2AMsjX2eqKb6wGR6wBv
         UCzBS2Lr6ISKhkWhTQrHf7yh2NAvPC62txnuOrhprAberPKJW5vp4JGHOdWFXtLpPQ0q
         nbE9ViUQmM5J85TFTOMx3NkcPmAJB6TcxpLWBytgvygurMLCOy7+FP1KJdlO8nIpjKAp
         SQmB46A5Cs281yYh7/b9XDFhZRXBWZo2eIBtd5jADZ6RdaG4APWU23yZpmwgZQO5r2yX
         xe/g==
X-Gm-Message-State: AOUpUlEyVdufKU5NOf2XG8ANrjttbgsQ8qoElGZtwaKqJc20YJeYQH2a
        jWURB4KTcobt68+hXsIigfjbDA==
X-Google-Smtp-Source: AAOMgpdrugyobidIWxN2idfGOheLPblcgZCsRPF1+G3oFdM2bmgdyRTl3pDm7awFnu7aQceHXMblJQ==
X-Received: by 2002:a63:4951:: with SMTP id y17-v6mr13362675pgk.32.1532368400161;
        Mon, 23 Jul 2018 10:53:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a77-v6sm30546119pfj.38.2018.07.23.10.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:53:19 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:53:18 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 8/8] fetch-pack: implement ref-in-want
Message-ID: <20180723175318.GB25435@google.com>
References: <20180626205438.110764-1-bmwill@google.com>
 <20180627223023.49659-1-bmwill@google.com>
 <20180627223023.49659-9-bmwill@google.com>
 <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/22, Duy Nguyen wrote:
> On Thu, Jun 28, 2018 at 12:33 AM Brandon Williams <bmwill@google.com> wrote:
> > +static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
> > +{
> > +       process_section_header(reader, "wanted-refs", 0);
> > +       while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> > +               struct object_id oid;
> > +               const char *end;
> > +               struct ref *r = NULL;
> > +
> > +               if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
> > +                       die("expected wanted-ref, got '%s'", reader->line);
> 
> Could you do a follow and wrap all these strings in _() since this one
> is already in 'next'?

What criteria is used to determine if something should be translated?
To me, this looks like a wire-protocol error which would benefit from
not being translated because it would be easier to grep for if it
occurs.  That and if a user sees this sort of error I don't think that
they could really do anything about it anyway.

Of course it appears as if all other 'die' calls in fetch-pack have been
marked for translation so I guess my though process doesn't hold :)

-- 
Brandon Williams
