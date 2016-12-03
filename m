Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9AE21FBB0
	for <e@80x24.org>; Sat,  3 Dec 2016 08:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbcLCIL1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 03:11:27 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36207 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbcLCIL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 03:11:27 -0500
Received: by mail-lf0-f50.google.com with SMTP id t196so210798250lff.3
        for <git@vger.kernel.org>; Sat, 03 Dec 2016 00:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+L+4eBD9QX3WLbgQw5TCjgqb3n++IBhCDtHvz32RjvA=;
        b=zmhE8h7lhkdH/vYjUyLh5Fb5zUw6viHP5uaSIhiUzScoJjSD14CXp2ywsMHoxg27mF
         1jIQ0UbUMZtbWZoCX8c62+uXhM9gLhQ1I961wVsf2t7CdsCBWr2zw6jKxpuSDcLa36tf
         CWZ5jceFjz+4JMU7gyAijkHwbYTn2o8ON6ebxNrQF5NOR8MXrob+yYrdfTwHam72C+ev
         WssceNG6RffKtw/8CY9Ifu/1suCPgpcsTcoNAcpC/Djfcl8ROzXZmaAj1jp7HeW20cJj
         td42EfkBI27WAFZhR6FGrgGATFxov7dZNatgmNgLFtFNFompaYtwgu5kBku+icrX4NT9
         dQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+L+4eBD9QX3WLbgQw5TCjgqb3n++IBhCDtHvz32RjvA=;
        b=ISuk28lPRjuFaQY598yNSUP3wf2eQrviJKfZ0CSNyw2XChWMZCrLSB7HOkuaWosvH6
         3DBIAiCLm5puJrLQjVz1aK4n5QH94RL5QhC2DWRucO1rPBWwMuPFib8swzDLjxWMpctz
         +YE08d5nt+IoplFOVBfBFecFAsB5vQ0vIJhaegP9YlHRwMaWmhSxSKPWaVfF/syuDEmj
         aDZHmEpltVLmaH/kq9zee/24AyTEfjDSQjnhB4ardw9gJFnTvypntoHOt7vbfzQC16JD
         cH7nYtNYOKSFyUWYHV6homJxqT9K963rYAqcpHnnuU7bOMO/E/kebxBsBwhCgMAyY/yA
         HxJg==
X-Gm-Message-State: AKaTC009TpoRN7yUlCSv/jAyOwlrB12eQ0EkkY4fCqg3+oMYJVeF27cQNY14rq1mbJI7oCP8HTpQusCQSqpWGw==
X-Received: by 10.46.7.10 with SMTP id 10mr24270425ljh.60.1480752685010; Sat,
 03 Dec 2016 00:11:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Sat, 3 Dec 2016 00:11:24 -0800 (PST)
In-Reply-To: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
References: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 3 Dec 2016 09:11:24 +0100
Message-ID: <CAP8UFD0ipS_4p+njfbbDGpYSDJhp43e9XDP69MOruZz9c136ew@mail.gmail.com>
Subject: Re: git reset --hard should not irretrievably destroy new files
To:     Julian de Bhal <julian.debhal@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 3, 2016 at 6:04 AM, Julian de Bhal <julian.debhal@gmail.com> wrote:
> If you `git add new_file; git reset --hard`, new_file is gone forever.
>
> This is totally what git says it will do on the box, but it caught me out.

Yeah, you are not the first one, and probably not the last
unfortunately, to be caught by it, see for example the last discussion
about it:

https://public-inbox.org/git/loom.20160523T023140-975@post.gmane.org/

which itself refers to this previous discussion:

https://public-inbox.org/git/CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com/

> It might seem a little less stupid if I explain what I was doing: I was
> breaking apart a chunk of work into smaller changes:
>
> git commit -a -m 'tmp'           # You feel pretty safe now, right?
> git checkout -b backup/my-stuff  # Not necessary, just a convenience
> git checkout -
> git reset HEAD^                  # mixed
> git add new_file
> git add -p                       # also not necessary, but distracting
> git reset --hard                 # decided copy from backed up diff
> # boom. new_file is gone forever
>
>
> Now, again, this is totally what git says it's going to do, and that was
> pretty stupid, but that file is gone for good, and it feels bad.

Yeah, I agree that it feels bad even if there are often ways to get
back your data as you can see from the links in Yotam's email above.

> Everything that was committed is safe, and the other untracked files in
> my local directory are also fine, but that particular file is
> permanently destroyed. This is the first time I've lost something since I
> discovered the reflog a year or two ago.
>
> The behaviour that would make the most sense to me (personally) would be
> for a hard reset to unstage new files,

This has already been proposed last time...

> but I'd be nearly as happy if a
> commit was added to the reflog when the reset happens (I can probably make
> that happen with some configuration now that I've been bitten).

Not sure if this has been proposed. Perhaps it would be simpler to
just output the sha1, and maybe the filenames too, of the blobs, that
are no more referenced from the trees, somewhere (in a bloblog?).

> If there's support for this idea but no-one is keen to write the code, let
> me know and I could have a crack at it.

Not sure if your report and your offer will make us more likely to
agree to do something, but thanks for trying!
