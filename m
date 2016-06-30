Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C78A1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 13:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbcF3N1Q (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 09:27:16 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34688 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbcF3N1P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 09:27:15 -0400
Received: by mail-io0-f181.google.com with SMTP id g13so70864198ioj.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 06:27:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9sswn6KxED5MkW1PombswCFj2Z20FI7ggyArPJlIkS0=;
        b=KfKqJr+WNZIe5AvO9kYpJS17BAECmQxx9mc9gUV+Wz7lu3CzDChGoGaVGeL/Brbb73
         PNV+JDZfD2fnMPwrAU9tOYPAco8rYcwnq3ivpqJN13e7ykhrCoQwne/5dwouji4OuZac
         /yiTfcbPMYKl9tQQVXEAasalTTsYERgSkesSljZCmnwC/vNMaLUm/hZlOByDDPlRQPL3
         LNXL04HE+FYH1y7if9rUmNqd0DnV9i6uv46rPlRuNX4PuzGtziBhotxj03N52PIys00h
         vjWKNWQ1o4LMz5mbhNYB+urHUJT2TZNn68RSquirpdVdozlVUMzHIeXofImFzrR8jGaD
         uQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9sswn6KxED5MkW1PombswCFj2Z20FI7ggyArPJlIkS0=;
        b=aO+GLYeu80WyuiHcUuqhSZDWlfGkNoa7OpbJrNFuuUFoPN1CAUkbh8XtqC4thCUmD2
         yu3unhd2g1+OfVa/JUELo3XoWOnsn1WdenvJgSU0R34KKul4WFjEQ6Ek2CUkrHQGJmVF
         OwXB/7lolpeqJtT2Eaq0xhO9oYjA2Gdq0WhariLc3jQMbFmLjY1L0LDVHFJcPv7RT2GH
         JVZrTX68ZtttU0GytB0ZVIVJZOv+MZei2oNCGz4Q9A/g1CY2Y7LATKdkdU1LNBN3+MjT
         OGDgTYHiO89M54CDgPd3pz/f5NeKRI1k3zTVZqCYISnIskq/DA+rZLPT3RiiQQMT89AV
         4Ccg==
X-Gm-Message-State: ALyK8tIFGDdm62igb5qjXI35dRiWMV6ooITkcPKUgAlDqx/0IXtuMOkK+BtdpflqSXSVExMrYMh1x206JScEoQ==
X-Received: by 10.107.174.5 with SMTP id x5mr14642670ioe.76.1467293234519;
 Thu, 30 Jun 2016 06:27:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.10.97 with HTTP; Thu, 30 Jun 2016 06:27:14 -0700 (PDT)
In-Reply-To: <20160622153145.GB16644@paksenarrion.iveqy.com>
References: <loom.20160620T145755-931@post.gmane.org> <20160622153145.GB16644@paksenarrion.iveqy.com>
From:	Istvan Zakar <istvan.zakar@gmail.com>
Date:	Thu, 30 Jun 2016 15:27:14 +0200
Message-ID: <CAPV8XuZ4wTWBPkwB4grmx-oznnx2koiCFvVLZ-oG+E2v1ipPBw@mail.gmail.com>
Subject: Re: Problem with --shallow-submodules option
To:	Fredrik Gustafsson <iveqy@iveqy.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

Thanks for your answers. I tested it after the changes were made on
the git server, and it seems to be working. But some other issue came
up.

We have quite many submodules in our project so I did some comaprision:

If I do a clone with these parameters:
--jobs 20 --recurse-submodules

The clone lasts ~53 seconds, and the total size of the folder is around 2 GB.

If I add the shallow-submodules option, the size of the folder will be
a bit below 1GB, so the size decreased as I expected, but the time of
the clone itself increased to 90 seconds. It seems the last step of
the command, checking out the submodules is executed one-by-one, and
not in parallel, so it seems at this step the jobs parameter does not
have effect.

Is it intentional, or there is some option I missed?

I'm using git 2.9.0 on client side.

Thanks,
   Istvan

ps: if I update the submodules with --depth 1 parameter in parallel
using xargs it lasts about 18 seconds, so it's a workaround for this
issue, but it would be nice to do it with a single command.




On 22 June 2016 at 17:31, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Mon, Jun 20, 2016 at 01:06:39PM +0000, Istvan Zakar wrote:
>> I'm working on a relatively big project with many submodules. During
>> cloning for testing I tried to decrease the amount of data need to be
>> fetched from the server by using --shallow-submodules option in the clone
>> command. It seems to check out the tip of the remote repo, and if it's not
>> the commit registered in the superproject the submodule update fails
>> (obviously). Can I somehow tell to fetch that exact commit I need for my
>> superproject?
>
> Maybe. http://stackoverflow.com/questions/2144406/git-shallow-submodules
> gives a good overview of this problem.
>
> git fetches a branch and is shallow from that branch, which might be an
> other sha1 than the one the submodule points to, (as you say). This
> is/was one of the drawbacks with this method. However the since git 2.8,
> git will try to fetch the sha1 direct (and not the branch). So then it
> will work, if(!), the server supports direct access to sha1. This was
> previously not allowed due to security concerns (if I recall correctly).
>
> So the answer is, yes this will work if you've a recent version of git
> and support on the server side for doing this. Unfortunately I'm not
> sure which git version is needed on the server side for this to work.
>
> --
> Fredrik Gustafsson
>
> phone: +46 733-608274
> e-mail: iveqy@iveqy.com
> website: http://www.iveqy.com
