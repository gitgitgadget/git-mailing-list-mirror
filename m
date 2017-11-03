Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8778B202A0
	for <e@80x24.org>; Fri,  3 Nov 2017 10:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbdKCKJ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 06:09:28 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:52662 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdKCKJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 06:09:26 -0400
Received: by mail-pg0-f50.google.com with SMTP id a192so2057365pge.9
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=kYj/j8SbLOiLDAPQ8mPRkUjcrkS+Pv2afRk4pWfAMWo=;
        b=JEgAsLnf3sLSYSL9wKMAMTrxxoVe2FX6ctJrGPrzs4GE6937IRcmglydFeEieEbSjA
         i5vG9ckkr2JNITIjCwYDBv4aeWqOlfIjEXAthtvleIp67nkANBm8dmEiJhFf9hJVmjA8
         yUMROJSdaxJCpPG8ehNbfJErNMsiZYx4quJnoQ880NVH2Sb8UO30gm5GgdzJT720/llp
         3xZwNDaX9s3v3p9jWXJtsLmiTTPeOqaD8LMkCukCgcuVCThwAWJflK1cs+hd3Qovvbva
         znhypJP1sElgbe7YWvSRQPEZk7GEaDPvLzlvl1Z9je099AnzSlX0E9xnSh41Uz0N4NFi
         nmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=kYj/j8SbLOiLDAPQ8mPRkUjcrkS+Pv2afRk4pWfAMWo=;
        b=I1f2oA9lDDr06BitorCh8+0AwWYcu/nafT4Ye3ixu+Pd4leX+v2lrdhqnz/ig2W9n5
         xv/SnPJbbMALkdyKDNvqNTRYgZsuY/aVHXGL8v/q3vFYqThjoMEsw4NqxYmuvUDGMxgu
         YH6iLoxdkoTeSDnT58alY2J0ziWtBjzhP8RLPCJSCDApm/jwFD+AOje4IkTO1xcqh0Ln
         xScjM4uqT2t9eUtJ58pVXAt13LvlMago07rv9Q4vAVCkWBCXJQk2Eg0HmxTFIsrjrvoa
         g9RtbbPiwhAox6FftV/ubu6x7l/Y2C69jtVg08QbBuYFps9xhLOQiUMtqO/yw9n7fw9L
         oWaA==
X-Gm-Message-State: AMCzsaUfywwMdrHhXRP+5jvyj67s0wnNuoq6Dgf/wyO2AeDo16fbXrGM
        arpH2fBNH86bHnNWQQ2CfIw=
X-Google-Smtp-Source: ABhQp+SKBDIViF1y0o+kquO9mPQ8kx9sluzHIS7Ty4jIMZewzGIpMhHvKTXHA5yhqSPtqdR1k6BmQg==
X-Received: by 10.99.114.81 with SMTP id c17mr6698395pgn.43.1509703765983;
        Fri, 03 Nov 2017 03:09:25 -0700 (PDT)
Received: from [192.168.1.126] (50-39-169-152.bvtn.or.frontiernet.net. [50.39.169.152])
        by smtp.gmail.com with ESMTPSA id d12sm11978348pfl.140.2017.11.03.03.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2017 03:09:24 -0700 (PDT)
Date:   Fri, 03 Nov 2017 03:09:20 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+A2iZZ5srHcAaaTv2kzdvWRLr3ffn61BB75Kuz0JoqfKCjwsg@mail.gmail.com>
References: <CA+A2iZZ5srHcAaaTv2kzdvWRLr3ffn61BB75Kuz0JoqfKCjwsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Documentation for git-diff is very difficult to understand for a layman.
To:     Vladimir Nikishkin <lockywolf@gmail.com>, git@vger.kernel.org
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <527B3708-BDF9-4854-9A29-17A0BA6EF8D4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Hi,

On November 3, 2017 2:43:03 AM PDT, Vladimir Nikishkin <lockywolf@gmail=2E=
com> wrote:
>Hello, honourable GIT developers=2E
>
>I would like to kindly ask you to do something with the git-diff
>manpage=2E (https://git-scm=2Ecom/docs/git-diff)
>
>In fact, I wasn't able to understand it even after reading it a few
>times=2E

Many parts of the man page are written from a very technical perspective=
=2E I'm sure patches to improve this would be welcome by the community=2E E=
ven just reading your thoughts here is helpful, though I do not know who ma=
y find the interest and time to produce such=2E

>
>In my case, I was trying to understand, what the command actually
>prints, but the man page doesn't really tell that=2E
>
>1)I mean, there is a section:
>
>"https://git-scm=2Ecom/docs/git-diff#_combined_diff_format", but at the
>very end of the manpage, so presumably, only aimed at advanced users=2E
>And the first thing it says is
>

The combined diff format is not a valid patch (as considered by the patch =
program) as it does not show how to convert from one file to another=2E Ins=
tead it's a way of showing the relevant differences between a resulting fil=
e and more than one input file, such as a merge would produce=2E

>"Any diff-generating command can take the -c or --cc option to produce
>a combined diff when showing a merge=2E This is the default format when
>showing merges with git-diff[1] "=2E
>

I suspect this is due to how parts of documentation are shared=2E The -c a=
nd -cc options can be given to many commands such as diff, log, show, etc

>This line is confusing, because I am already actually running git-diff
>(!)=2E So am I really seeing a 'combined diff' or some other diff? Is
>'git-diff' any different from 'git-diff -c' or 'git-diff -cc' ?


Yes, -c will cause git to always produce a combined diff format even for n=
on merge states=2E
>
>Could something be added to or rewritten in the manpage to clarify?

Suggestions are indeed welcome!

>
>2)Also, in point 3 of the same section:
>
>'index <hash>,<hash>=2E=2E<hash>
>mode <mode>,<mode>=2E=2E<mode>
>new file mode <mode>
>deleted file mode <mode>,<mode>'
>
>What do 'mode' and 'index' mean? Which values may this macros contain?
>What do two dots '=2E=2E' between two hashes mean? What are this hashes
>of?
>(Same question for <mode>=2E)
>

These I'm not sure about, they are bits of the diff we produce to give mor=
e context about the exact state of the changed files=2E

>3)Same section, after point 4=2E
>
>'Unlike the traditional unified diff format'=2E What is the 'traditional
>unified diff'? Is it the diff produced by GNU diff, POSIX diff or
>unidiff? Or, maybe there is some other diff in other parts of GIT?

The traditional unified format is what's produced by the normal diff progr=
am when -U is given=2E This entire section is referring to extra headers we=
 produce with our unified format=2E

>
>4)There is also a section called 'other diff formats':
>https://git-scm=2Ecom/docs/git-diff#_other_diff_formats
>
>But it doesn't actually tell anything about other diff formats, it
>just describes some other options to git-diff=2E
>

Each of those options refers to a different diff format=2E

>Maybe I am asking something trivial, but I believe, I am not the only
>novice trying to read the documentation of git=2E (I found the man page
>reference at the ProGIT book=2E)

Indeed, it's not trivial but it is important that our documentation is hel=
pful=2E Perhaps we might want to move the more technical parts to their own=
 section or to a separate page=2E=2E?

>
>5)Also, there is a contradiction in the documentation=2E
>
>The first lines at the 'options'
>(https://git-scm=2Ecom/docs/git-diff#_options) section say:
>
>-p
>-u
>--patch
>
>Generate patch (see section on generating patches)=2E This is the
>default=2E
>
>But at the 'combined diff' section:
>(https://git-scm=2Ecom/docs/git-diff#_combined_diff_format)
>
>The lines at the point 4 say:
>
>"Chunk header format is modified to prevent people from accidentally
>feeding it to patch -p1=2E"
>


The combined format is different because it fundamentally cannot be used a=
s a patch, since it's output does not provide enough context as it's meant =
to show the difference between more than 2 states=2E It is meant to show wh=
at changed with respect to multiple parent copies of a file such as what ha=
ppens in a merge=2E

>So what is in reality the behaviour of git-diff? Is it to create a
>patch, or to prevent the creation of a patch?
>

Git diff is meant to show differences between states=2E Much of the time t=
his is in the form of patches but not always=2E

>
>I would be happy if some of the developers could (if not simplify the
>man page), at least add some references at any manuals written in a
>more newbie-friendly way=2E
>
>Thank you in advance!


Suggestions are definitely welcome=2E I don't offhand have links to more n=
ewbie friendly pages=2E I do agree many parts of the man page are less clea=
r if you don't have a background in the tool already=2E Maybe we need to mo=
ve the technical format bits to their own page and keep the more daily use =
aspects easier to find=2E=2E=2E

Thanks
Jake

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
