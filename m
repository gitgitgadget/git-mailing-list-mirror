From: Jakub Narebski <jnareb@gmail.com>
Subject: The future of git-instaweb (was: Re: The future of gitweb (long term goals))
Date: Fri, 25 Feb 2011 23:37:23 +0100
Message-ID: <201102252337.28364.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201102212306.39084.jnareb@gmail.com> <4D64E75A.3050506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 23:37:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt6IG-0007P9-1u
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 23:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554Ab1BYWhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 17:37:42 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60949 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab1BYWhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 17:37:41 -0500
Received: by wyg36 with SMTP id 36so2078599wyg.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 14:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=9Q7Vw9ssHtIJMEReQmVA4xEyZVWaAKBO7IBIsKRwCOw=;
        b=oRaW1esi/LYjx4ITB5ZLGVjvJnW+GPX7s1U+3/9fek9YZPs54AFg/ZDXzRpMoep/c3
         WgaJmzE5B5TLOx8AdAy691S5wPBQUR7CumY0s/LiWLa5ClqQB3TvRO+T3y4xx9gYlFWk
         g7kh/D2VUJ5BebHEKBbfWxjTXcL8TVjKvL6yM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MhbBg1lGiSsre21rOC7Lb9nuYI4T68b3eZcg9nVnjLB0GUBb4+yP26aOST8Qa5BvxE
         tAgdeRAt9QJkNa39Vx6sdSO5La0rHOi1/ZCl/je993jzva2ilLrNNVkakfMPUhd1nvZo
         Z2im3+NXOmjHjFaR05Blv23i4bm92uFkf6iuY=
Received: by 10.216.5.65 with SMTP id 43mr2898394wek.9.1298673460261;
        Fri, 25 Feb 2011 14:37:40 -0800 (PST)
Received: from [192.168.1.13] (abwr26.neoplus.adsl.tpnet.pl [83.8.241.26])
        by mx.google.com with ESMTPS id t5sm583318wes.9.2011.02.25.14.37.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 14:37:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D64E75A.3050506@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167949>

On Wed, 23 Feb 2011, Michael J Gruber wrote:
> Jakub Narebski venit, vidit, dixit 21.02.2011 23:06:
>> On Tue, 15 Feb 2011, Michael J Gruber wrote:
>>> Jakub Narebski venit, vidit, dixit 14.02.2011 20:39:
>> 
>>>> Now that we are talking about future of git, including breaking some
>>>> of backwards compatibility bugs / misdesigns for 1.8.0, perhaps it is
>>>> the time to discuss long term goals and the future of gitweb.
>>> ...
>>>> Current requirements are:
[...]
>>>> - easy installation even without admin rights
>>>> - scanning for repositories (as an option)
>>>> - lightweight
>>>
>>> All of these are important for instaweb also. 
>> 
>> Nowadays git-instaweb uses _installed_ gitweb, so neither easy 
>> installation, nor installing / running without admin rights is necessary
>> for use of gitweb in git-instaweb.  Strictly speaking neither is scanning
>> for repositories; I think git-isnatweb could generate file with list of
>> repositories (with repository) to show.
> 
> Cool, I didn't know, but it's a great feature.
> By "easy installation" I mean being able to use it without having to
> configure a "central" web server, i.e. just the way a git+gitweb in
> $HOME can run instaweb without admin rights.

Yes, the idea of git-instaweb is to be able to run browser with gitweb
showing current repository, which means running some kind of web server.
Selected web server is run in "user mode", with config file generated
by git-instaweb, and with port number > 1024 (so non-root can open it).
Web server can be installed system-wide by administrator (for example
apache or lighttpd), or installed locally (for example plackup with
local::lib).

>>> I consider instaweb a very
>>> underrated feature! (It also needs some works of love, not just
>>> appreciation, of course.)
>> 
>> Beside adding support for new web servers (like recently added 'plackup'),
>> what do you thing needs to be done?
> 
> E.g., using an installed gitweb - I just learned it does that already!

This (git-isnatweb using installed gitweb) has its advantages and
disadvantages.

Pro:
~~~~
The main reason behind changing git-instaweb so it uses installed gitweb
(after 'install-gitweb' target was added to git Makefile, of course) in 
c0cb4ed (git-instaweb: Configure it to work with new gitweb structure, 
2010-05-28) was to be able to use git-instaweb with split gitweb.  This
commit by Pavan Kumar Sunkara was part of ultimately failed Google Summer
of Code 2010 project that was meant to add ability to edit repositories
to gitweb, of which first part was splitting gitweb into modules (packages)
for better maintability.

Second reason was to avoid duplication of disk space: generated
git-instaweb script included the whole gitweb.cgi script, and some of its
static files like e.g. gitweb.css.

Contra:
~~~~~~~
This change means that git-instaweb requires gitweb to be installed to work.
(Of course gitweb can be installed locally, and you can configure 
git-instaweb to use specified version of gitweb / specified gitweb script.)

There is also issue of packaging and dependencies: e.g. should git-instaweb
be a part of gitweb RPM package?

> Also, the graph viewer, i.e. including it as a module with the same
> "looks" as the rest of gitweb.

Errr, I think this is to be gitweb feature, rather than git-instaweb
feature.  Don't you agree?

> I don't know how customisable gitweb's layout is right now (CSS). That
> might be important for some.

You can change CSS, you can add additional CSS files (e.g. change default
font size) quite easily.

> [...]                        Personally, whenever I'm on the more 
> "modern" repo hosters, I'm longing for the clean interface and high
> information density of gitweb.

OTOH high information density (and lots of hyperlinks) make for steeper
learning curves, while adding power.

>>>> 1. Splitting gitweb into modules (packages), for better maintainability.
>>>
>>> Also, this may help including other optional parts. The graph viewer as
>>> used on repo.or.cz sets gitweb apart from quite a few alternatives and
>>> would be used more widely if it were an optional module shipping with
>>> gitweb. Just imagine instaweb with graphs ;)
>>> Also, being part of gitweb, the viewer may attract a few coders.
>> 
>> Well, adding anything major (like e.g. write functionality, output caching;
>> perhaps graph of history is also in this category) really require split
>> gitweb.  It is getting hard to maintain gitweb as it is now.
> 
> 100% agreed. Also, smaller modules make it easier for new gitweb
> contributors to join and help.

Right.

-- 
Jakub Narebski
Poland
