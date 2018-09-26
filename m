Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112D81F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeI0A1I (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:27:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43188 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeI0A1I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:27:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so13841284pfi.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bhvGrgVRlgsrrCi17t7MDNUN0Fv+awK9d/vzFZ98Ee0=;
        b=INYqL7ZIbLsAtI25zJB4cKltyvEVL1Uhf+I+2EkAbJh7FGaFTU5jNx4AoBp/ZVjo3w
         vgWLIKszSnYPbVtdhoBhM0+DiIRq31++6G843ypHSXyesAxpYFchnhTfm/HkQ2crOjAM
         7GZ9br63onuT1YeQiNZU/PMIEsnmGv3OQ7uK7vCRKayF2l0ru7AJB4EzzA/w85zB3aI3
         lSeqtuPgPURyWzXp21Z97XBug///VN4gDjPCggyFUd40XDwmflN4x6h3g+SndWP+Hrsz
         Jjl3j1xVNKKGi2/VNSp3ef7aOaK8BC8kAPoySZK14Ym5Oob7emqXD1rJrW3dyZO97Vs4
         aJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bhvGrgVRlgsrrCi17t7MDNUN0Fv+awK9d/vzFZ98Ee0=;
        b=ZdLnvQxMSr4CwQnk+YfF8dXA/qRpnetIvmRRq1zWnPP7WFb9dPl74M2ICU7H1c+L3M
         SI1eCqsmG6/Ixi9pvl6tuDLLS5pN3/YbeIUAZPzCNVPyvxG3e0cA2owdygqDr5fxgKuh
         7YWXo2v/YYgY0veOV6YeEjLHQWj5PemhpLczgz84CIF/v8cKqdMn4jqRp+PqcGE9F7b3
         eQxEMTSsxRQ+PvEKSxKdP3it2is7Vwgpo+eh1uG0Iae6NCbjoXmChxGfRMhhaS4KvGR2
         xPYV8oF2AH2t9YOwbI/WFF/+rEp904ZuNXjOOFlVDPYBG0KcJmylP63dFwaxPVL/BmEE
         54Eg==
X-Gm-Message-State: ABuFfoheAXCNmmqcqjEh4OZChu4bzDOM7yA/HP3ejdPG2U6LChxmgZnk
        /ub1rDkMZpeykiq7q8mm6YVflw==
X-Google-Smtp-Source: ACcGV63I2i5R5zfy0zOdXn3Xj3cqO9hpgbc6HY2PgcLl6MB2OVKwCgHGBtuNxFKI+qi3sP8/vTirDQ==
X-Received: by 2002:a17:902:5993:: with SMTP id p19-v6mr7302494pli.260.1537985573535;
        Wed, 26 Sep 2018 11:12:53 -0700 (PDT)
Received: from localhost ([205.175.107.36])
        by smtp.gmail.com with ESMTPSA id y136-v6sm10123644pfg.162.2018.09.26.11.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:12:52 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:12:51 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
Message-ID: <20180926181251.GB63889@syl>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 08:16:36AM -0700, Junio C Hamano wrote:
> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
>
> > I often use 'git <cmd> --help' as a quick way to get the documentation
> > for a command. However, I've also trained my muscle memory to use my
> > aliases (cp=cherry-pick, co=checkout etc.), which means that I often end
> > up doing
> >
> >   git cp --help
> >
> > to which git correctly informs me that cp is an alias for
> > cherry-pick. However, I already knew that, and what I really wanted was
> > the man page for the cherry-pick command.
> >
> > This introduces a help.followAlias config option that transparently
> > redirects to (the first word of) the alias text (provided of course it
> > is not a shell command), similar to the option for autocorrect of
> > misspelled commands.
>
> While I do agree with you that it would sometimes be very handy if
> "git cp --help" behaved identically to "git cherry-pick --help" just
> like "git cp -h" behaves identically to "git cherry-pick -h" when
> you have "[alias] cp = cherry-pick", I do not think help.followAlias
> configuration is a good idea.  I may know, perhaps because I use it
> all the time, by heart that "cp" is aliased to "cherry-pick" and
> want "git cp --help" to directly give me the manpage, but I may not
> remember if "co" was commit or checkout and want to be concisely
> told that it is aliased to checkout without seeing the full manpage.
> Which means you'd want some way to command line override anyway, and
> having to say "git -c help.followAlias=false cp --help" is not a
> great solution.

I think I responded partially to this hunk in another thread, but I
think I can add some additional information here where it is more
relevant.

One approach to take when digesting this is that 'git co --help' shows
you the manual page for 'git-checkout(1)' (or whatever you have it
aliased to), so that answers the question for the caller who has a
terminal open.

In the case where you are scripting (and want to know what 'git co'
means for programmatic usage), I think that there are two options. One,
which you note above, is the 'git -c help.followAlias=false ...'
approach, which I don't think is so bad for callers, given the tradeoff.

Another way to go is 'git config alias.co', which should provide the
same answer. I think that either would be fine.

Perhaps we could assume that 'help.followAlias' is false when it is
unset, _and_ isatty(2) says that we aren't a TTY. Otherwise, since I
feel that this is a good feature that should be the new default, we can
assume it's set to true.

Thanks,
Taylor
