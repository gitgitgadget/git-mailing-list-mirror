Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE641F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbcHOSRf (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:17:35 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34562 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcHOSRd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:17:33 -0400
Received: by mail-oi0-f44.google.com with SMTP id l203so69641191oib.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 11:17:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ydef3zVyn6YBEpZegsW8tL3OHv6IfcwqFKQbVlkFnwM=;
        b=I58fFC+e6w9ctpdGo3mmiAmz5OLAi7uRg1KrHwarjZAJtk8+cMMbN0PcQFTS2N4BDp
         2hHN/adsv0agzFN5huVE+Fk/a4602lf7aEOQ5AgpgwH3zVC4soMQtfwq2fjgDlMkjERO
         pUdWkQ8U5vxlUuZCqqLHMmZZdqa+r2xSATdSp6yOrGfHsEs+1F2S8cwR6zkMZdRIZ21B
         8VNZG7ZMQJV4I9Y27hRq9cmNjTj+PzcIsGfh0aY8hsGI4J4QJmGWjF5DGsieUYIMxW3o
         Fnkl0m5EleT0QQGDGtyLv53ltrOK+38nEmqAElM/o+zDHB5GgpXcEuV3eq8TmKiGITJd
         pAWQ==
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ydef3zVyn6YBEpZegsW8tL3OHv6IfcwqFKQbVlkFnwM=;
        b=Wg2SnkhgtlSyFF2VPQDc7DEr7jIyOJTsixXs+YRIW6c6YlB4W+hpf67EtJ+udaDH0r
         8dE972c5IVoKjGNCQhNz0wcPnPnT6PvycCnlFazWmnxpsE4iZCyHIg4H1rj5axN5Zs9N
         983Mb+5LtteUbASqGknvpAF5Ujfs0dL2Q3iW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ydef3zVyn6YBEpZegsW8tL3OHv6IfcwqFKQbVlkFnwM=;
        b=ZG/W/ia2ryO8M7Rj0AFpdTF8MeyCNGzZK4c9vIW4GZoHTEQR9lXzKdb7025Vc5wWKT
         8+056GP4UeF8Tw5bObdKYHasW/Us4DIDsSIjAs4RyOGfuBmqho8LQzQcVuwUkwuR69i8
         2XhFxRTrGytOGLfuas4N4ixMGwyzvLUBWcKs348Xp2JBrBk4bUgqmwcWeJ6MeeI0Emww
         MIXoQlhiEHhTMQLH1IPfF7ha1LRPm7L+uh5CBY71ERORvPjiLEPTf3Uh60qjljvhtOHg
         iV1DZ+wxcVSuEvHk51hw8RYwrH9zvHbu4Olb0VLo+greXQ48eBZmahHKfgVRO1gdBTZF
         0qSA==
X-Gm-Message-State: AEkoouurP2km6V8elQnll3FY8Y6i38HDwT02igSq/4CrwZsXXq1hNK/gf+6fReTuczHS1xBkl1+5STTPniRreSsl
X-Received: by 10.157.62.229 with SMTP id b92mr13007729otc.19.1471285052283;
 Mon, 15 Aug 2016 11:17:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.249.17 with HTTP; Mon, 15 Aug 2016 11:17:11 -0700 (PDT)
In-Reply-To: <20160801183750.ivwue4mxm5ilgzqz@x>
References: <20160729064055.GB25331@x> <b7bd1464-1412-1feb-fe10-9ecb6018e122@wwwdotorg.org>
 <20160801183750.ivwue4mxm5ilgzqz@x>
From:	Simon Glass <sjg@chromium.org>
Date:	Mon, 15 Aug 2016 12:17:11 -0600
X-Google-Sender-Auth: jk1QCGXqK0OEICOA4dQgbS3my24
Message-ID: <CAPnjgZ2-sWuibLGK-AR2D=mM=MoOrQM9OVuJnCtVAE5GYqJXcQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Stephen Warren <swarren@wwwdotorg.org>,
	Git List <git@vger.kernel.org>,
	lk <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Josh,

On 1 August 2016 at 12:37, Josh Triplett <josh@joshtriplett.org> wrote:
> On Mon, Aug 01, 2016 at 09:14:54AM -0600, Stephen Warren wrote:
>> On 07/29/2016 12:40 AM, Josh Triplett wrote:
>> > I'd like to announce a project I've been working on for a while:
>> >
>> > git-series provides a tool for managing patch series with git, tracking
>> > the "history of history". git series tracks changes to the patch series
>> > over time, including rebases and other non-fast-forwarding changes. git
>> > series also tracks a cover letter for the patch series, formats the
>> > series for email, and prepares pull requests.
>>
>> Just as an FYI, I wouldn't be surprised if there's some overlap, or
>> potential for merging of tools, between this tool and the "patman" tool
>> that's part of the U-Boot source tree:
>>
>> http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README;h=e36857dedea1d0dbafa41732aaf9bf0988d63f38;hb=HEAD
>
> Interesting tool; thanks for the link.
>
> As far as I can tell from that documentation, patman doesn't track old
> versions of a patch series; you rebase to modify patches or change
> patman tags (embedded in commit messages), and nothing preserves the
> previous version.  And it tracks the cover letter and similar in one of
> the commit messages in the series, so previous versions of that don't
> get saved either.  If you wanted to track the history of your changes,
> you'd have to use branch names or similar.

That's right. Normally you would keep the old branch around, or tag
it. Of course old branches are often based on older versions the
upstream repo, so they are not that useful for diiff, etc. But the
normal procedure when updating a series to a new version is:

git checkout -b wibble-v2 wibble
git rebase upstream/master
git commit --amend
# Edit commit to add 'Series-version: 2', update cover letter etc.

Of course any change log is preserved when you move to v3, since you
just add more 'Series-changes:' tags. The old version of the cover
letter, and the old version of the commits can be preserved with 'git
tag'.

>
> In addition, tracking metadata in commit messages only works with a
> patches-by-mail workflow where the messages get processed when
> generating patches; that doesn't work for please-pull workflows.

Can you explain what a please-pull workflow looks like, and what tags
are expected?

>
> patman does have quite a few interesting ideas, though.  git-series
> needs some way of handling To/Cc addresses for patches and the cover
> letter (beyond just scripts/get_maintainer.pl), and more automatic
> handling of series versioning (v2, v3, ...) and associated series
> changelogs.  Suggestions welcome.

Patman builds the cover letter change lists from the commits. The main
point of patman is to automate the error-prone process of submitting a
perfectly formed patch series.

In particular, patman requires no change to the normal workflow that
people use with git.

>
> - Josh Triplett

Regards,
Simon
