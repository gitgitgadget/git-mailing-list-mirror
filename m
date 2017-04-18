Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D111FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 11:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756071AbdDRLQy (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 07:16:54 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32887 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755968AbdDRLQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 07:16:53 -0400
Received: by mail-lf0-f52.google.com with SMTP id 88so32039107lfr.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zWJZhrjdcgYL/bjxKWqDoOuLcxwhym9vpIjSTI0AIyQ=;
        b=iHvHBIAbUz/ka7fGrEbLiyIeIjKvrHx/tLqOcd+JA6ICa9ITAyOp/yvMS6rV7lrfoW
         x0Mk7i7YtKrBPZkCDWM18LVO3ORsGimweAYXq7yYpV9eYYhgxuqvLodJLRT23ulsy6pb
         UQW17qJXb6ToRkT52EI7L7Nh22yIeZXWVvbiH9oANNrGs7nppCpnVgYNoVCMSCed1wyK
         2OP/SpI3euU/3xG2FPTMv1C1SHKERT9TSzg6aoQCOcLRd2VPk62yZzCRZyn9tP1Loa5b
         Pdsxnd6dr83hIm7MNO3wmlbQWDyw1Mk3OkcZPd9U1FNWPuGq9C4N7/4ADjpNcMMbr9Nk
         5imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zWJZhrjdcgYL/bjxKWqDoOuLcxwhym9vpIjSTI0AIyQ=;
        b=eg9KQSl4YNswofpS4d7Mvk0cAe66Cod79BloJjPTe/OXbtalrvsHSuLRhfGcD9GbLL
         vtXUaPypycvWfATUVXgKXs+FV2lX6JNw/SgT6MTXbhc/xX9ADsGwwtZZaqgaJ63f4Ti5
         iRqOXZnYGJHU+AL4v++0nFtmGC2KKilaTgB/ap7PGc7ILnzAt+GLPP9eNPWGzRH/WNDD
         9hAfL4/ojZE8UPjSDd/sZgLa0iqUMKsDTK5ssl0yJk9ANrMqKmmpDQBraPhh7lpbq0x8
         pSjLhIaTePd7s46PakT7bfhpZgOCP/qx4lXfh6aEeOvyqtQJwU5vuBnAG0bwyPJ+1nTL
         fWBg==
X-Gm-Message-State: AN3rC/5wylwi0cCFUo4UlbSln2n/sE7cJjwdcpbeuhi9+OJ2MW8+CQ96
        GFbFrPFnIrj/o+woHY2DU2dxRYavmw==
X-Received: by 10.46.69.133 with SMTP id s127mr4094047lja.44.1492514211506;
 Tue, 18 Apr 2017 04:16:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.79.71 with HTTP; Tue, 18 Apr 2017 04:16:50 -0700 (PDT)
In-Reply-To: <CAJgfmqXqfp3A+A74dfkKjQb_26ZNH9anY52-G2L5ipg=+6--2w@mail.gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com> <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
 <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
 <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com>
 <xmqq60i2im72.fsf@gitster.mtv.corp.google.com> <CAJgfmqXqfp3A+A74dfkKjQb_26ZNH9anY52-G2L5ipg=+6--2w@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 18 Apr 2017 13:16:50 +0200
Message-ID: <CANgJU+WbbF2yzg53D7NasN_nxqytOh=UoutmMPak77JhiJHx4A@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     "Fred .Flintstone" <eldmannen@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 April 2017 at 10:44, Fred .Flintstone <eldmannen@gmail.com> wrote:
> Well the easiest way to work with that would be JSON.
> So the best would be if Git could output the data I want in JSON format.
> Then it would be easy for me to work with data.
>
> With git rev-list and git-cat file, its not so easy to reliably parse
> that output.

Doesn't seem too hard to work with rev-list to me. As far as I can
tell the following produces what  you want. You need perl installed
obviously, and the JSON::PP module is required, but should come
bundled with recent perls.

git rev-list master --pretty=raw | perl -MJSON::PP=encode_json
-ane'if(/^(\w+) (.*)/) { if ($1 eq "commit") { push @objs, $o if $o;
$o={}; } $o->{$1} = $2; } else { $o->{text} .= $_; } END{ push @objs,
$o if $o; for $o (@objs) { s/^    //mg, s/^\n// for $o->{text};
($o->{message},$o->{long_message})= split /\n\n/, delete $o->{text}; }
print JSON::PP->new->pretty->encode(\@objs);}'

You might consider an alternative approach than stating that working
with JSON is "the easiest", especially to people who clearly are
making do without it. :-)

A better argument might be that exposing data through a well defined
and widely used and simple data format would trivially expand the
range of projects that might interoperate with git or enhance the git
ecosystem. For instance you could argue that having clean JSON output
would make it easier to integrate into search engines and other
indexing tools that already know how to speak JSON. Maybe a regular
contributor on this list might agree with your arguments and make it
happen.

Until then you can parse rev-list like the rest of us. :-)

cheers,
Yves
