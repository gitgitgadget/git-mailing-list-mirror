Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154A51F437
	for <e@80x24.org>; Thu, 26 Jan 2017 09:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbdAZJSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 04:18:40 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33245 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbdAZJSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 04:18:37 -0500
Received: by mail-oi0-f66.google.com with SMTP id j15so17591604oih.0
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 01:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lpqe5lWRMZX3l1BpRKjZTbBOmBa7UDq41PH5joS021M=;
        b=KRSL1V/OnfyHdT2+8+EIjO7+N5bI0tr9D7wNJSmpOQPRINpcGPzesCTn+ZNYiGyvul
         mZBJaG4lpHW0dwbN0g/j/vU8ic3X28n85BHa00y/4757R6tx3wVTmBMZ2c8q6JP7580g
         Ie5fRMUXdxEQ6ldeWS4SZIhgsaxysAqQZCtrgpHZtjqeAVofJJqANug2mQOOgoZoP9gM
         cV/I2x4JJc9bhiPBQ0PWlvYuixUGR5d8s5iuPnkiFqKXV4AW9IueVMBtx+n9YubzdUSg
         /Ee8yalGQJVz8LNdwOl7GTF/EEExDGhmhkwSCGnGCZwXBu1CfYksxoEZeuSIgWGpGOLK
         7w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lpqe5lWRMZX3l1BpRKjZTbBOmBa7UDq41PH5joS021M=;
        b=lAMMJ1XMwdEv4uvURt+jAoVTp7lDylkKr60sCd2ukWWcFoWkhipEDmRbENrh296zIl
         zYib0TkKnOsyIgB08M/YxJfjyjIYQa3bZLC3trCTMofQ1FEFn4WjUMqm+WAvLF9gpm/l
         q3cK0MUGrFKUM8PKBJUa/46pCXKakCstfVZVpD80Ob0HXYF8CL/BlaWqRbUkwmXTfz3O
         MmvICrRrOYW4iUlwnCJL8jODBWiz84dHlqWpi7W/PAvGPUfzdQqyYkecwi8NhezCj/W8
         +mnRRQlMH5IsvQ5VPAXmRO2oSgEgwimzjx8ei0b9d6thN9d7qGzszu92rSplBfxXB1VR
         MTmA==
X-Gm-Message-State: AIkVDXIGtCy+bBAJlug5xpOmJD4gNAt4CBAGi5kg05RVITgsNcErxOpXqonE9kiA3pQlxNPDBFczAyLgfwCGnw==
X-Received: by 10.202.239.132 with SMTP id n126mr892389oih.186.1485422317073;
 Thu, 26 Jan 2017 01:18:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 26 Jan 2017 01:18:06 -0800 (PST)
In-Reply-To: <20170125205037.cg3aebh5rsx4zb2l@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com> <20170125125054.7422-3-pclouds@gmail.com>
 <20170125205037.cg3aebh5rsx4zb2l@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 26 Jan 2017 16:18:06 +0700
Message-ID: <CACsJy8CeUWD9ux3Q-VRhwR4-qbSD69CzH2mmztVH_-cx=31h8w@mail.gmail.com>
Subject: Re: [PATCH 2/5] revision.c: group ref selection options together
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 3:50 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 25, 2017 at 07:50:51PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> These options have on thing in common: when specified right after
>> --exclude, they will de-select refs instead of selecting them by
>> default.
>>
>> This change makes it possible to introduce new options that use these
>> options in the same way as --exclude. Such an option would just
>> implement something like handle_refs_pseudo_opt().
>>
>> parse_ref_selector_option() is taken out of handle_refs_pseudo_opt() so
>> that similar functions like handle_refs_pseudo_opt() are forced to
>> handle all ref selector options, not skipping some by mistake, which may
>> revert the option back to default behavior (rev selection).
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  revision.c | 134 +++++++++++++++++++++++++++++++++++++++++++++---------=
-------
>>  1 file changed, 100 insertions(+), 34 deletions(-)
>
> Hmm. I see what you're trying to do here, and abstract the repeated
> bits. But I'm not sure the line-count reflects a real simplification.
> Everything ends up converted to an enum, and then that enum just expands
> to similar C code.

It's not simplification, but hopefully for better maintainability. This

if (strcmp(arg, "--remotes")) {
   if (preceded_by_exclide())
      does_something();
   else if (preceded_by_decorate())
      does_another()
} else if (strcmp(arg, "--branches")) {
   if (preceded_by_exclide())
      does_something();
   else if (preceded_by_decorate())
      does_another()
}

starts to look ugly especially when the third "preceded_by_" comes
into picture. Putting all "does_something" in one group and
"does_another" in another, I think, gives us a better view how ref
selection is handled for a specific operation like --exclude or
--decorate-ref.

> I kind of expected that clear_ref_exclusion() would just become a more
> abstract clear_ref_selection(). For now it would clear exclusions, and
> then later learn to clear the decoration flags.

It may go that way, depending on how we handle these options for
decorate-reflog. The current load_ref_decorations() is not really
suited for fine-grained ref selection yet.
--
Duy
