Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878461F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbeBEUNq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:13:46 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38184 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeBEUNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:13:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id 141so28171968wme.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=464/cup80+M/1bX2ll1ocMe4JxHRDIL8Lqgu166WjNU=;
        b=Zsn0Qc1GZIXabmjksGY69ijVQDUQd5FfP+QuELF5rUlOE6siKegzJzSgC7mrQ0tcSt
         TirnGEg+yHII6ImHW7NTGN1oTQFe++mBZAEb+WiNXcM9P/O7ia9/TwCJUgp680qukPZa
         PjkWWUmaXTam5jf6QgmRD1h5W7jomZ3Irh8idpb1pkcq+Hp4Dn3PvZTUUc9UvjUkeqjp
         6wHvZUU9ma0v7Wej4Tb6BYZHgLMQ4zpnU1QG0FykNn7TmzvB1RaFHq96Ou8duk2g03o+
         QQ6/jtEci9OmPwcm2r0FZJ3eU1RKyzfesf7wYeRjRtXbzQbGLcZTQUbmLN9t76xadr1O
         XJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=464/cup80+M/1bX2ll1ocMe4JxHRDIL8Lqgu166WjNU=;
        b=libMtartuefmPXNQbSv78uF36LCu+GHDYp5XSa5E3UnaO66O+M2eylDhQkjawj55sf
         nGhsRnL0AiZPtf6IOkS2h7DXAKe7pyxUuidD89o3BaifOPdojg7eUfs9qMUxaDZUNuR8
         3THBvVNaEWKy71l8sik9Ka2v5XRyl5v8VJx+9g1LNPjNgb8tiry2kM2BzK9at7PJ3kdm
         pc6B6nbpZ/cgGnbjYFu0z4Dr7HQ9qDrPEKsIvlpLQGFVxzXMFajtAuiuskOmpyq/GYlt
         sYeavzj+MW10Vmi5hw3wGPxQF4on0ObDD02v5mDddfc+JUS1L2/xGf2i9BWSHfeBsC0Y
         Hr9A==
X-Gm-Message-State: APf1xPB085n57U8KdWwdU+PB7AO5b+zrOx9JLkY9PlJ+LaeMPC34m6Bs
        YGmYVqdOergqkFTUaaz7S0g=
X-Google-Smtp-Source: AH8x2257DFAn4noiIEOL27F11RgJqe3N3by/ymmhfiq9f0zXtoJb3R2FNA05eze57AkohW3dOGoNzA==
X-Received: by 10.28.148.150 with SMTP id w144mr3416wmd.0.1517861623421;
        Mon, 05 Feb 2018 12:13:43 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id j125sm7924531wmd.19.2018.02.05.12.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:13:42 -0800 (PST)
Date:   Mon, 5 Feb 2018 20:13:49 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] worktree: improve message when creating a new
 worktree
Message-ID: <20180205201349.GD2130@hank>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-2-t.gummerer@gmail.com>
 <20180205021202.GA17847@duynguyen.dek-tpc.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205021202.GA17847@duynguyen.dek-tpc.internal>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05, Duy Nguyen wrote:
> On Sun, Feb 04, 2018 at 10:13:03PM +0000, Thomas Gummerer wrote:
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 7cef5b120b..d1549e441d 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -303,7 +303,7 @@ static int add_worktree(const char *path, const char *refname,
> >  	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
> >  	write_file(sb.buf, "../..");
> >  
> > -	fprintf_ln(stderr, _("Preparing %s (identifier %s)"), path, name);
> > +	fprintf(stderr, _("Preparing %s (identifier %s)"), path, name);
> >  
> >  	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
> >  	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
> > @@ -320,10 +320,19 @@ static int add_worktree(const char *path, const char *refname,
> >  	if (ret)
> >  		goto done;
> >  
> > +	fprintf(stderr, _(", setting HEAD to %s"),
> 
> As a former translator, I'm not thrilled to see a sentence broken into
> two pieces like this. I'm not a Japanese translator, but I think this
> sentence is translated differently when the translator sees the whole
> line "Preparing ..., setting ...".

Good point, I didn't think about the sentence structure other
languages could require here. 

> Since the code between the first fprintf and this one should not take
> long to execute, perhaps we can just delete the first printf and print
> a whole [*] sentence here?
> 
> I think the purpose of "Preparing..." in the first place is to show
> something when git is busy checkout out the worktree. As long as we
> print it before git-reset, we should be good.
> 
> > +		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> > +
> > +	strbuf_reset(&sb);
> > +	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
> > +	if (sb.len > 0)
> > +		fprintf(stderr, " %s", sb.buf);
> 
> [*] Yes I know it's not "whole" because of this piece. But this one is
> more or less a separate sentence already so it's probably ok.
> 
> Is it a bit too long to print everything in one line though?
> CMIT_FMT_ONELINE could already fill 70 columns easily.

Yeah, it does get a bit long.  Maybe just splitting the sentences here
would be the best solution, then we also won't have to worry about the
split not being good for translation.  I'll do that.

> > +	fputc('\n', stderr);
> > +
> >  	if (opts->checkout) {
> >  		cp.argv = NULL;
> >  		argv_array_clear(&cp.args);
> > -		argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> > +		argv_array_pushl(&cp.args, "reset", "--hard", "--quiet", NULL);
> >  		cp.env = child_env.argv;
> >  		ret = run_command(&cp);
> >  		if (ret)
> > -- 
> > 2.16.1.101.gde0f0111ea
> > 
