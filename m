Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67AC71F859
	for <e@80x24.org>; Tue, 30 Aug 2016 06:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbcH3Gmt (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 02:42:49 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35065 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbcH3Gms (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 02:42:48 -0400
Received: by mail-yw0-f176.google.com with SMTP id j12so5894039ywb.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BBTB6yYQFHfRIl3f2695hW1/ITMhuRZPgVFLvX7BC3A=;
        b=bqL84fr7Bn5hTB4/bdKQKXDTmUO50iWViKKzjB3DkHmRns6wyeBiUogzK1mVSzb6eY
         ec171ArfvCzvdGZ1Qiv/6SuTPdK4PwKZnduOzWurrTOezFA+nfNRBX5fMOSpFW6ashuE
         NpzPCEgYOgxgmao3YYk2mDAK0glPeoW1dqlxMZLWBy7FwBoceYu+mysfZQpr0tc4Wq/B
         SuUgg24A/tTPFsF0cDy7qyuGxXZJEocmCpYDFm67LXiSqP57/jLbRElNAIgqH1hSuCfb
         +2zMJT+jXFWrdnKUWjklWj5HvyqyhMST5JnxBmhfqQNohNPA34hDujf5THPBFJNREVs7
         vmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BBTB6yYQFHfRIl3f2695hW1/ITMhuRZPgVFLvX7BC3A=;
        b=XusZFYBMjN1jeE7EKemHWm/zuz1aIpfL9B71UzOw4ZrdAlEhtHLDFyExpmAkWoMlLB
         GpJGtoz3+QRXqO+JOg22CPDCWHmdKgBjRVdzcdF3Bo5HIlJJDl1JY5yFrivHjrH+8FUH
         eZDGNVRE5776O/FFokbH4YDlp6LGT/DsU6D7+i7p6Kww6qAvjNimpD844TJbqq5O4yQS
         ICZ7VehcHMYvLgcf6CK8+MWBDhGvqJIH5reNKnT78cmg3RExZvZUZcrOe/lfz6ztUJhv
         YNq9OMQHRQey6nmeUoI413SvLpGgigzfjXIbGMUYInXqxHxrUzE6KXHElBwi6cv/VZpu
         D2XA==
X-Gm-Message-State: AE9vXwOSk26kq1kUfVvCt2fpRgHA3+vfkeIT5ciVywEesAeRgrM0jHsFcVE45ocK951Uv0/LLIs4D8kGvTlEwA==
X-Received: by 10.129.136.5 with SMTP id y5mr1986242ywf.30.1472539367187; Mon,
 29 Aug 2016 23:42:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Mon, 29 Aug 2016 23:42:46 -0700 (PDT)
In-Reply-To: <xmqqtwe5di02.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6a7-2e9df745-e3f4-4830-a1af-4acae7964c11-000000@eu-west-1.amazonses.com>
 <xmqqfuptol4h.fsf@gitster.mtv.corp.google.com> <CAFZEwPMcUf-Tm_ijJbEG1Bh7F+7ML2fw6Vw2Gt94B9gyoGL1FQ@mail.gmail.com>
 <xmqqtwe5di02.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 30 Aug 2016 12:12:46 +0530
Message-ID: <CAFZEwPMz4n35x-g3cxM4KaADRJNmYmZBnwsDZD1wiiFPHJebew@mail.gmail.com>
Subject: Re: [PATCH v14 09/27] bisect--helper: `bisect_write` shell function
 in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Sun, Aug 28, 2016 at 2:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
> >>> +struct bisect_terms {
> >>> +     struct strbuf term_good;
> >>> +     struct strbuf term_bad;
> >>> +};
> >>
> >> I think "struct strbuf" is overrated.  ...
> >> I think you can just say "const char *" in this case.
> >
> > Using struct strbuf is not really overrated but in fact required. But
>
> Nothing is required.
>
> I can make your life easier by requiring you to never use struct
> strbuf as a structure field type, though.  You will almost never
> need it unless you are building something exotic anyway.
>
> Step back and think what "strbuf" is good for.  It holds a pointer
> to a piece of memory the field owns, over-allocates and knows the
> size of allocation and usage.  That is good if you need to
>
>  (1) frequently find out the length of the string; without a
>      separate .len member you would have to run strlen().
>
>  (2) incrementally add to the string in-place; as it overallocates,
>      appending to the string would not have to involve realloc()
>      every time and the cost of it is amortized.
>
>  (3) make complex operations like splicing another string in,
>      trimming substring out, etc.
>
> You need to do none of the above to these fields.  term.term_good is
> either taken from an argv[] element, or you read from a line from a
> file and set it.  You may do some trivial computation and set it to
> the result, like "the other field uses 'old', so this one need to be
> set to 'new'".  The user of the field either has the string and sets
> it there, or reads the field's value as a whole string.  No string
> manipulation in the field in-place is needed.
>
> > yes, for this patch it might seem as overrated. In the shell code
> > initally TERM_GOOD is set to "good" while TERM_BAD is set to "bad".
> > Now there are a lot of instances (one of which is bisect_start()
> > function) where this can change. So if we keep it as "const char *",
> > it would be right to change the value of it after wards. And we cannot
> > keep it as "char []" because we don't know its size before hand.
>
> You are not making sense.  Nobody would suggest to use a fixed-size
> char array in this structure.  That wouldn't even work in the case
> where you are stuffing what comes in an argv[] element in there,
> e.g.
>
>     terms.term_good = argv[3];
>
> And you can of course support changing the value of the field
> without using strbuf.  Just update the pointer to point at the piece
> of memory that holds the new value.
>
> In short, I do not see any good reason why the term_good field has
> to be anything other than "char *term_good" or "const char *term_good".
>
> Now, what you need to consider choosing between the two depends on
> where these strings can come from.  If they are known to be always
> unchanging between the time you set it til the end of the program
> (e.g. using an element in argv[]), you can just assign without
> making any copy and you can use "const char *term_good".  All other
> cases, the structure needs to take the ownership, and you would need
> to make a copy if you don't have the ownership, e.g.
>
>         terms.term_good = xstrdup(argv[3]);
>
> You may be reading from a file, a line at a time and you may have a
> line's content in a strbuf.  You do not (yet) own the buffer after
> reading it, e.g.
>
>         strbuf_getline(&buf, fp);
>         terms.term_good = strbuf_detach(&buf, NULL);
>
> Of course, if you need to take ownership of the memory, you would
> need to free(3) it as needed, which means the pattern to set the
> field would become
>
>         free(terms.term_good);
>         terms.term_good = ... some new value ...;
>
> Using strbuf as a local variable is good.  It gives a higher level
> of abstraction when you are actually performing string operations.
> In most applications, however, a field in a struct is where the
> result of a step of computation is kept, not a scratch-pad to
> perform steps of computation in.  When you are ready to update the
> value of a field, you _have_ a completed string, and you can just
> use "char *" field to point at it.  There is no need for strbuf in
> the field.
>
> Don't look at the data structure used in trailer.[ch] as a model; it
> is an example of a terribly bad implementation taste, a pattern that
> should not be followed.  Print it, not read it and burn it as a good
> symbolic gesture.

Thanks for explaining when to use strbuf. I am convinced that the
thing I am aiming for can be done with the help of "const char *".
Though I will have to use strbuf in get_terms() and detach the string
buffer from there as you have mentioned previously.

Regards,
Pranit Bauva
