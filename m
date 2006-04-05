From: Sam Vilain <sam@vilain.net>
Subject: Re: n-heads and patch dependency chains
Date: Wed, 05 Apr 2006 19:31:10 +1200
Message-ID: <4433723E.1080705@vilain.net>
References: <4430D352.4010707@vilain.net>	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>	<4431B60E.3030008@vilain.net> <7vhd596ua0.fsf@assigned-by-dhcp.cox.net> <443364F5.2040504@vilain.net> <e0vqjk$5dr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 09:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR2U8-0003dv-Qp
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 09:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWDEHbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 03:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWDEHbW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 03:31:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:21138 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751142AbWDEHbV
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 03:31:21 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 2D7A764EF; Wed,  5 Apr 2006 19:31:18 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 067CF4D36;
	Wed,  5 Apr 2006 19:31:11 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e0vqjk$5dr$1@sea.gmane.org>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18422>

Jakub Narebski wrote:

>First, hydras or n-head was invented to avoid capping and recapping, and
>just advance it as a normal head (and to remember what are
>subprojects/patch dependency chains/whatever to choose).
>
>Second, we could generalize those extra commit references in commit
>structure (be they "bind", "prior" or "previous", or "depends-on") and have
>  
>

Note that these are all quite different types of references. "Bind"
implies an unmerged tree to be woven in on checkout, "prior and
"previous" a historical relationship, and "depends-on" the previous
commit that the change that this commit supplies was based on.

So, I think "parent" already means "depends-on" closely enough.

>commit/merge pluggable helper manage them. And merge strategy may make use
>of them.
>
>Third, would using *directory* with for a N-HEAD (containing all the
>subheads, subprojects, chains, branches, fibers, whatever) instead of an
>ordinary file for HEAD be a good idea? For hydra if we want it to be easily
>interweaved with ordinary commit I think we would also need the link for
>bottom, hydra shoulder, hydra tail i.e. common commit being starting point
>for all the chains, or subprojects (for subprojects it can be empty tree
>commit).
>  
>

This was similar to the original suggestion, of heads that have multiple
heads, or hydra. I think the basic rejection for this is that nothing is
then tracking the progression of the merged tree - unless you keep a
"cherry picked" tree for the combined work. And of course it is a
backwards incompatible change.

Sam.
