From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 19:08:49 +0100
Message-ID: <dbfc82860701171008r65006b60vf81df9f82ab25712@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200701161514.47908.jnareb@gmail.com>
	 <dbfc82860701161417r650bc47fva92fa940b4e2cfc0@mail.gmail.com>
	 <Pine.LNX.4.63.0701162337330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 19:08:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7FDR-0004wi-Dc
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 19:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbXAQSIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 13:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbXAQSIv
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 13:08:51 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:27064 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbXAQSIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 13:08:50 -0500
Received: by an-out-0708.google.com with SMTP id b33so1283723ana
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 10:08:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=G+EHyRdWAQaG5ISuDcUpTnkSo9r3pHS3CPB+aamkoHFoeeD7fekANVwqUiz+0pox95oyild+znogzG7PlMKY0zM2au1vjcUruUQdaK1qfbWYafn92vs4FpUdUM0CdM7cX744OmVQvCjYF6m57xRu0KP+4iiZ8PaMYkLZGYz4OIc=
Received: by 10.100.7.18 with SMTP id 18mr3684827ang.1169057330230;
        Wed, 17 Jan 2007 10:08:50 -0800 (PST)
Received: by 10.70.111.12 with HTTP; Wed, 17 Jan 2007 10:08:49 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701162337330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 661ab2b37dcb8aea
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37023>

On 1/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> On Tue, 16 Jan 2007, Nikolai Weibull wrote:
>
> > And, as Johannes already pointed out, it's very disturbing having to
> > dump a configuration file so that it is more easily read by other
> > programs.
>
> I never pointed out such a thing. The configuration file is meant to be
> user-friendly, as the inventor did not mean to have a program like
> git-repo-config.

Then what did you mean in your mail from Jan 16, 2007 12:12 PM:

  How silly would that be: we parse an easy-to-read format,
  munge the easy-to-handle internal data format into another "easy-to-read"
  format which is then parsed by a script language into an easy-to-handle
  internal data format? No. NO.

?

> > That would suggest that the ini-based format for git's configuration
> > file is suboptimal.

> Not at all. Again, git's configuration file is meant for human inspection.
> Therefore, an ini-style file is optimal.

It is suboptimal because it's hard for computers to inspect.  An
optimal format would be accessible by all, whether human, machine,
robot, android, what have you.

I really don't like that people take my statements and somehow contort
them into meaning something else.  You can't take my statement and
then claim that because git's configuration file was meant for human
inspection my /suggestion/ about it being suboptimal is somehow flawed
because I didn't consider the original intent of the file in question.

Agreed, ini-style files are sweet for humans, but that's not what I
was saying.  My claim was that ini-style files aren't necessarily
optimal for parsing by computers.  I think that was made clear.  Also,
I only /suggested/ that it may be /suboptimal/ not that it in fact
/is/ suboptimal.

> And for scripts, we do have git-repo-config. But now some people want to
> be clever and read the whole config file in, to make it easier to have
> gazillions of configuration options for their script.

I maintain the git completion-definition for Zsh.  Being able to get
at the configuration settings is important, both for the completion of
git-repo-config, but also to provide completions of remote
repositories.  'git-repo-config -l' works fine, but it's not
guaranteed to be unambiguous, as the name of a remote repository can
contain characters like '=', so it can be difficult to decide where to
split the name of the remote repository from the url it represents as
the url can also contain '='.

> I was not happy when we introduced more relaxed section titles, and I am
> not happy now that I see what problems we introduced with that.

I'm with you on this one.

  nikolai
