Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660051F4B6
	for <e@80x24.org>; Tue, 23 Jul 2019 20:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfGWUAM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 16:00:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44135 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbfGWUAM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 16:00:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so20989480plr.11
        for <git@vger.kernel.org>; Tue, 23 Jul 2019 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tshyk+gM7tzvrE0mGaGXxOqZdJL9X+ucdP/75aDQ668=;
        b=nsAteAj5UpN/4ZocdUkYCpOP7kj3/bdu3cJ0Ie6U6sX23xjQIo/wVp7Kz6+PG1bo9/
         9PyffyplS4pPyH7ZRaMcK7UI5eWIx9lfiL3OLOLHMWSLNidUVFzK7CE0RLxj/K4hoCH3
         JwpJ7z4wYxQQXQ9VW7Gu1DhrvEW5TILAN4507QWkahCx0iCkCDi+o0Ixk6pOAp+GdIXd
         MjQgw8++LzbfEcJnZm1dVtroi1QBH6lpNhK14JB7xNwvBJU64wfTemysvVAdZrkXR/0k
         yUgwunHvIQx+8+SKDKlTa7927k7mIpyWBw3EXeiEQZYgLiKnClQlEdTzPNEAuOdemQ3K
         Xw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tshyk+gM7tzvrE0mGaGXxOqZdJL9X+ucdP/75aDQ668=;
        b=MKCVcWRXITMa+olmEjfzqbLMY+VmWLgEBDOxjdZCdemm/Ya8DIUMCXpeQaoLG4T45H
         y6O9pShBBBw/3ChB0lHU/4GIZLbT5yQgeHCS9sl7xds/VFsL+uPBL6yO8IqKs3mWfvFW
         veRh0ImtuIfK8DBlkOJf/B+vlp/vAxHbx2Pnk33G1ErdFK/S3zcY1R7wbKaRjolIuPxV
         vMadGIuR8a6664ssUKWMV+h278QLgZ7YITqCYHh0O/pO4xytPWLGqvmiCt138rAdbex2
         pz9To7GmZmmtF1Cdg9kKd73oa4MBvm2GpYba6fRpFeIuaUoi1pBQf/2zRG/f5kUEsFGp
         VN6Q==
X-Gm-Message-State: APjAAAUfsmNdt/JkKmlVKhNwEz/NpGFyN9QwTU60maNNeW+3PQjtyyID
        /mTgFWSlqiVauuxE78ZuEco=
X-Google-Smtp-Source: APXvYqznEj2WiU5oswgW6lVtuVIcZ/ufTERgptdYhCaBwQUwMy3FrarbiKOTP/HsC5dybu7agG4pKw==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr83437725pls.128.1563912011345;
        Tue, 23 Jul 2019 13:00:11 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.220])
        by smtp.gmail.com with ESMTPSA id s15sm43098826pfd.183.2019.07.23.13.00.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:00:10 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Phillip <phillip.wood123@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood@dunelm.org.uk>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 2/2] rebase -i: support --committer-date-is-author-date
Date:   Wed, 24 Jul 2019 01:27:22 +0530
Message-Id: <20190723195722.16745-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <7f53b294-57f7-77bf-ca0a-e9621227377c@gmail.com>
References: <7f53b294-57f7-77bf-ca0a-e9621227377c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On Sat, 20 Jul 2019 15:56:50 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
> [...]
> 
> > @@ -467,6 +470,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
> >   		OPT_BOOL(0, "autosquash", &opts.autosquash,
> >   			 N_("move commits that begin with squash!/fixup!")),
> >   		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
> > +		OPT_BOOL(0, "committer-date-is-author-date",
> > +			 &opts.committer_date_is_author_date,
> > +			 N_("make committer date match author date")),
> 
> I guess it's good to do this for completeness but does
> rebase--preserver-merges.sh support --committer-date-is-author-date? It
> is the only caller of rebase--interactive I think so would be the only
> user of this code.

Oh! Yes, I did it for the completeness. Let's add the flag while we
still have that _rebase--interactive_ command hanging out with us.

> [...]
> 
> > +	if (read_author_script(rebase_path_author_script(),
> > +			       NULL, NULL, &date, 0))
> > +		die(_("failed to read author date"));
> 
> Can we have this return an error please - we try quite hard in the
> sequencer not to die in library code.

Yes, we can through an error and continue, but then the user will
see the unchanged author date which is against his / her will but
it will not crash the program at least.

> [...]
> 
> > +	if (opts->committer_date_is_author_date) {
> > +		char *date = read_author_date_or_die();
> > +		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s", date);
> > +		free(date);
> > +	}
> 
> It's a shame to be doing this twice is slightly different ways in the
> same function (and again in try_to_commit() but I don't think that can
> be avoided as not all callers of run_git_commit() go through
> try_to_commit()). As I think the child inherits the current environment
> modified by cmd.env_array we could just call setenv() at the top of the
> function. It would be worth looking to see if it would be simpler to do
> the setenv() call in the loop that picks the commits, then we would
> avoid having to do it in do_merge() and try_to_commit() separately.

Ok, I'll have to change the code according to what Junio suggested.
Let's see how this area will look after that.

> [...]
> 
> > +		if (file_exists(rebase_path_cdate_is_adate())) {
> > +			opts->allow_ff = 0;
> 
> This is safe as we don't save the state of allow_ff for rebases so it
> wont be overridden later. It would be an idea to add to the checks in
> the assert() at the beginning of pick_commits() no we have another
> option that implies --force-rebase.

Are you suggesting to modify this assert() call (in pick_commits())?

    if (opts->allow_ff)
        assert(!(opts->signoff || opts->no_commit ||
                opts->record_origin || opts->edit));

Thanks
Rohit

