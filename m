From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Add colors to the prompt for status indicators
Date: Tue, 16 Nov 2010 11:43:09 +0100
Message-ID: <4CE2603D.8080209@drmicha.warpmail.net>
References: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com> <4CE04B82.1040804@pileofstuff.org> <19363118-D147-4946-8973-B5DDA4B00985@sb.org> <F7A9874A-738C-4BEA-8EDF-0ED1FA7D6ACF@sb.org> <AANLkTimpyug867ccsKA+fLjzDJ8NukQXcPnVJw3Uk4LD@mail.gmail.com> <C43669C9-CD42-4D51-BFB9-567AAA422C06@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sebastien Douche <sdouche@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	git list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 11:45:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIJ2U-0001b2-Kp
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 11:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024Ab0KPKpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 05:45:12 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50494 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932529Ab0KPKpK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Nov 2010 05:45:10 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 440F4A36;
	Tue, 16 Nov 2010 05:45:10 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 16 Nov 2010 05:45:10 -0500
X-Sasl-enc: rLKTeiYl/qw1PvgsrhAl7abSs574913QysTPicVqzTtm 1289904310
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 887AC5E66C9;
	Tue, 16 Nov 2010 05:45:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <C43669C9-CD42-4D51-BFB9-567AAA422C06@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161555>

Kevin Ballard venit, vidit, dixit 16.11.2010 10:07:
> On Nov 16, 2010, at 12:11 AM, Sebastien Douche wrote:
> 
>> On Tue, Nov 16, 2010 at 00:14, Kevin Ballard <kevin@sb.org> wrote:
>>> I take it back. We can use PROMPT_COMMAND for this, to set up variables
>>> containing what you want.
>>>
>>> Something like the following should work:
>>
>> Hi Kevin,
>> good job! I looked the git prompt and I'm a bit disappointed with the
>> combination, ps1 can show many items:
>>
>> #
>> %
>> +
>> *
>> $
>> REBASE-i|
>> REBASE-m|
>> MERGING|
>> BISECTING|
>> < > <> (or u+count u-count u+countu-count)
>>
>> Each item is "optional", so you can have REBASE-i| with * and +, or
>> only *. It seems to complicated to wrap all items (I think of the
>> verbose mode for upstream branches). Maybe coding a lua (or Python)
>> prompt with a config file.
> 
> In the end you need to stuff everything that needs a distinct color into its
> own shell variable. You could just extend the shell function that's doing that
> right now, or you could write a script in another language that emits a
> shell-quoted set of variables suitable for evaling by the shell.

Also, you should get away from parsing individual characters in
__git_ps1. Characters like + and - are valid in branch names. Coloring
them within the name is not quite intended.

I guess the only way is to produce colors within __git_ps1 (based on an
option). Also, colors would allow to use the same status letters as "git
status -s".

Michael
