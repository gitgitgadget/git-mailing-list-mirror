From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: restriction of pulls
Date: Mon, 12 Feb 2007 16:29:39 +0200
Message-ID: <45D079D3.2020500@dawes.za.net>
References: <200702091149.12462.duelli@melosgmbh.de> <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45CC941E.9030808@dawes.za.net> <Pine.LNX.4.63.0702101533060.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45D07296.7070804@dawes.za.net> <Pine.LNX.4.63.0702121508360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christoph Duelli <duelli@melosgmbh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 15:31:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGcCz-0006aC-0m
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 15:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbXBLOam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 09:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbXBLOam
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 09:30:42 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:43686 "EHLO
	spunkymail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964940AbXBLOal (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Feb 2007 09:30:41 -0500
Received: from [192.168.201.100] (dsl-146-24-208.telkomadsl.co.za [165.146.24.208])
	by spunkymail-a10.g.dreamhost.com (Postfix) with ESMTP id 06C821632F4;
	Mon, 12 Feb 2007 06:29:49 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <Pine.LNX.4.63.0702121508360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39405>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 12 Feb 2007, Rogan Dawes wrote:
> 
>> Johannes Schindelin wrote:
>>> (my favourite:)
>>> - use git-split to create a new branch, which only contains doc/. Do work
>>> only on that branch, and merge into mainline from time to time.
>> Your third option sounds quite clever, apart from the problem of attributing a
>> commit and a commit message to someone, when the actual commit doesn't match
>> what they actually did :-(
> 
> This problem is not related to subprojects at all. If the commit message 
> does not match the patch, you are always fscked.

Well, I was thinking about the fact that the files originally checked in 
will not match the files "checked in" in the rewritten commit.

>> As well as wondering what happens when they check out a few more files. Do we
>> rewrite those commits as well? What happens if the user has made some commits
>> already? What happens if they have already sent those upstream? etc.
> 
> I think you misunderstood. My favourite option would make docs a 
> _separate_ project, with its own history. It just happens to be pulled 
> from time to time, just like git-gui, gitk and git-fast-import in git.git.

I see. However, that does not allow for the random single-file checkout 
scenario I sketched out. Which may or may not be common/desirable, but 
it is an extreme case of the partial checkout, without fixed delineation.

>> I think the best solution is ultimately to make git able to cope with 
>> certain missing objects.
> 
> Hmm. I am not convinced. On nice thing about git is its level of 
> integrity. Which means that no random objects are missing.

Good point. :-(

>> I started writing this in response to another message, but it will do fine
>> here, too:
>>
>> The description I give here will likely horrify people in terms of
>> communications inefficiency, but I'm sure that can be improved.
>>
>> [goes on... and describes the lazy clone!]
 >
> AFAICT this really is the lazy clone. And it was already determined that 
> it is all to easy to pull in all commit objects by accident. Which boils 
> down to a substantial chunk of the repository.
>

Not so much a lazy clone as a partial clone. It is only in the "clone", 
"fetch" or "checkout" code paths that new objects will be retrieved from 
the source repo. Things like "git log"/"git show" would not do so, and 
would be required to handle missing objects gracefully.

> But if you want to play with it: by all means, go ahead. It might just be 
> that you overcome the fundamental difficulties, and we get something nice 
> out of it.
> 
> Ciao,
> Dscho
> 

Maybe ;-) We'll see if I get any time for it.

Rogan
