From: David Aguilar <davvid@gmail.com>
Subject: Re: git branch --current?
Date: Wed, 17 Mar 2010 12:06:47 -0700
Message-ID: <20100317190645.GA8304@gmail.com>
References: <fcaeb9bf1003170743kc347d53jefe41039e3b9a69a@mail.gmail.com> <76718491003170748h349c5ed0u7649864cc824f549@mail.gmail.com> <fcaeb9bf1003170804s4c9fdbb6id2c045bdb90f8c6f@mail.gmail.com> <76718491003170814v71e31e91q994daee849da4caf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 20:07:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NryaH-0003Yg-UM
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 20:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab0CQTHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 15:07:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:35778 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab0CQTHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 15:07:06 -0400
Received: by fg-out-1718.google.com with SMTP id 16so32194fgg.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9e62B3YKAUtXE/oM+107EDW/REU+5f1IYqFDQklxiFY=;
        b=r2OiZPflZj1mhfFTNkvVstby/7k0iNUoySe5Lzslg1cNHZbMB3E7vtskdJPEbRTmJE
         sN4ooep0vPI0Uimv8FcqbZS3bQ0alkYl8GY0U+kr9+udqxb0hZkNZ8IiKCRCxLDm5BR+
         VmNPjgf4BZWdGctAkK9NAhbn+h9/Jj9H44PKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uDpNxNZbL9cQrrd1leIPkci8ZbW89ZxdE8hB+BUyzVnGBvddo/UMsjm1L2xkXFIk1K
         aHfSo9VmpGAIIfAhAv+QvzbSckzixtLA10RjTfkAOmTPJOyvQBAPvozdKhyxoB9xFs+L
         7csaUAJGIBecquAEPDszC/WtwYbFw9C4uYlW0=
Received: by 10.87.74.5 with SMTP id b5mr4045160fgl.62.1268852823829;
        Wed, 17 Mar 2010 12:07:03 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [198.187.190.1])
        by mx.google.com with ESMTPS id l12sm2697279fgb.12.2010.03.17.12.07.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 12:07:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <76718491003170814v71e31e91q994daee849da4caf@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142431>


Hi,

On Wed, Mar 17, 2010 at 11:14:44AM -0400, Jay Soffian wrote:
> On Wed, Mar 17, 2010 at 11:04 AM, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com> wrote:
> > Hmm.. I have alias.pwb = symbolic-ref HEAD. Both solutions are not as
> > good as "git branch", say detached HEAD case.
> 
> How about naming something like this git-pwb and copying it to
> somewhere in PATH:
> 
> #!/bin/sh
> . /opt/git/share/git-core/git-completion.bash
> echo $(__git_ps1)
> 
> 
> Perhaps you are inspired to contribute git-completion.csh?
> 
> :-)
> 
> j.


You caught my attention.  I don't personally like csh.  In fact,
I'm actively working on a way to get us off of csh here at
$dayjob.  Hence, I usually shy away from anything that
encourages csh usage.

That said, I'm a practical person.  We've written a
git-completion.tcsh here so I figured I'd share.

Caveats -- it sucks!  I'm pretty sure that this is due
to either a) csh's poor completion facilities, or b) my
inability to use it to its best ability.  The thing that really
kills me is that I can't figure out how to get both path
completion and --option completion at the same time.
For a while I had 'echo *' in there to handle that but
that breaks down once you start completing down a subdirectory
(the "/" breaks it).  Hence, we always use the '--' separator
when specifying pathspecs.

What I learned from this exercise?
Bash completion is effin amazing!  (typed from a bash terminal)

I'm sure there's plenty of ways to improve this.  Aside from
throwing it in contrib/ and hoping others find it useful enough
to improve it, I've probably hit my tcsh completion-foo limit.


-- >8 -- git-completion.tcsh -- >8 --

#   Source this script in tcsh to setup shell completions
#   for git.  Completions are activated by typing <tab> or Control-D
#   in the shell after entering a partial command.
#
# Usage:
#   source git-completion.tcsh     (e.g. in ~/.cshrc)
#
# Supported completions:
#   git <tab>            (lists git commands)
#   git help <tab>       (lists git commands)
#   git branch <tab>     (lists branch names)
#   git checkout <tab>   (lists branch names)
#   git log <tab>        (lists the most commonly used flags)
#   git remote <tab>     (lists git remote commands)
#   git remote add|prune|rm|show|update <tab>
#                        (lists git remote names)
# In addition to entering <tab> where shown, you can enter it after
# typing part of the word, e.g. git branch bug<tab> to auto-complete
# branches starting with "bug".
#
# Author: David Adler, David Aguilar

if ( -x /usr/bin/git) then
    # Git is installed so define tcsh completions for it.

    # List of known git subcommands
    # This is a hard-coded list to avoid calling 'git help' at startup.
    set __git_cmd_names = (add bisect blame branch checkout clone commit config \
                           diff difftool fetch grep gui init log merge mv pull push \
                           rebase reset rm show shortlog stash status tag)

    alias __git_aliases 'git config --get-regex "alias.*" | sed -n "s,alias\.\([^ ]*\).*,\1,p"'
    alias __git_branches 'git for-each-ref --format="%(refname)" refs/heads refs/remotes | sed -e s,refs/remotes/,, | sed -e s,refs/heads/,,'
    alias __git_origin_branches 'git for-each-ref --format="%(refname)" refs/remotes/origin | grep -v HEAD | sed -e s,refs/remotes/origin/,,'

    # Define the completions (see the tcsh man page).
    complete git \
             'p/1/`__git_aliases | xargs echo $__git_cmd_names`/' \
             "n/help/($__git_cmd_names)/" \
             'n/branch/`__git_branches | xargs echo -m -d`/' \
             'n/config/(--global --get-regexp --list)/' \
             'n/diff/`__git_branches | xargs echo --check --staged --stat -- *`/' \
             'n/difftool/`__git_branches | xargs echo --no-prompt --staged -- *`/' \
             'n/fetch/`git remote`/' \
             'n/merge/`__git_branches`/' \
             'n/log/`__git_branches | xargs echo -- --name-only --name-status --reverse --committer= --no-color --relative --ignore-space-change --ignore-space-at-eol --format=medium --format=full --format=fuller`/' \
             'n/stash/(apply list save pop clear)/' \
             'n/push/`git remote`/' \
             'N/push/`__git_origin_branches`/' \
             'n/pull/`git remote | xargs echo --rebase`/' \
             'n/--rebase/`git remote`/' \
             'N/--rebase/`__git_origin_branches`/' \
             'N/pull/`__git_origin_branches`/' \
             'n/rebase/`__git_branches | xargs echo --continue --abort --onto --skip --interactive`/' \
             'N/rebase/`__git_branches`/' \
             'n/remote/(show add rm prune update)/' \
             'N/remote/`git remote`/' \
             'n/checkout/`__git_branches | xargs echo -b --`/' \
             'N/-b/`__git_branches`/'
endif

-- 
		David
