From: Federico Lucifredi <flucifredi@acm.org>
Subject: Re: Suggestion: "man git clone"
Date: Mon, 06 Jul 2009 00:11:18 -0400
Message-ID: <4A517966.1060401@acm.org>
References: <20090628023458.297703BC143@sarantium.pelham.vpn.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Colin Watson <cjwatson@debian.org>
X-From: git-owner@vger.kernel.org Mon Jul 06 06:11:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNfY8-0007vX-P3
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 06:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbZGFELS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 00:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbZGFELR
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 00:11:17 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:51104 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZGFELR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 00:11:17 -0400
Received: (qmail 26015 invoked from network); 6 Jul 2009 04:11:19 -0000
Received: from dsl092-066-189.bos1.dsl.speakeasy.net (HELO spaceman.local) (federico@[66.92.66.189])
          (envelope-sender <flucifredi@acm.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <cjwatson@debian.org>; 6 Jul 2009 04:11:19 -0000
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
In-Reply-To: <20090628023458.297703BC143@sarantium.pelham.vpn.ucam.org>
X-Enigmail-Version: 0.95.7
OpenPGP: url=http://keyserver.linux.it/pks/lookup?op=get&search=0xAEEBEC184A73884C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122772>

Colin Watson wrote:
> (Sorry I didn't see this until now. HPA only CCed the maintainer of one
> of the two man packages popular on Linux-based systems; I'm the other
> one. I happened to find this thread while searching for something else.)
> 

Really? Sorry, I thought I had added you. My bad.

> In article <48AE143C.8030704@acm.org>, Federico Lucifredi wrote:
>> Jeff King wrote:
>>> On Thu, Aug 21, 2008 at 08:07:56PM -0400, Federico Lucifredi wrote:
>>>> I am all for bass-ackwards compatibility, and I think the suggestion of  
>>>> going on "man foo bar" :
>>>>
>>>>  1) look for foo-bar; if success, terminate search
>>>>  2) look for foo
>>>>  3) look for bar
>>>>  ....
>>>>
>>>> may be acceptable - I don't see drawbacks at a first glance, and it would 
>>>> allow for groups of pages to be meaningful.
> 
> I think this is a sensible enough compromise, especially given an option
> to disable it. The code would be a little ugly, but *shrug* not that
> bad. The extra stat is cheap enough.
> 

Sounds good to me :)

> Using a plain 'git' section for this in order to provoke the
> happenstance of 'man git clone' working is definitely wrong as far as
> the manual page hierarchy goes; it means that things like searching for
> just user commands (section 1) that contain some term will fail. Putting
> them in section '1git' (i.e. section 1 with a git "extension") would be
> more in line with how manual pages are typically laid out, and at least
> with man-db would not require any configuration file changes. However, I
> think both of these are suboptimal. Section extensions are typically
> used for things like functions or modules in other programming
> languages, or sometimes for cases where file names would otherwise
> clash. I'm not much of a git user myself, but I don't get the impression
> that most git users think of 'git clone' as analogous to a 'clone'
> command in a hypothetical 'git' programming language; it's closer to an
> ordinary user command.
> 
> The only case where I've seen subcommands given their own unprefixed
> manual pages with only the section extension to tell them apart is
> OpenSSL, with pages like x509(1ssl). IME, this is very confusing and not
> a good example to follow: firstly, you can't trivially find a list of
> all the subcommands with something like 'apropos openssl-'; secondly,
> it's easy to miss that you're dealing with an openssl subcommand unless
> you keep your eyes peeled.
> 
> Short of some mechanism for git to provide a plug-in to man to tell it
> where to find subpages (eek! potential overengineering alert!), a
> foo-bar lookup seems tolerable enough.
> 
>>> Personally I have never ever wanted to see two manpages from one man
>>> invocation, so I have no real problem with that assumption.
>> I expected as much, and we should have an option to disable the "new" 
>> behavior as a safety anyway.
> 
> Would you like to suggest an option name for this, so that we can avoid
> unnecessary divergence? Perhaps something like --separate?

the option to trigger "classic" behavior? How about --no-subpages?

> 
>>>> Are you willing to put your patch where your mouth is? :-)
>>> I've never looked at man code before, but there seem to be at least two
>>> man packages for Linux. My boxes have man-db 2.5.2.
>> There are two man packages for linux, man and man-db, the latter being a 
>> 90's fork that uses Berkeley DB as a backend to speedup man -k searches 
>> (it helped back then).
> 
> (I hope git@ will excuse the digression.)
> 
> Don't be confused by the name. Once upon a time the main feature of
> man-db was indeed its database; these days that's almost one of the

[snip]

I am sorry Colin, I did not mean to say anything bad, just that there
are two packages, and as you said... there are differences but nothing
major.  I don't think we want to discuss "my package > yours" here
(although I can of course provide arguments for mine!).

Are you Git guys still interested in this? I actually have recently
worked on a project where we labeled man pages for subcommands with this
convention, so I would welcome the extension for neatness.

 Best -F

-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish
(Federico L. Lucifredi) - flucifredi@acm.org - GnuPG 0x4A73884C
