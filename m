From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sat, 20 Mar 2010 14:49:43 +0530
Message-ID: <f3271551003200219s5da3d620n602227eed948da70@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> 
	<fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com> 
	<32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 10:20:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsuqq-0000Oj-6E
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 10:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0CTJUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 05:20:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46402 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab0CTJUE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 05:20:04 -0400
Received: by gyg8 with SMTP id 8so1894748gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YQNgp6ueF0uCI4er2XxXJqUjIlTsDFeJ3jxAbXw9WgU=;
        b=cplvFdqaQ4VRLHRIDoWrSwnZj0zHWlNkxo4X3R3eWx8Kk9sk/KuQeiKyMYFs4onhtj
         9gJqOxjL2yv7rLfblGpn8sYc9xWInA0/DZzVGSA+IoDvAGd2xSOVxfrg4bU9c698NAOt
         BXsYDc1RNvFvxNjIqdhzkS/sSFgDYDmwptwf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i5ME53mDdvwcS5rKru4Obz/QYk43DU2TNSPMRAfzcuOMFugXneJqdxUtpZqBixRwKy
         90XwE1qU5BFp1mCSoR293KkHygOUb1eRo/zTdYA7UWKG7NgY8+Yvj6BtqLfdVAyqyq18
         tUXPoPequOdLO0W0v0ooD01BWy5vuUykznFpk=
Received: by 10.91.22.14 with SMTP id z14mr1626374agi.99.1269076803127; Sat, 
	20 Mar 2010 02:20:03 -0700 (PDT)
In-Reply-To: <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142699>

Hi,

> So if your goal is to write a possibly better replacement to git-svn,
> that's a potentially great goal with an unfortunately high probabilit=
y
> of failure (but great upside if you don't fail).  If you won't
> consider it successful unless it gets merged upstream... then you're
> setting yourself up for disappointment, at least if you expect to be
> done withing the GSoC timeframe.

As Sverre pointed out, this is not the goal of the project. The
proposal is not to rewrite git-svn. You're probably right to assume
that any such endeavor would be unsuccessful in one summer. The
proposal is to create an application that will natively support SVN
repositories in Git. I'm simply pointing out the limitations of
git-svn as a motivation for this project.

As I've mentioned in my proposal, good SVN exporters already exist,
and creating an SVN client can be fairly elementary. The whole point
of the project is to move away from the "git-svn.perl approach".
Ofcourse, that doesn't mean that I won't use some parts of git-svn in
native-git-svn. Along with creating the infrastructure for this
approach, I do expect to have *working* native SVN support at the end
of summer merged into mainline.

I'll make this clearer in the next revision of my proposal.

> You could always do your whole project in python or perl and make it
> *work* the way you want.  If it's really good, you can maybe get that
> accepted into the git core.  Then, if it's really modular enough, you
> ought to be able to rewrite the modules one by one into C as needed.

Writing everything in C can be quite painful. I plan to start off by
prototyping the various components in Python anyway. If and when it's
necessary, components can be re-implemented in C.

> In the current version of git-svn this is very hard. 'git svn dcommit=
'
> generates entirely new git commit objects corresponding to the ones
> that were created in svn... but which nevertheless have your merge
> history included, which is awesome. =A0But if a new person clones the
> svn repo from scratch, he will end up with git commits corresponding
> to those same ones from svn, but *without* the merge history, and
> therefore with different commit ids, and which therefore prevent
> push/pulling between other people who have cloned the repo.

Oh, that's terribly ugly. Thanks for pointing it out. I haven't
thought of a solution yet, but yes- it would be really nice if the new
design could handle this elegantly.

Do feel free to tell me what you'd like to see in the next revision of
my proposal, and what you'd like to see omitted. A proposal can't run
into many pages, so I'll attach anything that's very detailed as
notes.

Thanks,
Ramkumar
