From: Tupshin Harper <tupshin@tupshin.com>
Subject: Re: Darcs and git: plan of action
Date: Tue, 19 Apr 2005 16:38:32 -0700
Message-ID: <42659678.9090605@tupshin.com>
References: <20050418210436.23935.qmail@science.horizon.com>	
	<1113869248.23938.94.camel@orca.madrabbit.org>	
	<42645969.2090609@qualitycode.com>	
	<1113874931.23938.111.camel@orca.madrabbit.org>	
	<4264677A.9090003@qualitycode.com>	
	<1113950442.29444.31.camel@orca.madrabbit.org>	
	<42658D95.7020404@tupshin.com>
	<1113952916.29444.60.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kevin Smith <yarcs@qualitycode.com>, git@vger.kernel.org,
	darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Wed Apr 20 01:35:12 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO2FC-0004Tl-A9
	for gcvdd-darcs-devel@m.gmane.org; Wed, 20 Apr 2005 01:35:02 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DO2Im-0005Ge-5u; Tue, 19 Apr 2005 19:38:44 -0400
Received: from adsl-69-233-54-142.dsl.pltn13.pacbell.net ([69.233.54.142]
	helo=bastard.smallmerchant.com)
	by abridgegame.org with esmtp (Exim 4.50) id 1DO2Ij-0005GY-8L
	for darcs-devel@darcs.net; Tue, 19 Apr 2005 19:38:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by bastard.smallmerchant.com (Postfix) with ESMTP id C87C53A016C;
	Tue, 19 Apr 2005 16:44:00 -0700 (PDT)
Received: from bastard.smallmerchant.com ([127.0.0.1])
	by localhost (mail.smallmerchant.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 26408-01-2; Tue, 19 Apr 2005 16:43:51 -0700 (PDT)
Received: from [172.16.1.197] (unknown [172.16.1.197])
	by bastard.smallmerchant.com (Postfix) with ESMTP id 9C5E73A0161;
	Tue, 19 Apr 2005 16:43:51 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Ray Lee <ray-lk@madrabbit.org>
In-Reply-To: <1113952916.29444.60.camel@orca.madrabbit.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at smallmerchant.com
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

Ray Lee wrote:

>it allows regular expressions for the match and replace, which means
>multiple unique tokens could change atomically. (Does anyone actually
>*use* regexes? Sounds like a cannon that'd be hard to aim.)
>  
>
Yes, and replace patches need to be used very carefully.

>Regardless, I only care about code, not free text. If it's in a language
>that doesn't do some use-'em-as-you-need-'em duck typing spiel
>(<cough>python</cough), then the context of your patch (namely, the
>file) already has those tokens somewhere in them. And I bet that if
>*you* looked at that file, you could tell if it was a replace or a mere
>textual diff. Am I wrong?
>  
>
Yes. See my hello world example from my last email.

>
>Unless I'm missing something, the darcs replace patch can already do the
>wrong thing. 
>
Yes, depending on how you define wrong. Darcs replace is fully 
predictable, and poorly chosen replaces can lead to incorrect results 
after future patches are applied.

>If I do a replace patch on a variable introduced in a local
>tree, then do a darcs replace on it before committing it to a shared
>repository, and coder B introduces a variable of the same original name
>in my copy, then there's a chance that the replace patch will
>incorrectly apply upon his newly introduced variable. No?
>  
>
Absolutely correct, and the exact reason why replace patches need to be 
used *very* selectively.

>  
>
>>It's provable that you can not.
>>    
>>
>
>I'm still not seeing the problem, at least when it comes to ANSI C.
>
>Ray
>  
>
See hello world example in my other email. You can argue that it is an 
existing problem in darcs, but really, it just points out the fact that 
a computer is *incapable* of knowing whether it is safe to use a replace 
patch based on a diff because replace patches are dangerous if not used 
intelligently.

-Tupshin
