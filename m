Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C451F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 03:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbcHSDBE (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 23:01:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36707 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbcHSDBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 23:01:02 -0400
Received: by mail-io0-f196.google.com with SMTP id y34so4009399ioi.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=babxHyPOOCGcPjI516syCur7FAi/pYM0uuxzUsaAnIE=;
        b=TG0atGQRstIYYY1ePDPMkLErdOQGBYaX+SncY4A2w8l+FpT8s1Ubr8SGqPajxKsj+n
         NCDc40ntnQIl7wxnCGO+k/gOi4iU5j3ZRPN46YXMm984G8AduosrdHc2OqP7E7nUCtzA
         urRn3wvBzHQIA21yEF79YMGCUKY8xGDR5AvpZV6sIzx2ZQDR3UoJ+MODPWjYkVrhU9UT
         QZIXd52LBPLs8le9B2tc300DnZpxL4qZl5PNPm5UXDmb80fmF9+4rBgCgUxxxJ8fjjRH
         0pDd+HJU7FeAezMj4Oj6gIYBdRbxrzFoLPwnVhsmzP/WtE9MPJ+u8ycTob2DHMCnhLWY
         7dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=babxHyPOOCGcPjI516syCur7FAi/pYM0uuxzUsaAnIE=;
        b=UYiW+Hfk49Q9TP7EUr2Vywy7A6sf++O/Kx8RqQQhojyRRN7xmE0FB068jzpikGJXYr
         WpOxUReAFvaPLjoi0uNNM7EeBquTWH7ZZo3cLmjMljUz3sFTFuDlmNqgEsfX8TVlrWpt
         sbZQ8JFTVrX0WuxhGABm7aa2fWbtqdMRohFhebfeFyvUGt5qUbiwpfDlq+ULxW/e7VmM
         yU7eDNeXTSxuhSnYGcyiOWNDimEFOeKNkz5BOytRIteE0qcvm6PelcILzoDiJkBglSDv
         +roDqBFPkO4FmNjVedidGMobPHlTaM2JGkT9uNQO/knl3VBteey0t7ltUgZ0z03tG1wB
         8W4A==
X-Gm-Message-State: AEkooutB4pyJPJPCtybRbWnH9957Zukj2U1QwouPEx5aHESPcLzbZxnLU9dswV9o60odQeb7tQK6YKrKe1tJHg==
X-Received: by 10.107.32.206 with SMTP id g197mr4955125iog.155.1471545271745;
 Thu, 18 Aug 2016 11:34:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.253.71 with HTTP; Thu, 18 Aug 2016 11:34:11 -0700 (PDT)
In-Reply-To: <CAGZ79kZdXXe7QwgtK8ZNHS+aKDx5vOc9rvETP9zo+ZCTCX10oQ@mail.gmail.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-6-jacob.e.keller@intel.com> <CAGZ79kZdXXe7QwgtK8ZNHS+aKDx5vOc9rvETP9zo+ZCTCX10oQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Aug 2016 11:34:11 -0700
Message-ID: <CA+P7+xoXANOOratwedB3RgJfJm5RLyw6Goa03z61sMZF8mooug@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] submodule: correct output of submodule log format
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 11:25 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> The submodule log diff output incorrectly states that the submodule is
>> "not checked out" in cases where it wants to say the submodule is "not
>> initialized". Change the wording to reflect the actual check being
>> performed.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>>  submodule.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index 1b5cdfb7e784..e1a51b7506ff 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -348,7 +348,7 @@ void show_submodule_summary(FILE *f, const char *path,
>>         if (is_null_sha1(two))
>>                 message = "(submodule deleted)";
>>         else if (add_submodule_odb(path))
>> -               message = "(not checked out)";
>> +               message = "(not initialized)";
>
> I think "not checked" out is actually correct here.
>

Hmmm.. It shouldn't say not checked out. I was running iinto problems
in some of my tests which indicated that the entire sub module didn't
exist. I think I had already assumed it wasn't failing when no
checkout. I think I have some fix for add_submodule_odb that can help
with this, making submodule dir behave correctly for this case.

I want add_submodule_odb to work in both of these cases:

a) we don't have a working checkout but we have the objects in the
usual location
b) we have a working directory with objects inside a .git folder but
it hasn't yet been moved into .git/modules/<>

I'll take a look and see what I can do.

>     $ git clone https://gerrit.googlesource.com/gerrit
>     $ cd gerrit
>     $ git submodule update --init
>       ...
>     $ git diff cc82b24..5222e66 plugins/
>     Submodule plugins/cookbook-plugin 2d40ee2..69b8f9f:
>      > Organize imports
>     $ rm -rf plugins/cookbook-plugin/
>     $ git diff cc82b24..5222e66 plugins/
>     Submodule plugins/cookbook-plugin 2d40ee2...69b8f9f (not checked out)
>     $
>
> Mind that by "rm -rf" of the working dir I create the "not checked out,
> but initialized state and even cloned state".
>
> So as a long term TODO:
>     I guess we could teach `add_submodule_odb` to operate
>     inside its git directory instead of its working directory, to have
>     it working whenever we have the object database (no matter if
>     checked out or not). Although this may collide with the plan of a
>     different refs backend? I dunno.
>
> add_submodule_odb is used in a variety of places:
>     show_submodule_header
>     submodule_needs_pushing
>     push_submodule
>     is_submodule_commit_present
>     merge_submodule
>
> And all of them seem to not require a checkout, but the presence of
> objects is fine.

Yea, they really only need objects, not the working tree.

Thanks,
Jake
