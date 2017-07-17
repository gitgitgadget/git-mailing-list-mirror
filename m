Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BD720357
	for <e@80x24.org>; Mon, 17 Jul 2017 17:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbdGQRta (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 13:49:30 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33253 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdGQRt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 13:49:29 -0400
Received: by mail-pg0-f45.google.com with SMTP id k14so83523672pgr.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=m0HfTQlSJ5IZ31jgIuQuMPXpAUt09FZMgEeq7Ec45Og=;
        b=f/qVnM+D7td1hdoxrIIGImoCRvUcFnnk2/r5MpNrgBRdhte+yXyy1Hi5OANbv65sme
         ogKRuA5YEzuwwM9z7RJTMHQOaU+eSk0RW+T+hma6939a0uiQVbF7A0NrrgBZVye2NUBh
         4wD+YHbdJhc2CQzHXqn4PaojnyhpHTpekHytbr98hTz+yaUBKgoG8lt+Gllazu8sYM5C
         i7UOyVmz/H1suZMcbzlFZPyhNllZPD60kzIQcED+RFZHhVdl2UPv4emnGUifDAuvj1H8
         0SpRy699MIcE6s8c54wn0g1DA21Yd9iUyF26JXdY74plE2NXnurv1dV6rCATzwMjobRI
         mifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m0HfTQlSJ5IZ31jgIuQuMPXpAUt09FZMgEeq7Ec45Og=;
        b=jNwKp16396rjjCbAkuDGv9JDIK8fkkPEECH6cAEKf63dLwtqf3KcKcp3w6vVZNWOho
         9bjjPMnfD+PRkmubhXH3MmXhvE6E+deNQINGl8Hy6BXI9N2Kocg5bKox8kmdrtTUT42J
         TRXGrk+0Z8ACnNUM+L4yKAXBmynMBt9PoitYXY4VfBGuMddQ0KvdtynFCOdOwXkmmim5
         bySr6giXyTwOMsDR2hDpeAeK76PQQ64Qndm7zPxg5gPBHgqlKQbMeuqc/MMNPyMTrhHy
         ldBJz9w3Y7ldKhP2jZ6b/2wU1LHGSQmFIy1OnIIKotuz4D/7VXOJ5H7d+shww41dKbHi
         zWyg==
X-Gm-Message-State: AIVw111EASiG6CcYre1MOcsoVe+RlSCDan45SSGz7PyEmmt0GB0uDIJn
        oewbvdCbZolYPYRw
X-Received: by 10.84.143.36 with SMTP id 33mr30920061ply.171.1500313769018;
        Mon, 17 Jul 2017 10:49:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:987b:7430:64c7:786b])
        by smtp.gmail.com with ESMTPSA id q124sm30919288pga.8.2017.07.17.10.49.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 10:49:27 -0700 (PDT)
Date:   Mon, 17 Jul 2017 10:49:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 04/33] notes: make get_note return pointer to struct
 object_id
Message-ID: <20170717174925.GA10548@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-5-bmwill@google.com>
 <4c10c481-45c9-1b36-d83f-f70adca60bdb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c10c481-45c9-1b36-d83f-f70adca60bdb@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/15, René Scharfe wrote:
> Am 30.05.2017 um 19:30 schrieb Brandon Williams:
> > @@ -392,7 +392,7 @@ static int add(int argc, const char **argv, const char *prefix)
> >   	const char *object_ref;
> >   	struct notes_tree *t;
> >   	unsigned char object[20], new_note[20];
> > -	const unsigned char *note;
> > +	const struct object_id *note;
> >   	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> >   	struct option options[] = {
> >   		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),
> 
> In between here, note can be set to NULL...
> 
> > @@ -453,7 +453,7 @@ static int add(int argc, const char **argv, const char *prefix)
> >   			sha1_to_hex(object));
> >   	}
> >   
> > -	prepare_note_data(object, &d, note);
> > +	prepare_note_data(object, &d, note->hash);
> 
> ... which we then dereference here.
> 
> > @@ -598,13 +598,13 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> >   	t = init_notes_check(argv[0], NOTES_INIT_WRITABLE);
> >   	note = get_note(t, object);
> >   
> > -	prepare_note_data(object, &d, edit ? note : NULL);
> > +	prepare_note_data(object, &d, edit && note ? note->hash : NULL);
> 
> Here a NULL check was added; we need a similar one above as well.
> 
> -- >8 --
> Subject: [PATCH] notes: don't access hash of NULL object_id pointer
> 
> Check if note is NULL, as we already do for different purposes a few
> lines above, and pass a NULL pointer to prepare_note_data() in that
> case instead of trying to access the hash member.

Looks good, thanks for catching this!

> 
> Found with Clang's UBSan.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> The third parameter of prepare_note_data() could easily be turned into
> an object_id pointer (and it should), but this patch is meant to be a
> minimal fix.
> 
>  builtin/notes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 77573cf1ea..4303848e04 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -456,7 +456,7 @@ static int add(int argc, const char **argv, const char *prefix)
>  			oid_to_hex(&object));
>  	}
>  
> -	prepare_note_data(&object, &d, note->hash);
> +	prepare_note_data(&object, &d, note ? note->hash : NULL);
>  	if (d.buf.len || allow_empty) {
>  		write_note_data(&d, new_note.hash);
>  		if (add_note(t, &object, &new_note, combine_notes_overwrite))
> -- 
> 2.13.3

-- 
Brandon Williams
