From: Omar Othman <omar.othman@booking.com>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 15:12:25 +0100
Message-ID: <530CA4C9.60601@booking.com>
References: <530B0395.5030407@booking.com>	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 25 15:12:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIIkM-0006bt-QJ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 15:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbaBYOM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 09:12:29 -0500
Received: from mail-out5.booking.com ([5.57.20.182]:42741 "EHLO
	mail-out5.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbaBYOM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 09:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=booking.com; s=bk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=KmwQs7v+WHBtyRGK9V+n+Ef+IvDm96VbUNxgOdWzlY0=;
	b=Ut1S+s1W3Oixnm9p0OZgANw2cTuTTUO5OExWQijzQQuSlHZa9LlbRL4EBEqQTfrUpjZJmmXxq6pbZOoNnhUsfEOkqrqSqBzivY8FCXGzW0dujo+BzLcyyujMVWPPDo3Fdp+fDG/v+HTvcJXtVdc9veCGkidlmPUnztSa2bhVS1A=;
Received: from corpds-202.lhr4.corp.booking.com ([10.186.68.14]:60696)
	by mtx-201.lhr4.prod.booking.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIIkD-000Esk-T5; Tue, 25 Feb 2014 15:12:25 +0100
Received: from [10.155.74.57] (port=57819)
	by corpds-202.lhr4.corp.booking.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIIkD-0003TQ-Nc; Tue, 25 Feb 2014 15:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <vpqlhwz5o58.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242668>


>> Please note that what I am asking for is not always dropping the
>> stash, but doing that *only* when the merge conflict is resolved. This
>> is simply getting the whole command to be consistent. If you do `git
>> stash pop` and it succeeds, the stash reference is dropped. If you do
>> git stash pop` and it succeeds *after resolving the merge conflict*,
>> the stash reference is *not* dropped. This is *not* consistent and
>> *is* a user experience problem. I'm not asking about dumbing git down
>> by any means.
> Can you describe precisely what you would expect, e.g. what Git's output
> should look like after such and such command?
Sure. This is my current command prompt (which shows git's internal status):

[omar_othman main (trunk*)]$

I do a git stash pop, which causes a merge conflict:

Auto-merging path/to/file.txt
CONFLICT (content): Merge conflict in path/to/file.txt

[omar_othman main (trunk|MERGING*)]$ vi path/to/file.txt
[omar_othman main (trunk|MERGING*)]$ git add path/to/file.txt
[omar_othman main (trunk*)]$

Note how the status message has changed to show that git is now happy. 
It is at that moment that the stash reference should be dropped (or the 
user (somehow) is notified to do that herself if desired), because this 
means that the popping operation has succeeded.
