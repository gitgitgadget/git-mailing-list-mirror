From: Karl Brand <k.brand@erasmusmc.nl>
Subject: Re: How to avoid the ^M induced by Meld and Git
Date: Wed, 12 Dec 2012 17:17:24 +0100
Message-ID: <50C8AE14.4000704@erasmusmc.nl>
References: <50C72821.10908@erasmusmc.nl> <50C89B68.8090309@drmicha.warpmail.net> <50C8A403.9050304@erasmusmc.nl> <50C8AC0A.1010306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 17:17:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tip0A-0003fU-E8
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 17:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab2LLQR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 11:17:28 -0500
Received: from rbox3.erasmusmc.nl ([156.83.10.13]:25241 "EHLO
	rbox3.erasmusmc.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab2LLQR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 11:17:27 -0500
Received: from rbox3.erasmusmc.nl (localhost.erasmusmc.nl [127.0.0.1])
	by rbox3.erasmusmc.nl (Postfix) with ESMTP id 88B706D40F0;
	Wed, 12 Dec 2012 17:17:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at erasmusmc.nl
Received: from rbox3.erasmusmc.nl ([127.0.0.1])
	by rbox3.erasmusmc.nl (rbox3.erasmusmc.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id d30HvZevQSf4; Wed, 12 Dec 2012 17:17:25 +0100 (CET)
Received: from [10.92.2.214] (4jh5p4j.erasmusmc.nl [10.92.2.214])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: 117730)
	by rbox3.erasmusmc.nl (Postfix) with ESMTPSA id 350596D40DE;
	Wed, 12 Dec 2012 17:17:25 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50C8AC0A.1010306@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211364>



On 12/12/12 17:08, Michael J Gruber wrote:
> Karl Brand venit, vidit, dixit 12.12.2012 16:34:
>>
>>
>> On 12/12/12 15:57, Michael J Gruber wrote:
>>> Karl Brand venit, vidit, dixit 11.12.2012 13:33:
>>>> Esteemed Git users,
>>>>
>>>> What i do:
>>>>
>>>> 1. Create a script.r using Emacs/ESS.
>>>> 2. Make some modifications to script.r with the nice diff gui, Meld
>>>> 3. Commit these modifications using git commit -am "my message"
>>>> 4. Reopen script.r in Emacs/ESS to continue working.
>>>>
>>>> The lines added (&/edited ?) using Meld all end with ^M which i
>>>> certainly don't want. Lines not added/edited with Meld do NOT end with ^M.
>>>
>>> What happens if you leave out step 3? If the same happens then Meld is
>>> the culprit. (Unless you've set some special options, git does not
>>> modify your file on commit, so this can't be git related.)
>>>
>>
>> Leaving out step 3. results in exactly the same thing. Thus Git doesn't
>> appear to be responsible for the ^M's. Thanks a lot for your effort on
>> this and my apologies for not taking the care to dissect this more
>> carefully as you suggested. Over to the Meld mailing list...
>
> I didn't mean to shy you away ;)

Applying recent lessons form StackO'flow :P
>
> Could it be that there is a ^M very early in the file (or rather
> something else which isn't covered by dos2unix) so that Meld thinks it's
> DOS and inserts line endings as DOS? At least that's what vim would do.
>
If there is i don't find it using Emacs, but Emacs may only show what 
dos2unix sees... Will post back the Meld insights (here's hoping!)

> In any case, Meld people over there should know (or get to know) that
> effect.
>
>>>> There are plenty of posts around about these being line endings used for
>>>> windows which can appear when working on a script under a *nix OS which
>>>> has previously been edited in a Windows OS. This is not the case here -
>>>> everything is taking place on Ubuntu 12.04.
>>>>
>>>> FWIW: the directory is being synced by dropbox; and in Meld, Preferences
>>>>    > Encoding tab, "utf8" is entered in the text box.
>>>>
>>>> Current work around is running in a terminal: dos2unix /path/to/script.r
>>>> which strips the ^M's
>>>>
>>>> But this just shouldn't be necessary and I'd really appreciate the
>>>> reflections & advice on how to stop inducing these ^M's !
>>>>
>>>> With thanks,
>>>>
>>>> Karl
>>>>
>>>> (re)posted here as suggested off topic at SO:
>>>> http://stackoverflow.com/questions/13799631/create-script-r-in-emacs-modify-with-meld-git-commit-reopen-in-emacs-m
>>>>
>>>
>>

-- 
Karl Brand
Dept of Cardiology and Dept of Bioinformatics
Erasmus MC
Dr Molewaterplein 50
3015 GE Rotterdam
T +31 (0)10 703 2460 |M +31 (0)642 777 268 |F +31 (0)10 704 4161
