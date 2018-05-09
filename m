Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345FB1F424
	for <e@80x24.org>; Wed,  9 May 2018 12:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934753AbeEIMIz (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 08:08:55 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40135 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934641AbeEIMIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 08:08:53 -0400
Received: by mail-ua0-f196.google.com with SMTP id g9so22797883uak.7
        for <git@vger.kernel.org>; Wed, 09 May 2018 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QrL+JYw/faAKK8HkE8R/lr4133oJYhbgGNYXDR5AI8E=;
        b=TGvtUmHYZ9uS2KmV8uzZc3fI4x2qi/dwXYJXR9o+4KSswt9GKxZf8axvF9N7n3lW00
         lmnT4vobP5H1ywRB0V5hxDpVD4SewgDQBCUZ9pw+RY87lQQJz9JcJ1gGSd4YY/kawvX5
         jWsF9zx1N32Y/DsNeWO1QBuWXlNFlTUxFRJajCN2iHBussOClwFn80HketlpPgouN5em
         DmA6tfrWQxXlu1Dh4n9MPk424j1WSvEE0DRwzO+jFeNqhQMC8KkPQAq4fa5POvkFwg7x
         GuBBY+X40RPvnl18AwG5RN7muo5Cr+O1LPmPvAbc5ZNEN3fdYIcJKFfSM+wUBgwT8fcs
         ahTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QrL+JYw/faAKK8HkE8R/lr4133oJYhbgGNYXDR5AI8E=;
        b=OIiFayhR0WjEWyMrmNrD9YR7GTMaTlfHSch+ehs5qfJwPpiwjPwjav/ExU+nfuWxvj
         35zgTB9D4P3AozFB4k1zXerI2jJfCWlAon9Ag4/aDf2xIiKKQevIybnoEf9bCQQozF4F
         Tsv/XmHYWsnMvqAb/qKdky8+WtAbQ7Za6GPOTRawbgZjPGe4AqvQ1d8g8KV5u7y4BYCa
         7/lp7qKt4bWw/+ilA13wD+kWreA1LOLV5+LMWAampY0mANa/jv9cIzL+u8oh06rR9RAx
         HxCpPOlWV8V7nAutcr7uOFXb7b69JlXpUANDDFpZmXuEapZzZsQCQjbb4hhj0eJ67n4h
         ouvQ==
X-Gm-Message-State: ALQs6tAnTq22XudwB9qLHYYzuDoP2g/7sjrSH8wZ1IIQNP3/sperfddr
        cmgowWtfi1OnBYo9FBnpk/TEDPwOp2WNwG1EbFs=
X-Google-Smtp-Source: AB8JxZqpYGJd3o7H1Y05NVaGH28CENL4v7Kf1BMsEzTPkYa4uBbm4Rn6ftzaAKs8i38YW0d3htgXJNujSdQOk49QMEI=
X-Received: by 10.176.27.108 with SMTP id n44mr37797313uai.194.1525867732512;
 Wed, 09 May 2018 05:08:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.100.7 with HTTP; Wed, 9 May 2018 05:08:51 -0700 (PDT)
In-Reply-To: <56ccabf699cdc6e15c5dcb73db5692180c79906d.1525863290.git.raa.lkml@gmail.com>
References: <20180508121104.rtsrektxiihvpqtx@pflmari> <20180508122256.nyv6ddcoifygfpk4@pflmari>
 <CAKPyHN3YMU3oZaW-wR2ZMV6aMwoeFGMmiJBQXtvipVvkWPLZVQ@mail.gmail.com>
 <20180508133905.6jhhhp6l7avjkctl@pflmari> <CAKPyHN1bGtCBZUh7cDAN-t+5DTutvyL6FLwynALTGZA5ijqwrA@mail.gmail.com>
 <56ccabf699cdc6e15c5dcb73db5692180c79906d.1525863290.git.raa.lkml@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 9 May 2018 14:08:51 +0200
Message-ID: <CAKPyHN0iQh=UJOX-8u4PO1ON9SW+G1gBCGh25FJ_RyoGk906QQ@mail.gmail.com>
Subject: Re: [PATCH] gitk: do not limit tree mode listing in the file list
 panel to current sub-directory
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.

On Wed, May 9, 2018 at 12:59 PM, Alex Riesen
<alexander.riesen@cetitec.com> wrote:
> From: Alex Riesen <raa.lkml@gmail.com>
>
> The previous behavior conflicts with the "Patch" mode of the panel,
> which always shows the changes from the top-level of the repository.
> It is also impossible to get back to the full listing without restarting
> gitk.
> ---
>
> Bert Wesarg, Wed, May 09, 2018 09:19:55 +0200:
>> > Frankly, this listing limited to just a sub-directory confuses me a bi=
t. Is
>> > there anyway to get to display full repository without changing to the=
 top
>> > level?
>>
>> I noticed that too, while testing your patch and I'm also confused.
>> But was not able to send a request to Paul yet. ls-tree --full-tree
>> seems to be one that should be used here, I think.
>
> Well, I just tried your suggestion. 'ls-files' doesn't have --full-tree, =
so
> for those it is just cd-up.
>
> It is on top of the re-sent series.

I would consider the current behavior as a bug, therefor I would put
this patch first, and than your other fixes/enhancements.

>
>  gitk | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/gitk b/gitk
> index c430dfe..03ead98 100755
> --- a/gitk
> +++ b/gitk
> @@ -7600,18 +7600,18 @@ proc go_to_parent {i} {
>
>  proc gettree {id} {
>      global treefilelist treeidlist diffids diffmergeid treepending
> -    global nullid nullid2
> +    global nullid nullid2 cdup
>
>      set diffids $id
>      unset -nocomplain diffmergeid
>      if {![info exists treefilelist($id)]} {
>         if {![info exists treepending]} {
>             if {$id eq $nullid} {
> -               set cmd [list | git ls-files]
> +               set cmd [list | git -C $cdup ls-files]
>             } elseif {$id eq $nullid2} {
> -               set cmd [list | git ls-files --stage -t]
> +               set cmd [list | git -C $cdup ls-files --stage -t]
>             } else {
> -               set cmd [list | git ls-tree -r $id]
> +               set cmd [list | git ls-tree --full-tree -r $id]
>             }
>             if {[catch {set gtf [open $cmd r]}]} {
>                 return
> @@ -7670,7 +7670,7 @@ proc gettreeline {gtf id} {
>  proc showfile {f} {
>      global treefilelist treeidlist diffids nullid nullid2
>      global ctext_file_names ctext_file_lines
> -    global ctext commentend
> +    global ctext commentend cdup
>
>      set submodlog "log --format=3D%h\\ %aN:\\ %s -100"
>      set fcmt ""
> @@ -7680,15 +7680,15 @@ proc showfile {f} {
>         return
>      }
>      if {$diffids eq $nullid} {
> -       if {[file isdirectory $f]} {
> +       if {[file isdirectory "$cdup$f"]} {
>             # a submodule
> -           set qf [shellquote $f]
> +           set qf [shellquote "$cdup$f"]
>             if {[catch {set bf [open "| git -C $qf $submodlog" r]} err]} =
{
>                 puts "oops, can't read submodule $f: $err"
>                 return
>             }
>          } else {
> -           if {[catch {set bf [open $f r]} err]} {
> +           if {[catch {set bf [open "$cdup$f" r]} err]} {
>                 puts "oops, can't read $f: $err"
>                 return
>             }
> @@ -7704,7 +7704,7 @@ proc showfile {f} {
>             }
>         } else {
>             # also a submodule
> -           set qf [shellquote $f]
> +           set qf [shellquote "$cdup$f"]
>             if {[catch {set bf [open "| git -C $qf $submodlog $blob" r]} =
err]} {
>                 puts "oops, error reading submodule commit: $err"
>                 return
> --
> 2.17.0.593.g2029711e64
>
>
> ---
> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=C3=BCft.
> https://www.avast.com/antivirus
>
