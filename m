Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B00C1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 01:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeDYBbv (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 21:31:51 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36687 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeDYBbu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 21:31:50 -0400
Received: by mail-lf0-f52.google.com with SMTP id d20-v6so23072544lfe.3
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hqPTJWjkyOX5auyniCWKWmipF/pUHj8HG9xB2PFTXCg=;
        b=tFbuEb+wP+7UWKC8hiNv+cKqCp41o7FzIqLt6vG6QLJNlkk7PEhgRPu1QY6BfMGG6w
         b9BzqRkep/CubPCJPRqxir0ZM3woYmpVjQ8pe1ZyLtk+jtD49DzeNRQrYB0Q2Iow12uT
         dB0NckOyluNASsoTUDa066+0wDmYeryJWRthBIlZMMeTLUTgrTfaGeEaMAjYIqLNluJq
         m/Oaojg5mPCCOkrMhpXVl38y2TNJLytUYZH2dkCvutLnF4sN1MdkxtOlseOh+TnZN74o
         c7maHgkUQbbZGRclVqs4MJmqRUtQaVWNIsmfFhNhjINZJzJ4xGwCSxYZYxZOfwAr/miO
         +rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hqPTJWjkyOX5auyniCWKWmipF/pUHj8HG9xB2PFTXCg=;
        b=IXgGnR7sIu8g6Q8uFYpF8Vas3VaAjhC3l7KSjKlDx2Z+QRZqAPHv6GzrivHmGaAOtc
         k8SqX0yvHhLeHjor0vcrJF4u3ja4AfelN+GdbB1SIcQ7nySwQeFAM3iCIKFgnu8vyk/6
         aNnJiQMaBaesy0WrDNyb45gUQNK1LGz5kSh/Kje7QPMbZY818o2RpiMhIIKw0XcXQ4TQ
         +XGzZg1McQs94dYZ8HNzlBQpRu3O4WvOnUseUbkw/AjTICDY8D1fbsTrYPx8p/ylFU2v
         ZZKovFDd/SfzvPwPWl4dvObDssIXq02dMVWZsz6MFAZJTHIGQCBjYmUuxs2zf9AUF01H
         Hm/A==
X-Gm-Message-State: ALQs6tAHhcpJu7DetV49UQJB/DhSqwzvxUZyeaXiOFIafrj7ezzT3QwA
        jOK0QswzXNBJl2f05FTM/83Y19F4TDwcZcqI0OWC/rR+bDg=
X-Google-Smtp-Source: AB8JxZqnYxN2lxEaU73mPd5LTREYkfc2uTjOCv4mOGEG25PX4qzWVnDMTJrYSLcrlqCO92AAloHr+UKS5FXQTxK2+W4=
X-Received: by 10.46.151.6 with SMTP id r6mr4189490lji.5.1524619908728; Tue,
 24 Apr 2018 18:31:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 18:31:28
 -0700 (PDT)
In-Reply-To: <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
 <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Tue, 24 Apr 2018 18:31:28 -0700
Message-ID: <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Wink Saville <wink@saville.com> writes:
>
>> Ideally I would have liked the tags fetched from gbenchmark to have a prefix
>> of gbenchmark/, like the branches have, maybe something like:
>>
>> $ git fetch --tags gbenchmark
>> ...
>>  * [new branch]      v2              -> gbenchmark/v2
>>  * [new tag]         v0.0.9          -> gbenchmark/v0.0.9
>>  * [new tag]         v0.1.0          -> gbenchmark/v0.1.0
>>  * [new tag]         v1.0.0          -> gbenchmark/v1.0.0
>>  * [new tag]         v1.1.0          -> gbenchmark/v1.1.0
>>  * [new tag]         v1.2.0          -> gbenchmark/v1.2.0
>>  * [new tag]         v1.3.0          -> gbenchmark/v1.3.0
>>  * [new tag]         v1.4.0          -> gbenchmark/v1.4.0
>
> The tag namespace (refs/tags/) is considered a shared resource (I am
> not saying that that is the only valid world model---I am merely
> explaining why things are like they are), hence the auto-following
> tags will bring them to refs/tags/ (and I do not think there is no
> way to configure auto-following to place them elsewhere).
>
> But you could configure things yourself.
>
>     $ git init victim && cd victim
>     $ git remote add origin ../git.git
>     $ git config --add remote.origin.fetch \
>       "+refs/tags/*:refs/remote-tags/origin/*"
>     $ tail -n 4 .git/config
>     [remote "origin"]
>         url = ../git.git/
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = +refs/tags/*:refs/remote-tags/origin/*
>     $ git fetch --no-tags
>
> The "--no-tags" option serves to decline the auto-following tags to
> refs/tags/ hierarchy; once your repository is configured this way,
> your initial and subsequent "git fetch" will copy refs it finds in
> refs/tags/ hierarchy over there to your refs/remote-tags/origin/
> hierarchy locally.

Interesting that kinda works, what about teaching git-remote to
understand a "--prefix-tags" option which would create the
"fetch = refs/tags/*:refs/remote-tags/origin" entry. And teach
git-fetch to use that entry if it exists and not require the "--no-tags"?

Of course I'm sure there are "lots" of other things to change, doing
a search for "remotes/" gives the following:

$ find . -type f -name '*.c' | xargs grep '\bremotes/' | sort -uk1,1
./builtin/branch.c: fmt = "refs/remotes/%s";
./builtin/checkout.c: skip_prefix(argv0, "remotes/", &argv0);
./builtin/clone.c: strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
./builtin/describe.c:     !skip_prefix(path, "refs/remotes/", &path_to_match)) {
./builtin/fast-export.c: "refs/remotes/",
./builtin/fetch.c: else if (starts_with(rm->name, "refs/remotes/")) {
./builtin/merge.c: if (starts_with(found_ref, "refs/remotes/")) {
./builtin/pull.c: * refs/heads/<branch_name> to
refs/remotes/<remote_name>/<branch_name>.
./builtin/remote.c: strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
./builtin/rev-parse.c: handle_ref_opt(arg, "refs/remotes/");
./builtin/show-branch.c: if (!starts_with(refname, "refs/remotes/"))
./contrib/examples/builtin-fetch--tool.c: else if
(!strncmp(remote_name, "refs/remotes/", 13)) {
./help.c: if (skip_prefix(refname, "refs/remotes/", &remote) &&
./log-tree.c: else if (starts_with(refname, "refs/remotes/"))
./ref-filter.c:        skip_prefix(refname, "refs/remotes/", &refname) ||
./refs.c: return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
./remote.c: FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
./revision.c: for_each_glob_ref_in(handle_one_ref, optarg,
"refs/remotes/", &cb);
./sha1_name.c:     starts_with(refname, "refs/remotes/"))
./wt-status.c: skip_prefix(from, "refs/remotes/", &from);

-- wink
