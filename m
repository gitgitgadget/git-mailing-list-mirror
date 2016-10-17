Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E448920988
	for <e@80x24.org>; Mon, 17 Oct 2016 11:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbcJQLkS (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 07:40:18 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:34698 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbcJQLkR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 07:40:17 -0400
Received: by mail-it0-f44.google.com with SMTP id e187so12362593itc.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6E6Iqc7Y5mEnsj959Oxb2oxdpQSjDiRWJsoOGCsoAkI=;
        b=FWCy8Alcn+pV7/Qkpj/O0DyQLQ53hjsQlC7CQQIte3+kPgAJCCoFEB1187OsHKppDO
         Td6cboE6AvjJJYLN1myT1LmM/rhpNOj/wcHt85YrraT+QlAldM9g1+h6rpF8LmXdIJ5B
         hDbZGj8EJ2kp9e2qh4kRBfTF/WMxuKuNJ8p6COYrvI8Dn5sR2VuEVH0rb03TzTA+5EtW
         /dDBctc2YfpXlCHI4colHduBlWcdcZU7PveH92Gc4RgTVdNxp1BD8FPrbx2jpinDMNyn
         1dMxVQ3bOx8Gtuq4siIlmuj1qAAofI2OALTtFtwGs53tj+sMLbkLs2CTRHwfjvrwMz1u
         8AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6E6Iqc7Y5mEnsj959Oxb2oxdpQSjDiRWJsoOGCsoAkI=;
        b=WN+BXIg9mfVMTDSBIXWm7DvliXHtK9ssHomkj9RX6RHV9m5VYCnYrQ5GnNFsRL9+8C
         k+TmhcwKhPBHAfQqvayUPA8pvDgaESn5xLZOpvjVYmJGiCUlPV095ts4ek6pjXPikVue
         LDxhFsEnxskr2xz2r2H8wqk1OqdT95sHHf6/p0cNSw0/h9RoXwvb066s3WIqZUoDU5OI
         MdN1wnoD0Xdgx9IVRGUaIxAReGVIrJDpm/uGfX7s6MUcRKd+dSaPqyjDa5ad6tAXWrNp
         7LHDIA6+QZ0IOWheTRi4SuVTNcX89WVyAANVCLUD1iAFWznXLoHXiyAXEW44L2ScqrdU
         vbjA==
X-Gm-Message-State: AA6/9Rmnd9OoA5j3fBpCTN2sNEb4Q9Lw0DxJeh0EvU96wwaAVQsEA036LKjmjhVwBRAMN+BNykCD5hFVyMWT+Q==
X-Received: by 10.36.76.15 with SMTP id a15mr8750705itb.74.1476704417040; Mon,
 17 Oct 2016 04:40:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 17 Oct 2016 04:39:46 -0700 (PDT)
In-Reply-To: <CACPiFCJFXGmsJX97kQuA2h3trVX7L3SacwKrD4mpEU5SPxkLAA@mail.gmail.com>
References: <CACPiFC+8+wVEcDt9JZgTW1dwCCFKszyXD6ysDxNQorcNkom7Lw@mail.gmail.com>
 <20161014205842.GA6350@ikke.info> <CACPiFCJFXGmsJX97kQuA2h3trVX7L3SacwKrD4mpEU5SPxkLAA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Oct 2016 18:39:46 +0700
Message-ID: <CACsJy8A252mU8hgp2d+LQ8vku1w-sL9eP=t=G1AX61WJi8SUfA@mail.gmail.com>
Subject: Re: Automagic `git checkout branchname` mysteriously fails
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2016 at 4:06 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Fri, Oct 14, 2016 at 4:58 PM, Kevin Daudt <me@ikke.info> wrote:
>> Correct, this only works when it's unambiguous what branch you actually
>> mean.
>
> That's not surprising, but there isn't a warning. IMHO, finding
> several branch matches is a strong indication that it'll be worth
> reporting to the user that the DWIM machinery got hits, but couldn't
> work it out.
>
> I get that process is not geared towards making a friendly msg easy,
> but we could print to stderr something like:
>
>  "branch" matches more than one candidate ref, cannot choose automatically.
>  If you mean to check out a branch, try git branch command.
>  If you mean to check out a file, use -- before the pathname to
>  disambiguate.

Or even better, list all ambiguous candidates like Jeff did for
ambiguous short SHA-1 in 1ffa26c (get_short_sha1: list ambiguous
objects on error - 2016-09-26).There were a few occasions I was
confused by ambiguous refs and displaying them all would help me see
what problem was much faster.
-- 
Duy
