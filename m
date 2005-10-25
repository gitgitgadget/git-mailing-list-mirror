From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: latest stg/git commandline completions code
Date: Tue, 25 Oct 2005 19:05:26 +0200
Message-ID: <200510251905.27768.blaisorblade@yahoo.it>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac> <200510251753.20164.blaisorblade@yahoo.it> <b0943d9e0510250924g3f5d9281r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ben Clifford <benc@hawaga.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 19:03:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUSAx-0004NF-DK
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 19:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVJYRBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 13:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVJYRBY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 13:01:24 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:50010 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932209AbVJYRBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 13:01:24 -0400
Received: (qmail 62390 invoked from network); 25 Oct 2005 17:01:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=G5USB/0XOHBM3hZbauv7jaofmPIBmAtDFzBWbGSeKrCdEmq4/wsmEMJH+xfV12M5mi7SH93/Wjtazd2jaG23itrhX/X2jyKztYWKMPM3fifq4mN3aAiFzK3oX5AOs230Ir7jixX1YB1Qki9opzPOxOqJlMp0MsCjpr4zNZUJHrg=  ;
Received: from unknown (HELO ?151.97.230.22?) (blaisorblade@151.97.230.22 with login)
  by smtp005.mail.ukl.yahoo.com with SMTP; 25 Oct 2005 17:01:22 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.8.3
In-Reply-To: <b0943d9e0510250924g3f5d9281r@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10598>

On Tuesday 25 October 2005 18:24, Catalin Marinas wrote:
> On 25/10/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > The best idea seems to write a Python script sourcing the Stgit source
> > (stgit/main.py to get commands, and then loading each class and iterating
> > over the "options" module member).

> I can add a function in stgit/main.py which would list the options.
> The tla-completion generates a file listing a command with its option
> on every line:

>   push -a -all -n --number -t --to --reverse --undo -h --help
>   ...

> Since I don't know much about the bash completion, let me know of the
> format you'd prefer.
Ok, I'll look into that. Probably it'll be around "opts_push="-a --all -n 
--number...", i.e. this one works fine, through name indirection, i.e. you 
say "expand the var which name is given by this expr".

> > Btw, what do you think about speeding up completions by reimplementing
> > things like "stg applied" or "stg unapplied" via cat (as noted in the
> > comments at the beginning of the script)? Tab completions can easily
> > livelock a shell on a busy system, so it's worthy speeding the thing up.

> In general, it is better to use the stg commands but the repository
> structure won't probably change for a long time
Ok.
> and it's OK to 
> optimise (if the speed improvement is visible).
I believe it is, yes.
> Anyway, these 
> particular commands are pretty fast (they behave like cat) but there
> are others which are slower (usually the commands involving calls to
> the GIT tool).

They _would_ behave like cat, except that Python is slow enough. Half a second 
on a (almost) idle system means seconds and seconds on a busy system, and 
it's pretty frequent that when I don't wait enough for an op. to complete I 
get a traceback from the import statements, which haven't been completed. 

And let's leave Gentoo's emerge alone - I'd say imports can take up to a 
minute.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
