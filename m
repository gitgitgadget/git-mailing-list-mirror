From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: Re: Test 17 of `t9119-git-svn-info.sh' fails with svn 1.6.9
Date: Thu, 01 Jul 2010 12:36:02 +0200
Message-ID: <87lj9vebfx.fsf@ft.bewatermyfriend.org>
References: <8739w3fupp.fsf@ft.bewatermyfriend.org>
	<4C2C5D2F.90000@drmicha.warpmail.net>
	<87y6dveekn.fsf@ft.bewatermyfriend.org>
	<4C2C647F.7090909@drmicha.warpmail.net>
	<87pqz7ec79.fsf@ft.bewatermyfriend.org>
	<4C2C6D64.4060802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 01 12:36:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUH8b-0002xP-Va
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 12:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab0GAKgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 06:36:51 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:55994 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab0GAKgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 06:36:50 -0400
Received: from [212.117.84.72] (helo=bones.voodoo.lan)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1OUH8O-0006Ur-5k; Thu, 01 Jul 2010 12:36:44 +0200
Received: by bones.voodoo.lan (Postfix, from userid 1000)
	id 1CB9317EED; Thu,  1 Jul 2010 12:36:02 +0200 (CEST)
In-Reply-To: <4C2C6D64.4060802@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 01 Jul 2010 12:26:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150028>

Michael J Gruber wrote:
> Frank Terbeck venit, vidit, dixit 01.07.2010 12:19:
>> Michael J Gruber wrote:
[...]
>>> Do the following agree for you:
>>>
>>> git svn --version
>>> svn --version
>>>
>>> Do you have any private copies of svn/svn bindings in your path or perl
>>> path?
>> 
>> Okay, it wasn't really a private copy, but you're otherwise
>> spot-on. Here's what was wrong:
>
> Turns out you cc'ed the right persons :)

Heh, seems so. :)

>> I didn't realise, `git-svn' was using Perl's subversion bindings. This
>> happens on my laptop which runs debian stable (lenny). I was upgrading
>> my subversion package to the one provided by backports.org (a service
>> that provides backports of newer versions of certain software packages
>> to debian stable). While that worked nicely, the subversion bindings for
>> Perl are provided by a package called `libsvn-perl' which was kept at
>> the version in stable, which is 1.5.1. Backports.org also provides an
>> upgrade for that package. Now both "svn --version" and "git svn
>> --version" report the same subversion version and the test passes again.
>> 
>> 
>> Maybe it would be good if git-svn or maybe just the test suite checked
>> whether subversion's and the Perl binding's version matched?
>
> Then you would not be able to use git-svn with your setup!

Well, now it would. :)
But I get your point.

> Having svn and its bindings at different versions is perfectly fine for
> git-svn: it uses and cares about the bindings only (and adjusts
> according to the binding's version).

Okay.

> It's only the test suite which cares, because it tries to make sure that
> "svn" and "git-svn" behave as similar as possible.
>
> We should probably check in the test suite before triggering false
> alarms, I'll look into that.

Cool thanks.

And thank you for the quick response and solution.

Regards, Frank
