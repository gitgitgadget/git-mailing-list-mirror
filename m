Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23066244685
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640254; cv=none; b=trIOaT5z73VeUSqR4rlaiQ0iO/fkaAj0BzdPmYmfCvMNfXfFfysIZ5zLi8BxemaXOg2PESEDhwIkczRLF2EarLj5ENAsxJdKj3X7jX8RirKSSk+F0qX6vdVZj8CtDnCIIwIRdWfxUN2AyufMOlmfFwctGBL26nQg0s0EmynOiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640254; c=relaxed/simple;
	bh=IuDnVEDDoDHlsi+1Tgvr2qLstGhlcSN/QdH2YavFEms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXa7PcQ2W2iF4eFwrXQjjkdUre4CJ/07ApmQ/sqwGdzIOMtDg2PRZx9lf65lOoY5tWDt9nRBh6HDnf2X1/FgAoT+WpLnOiwQBigk1ZzW1YMFXqUA3ZEYWs07QkqpEg0gTFDA5TecYXIKDyilc8Xnl1omAubf+LX7KlncpS9tx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJEH2tXg; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJEH2tXg"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-62192ee029dso932205eaf.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758640252; x=1759245052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTmBdk5HmnAGYcbALMXw8qRHyRo8QZv3Z3GpThC1M7s=;
        b=LJEH2tXgvk32yHtsiidEJQm9xgd+aubmZ4XGEC2tekDvjBqxtNlOyJNU8K1bC3jEA8
         +JTymcMPK1jRV6lMgWJIxTVRcRqN8BE4lRF5zZ1fnpqUXjSAuMNxy4ch422FtPu6FBe6
         2kWdlVIYgo5DM6WLl9R8iz5kYYW6BDML703Cte+YhqwRiubDof0yRCKkCo7GyEg3jml/
         YtUO65vA/0QkxkrKf4y/4XO7Fd1GCwnyageluxJ0UXBtxh66Al2H8Xx2T+wR/+wM7fcs
         EJvs84yd7CeX4Q+kTPz4aGDHRjekOKnPi/nt+Xqub9xmdTDafFrUycCd91bdUQeu2/Qu
         HoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640252; x=1759245052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTmBdk5HmnAGYcbALMXw8qRHyRo8QZv3Z3GpThC1M7s=;
        b=cZkcTnpql8JfCT+WHffhccDeCxQG3Sd2h65z6NPb1tXRyqZapXBeuqEPZlUQVsnqoA
         T53jA1glwQLSp6e+ZzdiQsPSAFrwHwrOsr10iK0dLonShXc47Hor0H7LxFORc87jh5H9
         mLQF7LcCiU5SmzP+q6hhcoAxwi5TL7ecML0Kz6UKQagLK/x4XaZw7xDjcDldaY5T9mNg
         r25BMpyh+9rss6WoLQzgVt4SMx37A3jxXynua66NqhyuM+n1M7VZY2lpFCx7f8U2y16Z
         isAWANJm3j0bKU2leVr19AE+dl5uGS1xhcoZG3dT9nEqZHQPwzo4J6FLPjyVt1hkKhAG
         dlrQ==
X-Gm-Message-State: AOJu0YxYpOlMsC71mjxOH6rdITC7jTDIqXojLDEoaAcETYVVta1MNopc
	f9r0fgV7FDaPIolbwg+bTZFZziwOJq5h8QJnp7/dGHCV9ok4H7KFooP1
X-Gm-Gg: ASbGncuMMSqeTyg9a3ODCDCPAYK9mEMsYZ84tozRCPobOW3ofNMySAy4YV8wYPEGpUX
	O9kX/+F57lW4J9GemY+dKUdfjYlO0QKynaRs5hYcMLWcjefK9CUwPIoEuzyPcNMQq3T6GNEo6rf
	cqE8PJvHmGeTXYu9BB83Se2ioF1cx6mFLqvvaBYKM50oFbhEmcdFvruhKYB3X2VY9CBpjrAWFQH
	xgdaJ7QJNtVdC2K8MLpntMh20x4LsWzMkKKMKb7o8Bx7hMQ1XPASmJfGmHYbG20iPgMkMN5ETYN
	5tgInaHz66hz9PV7mouM15k5TNtwigk7khv8EM05bwrmXVqH72kP2Z7I1gzmWHHFyPQbMHzW7WC
	sQ3i9fYpnn9AFNpKG0/I+HN5zi5Y=
X-Google-Smtp-Source: AGHT+IE5Sla0C1le4bpvcUpv0EbYgcJFIdiPcuVC4hSn0qWJk1OdJmtnk8xRl9/lZJk99iB1hD0XVg==
X-Received: by 2002:a05:6808:3999:b0:438:201f:e036 with SMTP id 5614622812f47-43f2d28d0fcmr1274148b6e.9.1758640251869;
        Tue, 23 Sep 2025 08:10:51 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-336e5a2cfc7sm9240380fac.18.2025.09.23.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:10:51 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:10:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 1/4] builtin/repo: introduce stats subcommand
Message-ID: <w4c752odnthf26stoiu7he2xk6fucocmsnxo5pa5vh5sg647g2@a6vphhukasgv>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-2-jltobler@gmail.com>
 <aNJ7_GoKT5ea4QJE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJ7_GoKT5ea4QJE@pks.im>

On 25/09/23 12:52PM, Patrick Steinhardt wrote:
> On Mon, Sep 22, 2025 at 09:56:57PM -0500, Justin Tobler wrote:
[snip]
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> 
> Is this command built on Derrick's git-survey(1)? If so, it would
> probably be nice to add a "Based-on-patch-by" tag.

The git-survey(1) series sent by Derrick certainly served as inspiration
for this series. I didn't build this series from those patches, but
there is probably some overlap since I'm trying to accomplish something
very similar. I don't mind at all adding a "Based-on-patch-by" tag
though. Will do in the next version :)

[snip]
> > +	struct string_list_item *item;
> > +
> > +	item = string_list_append(&table->rows, name);
> > +	item->util = entry;
> > +
> > +	if (name_width > table->name_col_width)
> > +		table->name_col_width = name_width;
> > +	if (entry) {
> > +		int value_width = strlen(entry->value);
> > +		if (value_width > table->value_col_width)
> > +			table->value_col_width = value_width;
> > +	}
> 
> I was wondering at first why you'd ever want to not pass an entry, but
> we use that to have "dividers" in the table. Makes sense.

Yup. Also, some rows like "* References" may have a name, but no value.

> > +}
> > +
> > +static void stats_table_add_count(struct stats_table *table, const char *name,
> > +				  size_t value)
> > +{
> > +	struct stats_table_entry *entry;
> > +
> > +	CALLOC_ARRAY(entry, 1);
> > +	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
> > +	stats_table_add(table, name, entry);
> > +}
> > +
> > +static void stats_table_setup(struct stats_table *table, struct stats *stats)
> > +{
> > +	size_t ref_total;
> > +
> > +	ref_total = stats->branches + stats->remotes + stats->tags + stats->others;
> > +	stats_table_add(table, _("* References"), NULL);
> > +	stats_table_add_count(table, _("  * Count"), ref_total);
> > +	stats_table_add_count(table, _("    * Branches"), stats->branches);
> > +	stats_table_add_count(table, _("    * Tags"), stats->tags);
> > +	stats_table_add_count(table, _("    * Remotes"), stats->remotes);
> > +	stats_table_add_count(table, _("    * Others"), stats->others);
> > +}
> 
> Would it make sense to not translate the formatting directives, but only
> the actual words?

From a simplicity stand point, it is quite nice to have the formatted
offsets baked-in. It is probably better to separate out the
transalations though? I'll interate on this in the next version.

> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct string_list_item *item;
> > +
> > +	if (table->name_col_width > name_col_width)
> > +		name_col_width = table->name_col_width;
> > +	if (table->value_col_width > value_col_width)
> > +		value_col_width = table->value_col_width;
> > +
> > +	strbuf_addf(&buf, "| %-*s | %-*s |\n", name_col_width, name_col_title,
> > +		    value_col_width, value_col_title);
> 
> Aha, that's why you went with `int`. You can use `cast_size_to_to_int()`
> to convert between the types.

Yep :) I'll adapt following your suggestion in the next version.

> > +	strbuf_addstr(&buf, "| ");
> > +	strbuf_addchars(&buf, '-', name_col_width);
> > +	strbuf_addstr(&buf, " | ");
> > +	strbuf_addchars(&buf, '-', value_col_width);
> > +	strbuf_addstr(&buf, " |\n");
> > +
> > +	for_each_string_list_item (item, &table->rows) {
> 
> We typically don't have a space after between the macro and its
> arguments.

Your right! I seem to recall the style linter wanted me to have it this
way, but I'll change it back to be consistent.

> > +		struct stats_table_entry *entry = item->util;
> > +		const char *value = "";
> > +
> > +		if (entry) {
> > +			struct stats_table_entry *entry = item->util;
> > +			value = entry->value;
> > +		}
> > +
> > +		strbuf_addf(&buf, "| %-*s | %*s |\n", name_col_width,
> > +			    item->string, value_col_width, value);
> > +
> > +		if (entry)
> > +			free(entry->value);
> 
> It's a bit weird that we free the values when we pretend to only print
> data. Sure, we probably don't ever have a usecase where we want to print
> data a second time. But I still think it would be nice to separate
> concerns.

That's fair. I'll probably add a stats_table_clear() in the next
version.

> > +	}
> > +
> > +	fputs(buf.buf, stdout);
> > +	strbuf_release(&buf);
> > +}
> > +
> > +static void stats_count_references(struct stats *stats, struct ref_array *refs)
> > +{
> > +	for (int i = 0; i < refs->nr; i++) {
> > +		struct ref_array_item *ref = refs->items[i];
> > +
> > +		switch (ref->kind) {
> > +		case FILTER_REFS_BRANCHES:
> > +			stats->branches++;
> > +			break;
> > +		case FILTER_REFS_REMOTES:
> > +			stats->remotes++;
> > +			break;
> > +		case FILTER_REFS_TAGS:
> > +			stats->tags++;
> > +			break;
> > +		case FILTER_REFS_OTHERS:
> > +			stats->others++;
> > +			break;
> 
> Do we want to have a `default:` case where we `BUG()`? Otherwise we may
> not notice that we undercount the overall number of refs.

Since filter_refs() is only checking regular references, we shouldn't
ever encounter other types, but it doesn't hurt to BUG() here if it were
to happen. Will do.

> > +		}
> > +	}
> > +}
> > +
> > +static int repo_stats(int argc UNUSED, const char **argv UNUSED,
> > +		      const char *prefix UNUSED, struct repository *repo UNUSED)
> 
> Not a new issue, but I'd rather call this `cmd_repo_stats()` to note
> that this is the entrypoint. We might as well adapt the other subcommand
> to follow that naming schema in a preparatory commit.

Make sense. I'll update repo_info() in a preparatory commit as
suggested.

> > +{
> > +	struct ref_filter filter = REF_FILTER_INIT;
> > +	struct strvec ref_patterns = STRVEC_INIT;
> > +	struct stats_table table = { 0 };
> > +	struct ref_array refs = { 0 };
> > +	struct stats stats = { 0 };
> > +
> > +	filter.name_patterns = ref_patterns.v;
> > +	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);
> 
> `filter_refs()` may return an error code which we should probably
> handle.

Will do.

> > diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
> > new file mode 100755
> > index 0000000000..27c32ec45f
> > --- /dev/null
> > +++ b/t/t1901-repo-stats.sh
> > @@ -0,0 +1,59 @@
> > +#!/bin/sh
> > +
> > +test_description='test git repo stats'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'empty repository stats' '
> 
> Nit: I don't think it's necessary to repeat "repository stats" in every
> test name. That's already clear from the test suite.

That's fair. Will adapt the tests accordingly.

Thanks for the review,
-Justin
