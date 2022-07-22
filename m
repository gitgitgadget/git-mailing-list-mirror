Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928E7C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 13:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiGVNxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 09:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiGVNw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 09:52:57 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750187820B
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:52:55 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so6326250fac.13
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4A6BHNDJc2qyRYriSofI/FYU97QtJ7l1EsV255oA5J8=;
        b=Ih2mTSjZQO+abt7uwUBphRVdgiH3WxKwkuMiisU334S3RC48oyNelRuXyXGfzac3Ar
         4R+BFLPDR/puneNjyFiBcvDEFZcBtFT6V9LfW45TC8QKiJDmAAJWzwIUiDfJmyTo3Oow
         vgZcyM6IJvGy7mQkHBF9xZQkhxkLfWWZyPlqraS0sKoF0WTLc6wxJAjdhvTUd/ZkTEdv
         qfYFLnzUriGpRandUKErVApyLldau0Hf084EpCvGqRyid/xN+OcLmVknvAsTUaajbCnP
         mIpla8RpK9/z+vTp/+AsgECw6o1kpCvN3kLkl5NVdMnh8rCxpRnuzqOXh96B3uXKqLRS
         rulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4A6BHNDJc2qyRYriSofI/FYU97QtJ7l1EsV255oA5J8=;
        b=5przrPBz29ysVtFVBSEk3B2w3itL/eI5ptWR0nHzhxRmTxPiKd+pUW2MGjUtaj2yNn
         xsWHe3dsAh85+1NiuknhBtDJnhCk/qhYIloFIjHffP8I190ZC57676qLrh4HbhlgwyWp
         YlAtX3a2AW2bvowGg7TuGkOCeQTgRZSt3iIviCtmmvtjhzwNIi6Sns2RbvzapTkDUps/
         yGd5GjJDhgokp8MTVEJ6ZucQNZv6luede7ATGPjQYmaKt3yLTLjQjVVaBcicIB/wyWOb
         7LEX29XQcnsAhC+2asIsAt6qiff+3JQZKMEduINxErU75vxZ0pSiSGYAv76uUVWsJuY6
         ndDA==
X-Gm-Message-State: AJIora+d6BTzGGuOM7+4DVHoOAxuhN59Lz8ryH+r+Cgxi+aE2z091JEW
        Uj6Wx0XBKND6aTDLq+CPb7s1
X-Google-Smtp-Source: AGRyM1v0+fWggOc/m92usfnn0QIC+qVcjxsTBKQ0NsDZwAaJLHa9b+YUKvNgU0wfPSEJSGNsFpnufQ==
X-Received: by 2002:a05:6870:5a3:b0:10d:514a:939a with SMTP id m35-20020a05687005a300b0010d514a939amr29401oap.1.1658497974676;
        Fri, 22 Jul 2022 06:52:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:89e1:7440:c819:d192? ([2600:1700:e72:80a0:89e1:7440:c819:d192])
        by smtp.gmail.com with ESMTPSA id n18-20020a05680803b200b003358e034f72sm1772832oie.7.2022.07.22.06.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 06:52:54 -0700 (PDT)
Message-ID: <4ca1e9db-8603-0ba8-51e4-9bffe2a62ffe@github.com>
Date:   Fri, 22 Jul 2022 09:52:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <d444042dc4dcc1f9b218ca851fcf603a3afce92f.1656535245.git.gitgitgadget@gmail.com>
 <AS8PR03MB8689A38CDA60565FED96EC99C0919@AS8PR03MB8689.eurprd03.prod.outlook.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <AS8PR03MB8689A38CDA60565FED96EC99C0919@AS8PR03MB8689.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 8:09 AM, Matthew John Cheetham wrote:> I had a few questions and suggestions; below.
> 
> On 2022-06-29 21:40, Derrick Stolee via GitGitGadget wrote:> +Assuming a `200 OK` response from the server, the content at the URL is
>> +inspected. First, Git attempts to parse the file as a bundle file of
>> +version 2 or higher. If the file is not a bundle, then the file is parsed
>> +as a plain-text file using Git's config parser. The key-value pairs in
>> +that config file are expected to describe a list of bundle URIs. If
>> +neither of these parse attempts succeed, then Git will report an error to
>> +the user that the bundle URI provided erroneous data.
>> +
>> +Any other data provided by the server is considered erroneous.
> 
> I wonder if it may be worth considering adding an optional server requirement ("MAY" not "MUST") to provide a `Content-Type` header indicating if the response is a bundle list (or bundle) to skip straight to parsing the correct type of file? Eg "application/x-git-bundle-list"?
> 
> Even the simplest of content servers should be able to set Content-Type. If not falling back to 'try parse bundle else try parse bundle list' is still OK.
This is an interesting idea. We should keep it in mind for a future
extension, since the Git client needs to do some work to parse the
header and communicate that upwards to the logic that parses the file. 
>> +bundle.mode::
>> +    (Required) This value has one of two values: `all` and `any`. When `all`
>> +    is specified, then the client should expect to need all of the listed
>> +    bundle URIs that match their repository's requirements. When `any` is
>> +    specified, then the client should expect that any one of the bundle URIs
>> +    that match their repository's requirements will suffice. Typically, the
>> +    `any` option is used to list a number of different bundle servers
>> +    located in different geographies.
> 
> Do you forsee any future where we'd want or need to specify 'sets' of bundles where "all" _of_ "any" particular set would be required?
> Eg. there are 3 sets of bundles (A, B, C), and the client would need to download all bundles belonging to any of A, B, or C? Where ABC would be different geo-distributed sets?

The bundle.heuristic space is open-ended to allow for different ways to
scan the bundle list and download a subset, so that might be a way to
extend this in the future.

I think what you're hinting at is a single "global" bundle list that knows
about all of the bundles scattered across the world and it groups bundles
by geography, even though the list knows about multiple geos. Is that what
you mean?

> I guess what I'm getting at here is with this design (which I appreciate is intentionally flexible), there are several different ways a server could direct a client to bundles stored in a nearby geography:
> 
> 1. Serve an "all" bundle list with geo-located bundle URIs?
> 2. Serve a global "any" bundle list with each single bundle in a different geography (specified by `location`)
> 3. Serve a single bundle (not a list) with a different

I think this item 3 is incomplete. What were you going to say?

I'll assume for now that you just mean "3. Serve a single bundle (not a
list)."

> Are any of these going to be preferred over another for potential client optimisations?

I could do better in this document of giving clear examples of how a
bundle provider could organize bundles. As the client becomes more
sophisticated, then different organizations become "unlocked" as something
the client can understand and use efficiently. That also sets the stage
for how to add extensions: the client change can be paired with an example
bundle provider organization.

The bundle provider setup that I personally think will work best is:

 1. The origin Git server advertises a bundle list in "any" mode. Each URI
    is a static URI that corresponds to a different geography. The client
    picks the closest one and stores that URI in local config.

 2. Each static URI provides a bundle list in "all" mode with the
    creationToken heuristic. The bundles are sorted by creation time, and
    new bundles are created on roughly a daily basis, but it could be
    a wider time frame if not enough Git data is added every day. The
    creationTokens are added as appending to this order, but after the
    list has some fixed length, the oldest bundles are merged into a single
    bundle. That merged bundle is then assigned the maximum creationToken
    of the bundles used to create it.

This comes from experience in how the GVFS Cache Server prefetch packfiles
are created. To support those very-active repos, there's another layer of
"hourly" packs that are merged into "daily" packs; those daily packs are
merged into a giant "everything old" pack after 30 days. This means that
there is a maximum of 1 + 30 + 23 packs at any given time.

>> +
>> +bundle.heuristic::
>> +    If this string-valued key exists, then the bundle list is designed to
>> +    work well with incremental `git fetch` commands. The heuristic signals
>> +    that there are additional keys available for each bundle that help
>> +    determine which subset of bundles the client should download.
>> +
>> +The remaining keys include an `<id>` segment which is a server-designated
>> +name for each available bundle.
> 
> Case-sensitive ID? A-Za-z0-9 only? "Same as Git config rules"?

I would say "Same as Git config rules" in general, but we could try to be
more strict here, if we want.

>> +bundle.<id>.location::
>> +    This string value advertises a real-world location from where the bundle
>> +    URI is served. This can be used to present the user with an option for
>> +    which bundle URI to use or simply as an informative indicator of which
>> +    bundle URI was selected by Git. This is only valuable when
>> +    `bundle.mode` is `any`.
> 
> I assume `location` is just an opaque string that is just used for info or display purposes? Does it make sense for other 'display' type strings like 'name' or 'message'?

We should definitely give this key another look when we get around to
building the UX around choosing from a list in "any" mode with human-
readable information like this.

>> +Advertising Bundle URIs
>> +-----------------------
>> +
> ...
>> +The client could choose an arbitrary bundle URI as an option _or_ select
>> +the URI with best performance by some exploratory checks. It is up to the
>> +bundle provider to decide if having multiple URIs is preferable to a
>> +single URI that is geodistributed through server-side infrastructure.
> 
> Would it make sense for the client to pick the first bundle URI rather than an arbitrary one? The server could use information about the request (origin IP/geography) to provide a sorted list of URIs by physical distance to the client.
> 
> I guess if arbitrary is 'random' then this provides some client-side load balancing over multiple potential servers too. Interested in your thoughts behind what would be 'best practice' for a bundle server here.

I tend to think of the client as being the "smartest" participant in this
exchange. The origin Git server is just serving lines from its local config
and isn't thinking at all about the client's network topology. If instead
the bundle provider (not the Git server) organizes to have a single URI
listing all of the geographic options, then that server could do smarter
things, for sure. It might be able to do that reordering to take advantage
of the Git client picking the first option (before the client has the
capability to test the connections to all of them for the fastest link).

>> +If the bundle provider does not provide a heuristic, then the client
>> +should attempt to inspect the bundle headers before downloading the full
>> +bundle data in case the bundle tips already exist in the client
>> +repository.
> 
> Would this default behaviour also be considered another explicit heurisitic option? For example: `bundle.heuristic=default` or `inspect`.
> Is it ever likely that the default behaviour would change?

I think that if there is no explicit heuristic, then this is the only way
the client can avoid downloading all of the bundle content.

>> +* The client receives a response other than `200 OK` (such as `404 Not Found`,
>> +  `401 Not Authorized`, or `500 Internal Server Error`). The client should
>> +  use the `credential.helper` to attempt authentication after the first
>> +  `401 Not Authorized` response, but a second such response is a failure.
> 
> I'd probably say a 500 is not solvable with a different set of credentials, but potentially a retry or just `die`. Do we attempt to `credential_fill()` with anything other than a 401 (or maybe 403 or 404) elsewhere in Git?

This is poorly worded, and I should group 400-level errors in one bullet
and 500 errors as its own category. The implementation uses the same
"retry with credentials" logic that other HTTPS connections make, so the
logic should be shared there. This document should point to another place
that documents that contract, especially in case it changes in the future.

Thanks!
-Stolee
