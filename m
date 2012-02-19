From: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
Subject: Re: git-svn won't remember pem password
Date: Sat, 18 Feb 2012 20:03:14 -0800 (PST)
Message-ID: <1329624193999-7298035.post@n2.nabble.com>
References: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com> <m3zkcgqt0g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 05:03:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryxzc-0000f6-FJ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 05:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab2BSEDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 23:03:15 -0500
Received: from sam.nabble.com ([216.139.236.26]:43159 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab2BSEDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 23:03:14 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <nikolaus@nikolaus-demmel.de>)
	id 1RyxzW-0003yM-0v
	for git@vger.kernel.org; Sat, 18 Feb 2012 20:03:14 -0800
In-Reply-To: <m3zkcgqt0g.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191015>


Jakub Narebski wrote
> 
> Igor &lt;mrigor83@&gt; writes:
> 
>> I'm running into an issue where I have to enter my pem certificate
>> password every time I git-svn fetch or git-svn dcommit. Vanilla svn
>> uses OS X KeyChain and remembers my password just fine. Is there a
>> known solution for this?
> 
> I don't know if it is svn that has to remember password, or git that
> has to remember password.  Git 1.7.9 learned "credentials API" that
> allows integration with platform native keychain mechanisms, and I
> think OS X Keychain is one of examples / supported platforms (but it
> might not made it into core git)... though I am not sure if it affects
> git-svn, or only HTTP(S) transport.
> 

Wow, I just signed up to the mainling list to post about this, but it turns
out the latest message is exactly what I wanted to ask.

Like Eric wrote, I'm pretty sure it is svn that is meant to store the
password here and the perl bindings or the git-svn part fails to deal with
the os x keychain right. With pure svn the keychain authentication works
just fine. If I set up plaintext password storage in the svn configs, then
git svn is also able to store passwords.

There is also this macports ticket [1] that has been around for a while. But
that can only be fixed by an upstream fix here.

I would love to help to get this working, but I'm not sure how I can.

Cheers,
Nikolaus


[1] https://trac.macports.org/ticket/28329


--
View this message in context: http://git.661346.n2.nabble.com/git-svn-won-t-remember-pem-password-tp7295962p7298035.html
Sent from the git mailing list archive at Nabble.com.
