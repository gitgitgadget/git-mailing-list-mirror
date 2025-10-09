Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C61A9FAE
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047791; cv=none; b=ZlWjD/nW2h1ZO3aW6yUxJr6oZ6cQEhOdlqtdxZ0443bB6Aihzkfjt7DCr1ZQNdvGg/Fa8MYgc/pZw5MeMzL9VLfAObvKQiUn7arvzOrixGswjuQuNFtGkLiW86zaxptfAMZBZ/qnLd2DFcLXFwDMvOy/zwn/ykJS9dkkw9U2/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047791; c=relaxed/simple;
	bh=R+TQZHhWDWogOvtu6aQRamwmqLr6edKPXJ7tMzmTZR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkpXfsH7r3VcgJ2ZfvmWqsX02hKZI/YjhihXI15FFV09MiGOoAe8sSg+uApVv0bhJMzzpcDvSdNJkE4QSGwT9VujBUm+KIS8UKefZEuVWYe9bj2qH87roAX+P5GpPicA7thIiGQvQ1uoG6siU27RWUmgGMtgObWKaN9mVxzA/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2M21J/y; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2M21J/y"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3544c64380eso1949274fac.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760047787; x=1760652587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zX8z8gKLlLFmTXPwMkSM4bJ6phVD1wWvr3Uzsk8Prs=;
        b=A2M21J/ygzakkMqN7MrJxeYCQndZO6ZBdyC6Brh7XekkygtcmX/tycYN/fvotfOd7x
         3+Cn3TlpnkSQobLBbyGxb26y7FeQ+LvAXO7XXq+y8e2IIhhx13yBWXK05YBAFBQ+p2j6
         7O5S5mldDMt4jj7oTRhZBpeNN7Bytp7smgEImwrV2++nR7eQCABfvVI1zUW1ssLava2/
         EF/O0Zdz4YPBpvr7WyH59ZW+4ljGpD5ORC2eGDYQn2rQ1YLF73rEgpFdOuBUwlan4xok
         VgOyYmoUXUx5HlhhPjy2Sve/vZFlT0JMnriyphzYCi5iQms9nvoKOj5gLk13u/WnbDFY
         OBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760047787; x=1760652587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zX8z8gKLlLFmTXPwMkSM4bJ6phVD1wWvr3Uzsk8Prs=;
        b=E3MJtv09rDY0XrWtPpp7JAAhHtLMT+7iVmcWa0CyicIFIQr+bP+K3x4cu9FPGayEAy
         vhcFzpdn6szwn0h1HMPfhgYg5W4kTnwSYMZr8C49a9FxgtBMK+y8b+uzNsNE5oXriUJw
         DDvTfp31650KlmfFSkX77Yek4MagwOI/ZaJx5D30xk+o/dkO8V3NRdYjIi+LrOhavpFj
         TtMxTGAm2l1Ie/RmjXRjbvU4FZBryj+cfyJUILhWgYjFgUC95GKPmwEnCdhH1XqHqu28
         bx8ir5VhPk2TEJdjnJ6iC6EIns792GTm03NOLCMnTGzylMltuBCYuDGY3evt0S+CBiBf
         OU5A==
X-Gm-Message-State: AOJu0YxNWGTm52/1RoStxNGeJg/jtYoUD98RMEM94F+/1pDXcTMJO6Fr
	77PFRyM/Ret3LeetpxTnXYEWfsLNyEBLd9tHQq9oW9/B+Z4a9Nut3f0l17aD8g==
X-Gm-Gg: ASbGncvpyYwEnQIV2oaMgk+eHfTVPCXeKl2XWSrFqaUFJW2aQjtuW63z7YODPyXGpW0
	/R0/uOSdO+QnIyLzfB9F0wbc4HMUKLXPV/uGSFGOtLQKrsd/5yNKk7+wYGR8fobz2E9EL9STD6b
	0QGVNrxcNtfvhm+9MdokQql6qEx9nqfVU7IVdWoGveGFOzpvf1odMlZCU74ShaC0F7PZyYbVowG
	LAzemyyjDbJnBUcxX6gMbA+G84yzqoGNQEen2V85mBUkTp3stOQSZc6CBxlS31/SWZO3MCZbnOd
	F7qmxvPXWm3fYZDZifgpJcgC0Xk/CIj3QlrQ33SDws3ulO/6Fjwu94+cqBHjytu+Q7vI3lpFhpa
	PYy+yGbJoncVHBXoT8YBbtKFAsS5uZzFiHjBpLxPU
X-Google-Smtp-Source: AGHT+IFBQid4ee0zwXycpbsYx/ldsG7fxvQFrIcUzlJRU5J9E44xcSGMTBbfryQk240Cg8V9qzTANw==
X-Received: by 2002:a05:6870:31b2:b0:387:3c81:ee9 with SMTP id 586e51a60fabf-3c0fbd378ffmr4242816fac.51.1760047786794;
        Thu, 09 Oct 2025 15:09:46 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-3c8c8682138sm303201fac.0.2025.10.09.15.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:09:45 -0700 (PDT)
Date: Thu, 9 Oct 2025 17:09:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 4/7] builtin/repo: introduce stats subcommand
Message-ID: <qdot36lscj2jzuej2zixdlgocubiimh54dkxzl2xgcy3g2n42m@gpdi7jwc2oyd>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
 <20250927145049.723341-5-jltobler@gmail.com>
 <xmqqfrc797pk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrc797pk.fsf@gitster.g>

On 25/09/27 09:32AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > The shape of a repository's history can have huge impacts on the
> > performance and health of the repository itself. Currently, Git lacks a
> > means to surface key stats/information regarding the shape of a
> > repository via a single command.
> 
> Talking about "shape of a repository's *history*" may negatively
> affect your goal here.  If a project is overly mergy with many
> octopus merges, it would have huge impacts on the performance to run
> "git bisect" over its history, so it may be interesting to know the
> ratio of the merge commits in the total commits, and also the
> average number of merge parents.  But after you obtain such numbers,
> you cannot do anything about it, as you cannot afford to rewrite its
> history only to improve the "performance and health".

The above example is actually something I would like to add in a future
series. From my perspective, if a certain repository operation is
performing poorly, it is still valuable to have insight into the reason
why, regardless of whether it is realistically actionable or not for the
user.

I will try to better clarify the command's intent in the log message.

> And that is what makes "key stats" relative to your goal.  If your
> goal is to give stats on the things you can control (e.g., how long
> a typical delta chain is, how many loose objects there are that can
> be moved to a packfile, how small would your object database would
> become if you prune all the unreachable objects), that would cut off
> some stats that may still be interesting but may not contribute to
> address "huge impacts on the performance and health".

I would say the main goal of this command is to surface interesting
information about the repository and its object graph structure.
Something that may make a stat "interesting" is if its value could be a
potential indicator of poor repository performance. Like the max number of
parents a commit has, or the max number of entries a tree has. I don't
think the actual stat value needs to be concerning itself for it to be
displayed though.

If there is actionable recourse a user can take to remediate a
concerning stat that would be ideal, but I see the primarly goal being
to just surface the information regardless.

> With Devil's advocate hat on, a single command that gives a set of
> stats that are "key" to a goal of a single use case may not be as
> useful as a collection of commands, each of which gives stats on one
> aspect of the repository, that can be combined to help you address
> various different goals.

Good points. From my perspective, the benefit of having a single command
here is to provide a simple means to generate a report of the general
repository shape. In this context, "key stats" reflect certain
charactistics about the repository that may be concerning performance
wise for typical repository operations or just of interest in general.

One of the motivations here is to enable a user to easily generate such
a report and be able to share it with others that may not have access to
the underlying repository.

I think this still could leave room for more fine-grained commands that
can surface more targeted information about a repository with other
goals in mind in the future though.

> > To allow users to more readily identify potential issues for a
> > repository, introduce the "stats" subcommand in git-repo(1) to output
> > stats for the repository that may be of interest to users. The goal of
> > this subcommand is to eventually provide similar functionality to
> > git-sizer(1), but natively in Git.
> 
> So, it is needless to say that the kind of "stats" obtained by such
> a single tool needs to be chosen carefully, but more importantly,
> its output should give users actionable output, as whoever designed
> such a tool and chose what "key stats" are has a clear idea on
> various aspects of repository.  "stats" measure the health of the
> repository against certain yardstick, but it should come with a
> clear instruction to make use of that measurement.  The tool may say
> "the stats indicate that you have commits that touch too many paths
> at the same time".  The users need to be know what consequence of
> that finding is, and what they can do about it.

As mentioned above, from my perspective, the git-repo-stats command
itself is not about specifically targeting and diagnoising actionable
issues that a repository has. It's primary focus should be to provide
insight about the repository structure that may be helpful when trying
to understand certain repository performance characteristics in general.

In the next version I'll rework this log message to better clarify the
intent of this command.

> For example, what would the user do with the new knowledge that the
> repository has 100x as many local branches as there are
> remote-tracking branches?  Without breaking down these numerous
> local branches into those that are still used in active development
> (hint: peek into their reflog), kept as historical landmarks, past
> development that has already been merged (hint: "git branch --list
> --merged origin/master"), or abandoned cruft that hasn't been
> touched with some changes that are not merged anywhere, the users
> would not know what to do.

In a future series, I would like to introduce a "level of concern" meter
for the outputted stats. As you mentioned earlier, this could provide a
measure of health for a repository stat against a certain yardstick. At
that point in time, I think it would also make sense to provide
documentation on actions that a user could potentially take to address
specific stats that are marked with a higher level of concern. Certain
stats that get identified as concerning may not be realistically
actionable though.

For now, I think it's fine to omit this though because the outputted
stats are presented agnostically without any concern level.

> > +`stats`::
> > +	Retrieve statistics about the current repository. The following kinds
> > +	of information are reported:
> > ++
> > +* Reference counts categorized by type
> > +
> > ++
> > +The table output format may change and is not intended for machine parsing.
> 
> Do we eventually want to give another format that is intended for
> machine parsing?

Yes, and we introduce a key-value and NUL format later in this series. I
will mention this in the log message.

> In a format meant for human consumption, is it still sensible to
> target fixed-column terminals these days?  Rather, would they want
> prettier-formatted html, or csv that they can easily import to
> spreadsheet?  (these are not objections but genuine questions).

From my perspective, having an output format that can be immediately
viewed in the same place the command is run is still quite valuable and
is still common in similar tooling.

I think there may also be value in additional formats, such as the ones
mentioned above, but I think those should be implemented as a separate
series if demand presents itself.

> > +static void stats_table_print(const struct stats_table *table)
> > +{
> > +	const char *name_col_title = _("Repository stats");
> > +	const char *value_col_title = _("Value");
> > +	size_t name_title_len = utf8_strwidth(name_col_title);
> > +	size_t value_title_len = utf8_strwidth(value_col_title);
> > +	struct string_list_item *item;
> > +	int name_col_width;
> > +	int value_col_width;
> > +
> > +	name_col_width = cast_size_t_to_int(
> > +		max_size_t(table->name_col_width, name_title_len));
> > +	value_col_width = cast_size_t_to_int(
> > +		max_size_t(table->value_col_width, value_title_len));
> 
> If table->name_col_width and table->value_col_width were int to
> begin with, none of these casts would have been necessary.  Aren't
> we overusing size_t to count things that are not memory allocations?

Yes. Storing the column widths as size_t in this scenario doesn't make
much sense because they need to be an int for the format string anyways.
Furthermore, the number of columns will always be a relatively small
number.

I'll fix this in the next version. :)

> > +	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
> > +	       value_col_width, value_col_title);
> > +	printf("| ");
> > +	for (int i = 0; i < name_col_width; i++)
> > +		putchar('-');
> > +	printf(" | ");
> > +	for (int i = 0; i < value_col_width; i++)
> > +		putchar('-');
> > +	printf(" |\n");
> 
> I wonder if people want to use unicode "Box Drawing" block and other
> fancier things, as we assume utf8 for names and values, in which
> case these printf would need to be "translatable", but locale
> administrators should not have more say than others what kind of
> line drawing elements are to be used, so perhaps the above is good
> enough at least for now.

I think the current table is probably sufficient for now. I do forsee
iteration on this format in future series though.

-Justin
