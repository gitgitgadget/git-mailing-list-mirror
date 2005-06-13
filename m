From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [Revctrl] colliding md5 hashes of human-meaningful
Date: Mon, 13 Jun 2005 22:52:02 +0200
Message-ID: <42ADF1F2.1070008@gorzow.mm.pl>
References: <20050613195038.9191.qmail@science.horizon.com> (6eb06e09aa229a99680b3c9e55710050f05d13fe)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Jun 13 22:49:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dhvqp-00052D-PI
	for gcvg-git@gmane.org; Mon, 13 Jun 2005 22:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFMUwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 16:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFMUwl
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 16:52:41 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:58781 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261342AbVFMUwQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2005 16:52:16 -0400
Received: (qmail 28321 invoked from network); 13 Jun 2005 20:52:08 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <linux@horizon.com>; 13 Jun 2005 20:52:08 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 1F82D5F5868;
	Mon, 13 Jun 2005 22:52:03 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: linux@horizon.com
In-Reply-To: <20050613195038.9191.qmail@science.horizon.com> (6eb06e09aa229a99680b3c9e55710050f05d13fe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

linux@horizon.com wrote:

>>So the problem is totally different from the way git uses a hash. In the 
>>git model, an attacker by definition cannot control both versions of a 
>>file, since if he controls just _one_ version, he doesn't need to do the 
>>attack in the first place!
>>    
>>
>
>You are insufficiently paranoid, Grasshopper.
>
>The basic attack goes like this:
>
>- I construct two .c files with identical hashes.  One is something
>  useful; perhaps a device driver for some piece of hardware that my
>  desired target has.  The other is similar, but includes a remote
>  root explot.
>
>  (With an n-bit hash and an automated way to make harmless changes
>  to source files, I can generate 2^(n/2) variants of each and expect to
>  get a match, even in the absence of a better attack.)
>
>  
>
And you get lots of nonsense in the new file.

>- I submit the first one to the Linux kernel.  It's valid and gets
>  merged.
>
>  
>
And funny as it is, when the hole is found you're busted. Or at least
the first person responsible.
You probably couldn't shadow yourself enough not to get caught.

>- A kernel release, including the "interesting" driver, gets made and
>  sprinkled with holy penguin pee.  Signatures, hashes, and all that.
>
>  
>
Which mean that you can't change your name on the project. See above.

>- Through various means (possibly just running a kernel download mirror,
>  or possibly by splicing into my target's upstream Internet connection),
>  I substitute the malware file for the real source code.
>
>  
>
If you can splice into the connection, you can put there anything you want,
including another kernel and any amount of exploits. Even with SSH.
Ever heard of man-in-the-middle attacks?

With high-grade security you won't be able to splice into the connection,
as it'll be fully encrypted (with HTH key exchange) and/or randomised using things like EFF's Tor.
Then they can check with kernel.org or any other mirror.

>- My target verifies all the hashes and signatures, decides that this "Linus"
>  person signing it is trustworthy, and compiles and installs the kernel.
>  
>
And they're so unforseeing that they don't check the sources of the
drivers they use.
Funny. And if they don't use it, you'll have a problem with enabling
your exploit.
Your best target would be a scheduler, but that's heavily scrutinised.

>- I walk in my back door and do suitable rude things.
>
>  
>
Like going to jail.

>The point is, it *is* possible for an attacker to control both versions of
>a file.  The reason he needs to do the attack is that one version looks
>legitimate and the other includes a Nasty Surprise.
>  
>
It is in theory. Tell someone when you mount such an attack on anybody.

AstralStorm
