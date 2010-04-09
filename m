From: Vitaly Berov <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Fri, 09 Apr 2010 10:50:44 +0400
Message-ID: <4BBECE44.4040608@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <alpine.LFD.2.00.1004061709360.7232@xanadu.home> <4BBC1ED3.6020008@gmail.com> <alpine.LFD.2.00.1004070842580.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 09 08:55:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O087U-0003Vc-UA
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 08:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab0DIGzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 02:55:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:44178 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674Ab0DIGzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 02:55:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O087L-0003TA-TA
	for git@vger.kernel.org; Fri, 09 Apr 2010 08:55:03 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 08:55:03 +0200
Received: from vitaly.berov by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 08:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 195.218.191.171
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004070842580.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144411>

Hi,

On 04/07/2010 04:55 PM, Nicolas Pitre wrote:
>
> I was asking that because that would have helped me (or any other Git
> developer) analyse the issue and provide a fix.
>
> OK then.  What happens if you do the following on the server machine
> where the repository is stored:
>
> 	git repack -a -f -d
>
> How long does this take?
>
> How long does the "Resolving deltas" take when cloning this repacked
> repository? (don't wait more than 10 minutes for it).
Nicolas, we haven't stopped the process as you recommended, sorry for that.

So, the results: it took 37 hours. 20 hours is compressing objects 
(delta compression using up to 4 threads), 17 hours is writing objects. 
Almost all of the time the bottleneck was a CPU.

Objects amount: 3997548.
Size of the repository: ~57Gb.

> If the "Resolving deltas" takes more than 10 minutes, could you capture
> a strace dump from that process during a minute or so and post it here?
I'll capture strace later.

> Hmmm. Is this on Linux or Windows?
Short spec: Ubuntu 9.04 (64 bit), Intel(R) Core(TM)2 Quad CPU Q8400 
2.66GHz, 8 GB of memory

By the way, we have a large amount of binary files in our rep.

Vitaly
