Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19F91F461
	for <e@80x24.org>; Sat, 18 May 2019 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfERLj7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 07:39:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33966 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfERLj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 07:39:59 -0400
Received: by mail-io1-f68.google.com with SMTP id g84so7555995ioa.1
        for <git@vger.kernel.org>; Sat, 18 May 2019 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lMbDBx+MBpBvMOVRSdw89HEQg85MJv6bvgZG1YkUGY=;
        b=ei62U9/0HhF7BYTVS4+Gwbmo2Sr6dreTiETAvzkJ1IJqVVQp/64h6emrGdStIRiF4D
         Z7bD2C0bNWab8UgOAdnusxWp1Dn2sLMLILOBREXPZOBv0yvk6tICOGB1t88MNXUn39g3
         D1YJYQ994JJE4QdSnwlvAlrfalQD0r1qwxh8FsboLsKEJZyiwnUG7EDu1bYzN71wnmaL
         LBHVeMxh9ypyrTXOoC0zrbABNkJFhAZMyoxyzMar5B43wyAM/3+NkuxEWFV9kEgM0q6Q
         HWrgAQ+z59M35meV2lmkeaGfBrrqtLroJs0YYewQrFoZvHKwoS5k9dxznBHo3XwZa4dN
         rEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lMbDBx+MBpBvMOVRSdw89HEQg85MJv6bvgZG1YkUGY=;
        b=My/QQGYlMgIf8OzHBOZbSJnZQ087oVnd7TW1ns3ra94/YlSd4GaEDSqkpdUBc2qsuv
         IVWh/eXsNT0Smlo3Wa11Jk1dF72yhnnmtxYfjzcJnydOveFT3MiAAie5OImwK2e5VTk+
         zYQhFN79Lh8VP1NITgw3gaNeZ/F9GWktauQTAWTYHndHSD/2ToKIQrPM+PEIFq+v1Kgh
         txgivny1DyK7vveLziQiF9eT5NMGvGPOIZh7abT8uOe/hxt1Kw5HkLVt3c9l74AN6zNw
         xnFoPu4Xfta2IfJQqtqj3ixwW0s7sxglck803VXHM5bs9LR9owlGovFnvjRQEchLHG4X
         oPIQ==
X-Gm-Message-State: APjAAAU5oXdbzy3yAMweyJmlDjaRY3RpFy4pBY+YdQqDg+j9dPKGB/G4
        lgRpkIwfJGglGoRfp72OLRFMHCDRFdHgmgy8J1g=
X-Google-Smtp-Source: APXvYqye1iTogDwa83EmGfRP74dq1EUbUf/l/GRLJwpHhYKOOjN2lLVLldtld9Frza7zExwcMdGKZYIRs7SC7GAG1+U=
X-Received: by 2002:a5e:d60f:: with SMTP id w15mr31389037iom.282.1558179598406;
 Sat, 18 May 2019 04:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190516214257.GD10787@sigill.intra.peff.net> <20190516231509.253998-1-jonathantanmy@google.com>
 <20190517010950.GA30146@sigill.intra.peff.net> <20190517012234.GA31027@sigill.intra.peff.net>
 <20190517043939.GA12063@sigill.intra.peff.net> <CACsJy8CNyug3wvZ+6ts1nzgWyPF1JqC0LceP-HzMHjqvCr2Ugw@mail.gmail.com>
 <20190517085509.GA20039@sigill.intra.peff.net>
In-Reply-To: <20190517085509.GA20039@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 May 2019 18:39:32 +0700
Message-ID: <CACsJy8AkhKX57RYL1Z+HZHqKbAKKOcLoRkgwg8bSnk+DW2+Nmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
To:     Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 3:55 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, May 17, 2019 at 02:20:42PM +0700, Duy Nguyen wrote:
>
> > On Fri, May 17, 2019 at 12:35 PM Jeff King <peff@peff.net> wrote:
> > > As it turns out, index-pack does not handle these complicated cases at
> > > all! In the final fix_unresolved_deltas(), we are only looking for thin
> > > deltas, and anything that was not yet resolved is assumed to be a thin
> > > object. In many of these cases we _could_ resolve them if we tried
> > > harder. But that is good news for us because it means that these
> > > expectations about delta relationships are already there, and the
> > > pre-fetch done by your patch should always be 100% correct and
> > > efficient.
> >
> > Is it worth keeping some of these notes in the "third pass" comment
> > block in index-pack.c to help future readers?
>
> Perhaps. I started on the patch below, but I had trouble in the commit
> message. I couldn't find the part of the code that explains why we would
> never produce this combination, though empirically we do not.

That still has some value even if your commit ends up with a question
mark. There's not much to dig out of 636171cb80 (make index-pack able
to complete thin packs., 2006-10-25). Adding Nico, maybe he still
remembers...

> -- >8 --
> Subject: [PATCH] index-pack: describe an implication of our thin resolving
>
> After digging into the delta resolution code, I discovered a surprising
> (to me, anyway) implication of our strategy: we could never find a
> non-thin delta with a thin delta as its base. This is OK because
> pack-objects will never produce such a combination, because....?
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/index-pack.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index ccf4eb7e9b..f40f4560d4 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1224,6 +1224,13 @@ static void resolve_deltas(void)
>   * Third pass:
>   * - append objects to convert thin pack to full pack if required
>   * - write the final pack hash
> + *
> + * Note that we assume all deltas at this phase are thin. We take only a
> + * single pass over the unresolved objects, and we look for bases only
> + * in our set of already-existing objects, _not_ other objects within this
> + * pack. This means that we would never find an object A stored as a delta
> + * against another object B in this pack, when B is a thin delta against a base
> + * not in the pack.
>   */
>  static void fix_unresolved_deltas(struct hashfile *f);
>  static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned char *pack_hash)
> --
> 2.22.0.rc0.544.g1eb4087842
>


-- 
Duy
