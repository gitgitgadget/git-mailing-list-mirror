Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E691F404
	for <e@80x24.org>; Tue, 27 Feb 2018 19:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeB0Tkv (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 14:40:51 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:38234 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeB0Tku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 14:40:50 -0500
Received: by mail-pg0-f42.google.com with SMTP id l24so7920536pgc.5
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D8S+MIDB+jQVZN7z+xtPbRVeG6DCQlTkj6m7xPltpK0=;
        b=guTGpfzVZabYJ/05UHGlhFj0E9cny2m73yAfz4nVvN3WlC8UopAr7u+2qstwYtuRwu
         o739Xbv7/KqZWphM7w3OCDM/8QR5eVtjhG4oLki9rMzk/W7V8OoCjd9wGpb6q2cEaEfK
         15UOb4auWcjpXNQHi9XyiY0YEkDjTEbLidOXnTReaCkLIfVN2EAHbiyHUwtQhjv4M+kM
         XtD8qJqfUv0dAPlbsYhQIxNRjIhTVrS0r0mZ6eZZThCEEMZclYKSibL1c9qBnWNVzn82
         w43jzCu3dWqOYBvbx88JD3xSScuMhqJlAbiZzIIjuOgBS4E4tikKWT4kc9w9imMCP0dz
         e8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D8S+MIDB+jQVZN7z+xtPbRVeG6DCQlTkj6m7xPltpK0=;
        b=eS+lQMP6q3aGLVphdJKBoF3Ct/NdciV0gHCjWzFKb/Mg95Di3A2ekD3E3/qpKa/8BH
         va/gbY1oi42ZLwUifsrZmDoGNpSpLDF8GeFem1YUMbN/XmO9qce2WTTrSH4hWmsEU6Vr
         uaMQggwR+mq7q5moS2L+PVddB/4BbWbERLM9WJzieKbdvOiMMZnqZcWzAYwLnkLkCipB
         Xw/ROq1KbKVxBYX/78UGJB36Kaljt+4393AMjk7Yt2EGYow22+d5Do0LGnZjVPmTpHiW
         ui5EgsgM9lCuqA8MP5H6onw5k+y3ARd0SE4td0b4YP9D1JjT0YRfIUlZv3vjDHlWX5Hx
         Z3EQ==
X-Gm-Message-State: APf1xPCahOiz8FkVNKdeZcM/jYllWDAA92MsoEbQifg+sjttdacZUTo3
        ZWqRqqB7o/DNBOmYiQd5guOwsQ==
X-Google-Smtp-Source: AH8x225j9FZi3f1i3sUgEm8EX4BaK6DUvfM6VJOGWTx5LzgSt6SFBbAeUdhQwhkhFzc+AaS4Hp0UGg==
X-Received: by 10.101.86.138 with SMTP id v10mr12112190pgs.353.1519760449726;
        Tue, 27 Feb 2018 11:40:49 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y7sm23169754pfy.128.2018.02.27.11.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 11:40:48 -0800 (PST)
Date:   Tue, 27 Feb 2018 11:40:47 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 21/35] fetch-pack: perform a fetch using v2
Message-ID: <20180227194047.GH209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-22-bmwill@google.com>
 <CAGZ79kZLkHwfiqSf8htKPRKyVBCvurQwTAwW4n87ESbBfaL3sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZLkHwfiqSf8htKPRKyVBCvurQwTAwW4n87ESbBfaL3sA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Stefan Beller wrote:
> > +
> > +       /* Add initial haves */
> > +       ret = add_haves(&req_buf, in_vain);
> 
> I like the shortness and conciseness of this send_fetch_request
> function as it makes clear what is happening over the wire, however
> I wonder if we can improve on that, still.

I'm sure there is more that can be micro optimized but I don't really
want to get distracted by redesigning this logic another time right now.

> 
> The functions 'add_common' and 'add_haves' seem like they do the
> same (sending haves), except for different sets of oids.
> 
> So I would imagine that a structure like
> 
>   {
>     struct set haves = compute_haves_from(in_vain, common, ...);
>     struct set wants = compute_wants&wants);
> 
>     request_capabilities(args)
>     send_haves(&haves);
>     send_wants(&wants);
>     flush();
>   }
> 
> That way we would have an even more concise way of writing
> one request, and factoring out the business logic. (Coming up
> with the "right" haves is a heuristic that we plan on changing in
> the future, so we'd want to have that encapsulated into one function
> that computes all the haves?
> 
> > +
> > +/*
> > + * Processes a section header in a server's response and checks if it matches
> > + * `section`.  If the value of `peek` is 1, the header line will be peeked (and
> > + * not consumed); if 0, the line will be consumed and the function will die if
> > + * the section header doesn't match what was expected.
> > + */
> > +static int process_section_header(struct packet_reader *reader,
> > +                                 const char *section, int peek)
> > +{
> > +       int ret;
> > +
> > +       if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
> > +               die("error reading packet");
> > +
> > +       ret = !strcmp(reader->line, section);
> > +
> > +       if (!peek) {
> > +               if (!ret)
> > +                       die("expected '%s', received '%s'",
> > +                           section, reader->line);
> > +               packet_reader_read(reader);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int process_acks(struct packet_reader *reader, struct oidset *common)
> > +{
> > +       /* received */
> > +       int received_ready = 0;
> > +       int received_ack = 0;
> > +
> > +       process_section_header(reader, "acknowledgments", 0);
> > +       while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> > +               const char *arg;
> > +
> > +               if (!strcmp(reader->line, "NAK"))
> > +                       continue;
> > +
> > +               if (skip_prefix(reader->line, "ACK ", &arg)) {
> > +                       struct object_id oid;
> > +                       if (!get_oid_hex(arg, &oid)) {
> > +                               struct commit *commit;
> > +                               oidset_insert(common, &oid);
> > +                               commit = lookup_commit(&oid);
> > +                               mark_common(commit, 0, 1);
> > +                       }
> > +                       continue;
> > +               }
> > +
> > +               if (!strcmp(reader->line, "ready")) {
> > +                       clear_prio_queue(&rev_list);
> > +                       received_ready = 1;
> > +                       continue;
> > +               }
> > +
> > +               die(_("git fetch-pack: expected ACK/NAK, got '%s'"), reader->line);
> 
> This is slightly misleading, it could also expect "ready" ?

I'll update this.

> 
> 
> > +       }
> > +
> > +       if (reader->status != PACKET_READ_FLUSH &&
> > +           reader->status != PACKET_READ_DELIM)
> > +               die("Error during processing acks: %d", reader->status);
> 
> Why is this not translated unlike the one 5 lines prior to this?
> Do we expect these conditions to come up due to different
> root causes?
> 
> > +static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
> > +                                   int fd[2],
> > +                                   const struct ref *orig_ref,
> > +                                   struct ref **sought, int nr_sought,
> > +                                   char **pack_lockfile)
> > +{
> > +       struct ref *ref = copy_ref_list(orig_ref);
> > +       enum fetch_state state = FETCH_CHECK_LOCAL;
> > +       struct oidset common = OIDSET_INIT;
> > +       struct packet_reader reader;
> > +       int in_vain = 0;
> > +       packet_reader_init(&reader, fd[0], NULL, 0,
> > +                          PACKET_READ_CHOMP_NEWLINE);
> > +
> > +       while (state != FETCH_DONE) {
> > +               switch (state) {
> > +               case FETCH_CHECK_LOCAL:
> > +                       sort_ref_list(&ref, ref_compare_name);
> > +                       QSORT(sought, nr_sought, cmp_ref_by_name);
> > +
> > +                       /* v2 supports these by default */
> 
> Is there a doc that says what is all on by default?

Yeah protocol-v2.txt should say all of that.

> 
> Thanks,
> Stefan

-- 
Brandon Williams
