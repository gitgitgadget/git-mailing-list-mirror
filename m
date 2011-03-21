From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Mon, 21 Mar 2011 19:12:38 +0100
Message-ID: <4D879516.3060204@gmail.com>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com> <7vwrjssbfk.fsf@alter.siamese.dyndns.org> <4D877FAD.9000807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jdk-00040O-1o
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab1CUSPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:15:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56323 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab1CUSPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:15:34 -0400
Received: by fxm17 with SMTP id 17so5719331fxm.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=zJHHc2JVR85UsTEg5jwpiobmxG+hjRgw7wRwFaSXN5E=;
        b=JJlOCz1q0xh9Kzz/MyTibK2dx3SUWeq6DkPe9scRSEIxP9PUSWYi0iQCWjQ4mZvKUF
         5pCn+YIV5uVjQOVTzQinNhIs+sqvX3e1aXPI5oe1iK0pGQml+H9/TZBJuX8IjeLxluzv
         eiGODxRXnsTdwUdS3xBDINOdhRzSL0ROYdcJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=G211ONcp0qdfEqVmUQx17+9DgjRgBlLR/LWoPQwnP34kEco8zmQ2bq+d9wzyJjdFyH
         Ja0+gkOLtdC6Hl4HhayX4xKTL8DSChUyGpB5vvOruruj5rScQBNybqErp2T6kLHcKgCY
         V3j73pn155FM1PKrhFbJGuTNZEsWQ7XRoF0GM=
Received: by 10.223.160.5 with SMTP id l5mr786283fax.85.1300731166501;
        Mon, 21 Mar 2011 11:12:46 -0700 (PDT)
Received: from [192.168.1.101] (aadh98.neoplus.adsl.tpnet.pl [83.4.85.98])
        by mx.google.com with ESMTPS id n15sm2625957fam.12.2011.03.21.11.12.44
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:12:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <4D877FAD.9000807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169622>

W dniu 21.03.2011 17:41, Johannes Sixt pisze:
> Am 3/21/2011 17:09, schrieb Junio C Hamano:
>> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>>> But when I take a different approach, and in addition to this:
>>>
>>>> If I edit the file and remove the "<<<< HEAD" marked and code
>>>> between "===" and ">>>"  then
>>>
>>> I also manually add the "+line" which is the change done in the cherry-picked
>>> commit, git diff shows a lot of other changes in unrelated lines
>>> (which lie close
>>> but still were not modified by the patch, nor were shown previously by
>>> git diff).
>>>
>>> This is very weird.
>>
>> Sorry, I have no idea what you are talking about.

I hoped someone might have some clues :)

 
> Assuming you did not 'git add' the file yet, you are looking at the
> "condensed combined diff" after manually resolving the conflict by doing
> the "+line" manually that the cherry-pick should have brought in. Of
> course, a lot of context is visible here if both sides have diverged
> considerably in this area.
> 
> I.e. the diff will look something like
> 
>  +line from HEAD
>  +line from HEAD
> + line from cherry-picked
>  +line from HEAD
> ...
> 
> Notice the double columns before the content lines. This sort of diff
> extens above and below the conflicting section until there is a "gap" of 3
> lines that changed neither on the HEAD side nor on the cherry-picked side
> since the merge base.

Hm that might be possible! I'll check it tomorrow @work.

If that's the case here is what got me lost:

As I wrote earlier, after removing the "<<<< HEAD" and code between "===" 
and ">>>", the git-diff showed nothing. So the natural impression was
"my files does not have any changes in working tree".

But then when I have added one line and did the diff again, it suddenly
started showing some other changes, unrelated to the added line or to
the cherry-picked commit.
 
I might have misses the double columns in the diff output so I though
it's just normal diff.

Thanks to your and Junio explanation I now understand why it works like
that.

I think I even suspected this might have something to do with the merge
conflict and tried to make git-diff show me exact change between working
tree and index/HEAD (ignoring the merge), so I can verify the file indeed
only have the change I did, but I could not find such option.
Does it exists? 


-- 
Piotr Krukowiecki
