From: Tupshin Harper <tupshin@tupshin.com>
Subject: Re: Darcs and git: plan of action
Date: Tue, 19 Apr 2005 16:00:37 -0700
Message-ID: <42658D95.7020404@tupshin.com>
References: <20050418210436.23935.qmail@science.horizon.com>	
	<1113869248.23938.94.camel@orca.madrabbit.org>	
	<42645969.2090609@qualitycode.com>	
	<1113874931.23938.111.camel@orca.madrabbit.org>	
	<4264677A.9090003@qualitycode.com>
	<1113950442.29444.31.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Smith <yarcs@qualitycode.com>,
	darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Wed Apr 20 00:57:41 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1eu-0000SP-M3
	for gcvdd-darcs-devel@m.gmane.org; Wed, 20 Apr 2005 00:57:33 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DO1iZ-0007pG-ET; Tue, 19 Apr 2005 19:01:19 -0400
Received: from adsl-69-233-54-142.dsl.pltn13.pacbell.net ([69.233.54.142]
	helo=bastard.smallmerchant.com)
	by abridgegame.org with esmtp (Exim 4.50) id 1DO1iU-0007bB-TH
	for darcs-devel@darcs.net; Tue, 19 Apr 2005 19:01:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by bastard.smallmerchant.com (Postfix) with ESMTP id 6546C3A016C;
	Tue, 19 Apr 2005 16:06:14 -0700 (PDT)
Received: from bastard.smallmerchant.com ([127.0.0.1])
	by localhost (mail.smallmerchant.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 26077-02-2; Tue, 19 Apr 2005 16:05:56 -0700 (PDT)
Received: from [172.16.1.197] (unknown [172.16.1.197])
	by bastard.smallmerchant.com (Postfix) with ESMTP id F40653A0161;
	Tue, 19 Apr 2005 16:05:55 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Ray Lee <ray-lk@madrabbit.org>
In-Reply-To: <1113950442.29444.31.camel@orca.madrabbit.org>
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

>Here's where we disagree. If you checkpoint your tree before the
>replace, and immediately after, the only differences in the
>source-controlled files would be due to the replace.
>
This is assuming that you only have one replace and no other operations 
recorded in the patch. If you have multiple replaces or a replace and a 
traditional diff  recorded in the same patch, then this is not true.

> And since the
>language of the file is known (and thereby the tokenization -- it *is*
>well-defined), then a tokenizer that compares the before and after trees
>(for just the files that changed, obviously), can discover what you did,
>and promote the mere ASCII diff into a token-replace diff. (The same
>sort of idea could be done for reindention, I'd hope.)
>  
>
See above for one set of limitations on this. A more fundamental problem 
comes back to intent. If I have a file "foo" before:
a1
a2
and after:
b1
b2
is that a "replace [_a-zA-Z0-9] a b foo" patch, or is that a
-a1
-a2
+b1
+b2
patch? Note that this comes down to heuristics, and no matter what you 
use, you will be wrong sometimes,  *and* the choice that is made can 
substantively affect the contents of the repository after additional 
patches are applied.

>We agree on everything except that it's provable that one can discover a
>replace operation, given a before and after tree.
>  
>
It's provable that you can not.

-Tupshin
