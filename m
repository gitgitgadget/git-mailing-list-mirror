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
	by dcvr.yhbt.net (Postfix) with ESMTP id D64CE1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfBVJeu (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:34:50 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53527 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVJeu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:34:50 -0500
Received: by mail-wm1-f52.google.com with SMTP id e74so1307557wmg.3
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5MyV9hhry657dX04Qh0x6sHsh/43vVLcrt8vtsnZhxg=;
        b=dEWa6S/u4WTer8t0QayDl9hnvUvp81Y3Uqs1aOI84WDLtBr59CNQdotUxcCq+PLe/T
         MtchocUAC+0hI5JUOJNXw7an8RcBNO9nscy60KlWz7JTCv1f1r9kFgMLfJyKTPqzIg01
         C+ohA6J9twTSBvx5OOS84MnawREnla3azo+VfiLCsn/v6Z8yRLqAgxBmI5bR7bIr8Kw1
         P7bGT46+aWsPLv9+xwLjELNWaAeoX+Tqkclqd3K+K3VF687O6NLLhAt9pzqL0YqoU4BB
         x6Unrhd+XlVm0kBA/mnLDG6rB1VKVQ0zYenm+Viubh07eoV4M2w0mTdgDkiliqIv669r
         LJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5MyV9hhry657dX04Qh0x6sHsh/43vVLcrt8vtsnZhxg=;
        b=WKY+su8JfiWDuVAcnKOCoTyTYIlv+0llEES2h6jacMa1XUiVKsvrsLshrl6G4r09zc
         1BaUvYKUcz4Ur5qoqncQguWB3pxluo989/uKmg9iGa9lG3Z5CvKOln5l01pO5OHJLYt3
         E5eP8VZTMZHgxES7VAa+q3wNrDmBHr+AsiXMCmmA8ELhZzCk753mTDIfrEnLw9bocahc
         V7IUqSthadfhvRc+18t5V2Din0l/O4Xs3dV1dS29fGnU9d3/EbXnD/7QUe7YQmQBU+Ff
         BCsWicovkyq5pjvaWwlU5dfftNGw0RQetcTrgEX/gcTGSx2WLLX9kmaNelqDVypr4DcD
         88Vg==
X-Gm-Message-State: AHQUAubL6myCWwJykvIQoQomZxsNkkT03h9N7OQh4sNqDoy7V4CVQYr7
        ah4D0N00cdMUuHjUkkos2cA=
X-Google-Smtp-Source: AHgI3IZh6/6WrATZOasO3jaEpsR18WdL8e5caviVTJHmqAT82yx5npS2CTO2C1pcqyOZnaB/LeWsZQ==
X-Received: by 2002:a1c:27c6:: with SMTP id n189mr1764608wmn.108.1550828087693;
        Fri, 22 Feb 2019 01:34:47 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id j124sm723723wmb.48.2019.02.22.01.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 01:34:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
References: <cover.1543879256.git.jonathantanmy@google.com> <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com> <20181204015446.GX890086@genre.crustytoothpaste.net> <87lg2b6gg0.fsf@evledraar.gmail.com> <20190221010909.GA488342@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190221010909.GA488342@genre.crustytoothpaste.net>
Date:   Fri, 22 Feb 2019 10:34:46 +0100
Message-ID: <877eds5fpl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 21 2019, brian m. carlson wrote:

> On Tue, Feb 19, 2019 at 02:44:31PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Tue, Dec 04 2018, brian m. carlson wrote:
>> > First, I'd like to see a section (and a bit in the implementation)
>> > requiring HTTPS if the original protocol is secure (SSH or HTTPS).
>> > Allowing the server to downgrade to HTTP, even by accident, would be a
>> > security problem.
>>
>> Maybe I've misunderstood the design (I'm writing some other follow-up
>> E-Mails in this thread which might clarify things for me), but I don't
>> see why.
>>
>> We get the ref advertisement from the server. We don't need to trust the
>> CDN server or the transport layer. We just download whatever we get from
>> there, validate the packfile with SHA-1 (and in the future SHA-256). It
>> doesn't matter if the CDN transport is insecure.
>>
>> You can do this offline with git today, you don't need to trust me to
>> trust that my copy of git.git I give you on a sketchy USB stick is
>> genuine. Just unpack it, then compare the SHA-1s you get with:
>>
>>     git ls-remote https://github.com/git/git.git
>>
>> So this is a case similar to Debian's where they distribute packages
>> over http, but manifests over https: https://whydoesaptnotusehttps.com
>
> This assumes that integrity of the data is the only reason you'd want to
> use HTTPS. There's also confidentiality. Perhaps a user is downloading
> data that will help them circumvent the Great Firewall of China. A
> downgrade to HTTP could result in a long prison sentence.
>
> Furthermore, some ISPs tamper with headers to allow tracking, and some
> environments (e.g. schools and libraries) perform opportunistic
> filtering on HTTP connections to filter certain content (and a lot of
> this filtering is really simplistic).
>
> Moreover, Google is planning on using this and filters in place of Git
> LFS for large objects. I expect that if this approach becomes viable, it
> may actually grow authentication functionality, or, depending on how the
> series uses the existing code, it may already have it. In such a case,
> we should not allow authentication to go over a plaintext connection
> when the user thinks that the connection they're using is encrypted
> (since they used an SSH or HTTPS URL to clone or fetch).
>
> Downgrades from HTTPS to HTTP are generally considered CVE-worthy. We
> need to make sure that we refuse to allow a downgrade on the client
> side, even if the server ignores our request for a secure protocol.

All good points, I definitely agree we shouldn't do downgrading by
default for the reasons you've outlined, and e.g. make this an opt-in.

I'm just mindful that git's used as infrastructure in a lot of unusual
case, e.g. something like what apt's doing (after carefully weighing
http v.s. https for their use-case).

So I think providing some optional escape hatch is still a good idea.

>> > Second, this feature likely should be opt-in for SSH. One issue I've
>> > seen repeatedly is that people don't want to use HTTPS to fetch things
>> > when they're using SSH for Git. Many people in corporate environments
>> > have proxies that break HTTP for non-browser use cases[0], and using S=
SH
>> > is the only way that they can make a functional Git connection.
>>
>> Yeah, there should definitely be accommodations for such clients, per my
>> reading clients can always ignore the CDN and proceed with a normal
>> negotiation. Isn't that enough, or is something extra needed?
>
> I think at least a config option and a command line flag are needed to
> be able to turn CDN usage off. There needs to be an easy way for people
> in broken environments to circumvent the breakage.

Yeah, but let's try hard to make it Just Work. I.e. if in the middle of
the dialog the CDN connection is broken can we retry then, and if that
fails just continue with negotiation against the server?

As opposed to erroring by default, and the user needing to retry with
some config option...
