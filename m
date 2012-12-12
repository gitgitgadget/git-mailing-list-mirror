From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to avoid the ^M induced by Meld and Git
Date: Wed, 12 Dec 2012 17:08:42 +0100
Message-ID: <50C8AC0A.1010306@drmicha.warpmail.net>
References: <50C72821.10908@erasmusmc.nl> <50C89B68.8090309@drmicha.warpmail.net> <50C8A403.9050304@erasmusmc.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl Brand <k.brand@erasmusmc.nl>
X-From: git-owner@vger.kernel.org Wed Dec 12 17:09:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiory-00049d-0d
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 17:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413Ab2LLQIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 11:08:45 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58092 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752276Ab2LLQIn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2012 11:08:43 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F138720B99;
	Wed, 12 Dec 2012 11:08:42 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 12 Dec 2012 11:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=5pV8f/nG4VA6VhGG98DTeA
	/zwUA=; b=iZ6FcJDpmfqD+K5j/rpULiplwH1ZupZ84WdZ8T5qZdoE9qgp+HWZ8T
	6gXneIat/+zOpZ5qDdYrWGkaOenaRmgRN87OSC/ZfbGgFB+FytkYvICa6V5+UsO5
	rarACCM9POvc9VN0Ckht5ofj8JHuRNoG0G5TD0LD44x5VTJWL+mak=
X-Sasl-enc: gsDhcVVjpX3TNupOwH5M2LVhS9ikf0DnVFRawFallWxK 1355328522
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7DA568E063E;
	Wed, 12 Dec 2012 11:08:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50C8A403.9050304@erasmusmc.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211362>

Karl Brand venit, vidit, dixit 12.12.2012 16:34:
> 
> 
> On 12/12/12 15:57, Michael J Gruber wrote:
>> Karl Brand venit, vidit, dixit 11.12.2012 13:33:
>>> Esteemed Git users,
>>>
>>> What i do:
>>>
>>> 1. Create a script.r using Emacs/ESS.
>>> 2. Make some modifications to script.r with the nice diff gui, Meld
>>> 3. Commit these modifications using git commit -am "my message"
>>> 4. Reopen script.r in Emacs/ESS to continue working.
>>>
>>> The lines added (&/edited ?) using Meld all end with ^M which i
>>> certainly don't want. Lines not added/edited with Meld do NOT end with ^M.
>>
>> What happens if you leave out step 3? If the same happens then Meld is
>> the culprit. (Unless you've set some special options, git does not
>> modify your file on commit, so this can't be git related.)
>>
> 
> Leaving out step 3. results in exactly the same thing. Thus Git doesn't 
> appear to be responsible for the ^M's. Thanks a lot for your effort on 
> this and my apologies for not taking the care to dissect this more 
> carefully as you suggested. Over to the Meld mailing list...

I didn't mean to shy you away ;)

Could it be that there is a ^M very early in the file (or rather
something else which isn't covered by dos2unix) so that Meld thinks it's
DOS and inserts line endings as DOS? At least that's what vim would do.

In any case, Meld people over there should know (or get to know) that
effect.

>>> There are plenty of posts around about these being line endings used for
>>> windows which can appear when working on a script under a *nix OS which
>>> has previously been edited in a Windows OS. This is not the case here -
>>> everything is taking place on Ubuntu 12.04.
>>>
>>> FWIW: the directory is being synced by dropbox; and in Meld, Preferences
>>>   > Encoding tab, "utf8" is entered in the text box.
>>>
>>> Current work around is running in a terminal: dos2unix /path/to/script.r
>>> which strips the ^M's
>>>
>>> But this just shouldn't be necessary and I'd really appreciate the
>>> reflections & advice on how to stop inducing these ^M's !
>>>
>>> With thanks,
>>>
>>> Karl
>>>
>>> (re)posted here as suggested off topic at SO:
>>> http://stackoverflow.com/questions/13799631/create-script-r-in-emacs-modify-with-meld-git-commit-reopen-in-emacs-m
>>>
>>
> 
