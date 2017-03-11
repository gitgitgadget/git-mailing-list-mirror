Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22FA1FC43
	for <e@80x24.org>; Sat, 11 Mar 2017 00:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755400AbdCKA20 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 19:28:26 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34318 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdCKA2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 19:28:25 -0500
Received: by mail-pf0-f181.google.com with SMTP id v190so47552505pfb.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 16:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mx3XTqsSBZtnFIY760g6ceZsJSNZ6YilWrBQeRgA0dM=;
        b=NpnjjOmiQrCOY+hQjv5lsBBudY27wOvXruBoPzeN13ZyaUZnmFV8AEwSFPJdjgcQL/
         lJSc0qqSqRCpSbJXB7fJ5euFyExLEvhZh2nVV5sncKnhmMeGZFfoHJoGLKa9RWsqRSeb
         6TWrxIwF6Xlgdk8IPKJYZOIH+NnUS0uxhqGjx9g2wDirmrLyetG8loUfInWyTVD47Q+M
         Z9zSgS95VDbugzrefGNgxsDXOTBBEGn37a5qvmwzmLpzAVs71Nji0fVJwpSO51D1stOr
         8MuMK+qLHxsbrsptS1FIB46oL8ctTrCMZtVEruWOmXwLQXKwKGK+CQVjMNJaxn7Wvlqp
         qbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mx3XTqsSBZtnFIY760g6ceZsJSNZ6YilWrBQeRgA0dM=;
        b=tFe7Ix1+a0FAvN7UFLkr2AJZ/LH/RV3Y2QIr5cTnJodkXmEOd5zzTXlVs+RivB0yVt
         7fMFBQx1ZiMO5gGs9MtkXY1ynSQXn6iN80nYbRVL8x2Wir11wAvJwEzp1Ns3GnQggrZJ
         lYc5HmfZTTfO3gaycYrV9g+y1/knNN51BSsSo1YQOnaL9N4p1K+mGLlosRmjT5TKMPL2
         ebgp7UhLs0WcYgYEjdNKUIWxrIApqR/LeeNhKcoNdFth8+oZ8OYPcEMhplELhhKbeJYJ
         4ToqM2SXgfgCnpe1QxETYh1ImnNythisedOo+86bkKijQlVr9KW+ZVinySh/NwKavjQK
         ZpXw==
X-Gm-Message-State: AMke39k5HKMXhrOiOlNaKdE2rGPzJhn0kDl/Ztbehlr64ZA6Ues2ukK12zGrFpCZlHlhAASA
X-Received: by 10.99.36.71 with SMTP id k68mr23801291pgk.68.1489192103579;
        Fri, 10 Mar 2017 16:28:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:c69:ce9:a41e:fd0])
        by smtp.gmail.com with ESMTPSA id x15sm20833838pgc.16.2017.03.10.16.28.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 16:28:22 -0800 (PST)
Date:   Fri, 10 Mar 2017 16:28:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 1/2] pathspec: allow querying for attributes
Message-ID: <20170311002821.GD53198@google.com>
References: <20170309210756.105566-1-bmwill@google.com>
 <20170310185908.171589-1-bmwill@google.com>
 <20170310185908.171589-2-bmwill@google.com>
 <80fdf152-a4a1-7078-bb86-22f11763a4bb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80fdf152-a4a1-7078-bb86-22f11763a4bb@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/10, Jonathan Tan wrote:
> Thanks - I don't think I have any more comments on this patch set
> after these.
> 
> On 03/10/2017 10:59 AM, Brandon Williams wrote:
> >diff --git a/pathspec.c b/pathspec.c
> >index b961f00c8..7cd5f6e3d 100644
> >--- a/pathspec.c
> >+++ b/pathspec.c
> >@@ -87,6 +89,74 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
> > 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
> > }
> >
> >+static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
> >+{
> >+	struct string_list_item *si;
> >+	struct string_list list = STRING_LIST_INIT_DUP;
> >+
> >+	if (item->attr_check)
> >+		die(_("Only one 'attr:' specification is allowed."));
> >+
> >+	if (!value || !*value)
> >+		die(_("attr spec must not be empty"));
> >+
> >+	string_list_split(&list, value, ' ', -1);
> >+	string_list_remove_empty_items(&list, 0);
> >+
> >+	item->attr_check = attr_check_alloc();
> >+	ALLOC_GROW(item->attr_match,
> >+		   list.nr,
> >+		   item->attr_match_alloc);
> 
> If item->attr_match always starts empty, then I think an xmalloc or
> xcalloc suffices (and we don't need item->attr_match_alloc anymore).
> 
> We should probably also check item->attr_match above - that is, `if
> (item->attr_check || item->attr_match)`.

Correct, I'll make these changes.

> 
> >+
> >+	for_each_string_list_item(si, &list) {
> >+		size_t attr_len;
> >+		char *attr_name;
> >+		const struct git_attr *a;
> >+
> >+		int j = item->attr_match_nr++;
> >+		const char *attr = si->string;
> >+		struct attr_match *am = &item->attr_match[j];
> >+
> >+		switch (*attr) {
> >+		case '!':
> >+			am->match_mode = MATCH_UNSPECIFIED;
> >+			attr++;
> >+			attr_len = strlen(attr);
> >+			break;
> >+		case '-':
> >+			am->match_mode = MATCH_UNSET;
> >+			attr++;
> >+			attr_len = strlen(attr);
> >+			break;
> >+		default:
> >+			attr_len = strcspn(attr, "=");
> >+			if (attr[attr_len] != '=')
> >+				am->match_mode = MATCH_SET;
> >+			else {
> >+				am->match_mode = MATCH_VALUE;
> >+				am->value = xstrdup(&attr[attr_len + 1]);
> >+				if (strchr(am->value, '\\'))
> >+					die(_("attr spec values must not contain backslashes"));
> >+			}
> >+			break;
> >+		}
> >+
> >+		attr_name = xmemdupz(attr, attr_len);
> >+		a = git_attr(attr_name);
> >+		if (!a)
> >+			die(_("invalid attribute name %s"), attr_name);
> >+
> >+		attr_check_append(item->attr_check, a);
> >+
> >+		free(attr_name);
> >+	}
> >+
> >+	if (item->attr_check->nr != item->attr_match_nr)
> >+		die("BUG: should have same number of entries");
> 
> I think such postcondition checks are usually not worth it, but
> others might differ.

yeah probably not, but its just an assert check for just in case so I'll
leave it in.

> 
> >+
> >+	string_list_clear(&list, 0);
> >+}
> >+
> > static inline int get_literal_global(void)
> > {
> > 	static int literal = -1;

-- 
Brandon Williams
