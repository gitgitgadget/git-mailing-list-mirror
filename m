From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] If `egrep` is aliased, temporary disable it in bash.completion
Date: Wed, 12 Dec 2012 16:34:29 -0600
Message-ID: <CAMP44s2QHrwv0wZ=r+_E2i19Y-zJChPHaX=UeHXaGAppNzqm6A@mail.gmail.com>
References: <20121129151418.GA19169@redhat.com>
	<7vpq2wqr3v.fsf@alter.siamese.dyndns.org>
	<7vk3t4qpoe.fsf@alter.siamese.dyndns.org>
	<20121206140541.GA4892@redhat.com>
	<7v4njzjbzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Tkac <atkac@redhat.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:34:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiutA-00078b-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab2LLWed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:34:33 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62570 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721Ab2LLWe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:34:29 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1385385oag.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 14:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=w7tiRABvNK+9vYMC5VZFYRjFi//fQtPQ0gw+aSOMBDI=;
        b=Z403r9bTIHKiZfWMXzDD/EGXT7S7fmlUz9HBEsI0A4VDjhO36RSpX9iWoVRrHe0Ddz
         apGwaqZcZFo6yprgpdGrRDM2j7LfH6F8o6HtwFROxxdNR0hpwfILpn3LAxzNx/VA+FmV
         R1iKEsNkf93DlSHTlX53ShWTnb9ohMtzgVc8kN/NvFxfkqD7tvCKNAdrKi4hWg5wktvt
         B+4A5H9UaeKwOEPp96Ao5N/sz85qu6Tmtsk4HYmQefSup+Qz9xSj/4v0HbOMWOc5IfYM
         ztS2iQplwCyxp2SRXxToMMHCuQHFoVILyOfP8SP7OsSxocKkQX1icPeWmgxjNBZZ1gWP
         Bt1g==
Received: by 10.60.170.242 with SMTP id ap18mr1353369oec.97.1355351669167;
 Wed, 12 Dec 2012 14:34:29 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 12 Dec 2012 14:34:29 -0800 (PST)
In-Reply-To: <7v4njzjbzo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211402>

On Thu, Dec 6, 2012 at 12:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Tkac <atkac@redhat.com> writes:
>
>> On Thu, Nov 29, 2012 at 09:33:53AM -0800, Junio C Hamano wrote:
>> ...
>>> IOW, something along this line?
>>
>> This won't work, unfortunately, because shopt settings aren't inherited by
>> subshell (and for example egrep is called in subshell).
>>
>> I discussed this issue with colleagues and we found basically two "fixes":
>>
>> 1. Tell people "do not use aliases which breaks completion script"
>> 2. Prefix all commands with "command", i.e. `command egrep` etc.
>>
>> In my opinion "2." is better long time solution, what do you think?
>
> Judging from what is in /etc/bash_completion.d/ (I am on Debian), I
> think that others are divided.  Many but not all prefix "command" in
> front of "grep", but nobody does the same for "egrep", "cut", "tr",
> "sed", etc.
>
> If it were up to me, I would say we pick #1, but I cc'ed the people
> who have been more involved in our bash-completion code because they
> are in a better position to argue between the two than I am.

Why not both? I do prefer #1, but I don't see why we wouldn't prefix
some commonly problematic ones (\egrep), prefixing all of them seems
overkill for me.

-- 
Felipe Contreras
