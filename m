Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B625391518
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621345; cv=pass; b=U+qdOUqD7rQw4iJ3hgkUt2olS6mFa6XMZDhvNOCBVfjRM67hCOCEa4dmVrKgfAxz43UEGB4EBOZKCBUclcJo6RwcYOzO/ak5Zz7U8mYdJ7Em5teHB1jc52XIQbmpF5B/uRebgd6RhIoXsTlGAbfsTlG5+4ZGGgFzpnehgJ6rccM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621345; c=relaxed/simple;
	bh=pSr/900NakBNXZ2Whctaxh5mfP9MQW+RL6OQ3lTFbWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueLvQcUJ2YfOpwItQU6VvmHfmmcVmMpVOZ1RNNJi+n2S1xrbGb2tOOeU+92IXC95GmeUg5r7Pqjat89KDfrH57ums4IEXC0DW8i/HEUSadawq1uHEuIrahC9mV9Fntpsr7sj9Qxh8iHZrbiQNfBlXaLk19vUbwLGJLKSbd8CuuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crdIf+AT; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crdIf+AT"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a60975dc5so23881897b3.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621343; cv=none;
        d=google.com; s=arc-20240605;
        b=CyrAiQcsxo1/H2hTSvVWpLrtyBOwaVT8ti7F71Zo8mYsIAXeHowpboeTXNwEzNJqJR
         UBjh5QjV2sPY/KxxtX+crju9ofT2JIr3WTrE39GM0MUp6GbiTlAUZKWfVJudgTcZEKiZ
         CS4fSAR+Shk1pwUz0kTalRm0RXaGH01hONFaEz3K3KH5Ce6MAAbhljLmXYaYtGPRLMyU
         Ffy3zlfCEoaJ1Ke8/vafpiLUbjXK6jl98ykgbo2pBs88scJBOMfEYMpreXsMWXBI09rP
         wvc6X9L6MSS9RBJIngNSXLp+RvCnZb28odPo+cxrBZmNN2bAnhRW2CiRm665vt/IYTz2
         aWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3MfodvAk8laXwehUA5fEUr1TgIPTX7yAZ2MyFAFnWwU=;
        fh=EIe78UnJA+VVudPSM3+lTK73m4Wlx/m2JXEaQC4dc1k=;
        b=MjxtujmA+NcNdBteAecr32mZVV+N/UI/cXDssfC6WuT67istKCKB9UXh83JrMhamL1
         Av6ql9uqAW/LvOa/gvC944G3ybHKG2voVYdfJ7MQ+AKQF+xJly9vpX+RPg5zVm7J9kDT
         nZVG3bR3IBJIH11ECXalBdV0f7K5176S9/z121wgBmrNVSH+AXzPtI6uSojug4AFpeIM
         SMcbv44O2PTaWf5YOcA7hfGO+2jvNPj9Tu1a19vsTYOTj2PSdCHNVgEMqaQhvR9cO86F
         uJTHXjWJhAIl16ujCA6oGFSQ9OpOx7Q/xqem5ZAJgkN9VwPzUYf4dixSppf7nEljUtZ1
         CbTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774621343; x=1775226143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MfodvAk8laXwehUA5fEUr1TgIPTX7yAZ2MyFAFnWwU=;
        b=crdIf+ATfMjJf5CyBP1PgPGtY921Kj+oYAp/j0/TSuMGPCEJeQPhe3Ry8s/akAE+29
         guVFLCT3cK83UXfsCi+Gos0qrXUwI7k2AfCBUaFOOfTSFsnfmZOIoJMjUbSZIt1X5su6
         nuaDyF9Km2pZcD65vhiegOOSaMqaaP6m1F2205ieJKaEP61HI2aP55wtnKroqjthwQlP
         n1rUOGxD1T32ISCNUX8bOw/uqo/HSTRiyTtEW6URnQRlY/aihQgoNC+tsVHeq8ELI6hn
         KJLyMt5BSOX+T3spVY7TnSZkzgZQ9zt1y4vaov4UFfnNvpeacU6eJAHm4GyYudxVwXBC
         1GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621343; x=1775226143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MfodvAk8laXwehUA5fEUr1TgIPTX7yAZ2MyFAFnWwU=;
        b=gfUlEBQII+W+bIywQqDzA/ndUlNwLfl6zUymaJ2LXyzGB5WnRw5yY3oWL42uBx+Y54
         jtqHJbKCYi+5Ul9oVpYfDgYfMaauHOakXqunWjLgA/7lFFheHbtskBO7lu9O7BOXq/XE
         of64G5hgndI5oYpD9HbjqzkV73/kfDR53fGTJ+L1XA0D9Tag44Nj2XY34pgRYnrI8E7o
         x8ynuAfBkjRdOABWiIgYBxJqlzDL/v/qvVhQq4CGvONOJll/hIosijPKX8WlMdxuYL8b
         JlvYCgf5059pp313XaFDKQBZzg4Y1nhe/YgH+SjacxeCxuPVT5wUXKXdUKURfow9ugFV
         PxDw==
X-Gm-Message-State: AOJu0Ywar3U2uJdXbjzrzbsQSd+s8d8pOYygUXj5O9a2q3XJjuzFjdBX
	KwnyW9VkBjBPig2o8S/Iwf6e6gwItOcLxPLryxWeHpGXAOYhelWoxeyXUvhrJENalwAbekIOZDV
	RLd+90e33neI+5XaI6L8Zuidezzpy+ts=
X-Gm-Gg: ATEYQzw/P02raY7dk0LTUjDQp0uzkVxkB6V0HzljA3pD3xwD8s1JQSu3jJPj8yMiu7d
	d9Myrbi6RymukSop2iS9S6kxpHnRrz34e8Gl0DGNzD3fMVZfycq4tpxjjMzuRtsBHR5LCpSOUsX
	qgUGSKSxhrR+BwvffwHuWClLQyNbx6lD3ti+OgvcABRh/u0+0FTVm0E/i+NGbaMKnCik6AWdCZO
	nAEShu7NL6Dbb7HFDJywHjWmzEVKESNPwERZo/cpg0gigumO3hXuQJQE590w1ZZLrPpitaWCTN3
	XrRJRqlNvL0jYn8gFhULDKeStrgiauyfhTZ/zj/WWM1ol7jw5OpgiHX1eJQbrQQges3MIK3yv/O
	KgQh60T/464YKEjweOlvtsvk=
X-Received: by 2002:a05:690c:6b01:b0:79b:cd67:10b9 with SMTP id
 00721157ae682-79bdded0d3amr24960627b3.25.1774621342956; Fri, 27 Mar 2026
 07:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323215935.74486-1-pabloosabaterr@gmail.com>
 <20260325174401.217577-1-pabloosabaterr@gmail.com> <20260325174401.217577-2-pabloosabaterr@gmail.com>
 <xmqqh5q3sgnm.fsf@gitster.g>
In-Reply-To: <xmqqh5q3sgnm.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Fri, 27 Mar 2026 15:22:06 +0100
X-Gm-Features: AQROBzAAaemErkBm5Ut27o2hrUH4HiyQ-50_TKBAc0hLfVx9-xKmsMpgNchHHJA
Message-ID: <CAN5EUNSyBjpZHHAAd1YGVRjkLwzgGzpafhBJVTTcHJCLKNU2gQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 1/2] graph: add --graph-lane-limit option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, j6t@kdbg.org, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano (<gitster@pobox.com>) writes:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > +static int graph_needs_truncation(struct git_graph *graph, int lane)
> > +{
> > +     int max = graph->revs->graph_max_lanes;
> > +     /*
> > +      * Ignore values <= 0, meaning no limit.
> > +      */
> > +     return max > 0 && lane >= max;
> > +}
>
> Make a mental note that this helper function works on number of
> lanes, not display columns (which is roughly twice the number of
> lanes).
>
> > @@ -696,6 +705,18 @@ static void graph_update_columns(struct git_graph *graph)
> >               }
> >       }
> >
> > +     /*
> > +      * If graph_max_lanes is set, cap the padding from the branches
> > +      */
> > +     if (graph->revs->graph_max_lanes > 0) {
> > +             /*
> > +              * width of "| " per lanes plus truncation mark "~ ".
> > +              */
> > +             int max_columns_width = graph->revs->graph_max_lanes * 2 + 2;
> > +             if (graph->width > max_columns_width)
> > +                     graph->width = max_columns_width;
> > +     }
> > +
> >       /*
> >        * Shrink mapping_size to be the minimum necessary
> >        */
> > @@ -846,6 +867,10 @@ static void graph_output_padding_line(struct git_graph *graph,
> >        * Output a padding row, that leaves all branch lines unchanged
> >        */
> >       for (i = 0; i < graph->num_new_columns; i++) {
> > +             if (graph_needs_truncation(graph, i)) {
> > +                     graph_line_addstr(line, "~ ");
> > +                     break;
> > +             }
>
> And that mental note helps to convince us this loop makes sense, as
> it increments 'i' one by one ;-)

Ok, I'll add the note to graph_needs_truncation() and any other places
that might need to be more clear about if it handles columns or lanes.

>
> > @@ -903,6 +928,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
> >                       seen_this = 1;
> >                       graph_line_write_column(line, col, '|');
> >                       graph_line_addchars(line, ' ', graph->expansion_row);
> > +             } else if (seen_this && graph_needs_truncation(graph, i)) {
> > +                     graph_line_addstr(line, "~ ");
> > +                     break;
> >               } else if (seen_this && (graph->expansion_row == 0)) {
> >                       /*
> >                        * This is the first line of the pre-commit output.
> > @@ -994,6 +1022,12 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
> >               col = &graph->new_columns[j];
> >
> >               graph_line_write_column(line, col, '-');
>
> And here, 'j' comes from graph->mapping[] array.  Does that count in
> display columns or lanes?
>
> > +             if (graph_needs_truncation(graph, j / 2 + i)) {
>
> This makes it look as if 'j' counts in columns and needs to be
> divided by 2 to make it comparable to lanes.

Actually, no, because there are other parts like
graph_output_post_merge_line handling i and j  like that and it is a
more mechanical thing that logical I didn't double checked it, it
should be something like commit_index + 1 + i similar to what j is,
imma check to be sure and add another test for this to be sure because
current ones pass this and that's why I thought it was ok in the first
place.

>
> > +                     graph_line_addstr(line, "~ ");
> > +                     break;
> > +             }
> > +
> >               graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
> >       }
> >
>
> > +     if (graph->num_parents > 1) {
> > +             if (!graph_needs_truncation(graph, graph->commit_index)) {
> > +                     graph_update_state(graph, GRAPH_POST_MERGE);
> > +             } else {
> > +                     struct commit_list *first_parent = first_interesting_parent(graph);
> > +                     int first_parent_col = graph_find_new_column_by_commit(graph, first_parent->item);
>
> Are we sure that first_interesting_parent() will always give us a
> non-NULL pointer?

my bad, first_interestign_parent() can be a NULL, will add a check for that

>
> Can we use a bit shorter identifier names to deal with these overly
> long lines?  The lifetime of these two variables is very short so they
> do not have to be so descriptive.
>
>                         struct commit *p = first_interesting_parent(graph)->item;
>                         int lane = graph_find_new_column_by_commit(graph, p);
>
> > +                     if (!graph_needs_truncation(graph, first_parent_col))
> > +                             graph_update_state(graph, GRAPH_POST_MERGE);
> > +                     else if (graph_is_mapping_correct(graph))
> > +                             graph_update_state(graph, GRAPH_PADDING);
> > +                     else
> > +                             graph_update_state(graph, GRAPH_COLLAPSING);
> > +             }
> > +     } else if (graph_is_mapping_correct(graph))
>

sure

Thanks for the feedback I'll start with the v6,
Pablo.
