From: Andreas Ericsson <ae@op5.se>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 14:08:39 +0200
Message-ID: <4DB80747.8080401@op5.se>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:08:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF3Y5-0005Mj-Kn
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882Ab1D0MIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 08:08:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49769 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab1D0MIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 08:08:47 -0400
Received: by fxm17 with SMTP id 17so1066189fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 05:08:45 -0700 (PDT)
Received: by 10.223.113.193 with SMTP id b1mr2252972faq.47.1303906125440;
        Wed, 27 Apr 2011 05:08:45 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id c21sm221616fac.46.2011.04.27.05.08.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 05:08:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172225>

On 04/27/2011 05:36 AM, Jon Seymour wrote:
> Has anyone ever given consideration to git supporting a plugin
> architecture for git extensions?
> 
> The idea would be to provide a consistent way to install, and address
> extensions to the core git functionality in a manner that does not
> require the extension to actually be integrated into the git core.
> 

Horrible idea. There are already as many package managers as there
are packages without us throwing another one into the mix.

> For example, I have recently proposed a new command 'git work'
> https://github.com/jonseymour/git/blob/master/README.md which I think
> is a really useful extension to git.
> 
> I haven't had much feedback for the concept. I am not sure if it is
> because people are too busy, just don't grok it, or grok it and don't
> think it is useful.
> 

I had a look at the manpage. It seems to do more or less exactly what
the same command would do without the word "work" thrown in, so either
it's quite useless or you've failed to describe its usefulness in the
manpage.

"git atomic" seems nice though.

> So, perhaps it won't be included in git. That's fine, I can build my
> own fork of git which includes the proposed extension [ indeed, this
> is how I originally developed it]. That's fine for
> me, but it isn't the most practical way to distribute it to others
> since I'll have to produce distribution packages for a variety of
> different distribution formats or fallback to tars and zips.
> 

What you can do is let your Makefile (or some other install-script)
take the destination path for "make install" (or equivalent) from
the output of "git --exec-path".

That way, you can ship "git extadd" or whatever you want to call it
as a simple installer that installs executable and man-page in their
proper locations. If the commands you install require configuration
by default I'd say they're broken to begin with, but even that can
be remedied by running "git config --add key value" from the installer.

So in a way, git is already its own pkg-config binary and anyone
clever enough to write useful scripts that enhances git will almost
certainly see that and use it from their favourite language quite
without having to learn some new magic format for package management.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
