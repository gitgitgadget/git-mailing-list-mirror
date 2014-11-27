From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Antw: Re: Extended splitting for "git add --interactive"
Date: Thu, 27 Nov 2014 09:55:06 +0100
Message-ID: <5476F4FA020000A100018078@gwsmtp1.uni-regensburg.de>
References: <5475F7E7020000A100018050@gwsmtp1.uni-regensburg.de><5475F7E7020000A100018050@gwsmtp1.uni-regensburg.de>
 (Ulrich Windl's message of "Wed, 26 Nov 2014 15:55:19 +0100")
 <xmqq3895rdr1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 09:55:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XturA-0007sv-IU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 09:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbaK0IzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 03:55:12 -0500
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:50061 "EHLO
	rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386AbaK0IzK convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-git@vger.kernel.org:2:1>);
	Thu, 27 Nov 2014 03:55:10 -0500
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 0CB7152F2A
	for <git@vger.kernel.org>; Thu, 27 Nov 2014 09:55:09 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id E049B52D67
	for <git@vger.kernel.org>; Thu, 27 Nov 2014 09:55:08 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Thu, 27 Nov 2014 09:55:08 +0100
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
In-Reply-To: <xmqq3895rdr1.fsf@gitster.dls.corp.google.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260341>

I probably forgot to mention the obvious: My enhancement request was for cases where git would reject so split a junk. I don't want to change the default split (if it finds a point to split).
So maybe call it a "2nd-level-split". Only if split refuses to split, you could avoid using "edit" to manually split.
Iknow that in gerneral such things can't be right, but you can eith reject the new junks or use "edit". I just guessed the feature could save some time on the average.

>>> Junio C Hamano <gitster@pobox.com> schrieb am 26.11.2014 um 19:57 in Nachricht
<xmqq3895rdr1.fsf@gitster.dls.corp.google.com>:
> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
> 
>> This is for git-1.7.12 (an older version from the SLES11 SP3 SDK). If
>> the issue is solved meanwhile, I'll be happy, and I apologize for
>> being too lazy to find out.
> 
> The answer is no ;-).
> 
>> Currently Git cannot split a block of changes like
>>
>> -AAA
>> -BBB
>> +CCC
>> +DDD
>>
>> Into
>> -AAA
>> +CCC
>> and
>> -BBB
>> +DDD
> 
> And it is unlikely to do so ever, because it is a wrong thing to do.
> 
> What makes the user happy to see above split when the user is
> expecting this instead?
> 
> -AAA
> and
> -BBB
> +CCC
> +DDD
> 
>> Another split that is not possible is a split across an empty line, like:
>>
>> +AAA
>> +     <empty line (in reality)>
>> +BBB
> 
> Likewise.  An empty line is not that special.  AAA may be adding one
> block of lines "if (condition) { ... }" and BBB may be another, and
> it often happens that you would want to separate these into two
> changes, with or without an empty line in between.
> 
>    +if (foo) {
>    +  do foo thing
>    +}
>    +if (bar) {
>    +  do bar thing
>    +}
>    
> Having said all that, I am not opposed to a usable idea to allow the
> user to specify where in a contiguous block of -*+* to break a hunk
> and how.
