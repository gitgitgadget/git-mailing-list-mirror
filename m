From: Justin Frankel <justin@cockos.com>
Subject: Re: [PATCH 0/2] git-merge: ignore space support
Date: Mon, 23 Aug 2010 13:34:13 -0700
Organization: Cockos Incorporated
Message-ID: <4C72DB45.1080902@cockos.com>
References: <20100822054321.GA64856@ns1.cockos.com> <20100823193300.GA2120@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 22:42:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ondqh-00031r-9q
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 22:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab0HWUm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 16:42:26 -0400
Received: from ns1.cockos.com ([204.11.104.229]:51132 "EHLO ns1.blorp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab0HWUmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 16:42:25 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Aug 2010 16:42:25 EDT
Received: from localhost (localhost [127.0.0.1])
	by ns1.blorp.com (Postfix) with ESMTP id AA8531259C06;
	Mon, 23 Aug 2010 13:34:20 -0700 (PDT)
Received: from ns1.blorp.com ([127.0.0.1])
	by localhost (ns1.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sIBkSwtM36A7; Mon, 23 Aug 2010 13:34:13 -0700 (PDT)
Received: from [10.10.10.69] (poo.cockos.com [204.11.104.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ns1.blorp.com (Postfix) with ESMTPSA id C39A21259C07;
	Mon, 23 Aug 2010 13:34:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20100823193300.GA2120@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154256>

Jonathan Nieder wrote:
> (+cc: Eyvind Bernhardsen, resident scholar on LF/CRLF conflicts)
>
> Hi!
>
> Justin Frankel wrote:
>
>   
>> I've added  support for merging with ignoring line endings (specifically 
>> --ignore-space-at-eol) when using recursive merging.  I've added this as a 
>> strategy-option, so that you can do:
>>
>>    git merge --strategy-option=ignore-space-at-eol <branch>
>>
>> and
>>
>>    git rebase --strategy-option=ignore-space-at-eol <branch>
>>
>> The only option I needed was ignore-space-at-eol, however it made some sense (to 
>> me at least) to include the other xdiff options  (ignore-space-change, 
>> ignore-all-space, patient).
>>     
>
> Interesting.  The idea seems sane, provided it copes with edge cases
> well (haven't checked the code yet).
>
> I have even wished for a "merge -Xpatience" from time to time.
>
>   
I've mostly used it for dealing with a bunch of mixed-line-ending files 
(Xcode 3.1 has a nasty habit of converting all CRLFs to LFs, and VC6 
tends to just use CRLFs for inserted lines). For my tests it has worked 
very well. I'm not completely sure of the implications -- if you start 
merging code with various line endings, you probably end up with an 
annoying mix of them, forcing you to use -Xignore-space-at-eol for all 
future merges on those files.. So it is probably worth discouraging use 
of this, but is also a lifesaver if you have existing code that is messy.
>> Which branches should we derive from for things like this? The first patch is 
>> for master, the second for next (there were enough changes in ll-merge that 
>> the implementations are a bit different).
>>     
>
> See Documentation/SubmittingPatches, section labelled "Decide what to
> base your work on".
>
> Generally the rule is to develop features against "master", or on top
> of a relevant topic branch from "next" or "pu" if your implementation
> requires features from it (or if it is likely to create heavy
> conflicts).
>
> If the patches seem sane, is it all right if we forge your sign-off?  (See
> Documentation/SubmittingPatches for what this means.)
>
> Since the threading does not seem to have worked correctly, here are
> the patches, for reference.
>
> for master: http://thread.gmane.org/gmane.comp.version-control.git/154166
> for next: http://thread.gmane.org/gmane.comp.version-control.git/154167
>
>   
Thank you for pointing to me to this file (I had looked a bunch of 
places on the web but didn't think to look at the Documentation, shame 
on me). If you like I can clean up some stuff I did wrong (including the 
commit messages, as well as it appears some of my lines have indentation 
with spaces instead of tabs), and sign-off and resend.

Thank you again for the explanation and help, I very much appreciate 
your time.

-Justin
