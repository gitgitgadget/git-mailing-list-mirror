From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] replace: List replacement along with the object
Date: Fri, 26 Aug 2011 10:13:10 +0200
Message-ID: <CAP8UFD1Or8dPVBpAsOwge4o0Lpej2gTs7dQJM0eocbn7EiWVrQ@mail.gmail.com>
References: <bae5a8f7d30417864d972390f9f6b4470cf4e5bf.1314283118.git.git@drmicha.warpmail.net>
	<CAP8UFD2Cr4UQjWa=pRvcqgyX_Ed+qjts=TujWRdyk4dUZsd_7Q@mail.gmail.com>
	<4E574D61.8050501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 10:13:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwrXb-0001n3-Iq
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 10:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab1HZINN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 04:13:13 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64795 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1HZINK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 04:13:10 -0400
Received: by vxi9 with SMTP id 9so2388016vxi.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vmzotEaQCGzGq4lFph+D8SWx7Mmm7X6/dUvc5/gE+lk=;
        b=jHc68zSv/DvbRKemnSDali/fWe5UeM2KqJkqToTOSQkAIykwz/MhAAZnepI5G7gZCk
         HDheLy4ExGqw6lVMTYZTGOzuXp3pXa02ZgJ/yyQ9Q6qDsetoVtRKmYTQkCEEFuIrBfF9
         ycffFHF49Ekvo7y4T3SnLzUwqTMLF2KbP4Zkg=
Received: by 10.52.24.135 with SMTP id u7mr757163vdf.464.1314346390082; Fri,
 26 Aug 2011 01:13:10 -0700 (PDT)
Received: by 10.52.188.201 with HTTP; Fri, 26 Aug 2011 01:13:10 -0700 (PDT)
In-Reply-To: <4E574D61.8050501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180156>

On Fri, Aug 26, 2011 at 9:38 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Christian Couder venit, vidit, dixit 25.08.2011 18:29:
>> On Thu, Aug 25, 2011 at 4:39 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> The documentation could be misunderstood as if "git replace -l" lists
>>> the replacements of the specified objects. Currently, it lists the
>>> replaced objects.
>>
>> You could just change the documentation to make it more explicit.
>
> Well, sure. I just didn't find the current form that useful.
>
>>> Change the output to the form "<object> <replacement>" so that there is
>>> an easy way to find the replacement, besides the more difficult to find
>>> git show-ref $(git replace -l).
>>
>> I shamelessly copied the "-l <pattern>" feature and the documentation
>> from "git tag". If you just change the output of "git replace -l" it
>> will make the UI inconsistent between both commands.
>
> I don't think many people will expect consistency between branch and tag
> on the one hand, and replace refs on the other hand. It requires the
> knowledge that a replacement is basically a lightweight tag stored in a
> different namespace in refs/, which I would actually consider an
> implementation detail.

It is an implementation detail, but anyway UI consistency is important
and I would suggest the same behavior even if it was implemented in
another way.
By the way it would be nice to make "git remote" more similar to "git
branch", "git tag" and "git replace" while you are at it.

>> Maybe you could add a "-L <pattern>" feature to "git replace", "git
>> tag" and "git branch" that would output "<ref name> <ref content>"?
>
> I'd use "-v" then if this is about consistency, because that *always*
> means "verbose", and migrate the misnamed "git tag -v"...

Yeah, but "git branch -v" is decribed like this:

    Show sha1 and commit subject line for each head, along with
relationship to upstream branch (if any). If given twice, print the
name of the upstream branch, as well.

So if you implement it in "git replace" and "git tag", you should at
least show the commit subject line too.

Thanks,
Christian.
