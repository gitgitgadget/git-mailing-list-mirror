Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A621F405
	for <e@80x24.org>; Tue, 18 Dec 2018 18:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeLRSVQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 13:21:16 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35451 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeLRSVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 13:21:15 -0500
Received: by mail-ed1-f41.google.com with SMTP id x30so14715409edx.2
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TGoHRlBGwneyHwcuTJhImIOfgL/odXh+R1d9cDsKPW0=;
        b=hD7hc+eBM2+6Po3nx9xoPjKdCkwNiztcxisDV0/RkFltdHiG3Cb2H6jAhKwPre//4I
         awlX8LOpT3d8xGlzV8MI2J0zozT/AurOllJ4JuvnefTcGTzpHZ7IKIMWEljUeYJR1XzL
         mCZrjMPdpzSjLvMOokAfjjK+RSZ66gX41/6Y9+52/pABQptWLl8GMriztDIBM91HgSP3
         Uj920/J7y/6RKMZl0gicINHeGCxDvH0Mkqs1dlJtQH+MBgqQh/yE8vU0iK22FAutxqc9
         qKEp+YLlBHiD3k2+ojM3ZE4dNvQoBJ/N9C8pfodGrx8NvfXI8IqOYOAH467ZLAjQiYPI
         YINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TGoHRlBGwneyHwcuTJhImIOfgL/odXh+R1d9cDsKPW0=;
        b=VFNcPnNFIG0hdlWXCX3hhljAxWSb6t7AxzO34J1NceORorZbf2mc8y/cBeh6VcXsRd
         NxeWi7l3KbHGKO2RNY6RQDaXKxZyfGcEor+/GME61KlKmrUNGNsWmfGtV/R21l3qXRYA
         9iYtduEo8HzfgD6oFyHDQRe4Xhia2KllOqw/IuSpepKWJDOGImwDdOe2jx3D0wsHbSmR
         VbpBPL/7UrgB5jHElycIF2AD7FJUmUPNp7JwlNEUkio9PWX/qCvy1A34Slx5Dd9r40Ws
         bd1N1P/ocLAPmUr3cLwAcrcQ10ScAz8ijnn0P3lB3D9fofh5e6O2qPzel8gukQ8f9Zkv
         hjCQ==
X-Gm-Message-State: AA+aEWaPk+lpULiI9VZV31Y9ta2/3UCmvIuAOTR5UwuiKlz0FulHKK6A
        0FWNzXS38RE/6KMyrcPw4g4=
X-Google-Smtp-Source: AFSGD/UV+6m234Q/MB75DwN0UIUgpejpo7/+/6y3dgiKCTI0tB3cjT/m8bo6o753XmPsC72wrfS7FQ==
X-Received: by 2002:a17:906:cd2:: with SMTP id l18-v6mr13524334ejh.97.1545157273904;
        Tue, 18 Dec 2018 10:21:13 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id s3sm4618560edm.31.2018.12.18.10.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 10:21:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: commit-graph idea: warn when disabled for incompatible repositories
References: <CAEcj5uXJC3Za0YCyazJi82JdF-tLCDs5OrzCwyD8Y155GnJa6Q@mail.gmail.com> <b74bab07-dd77-5195-aaee-a324e9a6b824@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <b74bab07-dd77-5195-aaee-a324e9a6b824@gmail.com>
Date:   Tue, 18 Dec 2018 19:21:12 +0100
Message-ID: <87bm5ig0h3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 18 2018, Derrick Stolee wrote:

> On 12/18/2018 9:22 AM, Thomas Ferris Nicolaisen wrote:
>> Hey there,
>
> Hi, Thomas!
>
>> Accidentally, my first use-case was a local copy of a big repository
>> (chromium source) that another developer had cloned shallow (I wasn't
>> even aware of their clone being shallow at that point).
>>
>> After spending a little time trying to figure out why no commit-graph
>> file was being created, I noticed that it worked just fine testing in
>> a fresh git repo.
>>
>> Then I discovered the .git/shallow file in the big repo. So I did
>> fetch --unshallow, and commit-graph started working. Taking a 20
>> second log --graph operation down to less than a second (wooo!).
>>
>> I saw some recent release notes that mentions that commit-graph is
>> disabled in incompatible repositories (graft, replace). I assume this
>> also be the case for shallow clones.
>
> The commit-graph feature is not designed to work well with these
> features, and the "easy" fix we have so far is to completely avoid the
> interaction. The tricky bits come in when the commit parents can
> "change" according to these other features. The commit-graph would
> need to change at the same time, and this is actually very difficult
> to get correct.
>
>> Here's the idea that may help others on the same path: Some warning
>> output when attempting to use commit-graph when it is disabled (either
>> by configuration or automatically).
>>
>> I think others that come across commit-graph may have tried such
>> tricks (like shallow clones) to better work with their repositories,
>> and it could be frustrating that commit-graph has no apparent effect.
>
> This is a good idea, and I would happily review a patch that added
> such a warning.
>
> The warning would want to be in builtin/commit-graph.c, and use the
> commit_graph_compatible() method from commit-graph.c. (You'll need to
> expose the method in the .h file.)

This patch will work. Consider it to have my SOB. Just needs tests, and
b.t.w. I noticed that if I s/warning/die/ in this patch the commit graph
& GC tests pass, pointing to a blind spot in the test suite.

diff --git a/builtin/gc.c b/builtin/gc.c
index 871a56f1c5..702568b70d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -662,9 +662,14 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();

-	if (gc_write_commit_graph)
+	if (gc_write_commit_graph) {
+		int verbose = !quiet && !daemonized;
+		if (verbose && !commit_graph_compatible(the_repository))
+			warning(_("The `gc.writeCommitGraph' setting is on, "
+				  "but commit_graph_compatible() = false"));
 		write_commit_graph_reachable(get_object_directory(), 0,
-					     !quiet && !daemonized);
+					     verbose);
+	}

 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..60915bf9aa 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -61,7 +61,7 @@ static struct commit_graph *alloc_commit_graph(void)

 extern int read_replace_refs;

-static int commit_graph_compatible(struct repository *r)
+int commit_graph_compatible(struct repository *r)
 {
 	if (!r->gitdir)
 		return 0;
diff --git a/commit-graph.h b/commit-graph.h
index 9db40b4d3a..7c92d41a28 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -12,6 +12,8 @@ struct commit;

 char *get_commit_graph_filename(const char *obj_dir);

+int commit_graph_compatible(struct repository *r);
+
 /*
  * Given a commit struct, try to fill the commit struct info, including:
  *  1. tree object
