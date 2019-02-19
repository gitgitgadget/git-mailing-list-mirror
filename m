Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492841F453
	for <e@80x24.org>; Tue, 19 Feb 2019 13:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfBSNog (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 08:44:36 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36209 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfBSNof (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 08:44:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id g9so6260637eds.3
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YrzEZEQe9iP7sJ6s5WEAA4reQysEI71cPIMhuR7/ikE=;
        b=hDw2c04XaQq1l9WBTlaClVWl+fDXelJaDz7/F/BZFovpbaPGuM2Z0D7VHloObNSIp4
         TE3u4JzMtX9kWp3LN5RVV9SOmwe8Q932+9sEx+FinDI1SiiNstH8DWMTd6Gb0itmbts+
         VeyS39XOlDfvXEjVGTyAWG2NXiDZZA7pTi8iUDsZTGKb+jc842dNiJIsj6OKTDEKGHP0
         7dtUdKGlofRwZaSivEIvUwzMHzv3Muu8mzKCWGnzfUkjmGhRCHHs2jgPPbw5oNPbjPbx
         IKtSaASJSGpAUWPMtUagHo2qlFYMNXv9Funrr5HmdMu9N9RNvjX4EDuEaI6m8L73ZAaQ
         OGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YrzEZEQe9iP7sJ6s5WEAA4reQysEI71cPIMhuR7/ikE=;
        b=ACS0aYxgAA6fxpmNpn3DxRGANQQHlqLjui6m90shVI1dL5pzx8g65HEthdO5HPkQFj
         sz1z/rLLObCAD23ybp/QxIDWp360A3kB6qQ9y85lirejoD8dUH/GYME4PB9L0JqcUnbU
         5Skx7zndrNc5gkbMXq0sIQDCeoYbVtE25eLp+9y509S/vX/z7ctZqb35Yx6HSjonm2MK
         VXjK+qmKSUGp9I/3dhkEly6gPhtbsSUtd2v12FNHDQUFlBASLPd1CC28gSKlktRNyQYi
         GuDUAR1p7yaK5QarfsInmfsbTvKJUAJYiFjsYkRwV2Yu8YEulaSTwhKgoSakiAEs8+BW
         Nlbw==
X-Gm-Message-State: AHQUAuaHnDeKdFlkwLUToAS9LCiSloHzEZbsOIvSH1kjGdbJePK+leQb
        Gbd7rb18kRCyofPC9wt3Qw4=
X-Google-Smtp-Source: AHgI3Iaaaous2+P4IKPc0mLelS3Cjaa16Ml/SU+PKYRfLRQTOu7aZr0Xyy2eLaDhWCXkN4FJ5L0ISA==
X-Received: by 2002:a50:9964:: with SMTP id l33mr17334784edb.115.1550583873230;
        Tue, 19 Feb 2019 05:44:33 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id h24sm4426837edr.80.2019.02.19.05.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 05:44:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
References: <cover.1543879256.git.jonathantanmy@google.com> <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com> <20181204015446.GX890086@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20181204015446.GX890086@genre.crustytoothpaste.net>
Date:   Tue, 19 Feb 2019 14:44:31 +0100
Message-ID: <87lg2b6gg0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 04 2018, brian m. carlson wrote:

> On Mon, Dec 03, 2018 at 03:37:35PM -0800, Jonathan Tan wrote:
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>>  Documentation/technical/packfile-uri.txt | 83 ++++++++++++++++++++++++
>>  Documentation/technical/protocol-v2.txt  |  6 +-
>>  2 files changed, 88 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/technical/packfile-uri.txt
>>
>> diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
>> new file mode 100644
>> index 0000000000..6535801486
>> --- /dev/null
>> +++ b/Documentation/technical/packfile-uri.txt
>> @@ -0,0 +1,83 @@
>> +Packfile URIs
>> +=============
>> +
>> +This feature allows servers to serve part of their packfile response as URIs.
>> +This allows server designs that improve scalability in bandwidth and CPU usage
>> +(for example, by serving some data through a CDN), and (in the future) provides
>> +some measure of resumability to clients.
>> +
>> +This feature is available only in protocol version 2.
>> +
>> +Protocol
>> +--------
>> +
>> +The server advertises `packfile-uris`.
>> +
>> +If the client replies with the following arguments:
>> +
>> + * packfile-uris
>> + * thin-pack
>> + * ofs-delta
>> +
>> +when the server sends the packfile, it MAY send a `packfile-uris` section
>> +directly before the `packfile` section (right after `wanted-refs` if it is
>> +sent) containing HTTP(S) URIs. See protocol-v2.txt for the documentation of
>> +this section.
>> +
>> +Clients then should understand that the returned packfile could be incomplete,
>> +and that it needs to download all the given URIs before the fetch or clone is
>> +complete. Each URI should point to a Git packfile (which may be a thin pack and
>> +which may contain offset deltas).
>
>
> First, I'd like to see a section (and a bit in the implementation)
> requiring HTTPS if the original protocol is secure (SSH or HTTPS).
> Allowing the server to downgrade to HTTP, even by accident, would be a
> security problem.

Maybe I've misunderstood the design (I'm writing some other follow-up
E-Mails in this thread which might clarify things for me), but I don't
see why.

We get the ref advertisement from the server. We don't need to trust the
CDN server or the transport layer. We just download whatever we get from
there, validate the packfile with SHA-1 (and in the future SHA-256). It
doesn't matter if the CDN transport is insecure.

You can do this offline with git today, you don't need to trust me to
trust that my copy of git.git I give you on a sketchy USB stick is
genuine. Just unpack it, then compare the SHA-1s you get with:

    git ls-remote https://github.com/git/git.git

So this is a case similar to Debian's where they distribute packages
over http, but manifests over https: https://whydoesaptnotusehttps.com

> Second, this feature likely should be opt-in for SSH. One issue I've
> seen repeatedly is that people don't want to use HTTPS to fetch things
> when they're using SSH for Git. Many people in corporate environments
> have proxies that break HTTP for non-browser use cases[0], and using SSH
> is the only way that they can make a functional Git connection.

Yeah, there should definitely be accommodations for such clients, per my
reading clients can always ignore the CDN and proceed with a normal
negotiation. Isn't that enough, or is something extra needed?

> Third, I think the server needs to be required to both support Range
> headers and never change the content of a URI, so that we can have
> resumable clone implicit in this design. There are some places in the
> world where connections are poor and fetching even the initial packfile
> at once might be a problem. (I've seen such questions on Stack
> Overflow, for example.)

I think this should be a MAY not a MUST in RFC 2119 terms. There's still
many users who might want to offload things to a very dumb CDN, such as
Debian where they don't control their own mirrors, but might want to
offload a 1GB packfile download to some random university's Debian
mirror.

Such a download (over http) will work most of the time. If it's not
resumable it still sucks less than no CDN at all, and client can always
fall back if the CDN breaks, which they should be doing anyway in case
of other sorts of issues.

> Having said that, I think overall this is a good idea and I'm glad to
> see a proposal for it.
>
> [0] For example, a naughty-word filter may corrupt or block certain byte
> sequences that occur incidentally in the pack stream.
