Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D49B20191
	for <e@80x24.org>; Thu,  4 Aug 2016 00:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329AbcHDAvC (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 20:51:02 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38177 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933231AbcHDAuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 20:50:07 -0400
Received: by mail-it0-f45.google.com with SMTP id j124so250235768ith.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 17:50:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pt7n1blqNlbsKJr0/wWj4eqASXM7NEAavXPBrxKGCLw=;
        b=SHT/FIUZBQ8LrE/6JU9xX7pou/Hd/9Nm30aViJR1eaTAAmiXZVelvUKSe+5Ec/rgyn
         TVnYyBMtTnxpPO6UrkjeyGmVbkfl4ZK4gvL1qwSwtb7zgiHuwYVlUx1ar6QFVtYyb8He
         GnGFjWTb4x5tZkyf2a3ab0lKe/wqh6D1Na5p8YrGtWkhRvd/RtZ8U2CC/CBNdz9HdFAU
         ZW4tpxbZbvK7MY3+m2N6JbCge+urYADBIMZHp3s3Etd6UVc+DvvPtPrFugZyfwP2Ccak
         RAyRetpOfdnM0wiXI9Md7kQXgiQAfcu3aUaBJVT4C9Cv1Vuzirin0ckApeyFqPC4xxeB
         +Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pt7n1blqNlbsKJr0/wWj4eqASXM7NEAavXPBrxKGCLw=;
        b=HjxnvuFUsm5YLQgebgrXMOrMAtFZx1n+C9AMlNojn0ObvDGWjOLEoqp13SxyqgDwFL
         odA7jZ7LbespdCTOq0Jxf+t9IgTfGjEK5TqyzrYXlYWIKwEyxpBcHn5K7rX3mBJldFsG
         OGrsv+gqldLPJIhXz3Dpj81+Josufby2R4PzZCwXc5i3zNEaBA0O4s6q3SuFhFhLwpJ6
         WEosAWmoDt2d06QQjWPJV/qGswGygu+q4n6uNxExw7txzymoFQywCxVeMMTXp6tXuHki
         UDdCmKCga59YHsAnmXJ2x4zTptfjwthYFKyG2y8ZCBkGHdAIgLncdtHKpyYZUt1SdAMO
         etjg==
X-Gm-Message-State: AEkoouvWnVlu4b6Oo/tuzPQGOonPuU8axnic7dngHjABah/FUZzjNg1pQG2ep9HtER2GdklTGQDbyLMEGLjhpg==
X-Received: by 10.36.19.16 with SMTP id 16mr29307511itz.41.1470271307853; Wed,
 03 Aug 2016 17:41:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.6.212 with HTTP; Wed, 3 Aug 2016 17:41:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608031621590.107993@virtualbox>
References: <20160803084743.3299-1-judge.packham@gmail.com> <alpine.DEB.2.20.1608031621590.107993@virtualbox>
From:	Chris Packham <judge.packham@gmail.com>
Date:	Thu, 4 Aug 2016 12:41:47 +1200
Message-ID: <CAFOYHZDHGn2HsV5U4z3Or7=7ypSkuKwbtQCmNaNuK+n06c0YXA@mail.gmail.com>
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 4, 2016 at 2:31 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Chris,
>
> On Wed, 3 Aug 2016, Chris Packham wrote:
>
>> This is similar to the existing "reword" command in that it can be used
>> to update the commit message the difference is that the editor presented
>> to the user for the commit. It provides a useful shorthand for "exec git
>> commit --amend --no-edit -s"

<snip>

> Having said that, this patch clashes seriously with my current effort to
> move a lot of the interactive rebase from shell into plain C. It is
> actually ready, but getting this into the code base is really slow-going,
> unfortunately.
>
> Now, after looking at your patch it looks to me as if this would be easily
> ported, so there is not a big deal here.

Yeah sorry. I knew there was something in flight but ended up doing a
quick hack on top of master.

> However, I could imagine that we actually want this to be more extensible.
> After all, all you are doing is to introduce a new rebase -i command that
> does nothing else than shelling out to a command. Why not introduce a much
> more flexible feature, where you add something like "rebase -i aliases"?
>
> Maybe something like this:
>
> [rebase "command"]
>         sign = git commit --amend -s --no-post-rewrite --no-edit -S

I did briefly consider that. I ended up taking the shortcut because I
had a patch series I needed to sign.

Elsewhere in this thread the idea of pick -S or reword -S was raised.
I'd actually prefer that because there seems little between 'git
config rebase.command.sign blah' and 'exec ~/sign.sh'

> I have not completely thought this through, but maybe this direction would
> make the interactive rebase even more powerful?

The uses I can think of are adding sign-off and running "make check".
For me rebase -i doesn't need to be much more powerful than that.
