From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Mon, 02 Dec 2013 12:40:12 +0100
Message-ID: <1385984412.3240.17.camel@localhost>
References: <1385922611.3240.6.camel@localhost>
	 <20131201190447.GA31367@kaarsemaker.net>
	 <CACsJy8CxR+wj-P+fxF37DU=Tzk=su+V=UudbO7NkqTMS8qTn_w@mail.gmail.com>
	 <877gbop3so.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
	 <1385941093.3240.10.camel@localhost>
	 <CACsJy8CSQ2RfZub6As9TJc2Vd-wmp75ZVnjQ4nr1QY4mZ4f_TA@mail.gmail.com>
	 <1385971274.3240.14.camel@localhost>
	 <CACsJy8AuSej7Pwm5Tbo5r_FNaND1-E62Btk=7dZ74YD8K6UJDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>, ingy@ingy.net
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 12:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnRrR-0003hG-I5
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 12:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab3LBLkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 06:40:17 -0500
Received: from mail-we0-f172.google.com ([74.125.82.172]:38298 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab3LBLkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 06:40:16 -0500
Received: by mail-we0-f172.google.com with SMTP id w62so6091618wes.17
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 03:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=o6woiKQpgcTd1zqGVe3IWlTf7k/UsShNLBkaQZ1PECs=;
        b=FUY5cvYurHSE2uqCFpFX/XzkDVFPWPH9JVCseIiI64gSXQkdBCrvEelRUvELb5NsA9
         jr+NeIjPZBdSnFkEdcd4j1hHw4CvzEIIXOiIBnIZWI1br3/+iLa/8ERaSiJzaEuxhIBv
         dbMh0/k5M8kbr7KHGqC0NL9QUhMmkCZSaeNaHv5HrXel/hKAJF1defiJmRh+VetgJZ3c
         lRTLbXKNqsMhdMrGTDwvUzxV1c1aERxyAmmHpVnQHKj8s8nZpAH51z1Z3DWBo0Iw8x7j
         ygszgEuCndRXTF+eMX2bLh1mh/tZ3Ln2wzw/x6UgIieiIQT6I9qVYWPaA3cfJoOjvsMs
         1U8Q==
X-Gm-Message-State: ALoCoQlPg/Kxn0vhH/yBGCsF3A8O9iiGuc+PAPSCqJonv8eBNEVZwj87ZmyCy7XUz060pVKvqXhg
X-Received: by 10.194.48.115 with SMTP id k19mr1497877wjn.47.1385984414781;
        Mon, 02 Dec 2013 03:40:14 -0800 (PST)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id uc18sm82684679wib.11.2013.12.02.03.40.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 03:40:13 -0800 (PST)
In-Reply-To: <CACsJy8AuSej7Pwm5Tbo5r_FNaND1-E62Btk=7dZ74YD8K6UJDg@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238626>

On ma, 2013-12-02 at 16:35 +0700, Duy Nguyen wrote:
> On Mon, Dec 2, 2013 at 3:01 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
> > On ma, 2013-12-02 at 07:38 +0700, Duy Nguyen wrote:
> >> On Mon, Dec 2, 2013 at 6:38 AM, Dennis Kaarsemaker
> >> <dennis@kaarsemaker.net> wrote:
> >> > On ma, 2013-12-02 at 00:08 +0100, Thomas Rast wrote:
> >> >> Duy Nguyen <pclouds@gmail.com> writes:
> >> >>
> >> >> > On Mon, Dec 2, 2013 at 2:04 AM, Dennis Kaarsemaker
> >> >> > <dennis@kaarsemaker.net> wrote:
> >> >> >> We always ignore anything named .git, but we should also ignore the git
> >> >> >> directory if the user overrides it by setting $GIT_DIR
> >> >> [...]
> >> >> >> +       if (simplify_away(path->buf, path->len, simplify) || is_git_directory(path->buf))
> >> >> >>                 return path_none;
> >> >> >
> >> >> > this adds 2 access, 1 lstat, 1 open, 1 read, 1 close to _every_ path
> >> >> > we check. Is it worth the cost?
> >> >>
> >> >> Moreover it is a much more inclusive check than what the commit message
> >> >> claims: it will ignore anything that looks like a .git directory,
> >> >> regardless of the name.  In particular GIT_DIR doesn't have anything to
> >> >> do with it.
> >> >
> >> > Ah, yes thanks, that's rather incorrect indeed. How about the following
> >> > instead? Passes all tests, including the new one.
> >> >
> >> > --- a/dir.c
> >> > +++ b/dir.c
> >> > @@ -1198,7 +1198,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
> >> >                 return path_none;
> >> >         strbuf_setlen(path, baselen);
> >> >         strbuf_addstr(path, de->d_name);
> >> > -       if (simplify_away(path->buf, path->len, simplify))
> >> > +       if (simplify_away(path->buf, path->len, simplify) || !strncmp(get_git_dir(), path->buf, path->len))
> >> >                 return path_none;
> >>
> >> get_git_dir() may return a relative or absolute path, depending on
> >> GIT_DIR/GIT_WORK_TREE. path->buf is always relative. You'll pass one
> >> case with this (relative vs relative) and fail another. It might be
> >> simpler to just add get_git_dir(), after converting to relative path
> >> and check if it's in worktree, to the exclude list and let the current
> >> exclude mechanism handle it.
> >
> > This type of invocation really only works from the root of the workdir
> > anyway and both a relative and absolute path work just fine:
> >
> > dennis@lightning:~/code/git$ GIT_DIR=$(pwd)/.foo ./git status
> > On branch master
> > nothing to commit, working directory clean
> > dennis@lightning:~/code/git$ GIT_DIR=./.foo ./git status
> > On branch master
> > nothing to commit, working directory clean
> >
> > Well, unless you set GIT_WORK_TREE as well, but then it still works:
> >
> > dennis@lightning:~/code/git/t$ GIT_DIR=$(pwd)/../.foo GIT_WORK_TREE=.. ../git status
> > On branch master
> > nothing to commit, working directory clean
> > dennis@lightning:~/code/git/t$ GIT_DIR=../.foo GIT_WORK_TREE=.. ../git status
> > On branch master
> > nothing to commit, working directory clean
> >
> > So I'm wondering when you think this will fail. Because then I can add a
> > test for that case too.
> 
> ~/w/git $ cd t
> ~/w/git/t $ GIT_TRACE_SETUP=1 ../git --git-dir=../.git --work-tree=..
> --no-pager status
> setup: git_dir: /home/pclouds/w/git/.git
> setup: worktree: /home/pclouds/w/git
> setup: cwd: /home/pclouds/w/git
> setup: prefix: t/
> On branch exclude-pathspec
> Your branch and 'origin/master' have diverged,
> and have 2 and 5 different commits each, respectively.
> 
> I can't say this is the only case though. One has to audit to all
> possible setup cases in setup_git_directory() to make that claim.

I'm probably missing something, but that's the same as my second
example, and works. I also tried running it from completely outside the
repo:

dennis@lightning:~$ code/git/git --git-dir=code/git/.foo --work-tree=code/git status
On branch master
nothing to commit, working directory clean
dennis@lightning:~$ code/git/git --git-dir=/home/dennis/code/git/.foo --work-tree=code/git status
On branch master
nothing to commit, working directory clean

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
