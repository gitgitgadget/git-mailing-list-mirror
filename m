Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D75202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 17:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932192AbdJWRh7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 13:37:59 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44955 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdJWRh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 13:37:57 -0400
Received: by mail-qk0-f193.google.com with SMTP id r64so22995386qkc.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gwJpzM5lnIFL2Xiw4dSWC1HJP1xqhDWq6meSmTBeb+k=;
        b=FrOPzBKPt5j7GG/lNtputLqw09vE51xBz5KNm3qzH4NXBIY8oL4x4MSM55t5lbMIDK
         7S1ftf36niitVPitB5jdHwypAgMlfKEuhgv3DY2+9FhLXJrwQ6GLwI4LEVTLwxtiQ5Eb
         1jHGWEqHnI36jLShMG374pPzlQOdSAVSYcUQWKTDjcJhEf/reIoKAOrqGqbsovOs395e
         xZLCA5yJnnwMjpUOVnlrT4V9AOEaDbom6yiaN7At3WP9mRCnwN04/Q8BmxBWkqFK97Yb
         DaDCMSCABfZs/Kkzj7jv/vBQqgTWTjuzYX1tsno1AwhsmTZ/SicdSoaph4JVOlChucwD
         XY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gwJpzM5lnIFL2Xiw4dSWC1HJP1xqhDWq6meSmTBeb+k=;
        b=XoKNb71+KUsK+Ud4XY6zQNwL5Q+etEfOspEHfvipSk0VqtiCHu1hmn/juJL6STxVhA
         pCcbCY7OS1tDbeNGXDm42TRGV8w3wbSjrDZVrEHvkqvwQv8JqUndNidqjFP6rJbT+0tP
         tzQkKGN0wUyG1oykJw4GV3icduE0xIqlPcPtH0XzpNohnaVWbSS1e+MKsEqwp7FETMdg
         my51vSf0W3Bhj1aezYgd1i/JzOOskCcSwzN/sQxhPIdx7HKkPAdVcUgF2T7tc/WJZ5Kx
         cn8JFP2i9HwSDUWHRDpoTqYnGUSoLmCplVGWQcwV5+MqlI1PQi5fyTucIzTx91ohXD15
         o3Bg==
X-Gm-Message-State: AMCzsaXaGpTILOWZAmYA+209oiHDkJUZgmJCIBFvXDygSqeoLnFGvCxC
        JWvccNGyfnNX3hp0WxgOGH1wGJCv0p/Uzv/KiqTMwQ==
X-Google-Smtp-Source: ABhQp+QymCmx32clRAAvGoSp8zcFSv4ylOxRjSjIALlsx8lug4MOYT+w9Gabfz3b4jnVQFsc5f5KsAf9NkSewgBinDc=
X-Received: by 10.55.125.196 with SMTP id y187mr20969385qkc.180.1508780276322;
 Mon, 23 Oct 2017 10:37:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 10:37:55 -0700 (PDT)
In-Reply-To: <20171023003647.4pvzmhk7v5t6zqm5@sigill.intra.peff.net>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
 <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net> <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
 <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net> <CAGZ79kaeJsahVuWgFsJfyGahciT4xBeM3m59F5crGy4+ZRJMCw@mail.gmail.com>
 <1508682297.6715.15.camel@gmail.com> <20171023003647.4pvzmhk7v5t6zqm5@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 10:37:55 -0700
Message-ID: <CAGZ79kYAn0Hi0qaG8P5zvVOFTsfXYrtvrR7oiT0KwwWeKLqZgw@mail.gmail.com>
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 22, 2017 at 5:36 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 22, 2017 at 07:54:57PM +0530, Kaartic Sivaraam wrote:
>
>> On Fri, 2017-10-20 at 13:45 -0700, Stefan Beller wrote:
>> >
>> > The git-test from Michael sounds intriguing. Initially I put off using
>> > it as I had my main working dir (or rather test dir) on a spinning
>> > disk, still. Now I test in memory only, which is a lot faster, so I could
>> > try if git-test can keep up with my local commit pace.
>> >
>>
>> Excuse my ignorance but I don't get your statement correctly. What do
>> you mean by "I test in memory only"? How do you do that?
>
> I assume it means pointing "--root" at a tmpfs or ram disk in
> GIT_TEST_OPTS. That makes the test suite run _way_ faster.

Exactly. By memory I mean volatile RAM (as opposed to
memory on a spinning disk).

Using GIT_TEST_OPTS has had some issues (I remember vaguely
there was an inconsistency between the output of `make test` and prove),
so I put my entire working tree on a tmpfs, I run roughly this script
after booting my computer:

  sudo mount -t tmpfs -o size=16g tmpfs /u
  mkdir /u/git
  echo "gitdir:
/usr/local/google/home/sbeller/OSS/git/.git/worktrees/git"
>/u/git/.git
  git -C /u/git checkout -f HEAD

  cat <<EOF >/u/config.mak
  DEVELOPER=1
  DEVELOPERS=1
  CFLAGS += -g -O2
  CFLAGS += -DFLEX_ARRAY=2048
  #CFLAGS += -Wno-unused-value
  EOF

The downside (or upside?) is that there will be no files cluttering
my git directory, but any untracked file is wiped periodically. So if I want
to really preserve a thing I am forcing myself to put it somewhere else
than in an untracked file inside the git repo.

The test suite (excluding t9*) runs in less than 50 seconds on the ram
disk.

Thanks,
Stefan

>
> -Peff
