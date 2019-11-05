Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C263B1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 00:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfKEAVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 19:21:18 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44034 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfKEAVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 19:21:18 -0500
Received: by mail-lj1-f169.google.com with SMTP id g3so13570934ljl.11
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 16:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0qRkBmySKBnZLWwaCe/coSFR7a0q2tVAs7OuEInDsdI=;
        b=Dr+izGRFyr78YNSXt/zVekHKi+Z3gNgCZeYix2UxwZDjaYNvp56sA/FWyYjlQwlMEv
         Nc3+BT0TfbfADW6cL2lXGwYiGfQGlPfMv1aZkhb7cnAmpd+GvtJ5oLSi7qc8Yf/X/Fs/
         Op+XQgo3pYrZ6LlqW2/XmBSGP63U7Fv0Jt1DX8RNWCfmt3DYANwr5BhinXOovtD487Gf
         cSmcSwbPjUMXgrlmo3Iqoq2XDvkH4dCSjxrPZcHbGRDZFzyjcv7wRnVhy43Xx7JsI0yf
         WmGVp+7Uajiq8u3YKv/9bgEsCFNr1K6GgCcRHWVkiENpn0x/kzudE4eCN9uuRM+57eaM
         x3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=0qRkBmySKBnZLWwaCe/coSFR7a0q2tVAs7OuEInDsdI=;
        b=PvAQTw7ycXB+DfynseVgqebvVcR1fJkNeYy/Ayvkq3M3uxLZ4grI38kSQUJXPJrs3Y
         dmm60Au1BCI+ydLIpVjwDGzdue6laZNlPd/I+BYSv5aaxUQIqD9mHcbxFtSK/h5YhgOB
         SNJkVmpE2wOOFSnlF1yiOEcr+EGprTgBFA+q/GWEeWxLI6I5EIwsvbsY6KK1XeMpNgHG
         FT+bKcMUskIbFBmYKrKGj2ftj+vS2tRcJz2KZrnLemdjIVMewIilTaYzrGQ9IFQA0yfn
         CHGL6Aykegr3t6O2EKWVhaMRUUb5afBJZtdKBde0pF+sDARxz7uZAQk5q9bh5YfSWvrl
         678g==
X-Gm-Message-State: APjAAAVTROkZVwxeE/6pNVv9N+rjCynVV+jPR59ESL031Q4YX1lCOYQU
        TChpiMIvzNKRrMBCdTiT89k=
X-Google-Smtp-Source: APXvYqwp213N90CcMVk8Rhgl38jBCUD5+jRpO1VI5PvcbPTHDPTrrP1MdnHZ6/DuR0Q3p8+v13Iv0A==
X-Received: by 2002:a2e:900e:: with SMTP id h14mr12692050ljg.27.1572913273957;
        Mon, 04 Nov 2019 16:21:13 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id m62sm207247lfa.10.2019.11.04.16.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Nov 2019 16:21:12 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked files
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191102192615.10013-4-sandals@crustytoothpaste.net>
        <86h83lhugj.fsf@gmail.com>
        <20191103185908.GA32531@camp.crustytoothpaste.net>
        <861ruoiw97.fsf@gmail.com>
        <20191103214608.GC32531@camp.crustytoothpaste.net>
Date:   Tue, 05 Nov 2019 01:21:10 +0100
In-Reply-To: <20191103214608.GC32531@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 3 Nov 2019 21:46:08 +0000")
Message-ID: <86imnzgoll.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:
> On 2019-11-03 at 19:40:36, Jakub Narebski wrote:
>>
>> Your proposed change:
>>=20
>>   +If the file you want to change is some sort of configuration file (sa=
y,
>>   +for a build tool, IDE, or editor), a common solution is to use a
>>   +templating mechanism, such as Ruby's ERB, to generate the ignored
>>   +configuration file from a template stored in the repository and a sou=
rce
>>   +of data using a script or build step.
>>=20
>> I don't see how such templating mechanism could be used.  You have some
>> kind of configuration file with placeholders comitted, and you have a
>> version of this file with local changes -- how templating mechanism
>> could solve this?  I would like to see few lines of an example and its
>> use.
>>=20
>> Alternatives:
>> ~~~~~~~~~~~~~
>>=20
>> In our build system, we have versioned Makefile, and not versioned
>> config.mak (with local configuration), which is included by Makefile.
>
> Essentially, make and shell support this by themselves, but if, for
> example, I wanted to adjust my dotfiles to set the email address once
> and for all, I could create the following files:
>
> .muttrc.erb:
> ----
> my_hdr From: brian m. carlson <<%=3D data["email"] -%>>
> ----
>
> .gitconfig.erb:
> ----
> [user]
> name =3D brian m. carlson
> email =3D <%=3D data["email"] -%>
> ----

All right, the above might be useful as an example (well, one of those),
but might be not necessary if the description of preferred solution is
stated in more detail.  I think it is better to start with generics,
i.e. track template, and generate untracked file, then provide examples
like Ruby's ERB.

> template.rb:
> ----
> #!/usr/bin/env ruby
>
> require 'erb'
>
> class Template
>   def name
>     @name ||=3D 0
>     @name +=3D 1
>     "name_a#{@name}"
>   end
>
>   def data
>     ENV.map { |k, v| [k.downcase, v] }.to_h
>   end
>
>   def erb(file)
>     ERB.new(File.read(file), nil, '-', name).result(binding)
>   end
> end
>
> puts Template.new.erb(ARGV[0])
> ----

This is certainly too much detail.

> and then run:
>
> EMAIL=3Dsandals@crustytoothpaste.net template.rb .muttrc.erb >.muttrc
> EMAIL=3Dsandals@crustytoothpaste.net template.rb .gitconfig.erb >.gitconf=
ig

That could be kept as an example, after simplification.

> The problem that folks tend to have is that they have a single editor or
> IDE project file, such as an XCode configuration file, that can't be
> split among multiple files, some of which are checked in and some of
> which are not.  Other situations are generating a configuration file for
> a web server like nginx in development, which may of course differ
> depending on where the user has checked out the repository.

All right.

> Using some sort of file like a config.mak is a fine solution, but many
> programs don't support that, so it's necessary to create a template for
> the build process and add a script to generate it.  The actual
> configuration values can come from the environment, the user's
> gitconfig, a YAML file the user has configured, or anywhere else that
> makes sense.

I still think that config.mak (or equivalent) solution might be worth
mentioning in passing.

> As you can see, the example is large and unwieldy, and would not make a
> good inclusion in the man page.  I included that paragraph because Peff
> stated that it would be nice if we could offer people a solution, but
> I'd rather drop it if it's too confusing without an example.

I think it can be done even without example, but without example it
would need careful crafting of the wording.

Best,
--=20
Jakub Nar=C4=99bski
