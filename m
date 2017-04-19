Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777071FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 18:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030775AbdDSSyZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 14:54:25 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33328 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030256AbdDSSyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 14:54:23 -0400
Received: by mail-io0-f172.google.com with SMTP id k87so32666098ioi.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NF+Unj604rTN+K3FTIG3cekoH4T6OUOxStV8nxp1IFc=;
        b=VT27gIqG3Y07gPB3TgGHL7JyR/Sey6kwrg1O4cXbGU3wu7Q6lI9DB2u02VtANTMo9m
         UqpbSCypJWHfcnkBmrJ37PNQJNBXhJzor0EMBf6vSaAsAujlWrIpk7ByAbAZKsnuBf8r
         5A7AFNh7XE5ForLgAN18Ph1chvOZkORcXCv521zwjJIsareTbhrAkilboGhwKdSAvJFb
         oCz2RwCzH8rJmkN+oYbhiq5SObzPokOKSpfe4Qe8UPKLZrGBEVMfWxWhFSCgoHeTKKrZ
         44pgQUWlBaTLvLcCg52Wvyx3TImcor0FHZr6fVVNVqixZrKOck/v/+qGZRJ2t3IovPZN
         Jyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NF+Unj604rTN+K3FTIG3cekoH4T6OUOxStV8nxp1IFc=;
        b=ujyeLYc/AQusHvygtEO9JVieAHCsX3gFjTbAA4pxI6OsCAIK54QL0ii/a+GSWPMbcg
         hvOvjuVFg18fWLHfXbqPhZ8wP5K6RLN7prDVjJwczMVkJ/m/JsXoR7ZhOgUjrTOFu946
         luF4nHx1eDka2ObONchWZnpV07MFHTtJqb4VEnTIhHOWeTDDkaYG4OeAhGgZDqRbP5hj
         l2UgbIiKXWTwfPEPzB4LfxVf4tbs3BgLaGJKUMBJAWnWHw74Fw1ApiuO9bQiINZ7Y+ja
         e789p7KbOKM23Ao/SuSg9Vm6aeshtMOafwtLgP4dx29PsIiaQqGcjgA6JnlMjvB32NoF
         4diQ==
X-Gm-Message-State: AN3rC/5U1zwE+UTglNJK+uFAsB2+SqPgmCGb97QG/iL9AhDYWRWIsKee
        fV7QkCSKM5TstOhecZA2V52g5JeHOKqy
X-Received: by 10.99.146.30 with SMTP id o30mr4311276pgd.183.1492628062042;
 Wed, 19 Apr 2017 11:54:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 19 Apr 2017 11:54:21 -0700 (PDT)
In-Reply-To: <CACBZZX5goUsb4JTn6aGkJ-_S4W0Ymg7-HTzryDjC=AJBiLC3Fg@mail.gmail.com>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net> <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5goUsb4JTn6aGkJ-_S4W0Ymg7-HTzryDjC=AJBiLC3Fg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Apr 2017 11:54:21 -0700
Message-ID: <CAGZ79kZ1ViZterpZoH7qSjXxZf_qbrveAf4XodskA2xPXdZb6g@mail.gmail.com>
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a submodule
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Vadim Eisenberg <VADIME@il.ibm.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 4:30 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sun, Jun 19, 2016 at 10:51 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Jeff King <peff@peff.net> writes:
>>
>>> Stefan, I think it might be worth revisiting the default set by d22eb04
>>> to propagate shallowness from the super-project clone. In an ideal
>>> world, we would be asking each submodule for the actual commit we are
>>> interested in, and shallowness would not matter. But until
>>> uploadpack.allowReachableSHA1InWant works everywhere, I suspect this is
>>> going to be a problem.
>>
>> Yup, something like this on top of d22eb04 to be merged before
>> v2.9.1 for the maintenance track would be necessary.
>>
>> -- >8 --
>> Subject: clone: do not let --depth imply --shallow-submodules
>>
>> In v2.9.0, we prematurely flipped the default to force cloning
>> submodules shallowly, when the superproject is getting cloned
>> shallowly.  This is likely to fail when the upstream repositories
>> submodules are cloned from a repository that is not prepared to
>> serve histories that ends at a commit that is not at the tip of a
>> branch, and we know the world is not yet ready.
>>
>> Use a safer default to clone the submodules fully, unless the user
>> tells us that she knows that the upstream repository of the
>> submodules are willing to cooperate with "--shallow-submodules"
>> option.
>>
>> Noticed-by: Vadim Eisenberg <VADIME@il.ibm.com>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/git-clone.txt | 5 ++---
>>  builtin/clone.c             | 5 ++---
>>  t/t5614-clone-submodules.sh | 4 ++--
>>  3 files changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> index e1a21b7..c5a1ce2 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -192,9 +192,8 @@ objects from the source repository into a pack in th=
e cloned repository.
>>         Create a 'shallow' clone with a history truncated to the
>>         specified number of revisions. Implies `--single-branch` unless
>>         `--no-single-branch` is given to fetch the histories near the
>> -       tips of all branches. This implies `--shallow-submodules`. If
>> -       you want to have a shallow superproject clone, but full submodul=
es,
>> -       also pass `--no-shallow-submodules`.
>> +       tips of all branches. If you want to clone submodules shallowly,
>> +       also pass `--shallow-submodules`.
>>
>>  --[no-]single-branch::
>>         Clone only the history leading to the tip of a single branch,
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index ecdf308..f267742 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -40,7 +40,7 @@ static const char * const builtin_clone_usage[] =3D {
>>
>>  static int option_no_checkout, option_bare, option_mirror, option_singl=
e_branch =3D -1;
>>  static int option_local =3D -1, option_no_hardlinks, option_shared, opt=
ion_recursive;
>> -static int option_shallow_submodules =3D -1;
>> +static int option_shallow_submodules;
>>  static char *option_template, *option_depth;
>>  static char *option_origin =3D NULL;
>>  static char *option_branch =3D NULL;
>> @@ -730,8 +730,7 @@ static int checkout(void)
>>                 struct argv_array args =3D ARGV_ARRAY_INIT;
>>                 argv_array_pushl(&args, "submodule", "update", "--init",=
 "--recursive", NULL);
>>
>> -               if (option_shallow_submodules =3D=3D 1
>> -                   || (option_shallow_submodules =3D=3D -1 && option_de=
pth))
>> +               if (option_shallow_submodules =3D=3D 1)
>>                         argv_array_push(&args, "--depth=3D1");
>
> Very late reply, since I'm just looking at this now with the --no-tags
> opti,n, but that =3D=3D 1 makes no sense anymore, and should just be `if
> (option_shallow_submodules)` shouldn't it? I.e. this used to be an int
> for the depth, now is a bool, but the current =3D=3D 1 check is left over
> probably from an earlier version where the depth was configurable.

Yes we can drop the "=3D=3D 1" here.

Thanks,
Stefan
