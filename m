From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 10:24:14 -0700
Message-ID: <4DCC17BE.7000005@kernel.org>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu> <20110512105325.GA13490@elie> <201105121701.26547.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 19:26:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKZek-0002xW-G2
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 19:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179Ab1ELR03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 13:26:29 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:52156 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758127Ab1ELR03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 13:26:29 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p4CHOEkB002206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 12 May 2011 10:24:14 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <201105121701.26547.jnareb@gmail.com>
X-Enigmail-Version: 1.1.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Thu, 12 May 2011 10:24:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173487>

On 05/12/2011 08:01 AM, Jakub Narebski wrote:
> On Thu, 12 May 2011, Jonathan Nieder wrote:
>> Drew Northup wrote:
>>
>>> This is a work in progress. Much of what is in it has been pulled
>>> directly from the README and INSTALL files of gitweb. No effort has yet
>>> been made to de-duplicate any of this.
> 
> While it might be a good idea to split main part of gitweb/README into
> gitweb.conf.txt (documenting configuration), and perhaps also separate
> gitweb.txt (main page for gitweb, like SVN::Web manpage), I don't think
> that much of gitweb/INSTALL should be moved.

I would agree with this, if you are shooting for a config file
man/txt/html page INSTALL has nothing to do with it, and serves a
different purpose.

>>> TODO:
>>>   * Clean up README and INSTALL files
>>>   * Add Makefile rules to build man / HTML pages.
>>>   * Remove or rephrase redundant portions of original documentation
>>>   * A lot more...
>>
>> I agree with this TODO list. :)  It should be possible to reuse rules from
>> Documentation/Makefile if you put this under Documentation/.  gitweb already
>> keeps its tests under t/ for convenience; I think it's okay if it
>> puts some documentation under Documentation/.
> 
> Note that git-gui and gitk both also keep their manpages in Documentation/
> as Documentation/git-gui.txt and Documentation/gitk.txt
> 
> We can add "doc" target to gitweb/Makefile, which would delegate work to
> ../Documentation/Makefile, similarly to existing "test" target in
> gitweb/Makefile.

I disagree slightly, I'd personally rather try and keep gitweb more
self-contained under gitweb/.  I can see the advantage of keeping the
docs under Documentation/ but I can also appreciate keeping gitweb self
contained, like it is currently.

>>> +
>>> +SYNOPSIS
>>> +--------
>>> +/etc/gitweb.conf
> 
> I'd say
> 
>     +SYNOPSIS
>     +--------
>     +gitweb_conf.perl
>     +/etc/gitweb.conf
> 
> or
> 
>     +SYNOPSIS
>     +--------
>     +$GITWEBDIR/gitweb_conf.perl
>     +/etc/gitweb.conf

I'd prefer the later, I don't know of many people who actually use
/etc/gitweb.conf, and I'd rather see this be a more generic man page
than steering someone who's implementing this to only trying to use
/etc/gitweb.conf

>> gitweb will also look for gitweb_config.perl along @INC, and
>> the $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM envvars can override
>> these paths.
> 
> I think that we don't need to describe envvars in synopsis, but we
> should have per-gitweb configuration file (gitweb_conf.perl) in
> "Synopsis" section.

That sounds more like an INSTALL thing.

[...]

Beyond that I've no real issue that haven't already been brought up, but
I do want to make sure that the ultimate plan here is to add the scripts
that generate this vs. the final output, right?  I mean we already have
2 places this documentation lives (in gitweb.perl and README), I'm not
sure we need a 3rd place to update the documentation at by hand.  Just
asking.

- John 'Warthog9' Hawley
