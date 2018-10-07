Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A081F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 18:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeJHBge (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 21:36:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38145 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeJHBge (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 21:36:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so15708655ede.5
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=UBt5rbEhn8alHbTNu+NrXzxJNPn3Jwg1+c0bP27/1Oo=;
        b=s0yqX0jZH9eVfocB92DPLhQB1qr4ypZcRr8E1RA+Wit3/4fNFzkYr4w6Ly0xBUJIor
         Yz/zM7n9FGA5IkJeW2uknPnYymvqX1ewILbF69rAtnU1zba2JckHhmEfQhghaioOZ/rW
         wZyZsU+U+7zIhtxnNfU3/yUaxt8yKbERzGtBZE8eSl/VyhqhzHkSkukQgltjnzDbWul8
         o8G8nbdH+gDoI92AmU7BlCMlAp4s7542ielz61cHYWm2E0SZgNlHMuc6/1tbwo9VTqWr
         jf93fVDVU4fzlbtmKPQcKTvPxcfyD530v+D1Ta77oTzIghqq3kLaTc/lVw0KDeQdHCss
         BZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=UBt5rbEhn8alHbTNu+NrXzxJNPn3Jwg1+c0bP27/1Oo=;
        b=PN0r/xQiM+Ejxr5dGDDhEClqUyNAk228z+pdtTAmytVjPaPjf2jHb0kLGcv7dmQM/H
         HT1sN6q1LdSjSViqEKTL35s0+RKRYKHIR8lO2ir5DZ0ImVSwOka3VvlDWnwEZafZCW29
         OXaaLwOmWE31ax0/pjElKiNdNvB8kwQx6sJf/xJZf1ejgP1QpfuT8puZWA1U/dlreCNK
         rQRX6G6KA9VQRuvTk3kqf6U+zkC+suAjii7ueLMJZOx1fEjEIfYgsxAgALACSmTsI5u8
         uHXa7XdehFRe4hgt54qQAtteRSGhPR3xrhldyb8foCr4jFXKk9dIWwao/HrwVq8RQoFj
         PJ9A==
X-Gm-Message-State: ABuFfojWf3VHSy7MniljG85oFs6vxktt5635MzudDi96CLcDPb6deU0o
        i8KXe5H6QzoUAPd6L4vXRJw=
X-Google-Smtp-Source: ACcGV62jmGLbWvzuUg0wCEaakhXCR6D1wtscV0/2yoCYIDf5KabRgbS3huomXkt4PoQgi3rHaHQYNA==
X-Received: by 2002:a17:906:f254:: with SMTP id gy20-v6mr20652770ejb.2.1538936903980;
        Sun, 07 Oct 2018 11:28:23 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id e38-v6sm4899585eda.67.2018.10.07.11.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 11:28:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
        Steven Grimm <koreth@midwinter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: What's so special about objects/17/ ?
In-Reply-To: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
        <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
        <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
        <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
        <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Sun, 07 Oct 2018 20:28:22 +0200
Message-ID: <87k1mta9x5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2007 Junio wrote
(https://public-inbox.org/git/7vr6lcj2zi.fsf@gitster.siamese.dyndns.org/):

    +static int need_to_gc(void)
    +{
    +	/*
    +	 * Quickly check if a "gc" is needed, by estimating how
    +	 * many loose objects there are.  Because SHA-1 is evenly
    +	 * distributed, we can check only one and get a reasonable
    +	 * estimate.
    +	 */
    +	char path[PATH_MAX];
    +	const char *objdir = get_object_directory();
    +	DIR *dir;
    +	struct dirent *ent;
    +	int auto_threshold;
    +	int num_loose = 0;
    +	int needed = 0;
    +
    +	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
    +		warning("insanely long object directory %.*s", 50, objdir);
    +		return 0;
    +	}
    +	dir = opendir(path);
    +	if (!dir)
    +		return 0;
    +
    +	auto_threshold = (gc_auto_threshold + 255) / 256;
    +	while ((ent = readdir(dir)) != NULL) {
    +		if (strspn(ent->d_name, "0123456789abcdef") != 38 ||
    +		    ent->d_name[38] != '\0')
    +			continue;
    +		if (++num_loose > auto_threshold) {
    +			needed = 1;
    +			break;
    +		}
    +	}

A couple of questions about this patch, which is in git.git as
2c3c439947 ("Implement git gc --auto", 2007-09-05)

1. We still have this check of objects/17/ in builtin/gc.c today. Why
   objects/17/ and not e.g. objects/00/ to go with other 000* magic such
   as the 0000000000000000000000000000000000000000 SHA-1?  Statistically
   it doesn't matter, but 17 seems like an odd thing to pick at random
   out of 00..ff, does it have any significance?

2. It seems overly paranoid to be checking that the files in
  .git/objects/17/ look like a SHA-1. If we have stuff not generated by
  git in .git/objects/??/ we probably have bigger problems than
  prematurely triggering auto gc, can this just be removed as
  redundant. Was this some check e.g. expecting that this would need to
  deal with tempfiles in these directories that we created at the time
  (but no longer do?)?
