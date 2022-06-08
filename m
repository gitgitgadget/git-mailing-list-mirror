Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95453C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiFHTUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiFHTUv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 15:20:51 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF5172C38
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 12:20:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 19so618954iou.12
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fWVco/t4NQ+epO0PlmvKYssVWPGqxbfHRyKi7/0QI5s=;
        b=R6fTq9MC792OKOIP1MEE61/ypFeUeJhG1Q+ycYROtRSmPre9XmqBhPZtzJ0PGI0nlc
         Ni44BSD1wyowCoOGKj5QshINhDUsCZC7gog07MoEs+14E/Tbh7JDPGgXgQCuljb9TpMs
         KmFGobkcSNDsDBKXlim3bfdRO0/FWdJKHekwMdHyNh3IPRHEWTwu3ZgNtXVhq4pGgOP3
         q6EGpcTKUgBhNK3St2smqEZYFoEgSLE2d+AIB1/jWDMlojmNZTZeV2VuW8CJVS3ezrxZ
         qiA9WapwhlRhOcZp0d+a9cC7pqK2s4lmjyy1fZJrbcU6STmFLUP7fG46hSTi+7TaYHrO
         IC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fWVco/t4NQ+epO0PlmvKYssVWPGqxbfHRyKi7/0QI5s=;
        b=D4OALn0Ntl89JB9Kzco3LRPIYNTX2K8dOwwTiA7MFi6pnti8XJ4MNdNsBvaXKhxlLP
         bOvnAI6qrZd1j6XLX8BvssW5f5Hs5C2kLQ4m9g5Zl0QNBOxTU19GKgw4YnU1HoAqIHuz
         vIHHqbUt4Ye1rccuWeFuOpUBTG95aPioMiZJGetTdz0ZJEs/8Q/bXXFLIB2juS9esKGg
         B1wGQ2NJx4sg0pqxBOLou8i/T+anlNLiiYvVl2ifVY7lzTCR+ft+hMq/fO5e16fSNp+c
         e7jHNOAkeZGs9idJfP2XUleuC8Js7FfLlMACOWQmWA5aH2r0irhlowziLjIek0HOVD4d
         ivnA==
X-Gm-Message-State: AOAM53181dRM8RYo0YWxVJ/2tiE/o0fzs3XoR/FTRYyhd0MwxlVHS/hV
        5y1Ymb0m6qv51hl6duwouefr
X-Google-Smtp-Source: ABdhPJzRj7QuMyAkeQ1+bLc2Xx+PhghRTrjSP7f2xRD9IavnYfVuYwsM8EadPrmcazfXRnmRsa758w==
X-Received: by 2002:a02:852f:0:b0:331:8c7e:691 with SMTP id g44-20020a02852f000000b003318c7e0691mr12007838jai.169.1654716048791;
        Wed, 08 Jun 2022 12:20:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90ef:16b:eb19:f653? ([2600:1700:e72:80a0:90ef:16b:eb19:f653])
        by smtp.gmail.com with ESMTPSA id t17-20020a92c0d1000000b002d3da8e4af5sm9000844ilf.23.2022.06.08.12.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 12:20:48 -0700 (PDT)
Message-ID: <9244644f-2c80-f23d-f054-3f0c961696af@github.com>
Date:   Wed, 8 Jun 2022 15:20:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
 <xmqqsfoh4ery.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfoh4ery.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2022 6:18 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> +Assuming a `200 OK` response from the server, the content at the URL is
>> +expected to be of one of two forms:
>> +
>> +1. Bundle: A Git bundle file of version 2 or higher.
>> +
>> +2. Bundle List: A plain-text file that is parsable using Git's
>> +   config file parser. This file describes one or more bundles that are
>> +   accessible from other URIs.
>> +
>> +Any other data provided by the server is considered erroneous.
> 
> How does a client tell which one it got?  Do we register mimetype
> with iana to use for these two types of files, and have the HTTP
> downloader to use the information?

My implementation is much dumber than that: it first attempts to
parse the file as a bundle (looking for a bundle header) and then
attempts to parse it as a config file after that. If neither
succeed, then an error is thrown.

>> +bundle.list.mode::
>> +	(Required) This value has one of two values: `all` and `any`. When `all`
>> +	is specified, then the client should expect to need all of the listed
>> +	bundle URIs that match their repository's requirements. When `any` is
>> +	specified, then the client should expect that any one of the bundle URIs
>> +	that match their repository's requirements will suffice. Typically, the
>> +	`any` option is used to list a number of different bundle servers
>> +	located in different geographies.
> 
> OK. Presumably, if there are two sets of bundles, A and B, that
> consist of 3 and 2 bundle files respectively, and either one of
> these two sets is sufficient to help the client, then we'd have a
> bundle.list of type 'any', with two bundle.<id>.uri, that point at
> (sub) bundle.list of type 'all' in which these 3 or 2 bundle files
> are contained?  I am just wondering why we need 'all' and 'any', and
> at the same time why these two are sufficient for our needs.

Necessary: The origin Git server may want to advertise a list of
geo-distributed bundle servers, but not need to know the exact list
of bundles at each of those locations. The client can choose from
"any" advertised bundle URI, then download a bundle list from that
URI and download "all" bundles it advertised.

Sufficient: I can see a few different ways that we could want to
have something in-between "any" and "all" and that is: "The bundles
break into 'buckets', so pick any bucket and get all within that
bucket." This is already planned as part of the bundle.<id>.filter,
which creates different 'buckets'. So, if we need a partitioning
like this, then we can rely on functionality-based partitions.

Finally, we can always extend this in the future. If we want to
add a new mode "use-key-X" or something, then bundle providers
could start using it, but knowing that older clients would not
understand it and would lose the ability to use their bundles. This
is only a performance issue, not a correctness issue.

I'm definitely trying to minimize the need for these kinds of
extensions while keeping the spec small enough to implement in a
reasonable amount of time.
 
>> +bundle.list.heuristic::
>> +	If this string-valued key exists, then the bundle list is designed to
>> +  work well with incremental `git fetch` commands. The heuristic signals
>> +  that there are additional keys available for each bundle that help
>> +  determine which subset of bundles the client should download.
> 
> Funny indentation?

Thanks. Editor confusion with .txt files, apparently. Fixed now.

>> +The remaining keys include an `<id>` segment which is a server-designated
>> +name for each available bundle.
>> +
>> +bundle.<id>.uri::
>> +	(Required) This string value is the URI for downloading bundle `<id>`.
>> +	If the URI begins with a protocol (`http://` or `https://`) then the URI
>> +	is absolute. Otherwise, the URI is interpreted as relative to the URI
>> +	used for the bundle list. If the URI begins with `/`, then that relative
>> +	path is relative to the domain name used for the bundle list. (This use
>> +	of relative paths is intended to make it easier to distribute a set of
>> +	bundles across a large number of servers or CDNs with different domain
>> +	names.)
> 
> I have no objection to a host-relative URI notation, but is it
> something we need to spell out here?  I am mostly interested in
> making sure that we do not deviate a practice that is already used
> to point at different resource at the same server.  If the way we
> specify host-relative is unnecessarily different from the way
> existing "internet" programs (say, a web browser) work, that would
> be embarrasing, unless there is a very good reason for us to be
> different.

Since it requires careful implementation, I thought the detail along
with the justification would fit in this technical document. I can
avoid including that when describing the config options inside the
user-facing docs.

>> +bundle.<id>.list::
>> +	This boolean value indicates whether the client should expect the
>> +	content from this URI to be a list (if `true`) or a bundle (if `false`).
>> +	This is typically used when `bundle.list.mode` is `any`.
> 
> OK, so the type of a (sub) bundle.list can be specified using this
> without having the HTTP(s) server annotate the resource with
> mimetype when the thing gets actually downloaded.  It still leaves
> the issue of bootstrapping the system.  If the server advises bundle
> URI when the client contacts, presumably that first-contact
> bundle.*.uri can be annotated with the bundle.*.list at the same
> time, but the model allows the client to learn bundles independently
> from the server, and it still is a bit unclear how we tell.  Of
> course, we can examine the contents of a file that was obtained from
> a bundle URI, a file that parses correctly as a config-like file is
> very unlikely to be a valid bundle file, and we need to be prepared
> to deal with a corrupt resource downloaded from a bundle URI anyway,
> so this may not be a huge deal.

Right. We can inspect the file with our existing tools to see if they
fit the format. It might be worth doing some fuzz testing on these
parsers to be sure there isn't a surprising way to trick them into
doing strange things.

>> +bundle.<id>.filter::
>> +	This string value represents an object filter that should also appear in
>> +	the header of this bundle. The server uses this value to differentiate
>> +	different kinds of bundles from which the client can choose those that
>> +	match their object filters.
> 
> Is it an error to have .filter defined for a bundle URI whose .list
> says "true"?  Or does it mean all bundle files that make up the list
> share the same object filter?

While this would not be the typical situation, a bundle provider could
choose to combine these and the client would expect a list where all of
the .filter values match the one here. Of course, it would not be a
_failure_ if that wasn't true, but the client would ignore any bundles
it finds where .filter doesn't match.

>> +bundle.<id>.timestamp::
>> +	This value is the number of seconds since Unix epoch (UTC) that this
>> +	bundle was created. This is used as an approximation of a point in time
>> +	that the bundle matches the data available at the origin server. This is
>> +	used when `bundle.list.heuristic=timestamp`.
> 
> Name of this field should be better than 'timestamp'; we should say
> timestamp of creation (or last modification if the same name can be
> reused).

How about creationToken? That communicates that we don't really care
what the number is as long as it comes from an increasing sequence
controlled by the bundle provider.

>> +bundle.<id>.requires::
>> +	This string value represents the ID of another bundle. When present, the
>> +	server is indicating that this bundle contains a thin packfile. If the
>> +	client does not have all necessary objects to unbundle this packfile,
>> +	then the client can download the bundle with the `requires` ID and try
>> +	again. (Note: it may be beneficial to allow the server to specify
>> +	multiple `requires` bundles.) This is used when
>> +	`bundle.list.heuristic=timestamp`.
> 
> So, bundle.list.mode can say 'any', with three <id>s in it, but
> bundle.1.requires can point at '2', while bundle.2.requires can
> point at '1', and bundle.3.requires can be emtpy, in which case you
> can either fetch 1&2 or 3 alone.  Is that the idea?

The idea is that if I download bundle '1' and I can't unbundle it
(because I'm missing some required refs), then I can look at bundle.1.requires
to get any missing refs. If that is '2', then I download that. It then
continues in a chain.

The 'any' means "start anywhere", but I also don't expect a provider to use
.requires without the (maybe-to-be-renamed) timestamp heuristic. We could also
make that be a hard-coded statement: ".requires will be ignored unless mode=all
and heuristic=X"

>> +bundle.<id>.location::
>> +	This string value advertises a real-world location from where the bundle
>> +	URI is served. This can be used to present the user with an option for
>> +	which bundle URI to use. This is only valuable when `bundle.list.mode`
>> +	is `any`.
> 
> I am afraid I do not follow.  Do you mean, by "a real-world
> location", we write things like "America/Los_Angeles" and
> "Asia/Tokyo" in this field, so people can tell which one is cheaper
> to get to?  Do we make any further specification to make it machine
> usable in any way (I suspect machines would rather measure the
> latency and throughput against bundle.<id>.uri and .location is
> meant purely for human consumption)?

The intention is to be human-readable, for a user-facing prompt.
This could be for an interactive "chooser" or just letting the user
know "this is the location of the bundle URI I picked".

If we want the computer to automatically select, then using ping
latency would be a better way forward. Even in that case, it would
be helpful to tell the user "I discovered the closest bundle URI
is <location>".

>> +Here is an example bundle list using the Git config format:
>> +
>> +```
>> +[bundle "list"]
>> +	version = 1
>> +	mode = all
>> +	heuristic = timestamp
> 
> In all mode, how does heuristic help?  Doesn't mode=all by
> definition require you to grab everything anyway?

The heuristic is for incremental fetches, when you already have
some Git object data locally and don't want to download every
single bundle if you don't need to. (I think I have a step-by-step
flow of this lower in the doc.)

>> +[bundle "2022-02-09-1644442601-daily"]
>> +	uri = https://bundles.fake.com/git/git/2022-02-09-1644442601-daily.bundle
> 
> example.com (cf. RFC6761)?

Sure. Thanks.

>> +	timestamp = 1644442601
>> +	requires = 2022-02-02-1643842562
>> +
>> +[bundle "2022-02-02-1643842562"]
>> +	uri = https://bundles.fake.com/git/git/2022-02-02-1643842562.bundle
>> +	timestamp = 1643842562
>> +
>> +[bundle "2022-02-09-1644442631-daily-blobless"]
>> +	uri = 2022-02-09-1644442631-daily-blobless.bundle
>> +	timestamp = 1644442631
>> +	requires = 2022-02-02-1643842568-blobless
>> +	filter = blob:none
>> +
>> +[bundle "2022-02-02-1643842568-blobless"]
>> +	uri = /git/git/2022-02-02-1643842568-blobless.bundle
>> +	timestamp = 1643842568
>> +	filter = blob:none
>> +```
>> +
>> +This example uses `bundle.list.mode=all` as well as the
>> +`bundle.<id>.timestamp` heuristic. It also uses the `bundle.<id>.filter`
>> +options to present two parallel sets of bundles: one for full clones and
>> +another for blobless partial clones.
>> +
>> +Suppose that this bundle list was found at the URI
>> +`https://bundles.fake.com/git/git/` and so the two blobless bundles have
>> +the following fully-expanded URIs:
>> +
>> +* `https://bundles.fake.com/git/git/2022-02-09-1644442631-daily-blobless.bundle`
>> +* `https://bundles.fake.com/git/git/2022-02-02-1643842568-blobless.bundle`
> 
> So,... is the idea that bundle.list.mode=all does *not* mean "you
> need to get all of them"?  Rather, you first group bundles with the
> same filter, attribute, and then for each group with the same filter,
> you'd need to grab all of them?  IOW, if you are interested in a
> full clone, you can ignore <id>'s with non-empty bundle.<id>.filter 
> and grab all the rest?
> 
> If so, then I can see how the design makes sense.  I still do not
> know how heuristic kicks in, though.
> 
> ANother thing I noticed.  The above scheme makes it impossible to
> have <id> that happens to be "list".  I think the variables that
> apply to the entire list should be given two-level names, i.e.
> 
>       [bundle]
> 	version = 1
> 	mode = all
> 	heuristic = timestamp
>       [bundle "2022-02-09-1644442631-daily"]
> 	uri = ...

This then means that <id> can't be "version", "mode", or "heuristic",
or any other possible key that we use in the future, right? Using "list"
helped with this.

Perhaps we could do this:

	[bundles]
		version = 1
		mode = all
		heuristic = timestamp
	[bundle "id1"]
		uri = ...

Notably: "bundles" refers to the full list, while "bundle" refers
to a single bundle at a time. It makes the situation slightly more
complicated from the server side (we reserve bundles.* and bundle.*
for this advertisement).

>> +The client could choose an arbitrary bundle URI as an option _or_ select
>> +the URI with lowest latency by some exploratory checks.
> 
> Some places may have higher latency but great throughput.
> 
> The review for the rest of the document will be left for another
> sitting.

Thanks for your careful reading!
-Stolee
