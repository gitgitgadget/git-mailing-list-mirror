Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F1B207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 00:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1432727AbdDZAZH (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 20:25:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34111 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947933AbdDZAZF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 20:25:05 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so55704698ioi.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 17:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QajaI//Dt24BOqAwhYMcz26r3YmV6ziW3i56S+xrDLQ=;
        b=WJMfGwH0Nff7W3Ca3fWtEneYVYU8wcGtlUiarXFJDKe14l0CF85BR5ZhNVG/kzQWAO
         qh6GV4pV6hTo7Rf0SOzgbMYUoWGuz9+ClpmKEjYKG3xld0nKJeWrxAG21hcxwN0UFyE/
         Fff93lfITXT3y6QTmxmDz76Og2WXP+kl2LuA7d55fwFccy+I+0I/G3m6T4MMo3ekjOZo
         hPk9lN1TacY2C1iJq9yPfINLz8VJd7nMHb/gF+Z78VRm2m8f8pzXnzI08hArSf0EiiNC
         zDqx7PfRh3MkfYmnB6VnIeZSuiAQVChnaRmmqa3upityRdqBAul6FKdDdyIU068SV7Fy
         P4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QajaI//Dt24BOqAwhYMcz26r3YmV6ziW3i56S+xrDLQ=;
        b=En9j/ZNCd5vfTJrwwqDFNggz2yFAMhRaJl0rleKn9IR76ttgwyaRzVx4KdHJeQJLws
         Nkmh/CiKFFeyBJqByITbCNK9wGr15H1cpCF3XwVxx5dthP9J3GQx2hpUCzrH/v0J673x
         HFeLbqTt9kAELCs0v9D2wo8k/nkuZLkDafuUb8AOwUUtGsbqUcUKNblNev8eZC2fBLlx
         VHbzFGvqJntewzcuFMhOHd+vjorvUdBFWjCXw7g2Zzd/8SOMC0m8cQbDqBbSTTMdSVzl
         2urdor7Qift5En/9aNoMuTTfuRMzGvGHe7hhpuguki4iPQdmlwbMctaEbCpEVRrBEapB
         JzEw==
X-Gm-Message-State: AN3rC/4x6nRvwTOvDU5T0R+X3IProvqx2UOk9CaVEYsQG/F5WLdqZxEk
        wwrlj8rGPhgS8g==
X-Received: by 10.107.146.139 with SMTP id u133mr19987121iod.160.1493165615413;
        Tue, 25 Apr 2017 17:13:35 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id 9sm880723iol.36.2017.04.25.17.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Apr 2017 17:13:34 -0700 (PDT)
Message-ID: <1493165607.29673.31.camel@gmail.com>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
From:   liam Beguin <liambeguin@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, peff@peff.net
Date:   Tue, 25 Apr 2017 20:13:27 -0400
In-Reply-To: <alpine.DEB.2.20.1704252148400.3480@virtualbox>
References: <20170424032347.10878-1-liambeguin@gmail.com>
         <20170425044320.17840-1-liambeguin@gmail.com>
         <alpine.DEB.2.20.1704252148400.3480@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes, 

On Tue, 2017-04-25 at 22:08 +0200, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Tue, 25 Apr 2017, Liam Beguin wrote:
> 
> > Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
> > to abbreviate the command-names in the instruction list.
> > 
> > This means that `git rebase -i` would print:
> >     p deadbee The oneline of this commit
> >     ...
> > 
> > instead of:
> >     pick deadbee The oneline of this commit
> >     ...
> > 
> > Using a single character command-name allows the lines to remain
> > aligned, making the whole set more readable.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> 
> Apart from either abbreviating commands after --edit-todo, or documenting
> explicitly that the new config option only concerns the initial todo list,
> there is another problem that just occurred to me: --exec.
> 
> When you call `git rebase -x "make DEVELOPER=1 -j15"`, the idea is to
> append an "exec make DEVELOPER=1 -j15" line after every pick line. The
> code in question looks like this:
> 
> add_exec_commands () {
>         {
>                 first=t
>                 while read -r insn rest
>                 do
>                         case $insn in
>                         pick)
>                                 test -n "$first" ||
>                                 printf "%s" "$cmd"
>                                 ;;
>                         esac
>                         printf "%s %s\n" "$insn" "$rest"
>                         first=
>                 done
>                 printf "%s" "$cmd"
>         } <"$1" >"$1.new" &&
>         mv "$1.new" "$1"
> }
> 
> Obviously, the git-rebase--interactive script expects at this point that
> the command is spelled out, so your patch needs to change the `pick)` case
> to `p|pick)`, I think.
> 
> In addition, since the rationale for the new option is to align the lines
> better, the `exec` would need to be replaced by `x`, and as multiple `-x`
> options are allowed, you would need something like this at the beginning
> of `add_exec_commands`, too:
> 
> 	# abbreviate `exec` if rebase.abbrevCmd is true
> 	test p != "$rebasecmd" ||
> 	cmd="$(echo "$cmd" | sed 's/^exec/x/')"
> 



> Also:
> 
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 475e874d5155..8b1877f2df91 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2614,6 +2614,25 @@ rebase.instructionFormat::
> >  	the instruction list during an interactive rebase.  The format will automatically
> >  	have the long commit hash prepended to the format.
> >  
> > +rebase.abbrevCmd::
> 
> It does not fail to amuse that the term "abbrevCmd" is abbreviated
> heavily itself. However, I would strongly suggest to avoid that. It would
> be much more pleasant to call the config option rebase.abbreviateCommands

I tried to use something similar to the rest of the options but I guess that
would be best.

> 
> > +rebase.abbrevCmd::
> > +	If set to true, `git rebase -i` will abbreviate the command-names in the
> > +	instruction list. This means that instead of looking like this,
> 
> This is by no means your fault, but it is really horrible by how many
> different names Git's documentation refers to the todo script, nothing
> short of confusing. It is the todo script (which I called it initially,
> maybe not a good name, but it has the merit of the longest tradition at
> least), the todo list, the instruction sheet, the rebase script, the
> instruction list... etc
> 
> However, the thing is called "todo list" elsewhere in the same file,
> therefore lets try to avoid even more confusion and use that term instead
> of "instruction list" here.

thanks for pointing this out, I was not quite sure what to call this list.

> 
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 2c9c0165b5ab..9f3e82b79615 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -1210,6 +1210,10 @@ else
> >  	revisions=$onto...$orig_head
> >  	shortrevisions=$shorthead
> >  fi
> > +
> > +rebasecmd=pick
> > +test "$(git config --bool --get rebase.abbrevCmd)" = true && rebasecmd=p
> 
> A better name would be "pickcmd", as there are more rebase commands than
> just `pick` and what we want here is really only associated with one of
> those commands.

Wouldn't that make it confusing when the patch starts to handle other commands?
A common name across the script would limit further confusion.
I noticed that it is already called `action` in `rearrange_squash`.
would that do? (even though it has no reference to 'command')

> 
> Ciao,
> Johannes

Thanks for the detailed answer,
Liam
