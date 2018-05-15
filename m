Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0031F406
	for <e@80x24.org>; Tue, 15 May 2018 18:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeEOShG (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 14:37:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35060 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEOShE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 14:37:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id x9-v6so476246pfm.2
        for <git@vger.kernel.org>; Tue, 15 May 2018 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VGrZsKXhX98CEUoc4jenHJKImNznSpdGqU/kUfwyRJA=;
        b=Q93aQHyVvfM7V/y6fU+osUSrb76G2Y1lgG9Z9NbCRh/LCpwVDn0XToVC0xQbdTcrUA
         tV6xGN4jPAwHwMzkH/oBDM6qShWKWyFPyy2HKyzYyWsSMl2useQLKXmEaUileaxRbPX2
         eeVB98aaZXQQmOJrLxBm8a5R5P8fE8g0E4LzDemfL7nhHtmVSzgOC/uP6P1ekGGmq6Ws
         ugsuJnQf4dmsLHip15QLmftTXR31yvp3Bwx5mKbMueNNLQlhIPp2S3ZZp32ePQ5WHyT+
         zDJ+SEBwgjuwfKOMPSsHxljRvtSjF8LxgaUuCWkI1kzNvwxtzZeLAcSp6Epqrabn3rWt
         C9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VGrZsKXhX98CEUoc4jenHJKImNznSpdGqU/kUfwyRJA=;
        b=VfbekRUocyjnGBQxC9jZAPhkYndK7jzCUu4Zn48uXleGsJPo6gmaGV0JfTXfOjCp7w
         DGLijW75ERCcUQQ5PTIFisn31f+gBMj5ONqujiEfdvtt5U16XBiWgqem6QkzUI6xvBcz
         Dyhyfh8dAjrEb9xI3VN6NkDlqXpgI3eEAj5fgloj6A67Onk6SEJJRFg6wx2eR5e54LgF
         8zRhihkV6dcxkzyck01c4lNKyWckjcRvS9HbAl/NJkx95vfnn5T0DISzYFHKN1dm4o5D
         YQjesjo0r+if3aVgwQDOj5F+r5+iqbOh8k9MD5EkmeH+v1gXv4Z6/hQgVIVfr0Omhwdy
         INGA==
X-Gm-Message-State: ALKqPwfYVXOoqKGHRxCXFU+Vd/ijqhn/i42FPlIZnGlF08DG3WJGrY9L
        L/P5DywcJ4PwvuKClnaFXKzPyucs3mY=
X-Google-Smtp-Source: AB8JxZqJLbfkGDW2HdShcnkFouy4kejWjTml1d2Y9slJE62EQS7xgZC6DGpAuHJIH3cTY8SK2vtGng==
X-Received: by 2002:a62:aa18:: with SMTP id e24-v6mr16182895pff.107.1526409424130;
        Tue, 15 May 2018 11:37:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t14-v6sm1135138pfa.31.2018.05.15.11.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 11:37:03 -0700 (PDT)
Date:   Tue, 15 May 2018 11:37:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/35] refspec: introduce struct refspec
Message-ID: <20180515183702.GG72551@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
 <20180514215626.164960-5-bmwill@google.com>
 <xmqqefid8djg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefid8djg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/15, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > diff --git a/refspec.h b/refspec.h
> > index 173cea882..f6fb251f3 100644
> > --- a/refspec.h
> > +++ b/refspec.h
> > @@ -20,4 +20,29 @@ struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec);
> >  
> >  void free_refspec(int nr_refspec, struct refspec_item *refspec);
> >  
> > +#define REFSPEC_FETCH 1
> > +#define REFSPEC_PUSH 0
> 
> The reversed order of these two definitions looks somewhat unusual.
> I guess the reason why you made FETCH true and PUSH false is
> probably because quite a lot of places in the existing code we do

Yeah I really just made the choice based on what the existing logic did
(parse_refspec takes in a parameter 'fetch' which is 1 if we are parsing
the refspec for a fetch and 0 for push).  So it wouldn't be too
difficult to go and make this change here since all future callers use
the #defines themselves, because it is significantly easier to read
'REFSPEC_PUSH' than to read a 0 like you point out below :)

> 
> 	if (fetch)
> 		do the fetch thing;
>  	else
> 		do the push thing;
> 
> i.e. "fetch" variable is used as "is this a fetch: yes/no?"
> boolean, and a caller that mysteriously passes "1" (or "0")
> is harder to read than necessary.  Being able to pass REFSPEC_PUSH
> instead of "0" would certainly make the caller easier to read.  But
> as long as the variable is understood as "is_fetch? Yes/no", the
> caller can pass Yes or No and be still descriptive enough.
> 
> I think the way to make such a code more readable would not be to
> rewrite the above to
> 
> 	if (fetch_or_push)
> 		do the fetch thing;
>  	else
> 		do the push thing;
> 
> Rather it would be 
> 
> 	if (fetch_or_push == REFSPEC_FETCH)
> 		do the fetch thing;
>  	else
> 		do the push thing;
> 
> And once you have gone that far, the actual "enum" value assignment
> no longer makes difference.
> 
> > +#define REFSPEC_INIT_FETCH { .fetch = REFSPEC_FETCH }
> > +#define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
> > +
> > +struct refspec {
> > +	struct refspec_item *items;
> > +	int alloc;
> > +	int nr;
> > +
> > +	const char **raw;
> > +	int raw_alloc;
> > +	int raw_nr;
> > +
> > +	int fetch;
> > +};
> > +
> > +void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
> > +void refspec_item_clear(struct refspec_item *item);
> > +void refspec_init(struct refspec *rs, int fetch);
> > +void refspec_append(struct refspec *rs, const char *refspec);
> > +void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
> > +void refspec_clear(struct refspec *rs);
> > +
> >  #endif /* REFSPEC_H */

-- 
Brandon Williams
