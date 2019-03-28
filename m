Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C467520248
	for <e@80x24.org>; Thu, 28 Mar 2019 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfC1Hf1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 03:35:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34456 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfC1Hf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 03:35:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so13644216eds.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68XQhmz+6KUf4xCmbqKCFJI/hIBywgibH7OAV3ytWL4=;
        b=lV1fZNZMzhX1M1A76MKRcghliH8XGGXxDijtBBPmC7zDZiW3HIKYCgP/HL17bm1pQI
         jDaceVks1bQTfUQbp6DnJS87m8Dxo/imxsux5mLHuv+z67uUDdA/3zFrTtL+a3LnTPNJ
         YIOiP8c6DxXlHF7+kkMG/EPctVBI8PKaoAqQdFpM8Zvv2UP28g3gDhaiSnmCqi03XNys
         JkQ7lf3SZyjBk/w4Z9w253k3Kqa0/R5/yS1r2OHCdz88kHzMrGtwyOq7yE51hd40g+Ns
         fpwO+OvIY4MzdhvhlGod5cLoypI7l82NKnvqxdoUOFmFPrbWO1ZEzItC3+tisUaXiZ64
         6u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68XQhmz+6KUf4xCmbqKCFJI/hIBywgibH7OAV3ytWL4=;
        b=Jc5dlAVbl4Bxg78bdJ/c5xAjxIqu1guTa8RIuch5tN7k6Aw4jBTpXAxrMSP3JGDjTo
         NGOMa/U7s27YqFEbcJsT53yLdJytEwKhvANN72pyWkQGNF+0iVP/5FyEL/BHid8OnZGI
         MEuRjxaPB0kqfWhjoTUmcey0xVwyCOyONF7+0uzN3xkO0egkMmW1TzLHf78oxhYMgUp4
         0OHK35mZp8OWziNidQYNwFG3FZyYoQ14W5v2D3ijjBem0DxDsc2v2EvBTbDms6ns1OO0
         qRx99vrGPtrpkoyJIB2IkkT1NtbeqBxD8eBh3/t48CEePmRaR8PI9ydwcYpYRjiMyZaX
         58mQ==
X-Gm-Message-State: APjAAAU9YwpDHWDPlQ1S+X9Y0A2ISzAu09LyjtLJ+x6G5X19c3EMhugf
        eDHNTSQN0BsZiPkO866ViSpV2PLR1OqLgXW7Tnk=
X-Google-Smtp-Source: APXvYqwiQ4Eahoi2elKZxkm7Pyr1kER+cceOw6itgDpYNiUPVwkoUEkGk2mkhCFPUBUC6abtx/CCVJVgQz9XprPH9rY=
X-Received: by 2002:a17:906:641:: with SMTP id t1mr4598738ejb.158.1553758525696;
 Thu, 28 Mar 2019 00:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <mvmd0mcsjkf.fsf@suse.de> <CAP8UFD1qU_kJ97MdLFwzx+g3F6Q+fQ9LWOBxd=1m4vSi-fxF=Q@mail.gmail.com>
 <CAP8UFD111-zqa7Fhr1KnmWYAKpBN4ofqn0AvD_nP3s_WBFzLqw@mail.gmail.com>
In-Reply-To: <CAP8UFD111-zqa7Fhr1KnmWYAKpBN4ofqn0AvD_nP3s_WBFzLqw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Mar 2019 08:35:13 +0100
Message-ID: <CAP8UFD2yMOLKOdcXnPsCvAzymjLJX2A4U2DHfq1JjvZnQj9pLQ@mail.gmail.com>
Subject: Re: git replace --graft does error checking too late
To:     Andreas Schwab <schwab@suse.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 2:21 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Mar 27, 2019 at 2:11 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Wed, Mar 27, 2019 at 11:24 AM Andreas Schwab <schwab@suse.de> wrote:
> > >
> > > When running `git replace --graft A B' where B is a non-commit (eg. a
> > > tag) it displays an error,
> >
> > Yeah, it seems that when A is a commit and B a tag I get:
> >
> > "error: object A is a tag, not a commit"
> >
> > which is wrong as A is a commit.
>
> Actually I get the above only if A is a commit but there is a tag
> pointing to it. If there is no tag pointing to it I get:
>
> error: object C is a tag, not a commit
>
> where C is the hash of the tag object B (C=$(git rev-parse B))
>
> So yeah, this is weird.

I think I understand what happens. It seems that we put the SHA-1 of
the tag in the new object we create instead of the SHA-1 of the
underlying commit and that's what generates the error message and
other issues later.

The following patch (that unfortunately Gmail is likely to muck)
should fix at least part of the issue. I will send a real patch with
tests later.

diff --git a/builtin/replace.c b/builtin/replace.c
index f5701629a8..b0a9227f9a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -370,16 +370,19 @@ static int replace_parents(struct strbuf *buf,
int argc, const char **argv)
        /* prepare new parents */
        for (i = 0; i < argc; i++) {
                struct object_id oid;
+               struct commit *commit;
+
                if (get_oid(argv[i], &oid) < 0) {
                        strbuf_release(&new_parents);
                        return error(_("not a valid object name: '%s'"),
                                     argv[i]);
                }
-               if (!lookup_commit_reference(the_repository, &oid)) {
+               commit = lookup_commit_reference(the_repository, &oid);
+               if (!commit) {
                        strbuf_release(&new_parents);
-                       return error(_("could not parse %s"), argv[i]);
+                       return error(_("could not parse %s as a
commit"), argv[i]);
                }
-               strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
+               strbuf_addf(&new_parents, "parent %s\n",
oid_to_hex(&commit->object.oid));
        }

        /* replace existing parents with new ones */
