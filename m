Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC97202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbdKTV6K (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:58:10 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:40230 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbdKTV6J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:58:09 -0500
Received: by mail-io0-f181.google.com with SMTP id d123so1246683iog.7
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uR8WfAPmrJYfClsZBAM2qoTSDTj/oW9gpAHQ5RJF74E=;
        b=CfTzvlPFJnrLLweQgOBaeLU0b+nxhMJBIuRhd8DGyHn0mch1a8J1Lya6xCiBa8guy3
         16Qbt1YLGuFAYp2ooJ3laPyWf2BM50IRob9T2ME66PDJYVMmIoUdu1Aq/EDX7xpuuHik
         m9bwZlysRutWpiiWcc8o35pa/ViGeees71CbCEPSWyMFeZvO0958NsZA6cPBdwE1c7lU
         IAawUEAUuFgrNE1j/0SgPRjPo0w9cB1+4R5NW0JD3mdnkCf0qimzSrJ+/78hYQMEmWJO
         oqURKABV7zvQESKKX0SwTHnZbNB/HriM7K9rPLWlpYLzz0PaAXl0JUYZkZLdoNRJBe4Z
         6HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uR8WfAPmrJYfClsZBAM2qoTSDTj/oW9gpAHQ5RJF74E=;
        b=Pn1HhJZuJ+TuoIGVFfa2RU5jDYkrKSZ7m7k6uZUON0FDRqXYAwEf1gtjUv/NV5FPaP
         w/YtlD2er+3Z/0ANT2KBRJ/7Vxnx9+cyhnzY34QADmhpD1c5nrcA9BrtDaFnjkSw6qKr
         RS4QpqT5Q7B/KWsjBOdEXFJCPZ0iAYVvZKTUPx2824rwqT+VY3sor3hMePQePVxYjELj
         bwUHk22OOEVXUiT3fx5iIgT+/11Ld87KsawusIxOF7pm7sIPeYDWChf5J8xZbk93M18p
         759T2WOQZl/k1CdaAGa7MbmexLyqGlBdZIKTs0pUmvpbJhWXDX/9MaUc8Gkr9/t3BC6/
         opug==
X-Gm-Message-State: AJaThX7QexFz5S5UlXoh7tMz+mBql1a9h2Irig9+itILk54wsACA2Eeo
        Pa9L1iatjZZMjs575qanSUyZAA==
X-Google-Smtp-Source: AGs4zMaLcF2n+nInSIBD6+LRFlaPrRNQybiKZ0MBcbJPLPwG83NaCUZKkJOcMNMgouyfGziTiPelfg==
X-Received: by 10.107.46.169 with SMTP id u41mr16124350iou.303.1511215088427;
        Mon, 20 Nov 2017 13:58:08 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id 97sm4047467ioh.22.2017.11.20.13.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 13:58:07 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, dnj@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re(2): [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Mon, 20 Nov 2017 16:58:05 -0500
Message-Id: <20171120215805.16994-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <87lgj0wtr9.fsf@evledraar.booking.com>
References: <87lgj0wtr9.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Nov 2017 22:00:10, Ævar Arnfjörð Bjarmason replied:

> [...]

Thanks for responding. I'll readily confess that PERL and the PERL
ecosystem are not areas I'm very familiar with, so I'm really grateful
for your feedback here.

> You need to bust the perl/PM.stamp cache as a function of your
> RUNTIME_PREFIX_PERL variable (or NO_PERL_MAKEMAKER).

Good catch, I'll add that to the next version of the patch.

> Other than that, is this whole NO_PERL_MAKEMAKER workaround just because
> you couldn't figure out what the target RELPERLPATH is in
> $prefix/$RELPERLPATH, which in this case is share/perl/5.26.1 ?

Sort of. I actually had a version set hacked MakeMaker's $INSTALLSITELIB
(same general result) and it worked.

The executable path resolution logic that I built make assumptions about
the layout of the installation, and I ended up favoring NO_PERL_MAKEMAKER
because I could rely on its explicit and straightforward installation
logic.

I am not sure that MakeMaker adds value in a RUNTIME_PREFIX
installation, since RUNTIME_PREFIX's motivation is fundamentally portable
and my impression of MakeMaker is that much of the value that it adds is
handling system-specific PERL installation details. Given that
NO_PERL_MAKEMAKER is supported as a Git installation option, I opted to
take advantage of the explicit installation rather than rely on
MakeMaker as an intermediary.

My other motivation is that if I integrate $RELPERLPATH into the MakeMaker
installation, I'd still have to implement that behavior when
NO_PERL_MAKEMAMER is enabled so that it is compatible with
RUNTIME_PREFIX_PERL.

I'd welcome any insight on whether this is the correct way to proceed.
If we decode to go forward with NO_PERL_MAKEMAKER, I'm happy to add some
better documentation in the Makefile to detail the rationale for
forcefully enabling it.

> 1. The regex match you're doing to munge the dir could be done as a
>    catdir($orig, '..', '..', 'lib'), that doesn't work as discussed
>    above, but *might* be more portable. I say might because I don't know
>    if the path string is always normalized to be unix-like, but if not
>    this won't work e.g on Windows where it'll have \ not /.

The regex-based approach was motivated by a perceived value to
conciseness. Since a larger header code block seems to be acceptable, I
could emit "$(gitexecdir)" as a constant in the header and operate on it
at runtime. This would avoid having to calculate the correct sequence of
"../" to walk up from "$(gitexecdir)" directly in the Makefile.

> 2. You are 'use'-ing FindBin there unconditionally (use is not function
>    local in perl), and implicitly assuming it loads File::Spec.
>
>    Ignoring the NO_PERL_MAKEMAKER caveats above I'd suggest something
>    like this:

Sounds good! I wasn't sure whether I should adhere to the one-line header
that was being used before, but I am all for whitespace if that is
acceptable.

This seems a bit much to emit from a Makefile - what do you think about
adding template files for each header in the "perl/" directory and
preprocessing them via "sed" in the Makefile?

> 3. I may be squinting at this wrong but it seems to me that between
>    your v1 and v2 reading GITPERLLIB here no longer makes any sense at
>    all. You used to set it in git itself, now it takes priority but
>    nothing sets it, presumably you'd have some external wrapper script
>    that'll set it?

$GITPERLLIB is (as far as I can tell) used for testing, so that PERL scripts
invoked by tests can find the Git support libraries. I think it is still
necessary in both RUNTIME_PREFIX_PERL and default worlds because tests run
Git out of the repository root, so relative resolution logic based on
installation paths will not work.

Thanks again!
-Dan
