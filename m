Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1AD81FAED
	for <e@80x24.org>; Wed, 18 Oct 2017 22:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbdJRWNT (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 18:13:19 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:51062 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdJRWNR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 18:13:17 -0400
Received: by mail-it0-f42.google.com with SMTP id 72so8106551itl.5
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jgbiar+X0fFMZS2wx/jTWjpAXS4g2pavhp+2y0EJniU=;
        b=IZfoUWEpYiD5qz237+4KEt5QV9ANJ/hoTrrD0q/+0+gQLP1baH09UuSUodD72YxEOB
         cT/UeNiSNwiekBGhQZ3Zpu0LDNzgAivmglJewcN/lfgdk1i4a2N0efWpoH/6z/Kxaf9B
         EncVhaDthweAEdos3ADbhaQELm9Tx3fBeFgmc5hpf7vflrYGmYx7hoVM6/spssqOewaW
         QXPfaXx14fZ1QVhtyi1DVdS6TvIRKnZ6X75nj2H2Uq4kmSVQVYCC0k6SfOIRGQ2wmaPd
         r4IuYacrilntcpguv3RnzuXdwEhiU68ZpF/V8KBD8ibJ0dMWI1h5I+2g44M+ockXDZtN
         /SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jgbiar+X0fFMZS2wx/jTWjpAXS4g2pavhp+2y0EJniU=;
        b=aGra5luAq3nKTgTpH0d2OiYm6PAJfV7rxJesiMWTgrI3C55znsB2EgDmrtq9fq5WYa
         tXmRXEBP+00ZqF1olZ+PK/o7kF9WceP3wFZEGKYskmZv7tHWZ9flj876axWcMUY6JVLn
         4Bp6aaEj+wqQFgpiFSfbEyP2ABdLwl8+MRT7aCkjpJcylPnwNQFHrqzjoJjrFFvHvjb4
         9FxeR1ZG89mXxZn16lUlLr3zMdVvCQmE/GxhAzK/gf+TehPl9SbXa++7crkQsE5cr/V/
         uj7GyLNdw69d+8ajpSWlTT4czdQF0iE5YUQMlhKSmJWnd1XERuzxrgntVwA0EzHQals/
         1nbQ==
X-Gm-Message-State: AMCzsaUCKuqTibN5SDreY96BNFu+E7StHDDVI1WL+/9FKlKSAsak0MPZ
        WpYIIyMR2/2HLFdAIdBTATA=
X-Google-Smtp-Source: ABhQp+Tj/+9I7/R/dySB5duoyimLQoycmiu6bgm/CyunL+MVLQv1SzeR5WMuf9LcJMBn+J5oFbd2IA==
X-Received: by 10.36.70.76 with SMTP id j73mr11259320itb.32.1508364796745;
        Wed, 18 Oct 2017 15:13:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 78sm6950592itz.12.2017.10.18.15.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Oct 2017 15:13:15 -0700 (PDT)
Date:   Wed, 18 Oct 2017 15:12:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     PAYRE NATHAN p1508475 <second.payre@gmail.com>
Cc:     git@vger.kernel.org,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        MOY Matthieu <matthieu.moy@univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3] Documentation/git-config.txt: reword missleading
 sentence
Message-ID: <20171018220530.h6dgneq2dvhmwfeu@aiede.mtv.corp.google.com>
References: <xmqqvajjuudo.fsf@gitster.mtv.corp.google.com>
 <20171018202716.13313-1-nathan.payre@etu.univ-lyon1.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018202716.13313-1-nathan.payre@etu.univ-lyon1.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nathan et al,

PAYRE NATHAN p1508475 wrote:

> From: PAYRE NATHAN p1508475 <second.payre@gmail.com>

nit: this 'From' line doesn't match any of the authors with sign-offs
below.  I'm wondering if the authorship of the commit (from "git
commit --author" or git's "user.name" / "user.email" settings) made it
through in the email.

If you pass --from='PAYRE NATHAN p1508475 <second.payre@gmail.com>' to
"git format-patch", then it will send email from that address and add
an in-body "From:" line to the message it produces based on the author
field of the git commits.  This can be useful for sending patches that
someone else wrote.  This way, the authorship of the commit gets
through, to be used by "git am".

See https://public-inbox.org/git/20170922203017.53986-7-git@jeffhostetler.com/
for an example of how that works.

> Subject: Documentation/git-config.txt: reword missleading sentence

more nits:

- this subject line can use a more concise name for the subsystem,
  like "config doc"

- there's one too many esses in missleading

- more importantly, this is a good place to provide a summary of what
  change the patch makes, so people reading the shortlog in Git
  release announcements know what changed. Maybe something like
  "use a clearer placeholder in example"?

That would mean something like

	config doc: use a clearer placeholder in example

Or, to capture the other changes being made at the same time:

	config doc: clarify "git config --path" example

Thanks for working on this.

> Change the word "bla" to "section.variable", "bla" is a placeholder
> for a variable name and it wasn't clear for everyone.  This change
> clarify it.

The "," should be a semicolon or period, since it separates two
independent clauses.

I think the "This change clarify it" sentence can go away.  The first
sentence already explains that this is for clarity.

> Change the appearance of 'git config section.variable {tilde}/' to
> `git config section.variable ~/` to harmonize it with the rest of the
> file, this is a command line then the "`" are necessary.

I had to read this sentence a few times to understand it. Maybe:

	While we're here, also reformat this sample command line to use
	monospace instead of italics, to better match the rest of the file.

> Replace "git-config" by "git config" because the command is not
> "git-config".

My first reaction to that is, "But the manpage is git-config(1)!"
To avoid that reaction, it can say

	Use a space instead of a dash in "git config", as is common in the
	rest of Git's documentation.

By the way, should the initial `git config` be 'git config' (in
italics instead of monospace)?  I don't see `git config` anywhere else
in the file and there are a lot of instances of 'git config'.

> See discussion at:
> https://public-inbox.org/git/20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca/

The commit message is meant to be (and is, I think!) self-contained, so
this link shouldn't be needed for people running into this change in
"git log".  I'd leave it out.

> Signed-off-by: MOY Matthieu <matthieu.moy@univ-lyon1.fr>
> Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
> Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
> Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
> Noticed-by: rpjday@crashcourse.ca

optional:

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>

This can go before the sign-offs to reflect the chronology.

[...]
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -174,11 +174,11 @@ See also <<FILES>>.
>  	either --bool or --int, as described above.
>  
>  --path::
> -	'git-config' will expand leading '{tilde}' to the value of
> +	`git config` will expand leading `~` to the value of

not about this patch: the article "a" is missing before "leading `~`":

	'git config' will expand a leading `~` to the value of ...

> -	'$HOME', and '{tilde}user' to the home directory for the
> +	`$HOME`, and `~user` to the home directory for the
>  	specified user.  This option has no effect when setting the
> -	value (but you can use 'git config bla {tilde}/' from the
> -	command line to let your shell do the expansion).
> +	value (but you can use `git config section.variable ~/`
> +	from the command line to let your shell do the expansion).

I like it.

Thanks and hope that helps,
Jonathan
