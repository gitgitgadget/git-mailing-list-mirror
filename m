From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: The future of gitweb (long term goals)
Date: Wed, 23 Feb 2011 11:54:18 +0100
Message-ID: <4D64E75A.3050506@drmicha.warpmail.net>
References: <201102142039.59416.jnareb@gmail.com> <4D5A42B2.3090603@drmicha.warpmail.net> <201102212306.39084.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 11:57:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsCPf-0003nS-1W
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 11:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab1BWK5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 05:57:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59705 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753755Ab1BWK5g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 05:57:36 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DC76C20BB3;
	Wed, 23 Feb 2011 05:57:33 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 23 Feb 2011 05:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4yw+SEcEVc3Y5f6usP/KZjFT2w4=; b=rtKPgwdwpgLf50c73QoVRh9vSpF7A74Ahg5FaTcSVm990qWm7rx7NToc5IOGRNzDxaHjMwnapOBrOv8FB0nA+sbYAasxQG3e+4kxAaYOarsJu53tyE8YAlwinYzABv32XuZjZ7/pc3W0gx+Fs0WYXL5tZdhZMVvNXOboTQqC1tY=
X-Sasl-enc: kjM9ewayzRKBEiHQw2ySX8QsVzoZnfU9HWyQvUFIeig1 1298458653
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4B9DB401100;
	Wed, 23 Feb 2011 05:57:33 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <201102212306.39084.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167686>

Jakub Narebski venit, vidit, dixit 21.02.2011 23:06:
> On Tue, 15 Feb 2011, Michael J Gruber wrote:
>> Jakub Narebski venit, vidit, dixit 14.02.2011 20:39:
> 
>>> Now that we are talking about future of git, including breaking some
>>> of backwards compatibility bugs / misdesigns for 1.8.0, perhaps it is
>>> the time to discuss long term goals and the future of gitweb.
>> ...
>>> Current requirements are:
>>> - Perl 5.8.x (for proper Unicode / UTF-8 support)
>>> - core Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename,...
>>> - non-core Perl modules optional, needed for some of extra features
>>> - backward compatibility (query params and path_info URLs)
>>
>> I'd second that this is important for adaption by some main users.
> 
> You mean here backward compatibility of API (i.e. old links keep working),
> isn't it?

Yep, the last item.

> 
>>> - easy installation even without admin rights
>>> - scanning for repositories (as an option)
>>> - lightweight
>>
>> All of these are important for instaweb also. 
> 
> Nowadays git-instaweb uses _installed_ gitweb, so neither easy 
> installation, nor installing / running without admin rights is necessary
> for use of gitweb in git-instaweb.  Strictly speaking neither is scanning
> for repositories; I think git-isnatweb could generate file with list of
> repositories (with repository) to show.

Cool, I didn't know, but it's a great feature.
By "easy installation" I mean being able to use it without having to
configure a "central" web server, i.e. just the way a git+gitweb in
$HOME can run instaweb without admin rights.

>> I consider instaweb a very
>> underrated feature! (It also needs some works of love, not just
>> appreciation, of course.)
> 
> Beside adding support for new web servers (like recently added 'plackup'),
> what do you thing needs to be done?

E.g., using an installed gitweb - I just learned it does that already!

Also, the graph viewer, i.e. including it as a module with the same
"looks" as the rest of gitweb.

I don't know how customisable gitweb's layout is right now (CSS). That
might be important for some. Personally, whenever I'm on the more
"modern" repo hosters, I'm longing for the clean interface and high
information density of gitweb.

>>> 1. Splitting gitweb into modules (packages), for better maintainability.
>>
>> Also, this may help including other optional parts. The graph viewer as
>> used on repo.or.cz sets gitweb apart from quite a few alternatives and
>> would be used more widely if it were an optional module shipping with
>> gitweb. Just imagine instaweb with graphs ;)
>> Also, being part of gitweb, the viewer may attract a few coders.
> 
> Well, adding anything major (like e.g. write functionality, output caching;
> perhaps graph of history is also in this category) really require split
> gitweb.  It is getting hard to maintain gitweb as it is now.

100% agreed. Also, smaller modules make it easier for new gitweb
contributors to join and help.

Cheers,
Michael
