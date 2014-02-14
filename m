From: David Kastrup <dak@gnu.org>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 17:52:54 +0100
Message-ID: <87d2ip3ac9.fsf@fencepost.gnu.org>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	<xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 17:53:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEM0b-00064L-Sm
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 17:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbaBNQw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 11:52:58 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:56553 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaBNQw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 11:52:57 -0500
Received: from localhost ([127.0.0.1]:55593 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WEM0U-0005sx-UJ; Fri, 14 Feb 2014 11:52:55 -0500
Received: by lola (Postfix, from userid 1000)
	id 6B867E40ED; Fri, 14 Feb 2014 17:52:54 +0100 (CET)
In-Reply-To: <xmqqy51dirjs.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 14 Feb 2014 08:32:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242112>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Feb 14, 2014 at 7:45 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>>> Josef Wolf <jw@raven.inka.de> writes:
>>>
>>>> Notice the refs/heads _within_ refs/heads!
>>>>
>>>> Now I wonder how I managed to get into this situation and what's the best way
>>>> to recover?
>>>
>>> Probably you did something like "git branch refs/heads/master".  You can
>>> remove it again with "git branch -d refs/heads/master".
>>
>> As a porcelain, "git branch" should prevent (or at least warn) users
>> from creating such refs, I think.
>
> "warn", possibly, but I do not see a reason to *prevent*.
>
>  A. You are not allowed to call your branch with a string that begins with
>     'refs/heads/'.
>  B. Why?
>  A. Because it will confuse you.
>  B. I know what I am doing.
>  A. ???

A. But maybe Git will no longer know what you are doing.  Its standard
way of resolving references will mean that once a branch
refs/heads/wibble exists, referring to a branch wibble will become extra
hard.  For example, stuff like

push origin HEAD:refs/heads/wibble

will maybe create or update a new branch wibble, or maybe it will just
push to the existing branch refs/heads/wibble.

-- 
David Kastrup
