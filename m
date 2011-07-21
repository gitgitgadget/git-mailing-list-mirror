From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] gitignore: add top level patch ignore rule
Date: Thu, 21 Jul 2011 10:50:06 -0400
Message-ID: <4E283C9E.2050000@xiplink.com>
References: <1311113877.2643.2.camel@vitaliy-Vostro-1400>	<4E268D2F.50201@drmicha.warpmail.net>	<CAGTPOqeF6LneWCg_du5dDfzFp7QV_jGg1t4u23sziTN+uHQyXA@mail.gmail.com>	<4E282349.4040404@drmicha.warpmail.net> <CAGTPOqcd5G=NG83wgnH80nqNsS1FYwtRp4QjaB=oU5NkPts_Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Vitaliy Ivanov <vitalivanov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 16:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjuZu-0005DP-RK
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 16:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab1GUOuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 10:50:12 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:57246 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1GUOuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 10:50:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id D2ECC1A02E1;
	Thu, 21 Jul 2011 10:50:09 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp24.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 85AF51A02C1;
	Thu, 21 Jul 2011 10:50:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <CAGTPOqcd5G=NG83wgnH80nqNsS1FYwtRp4QjaB=oU5NkPts_Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-07-21 09:22 AM, Vitaliy Ivanov wrote:
> On Thu, Jul 21, 2011 at 4:02 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Vitaliy Ivanov venit, vidit, dixit 21.07.2011 14:54:
>>> Michael,
>>>
>>> On Wed, Jul 20, 2011 at 11:09 AM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Vitaliy Ivanov venit, vidit, dixit 20.07.2011 00:17:
>>>>> Add top level ignore rule for patches created by format-patch command.
>>>>
>>>> Please don't.
>>>>
>>>> The tracked ignore file is for ignoring products and artefacts of our
>>>> build process. format-patch is not part of this process, and the
>>>> existence of *.patch files depends on your workflow. But what is much
>>>> worse: In
>>>>
>>>> git status
>>>> git format-patch rev-spec
>>>> git send-email *.patch
>>>>
>>>> it is very easy to send out the wrong patches (along with the right
>>>> ones), because your patch hides them from status. Also, I can't clean
>>>> them up with "git clean -f" any more. I would have to use "git clean -f
>>>> -x" which would clean the build products also (and force a rebuild).
>>>>
>>>> So, your patch makes a format-patch based workflow much worse. What
>>>> problem does it try to solve?
>>>
>>> I will not insist. You may know it better but git as is a public
>>> project where anyone can create and send patches. So it seems to me
>>> basic workflow for sharing changes.
>>
>> Well sure it is. We do that and discuss the merits of patches.
>>
>> I do use format-patch/send-email, and as I explained, your patch would
>> make that more difficult. If there is something that it makes better
>> that may outweigh it. Can you explain what improvement this (ignoring
>> *.patch) introduces?
> 
> I'm not sure how listing all the patches that you have under "git
> status" will help you not to send a wrong one.

Seeing various patch files in "git status" bothered me as well.

So I put all my patches in a top-level patches/ directory, along with a
patches/.gitignore file that ignores everything there.

If that doesn't meet your needs, you could instead add a core.excludesfile
entry to your ~/.gitconfig, and in there ignore *.patch files.

So given those alternatives, I'm not convinced your patch is suitable for all
git users.

		M.
