Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0641F202BB
	for <e@80x24.org>; Thu,  4 Apr 2019 13:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfDDN4b (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 09:56:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42535 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfDDN4b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 09:56:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id b7so1852322lfg.9
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=oRGlNmNWV1pWyefwpV7ZPIRRYw/eCM1ooBYcQ0Ir57s=;
        b=mzFXgfmJ7Xdzxgp3Snc3+FahDW4n0C1i0TOfVMVZ1zz9n3uDiQuM9WgAp/L4tjQxnk
         I7E/YedBguH+QQx+B0qNruo23Ju2Ho2/Ylz4LjtiowNluOeGf7iWTY6E8NjWyOF27j0t
         RuT67ddgwacnE7e4wVwYCo/HVLU7PXE7S4n2/OPmxIPOR1Aano8jxVZ/6/+ilN7BDOXC
         vgmzNXHcSkTDB2/h8MztwXOuUVd+sZH5K/lzhzTqx7b6eamGLlYXUf0euKY8zkg2cjQt
         hJgxkEPPZxlPXmMRnz+XAnS9aOVyPGOAQXdjFwmKsBSo8qe4WUkdzznMdGvlW7X3DfSV
         LYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=oRGlNmNWV1pWyefwpV7ZPIRRYw/eCM1ooBYcQ0Ir57s=;
        b=ErHYFHxvgLCTM3URMLCTO2jqH/DA/QP/zfbLJrJUfSpMzoa8MCM/GH5FlEZ27f6ZS1
         YqXfNuIKBa1xu28VlUEWR97TM1oIkgYoos90sKU8nSTv49JzYcIOrTFmk3TLF7B7Ru3N
         oZr7kGBfuK56iVs3mtX8irPZTxrodOaFdWviC3MRnpvRt7xhZYzqsvg2Ttatd9XDTkOw
         4yT3xd8IagCqJyv9nPueXY2O162RHbWXLoB1WTyem05hRonnuHlhQR/8Os9MVfjvygZk
         T1SHggyuZr5BAgTE8b+otWeCrcZoi5rthogwS+YT4zbfGX3Y8w6qn8kj4M1gX2YAVwFV
         1mYg==
X-Gm-Message-State: APjAAAVi48CekR6sysM1aosRrXP65deNFbQri04pzN5jpRsHyk0fWrXG
        CwNC0eI20/1Au7KPn9glSV/ntXkGcuhYx6iTUzE=
X-Google-Smtp-Source: APXvYqzmvRXCQ7JJbymthbPjlsdaAX2Yx/1r6O3MhPBMqOqbaQhXSHNQPVXZdDpt/N5CERr0gwqtHp7axh0dQEdic+4=
X-Received: by 2002:ac2:52a6:: with SMTP id r6mr3345450lfm.27.1554386188497;
 Thu, 04 Apr 2019 06:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
 <20190404015744.GF4409@sigill.intra.peff.net> <20190404032606.GA39148@Taylors-MBP.hsd1.wa.comcast.net>
 <20190404120613.GB22324@sigill.intra.peff.net>
In-Reply-To: <20190404120613.GB22324@sigill.intra.peff.net>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 4 Apr 2019 08:56:16 -0500
X-Google-Sender-Auth: 8sfOv_HVPBEYEY-ZNhVtQ9_R8sE
Message-ID: <CAHd499CUCoShsQHYZotFqprfDUf_owg_Urbt29fkNRV6LhFc3Q@mail.gmail.com>
Subject: Re: Feature request: Add --no-edit to git tag command
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 4, 2019 at 7:06 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Apr 03, 2019 at 08:26:06PM -0700, Taylor Blau wrote:
>
> > Agreed.
> >
> > I think that the implement is a little different than "add a --no-edit"
> > flag, though. 'git tag' already has a OPT_BOOL for '--edit', which means
> > that '--no-edit' exists, too.
> >
> > But, when we look and see how the edit option is passed around, we find
> > that the check whether or not to launch the editor (again, in
> > builtin/tag.c within 'create_tag()') is:
> >
> >   if (!opt->message_given || opt->use_editor)
> >
> > So, it's not that we didn't take '--no-edit', it's that we didn't get a
> > _message_, so we'll open the editor to get one (even if '--no-edit' was
> > given).
>
> Yeah, I think the fundamental issue with --no-edit is that it is not a
> tristate, so we cannot tell the difference between --edit, --no-edit,
> and nothing.
>
> I think regardless of the "re-use message bits", we'd want something
> like:
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 02f6bd1279..260adcaa60 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -196,7 +196,7 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
>
>  struct create_tag_options {
>         unsigned int message_given:1;
> -       unsigned int use_editor:1;
> +       int use_editor;
>         unsigned int sign;
>         enum {
>                 CLEANUP_NONE,
> @@ -227,7 +227,7 @@ static void create_tag(const struct object_id *object, const char *tag,
>                     tag,
>                     git_committer_info(IDENT_STRICT));
>
> -       if (!opt->message_given || opt->use_editor) {
> +       if ((!opt->message_given && opt->use_editor != 0) || opt->use_editor > 0) {
>                 int fd;
>
>                 /* write the template message before editing: */
> @@ -380,7 +380,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>         static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
>         struct ref_format format = REF_FORMAT_INIT;
>         int icase = 0;
> -       int edit_flag = 0;
> +       int edit_flag = -1;
>         struct option options[] = {
>                 OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>                 { OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
>
> which even does the right thing with "git tag --no-edit -a foo" (it dies
> with "fatal: no tag message?"
>
> > This makes me think that we should do two things:
> >
> >   1. Make !opt->message_give && !opt->use_editor an invalid invocation.
> >      If I (1) didn't give a message but I did (2) give '--no-edit', I'd
> >      expect a complaint, not an editor window.
> >
> >   2. Then, do what Robert suggests, which is to "make opt->message_given
> >      true", by re-using the previous tag's message.
>
> I think I misunderstood Robert's proposal. I thought it was just about
> fixing --no-edit, but it's actually about _adding_ (2). Which I think
> we'd want to do differently. See Junio's reply elsewhere in the thread
> (and my reply there).
>
> > > I think it wouldn't be very hard to implement, either. Maybe a good
> > > starter project or #leftoverbits for somebody.
> >
> > Maybe. I think that it's made a little more complicated by the above,
> > but it's certainly doable. Maybe good for GSoC?
>
> I was thinking it was just the --no-edit fix. :) Even with the "--amend"
> thing, though, it's probably a little light for a 3-month-long GSoC
> project. :)

I apologize for the confusion. I'm not fully aware of any per-option
philosophies in Git, so I may be unaware of the misunderstanding my
request is causing. Let me attempt to clarify.

My goal as a user is to correct a tag. If I point a tag at the wrong
commit, I simply want to move that tag to point to another commit. At
the moment, the only way I know to do this is the -f option, which I
just treat as a "move" for the tag. I realize that may not be its
intent in the implementation, but from a user perspective that's the
end result I get.

So if I treat -f as a "move this tag", I also want to say "reuse the
existing commit message". So again, in my mind, that means -f
--no-edit. Which means "I'm moving this tag and I want to keep the
previous commit message".

I hope this makes more sense. If getting this means not using -f or
--no-edit at all, and is instead a whole different set of options, I'm
OK with that as long as the end result is achievable. It's impossible
to write a script to "move" (-f) a bunch of annotated tags without an
editor prompting me on each one. So this "--no-edit" addition would
assist in automation, and also making sure that we simply want to
correct a tag, but not alter the message.
