From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:03:56 +0200
Message-ID: <87vdbitu9v.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221651590.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:04:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5EoC-00016t-7z
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762Ab0DWJEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 05:04:04 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57457 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747Ab0DWJD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:03:59 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6D34115E7B0D2;
	Fri, 23 Apr 2010 11:03:57 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5Enl-0008Uk-00; Fri, 23 Apr 2010 11:03:57 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5Enk-0003Rl-8Z; Fri, 23 Apr 2010 11:03:56 +0200
In-Reply-To: <alpine.LFD.2.00.1004221651590.7232@xanadu.home> (Nicolas Pitre's
	message of "Thu, 22 Apr 2010 17:25:07 -0400 (EDT)")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX1+UNlsaWGx1IotJKF0RvWlRwLmuQZ9csy6hw9V9
	pivw44AXatuMxC5h7/QItPMTecS2uWBcMLRWckjmU1DV/uMcpF
	xhzRTCmO8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145596>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Thu, 22 Apr 2010, Goswin von Brederlow wrote:
>
>> Nicolas Pitre <nico@fluxnic.net> writes:
>> 
>> > On Thu, 22 Apr 2010, Goswin von Brederlow wrote:
>> > Exact.  It is therefore not progress to impose some inconvenience to one 
>> > work flow in order to make another one easier.  And in this case we're 
>> > talking about the difference between having to type an additional -a vs 
>> > the risk of creating a commit with unexpected content.
>> 
>> Is there a risk? You do get an editor with all the files affected listed
>> giving you a big fat warning what you are about to commit. Yes I
>> sometimes do start to commit wrongly too (no matter what RCS used) but
>> then I just close the editor to abort and commit the things seperately.
>
> Yes, but this is a much greater burden to 1) not forget to empty the 
> editor, and 2) actually save the empty file.  Simply exiting the editor 
> will cause unwanted commit.
>
> Compare that with simply adding -a to your commit command when told so.

That is not how it works in other RCS. Initialy the editor only contains
comments listing the affected files. If you do not alter the file then
the commit aborts. I agree that having to empty the file and save it
would be a greater burden.

>> >> Alternatively an option to take all changes but only if the index is
>> >> empty would be helpfull. Then people could define an alias for that or
>> >> set the option in the config. Other than setting -a that would allow
>> >> using an index when needed and commit everything in the normal case
>> >> without having to change the command used to commit.
>> >
>> > But you're proposing to change the semantics for that command.  And I 
>> > also suspect that you're trying to make the index more hidden while what 
>> > we're actually trying to do is to promote it.
>> 
>> Yes, it would hide the index. But you are not just promoting it. You are
>> forcing people to always use it, even if only through the -a option.
>
> Well, sure.
>
> And you might be glad that the -a option is there at all.  When this was 
> debated, the concensus was that the index is what makes Git so 
> different, and actually *better* than the alternatives.
>
> Concerns were raised about natural human resistance to change and the 
> fact that some people would have problem adapting to a different model.  
> So the -a argument was added as a compromize, although the concensus was 
> much less strong in that case.
>
> And experience so far has shown that the vast majority of new Git users 
> started to really appreciate the index once they've past the initial 
> hurdle of getting used to a different concept.
>
> So we can say that Git's index is one of its major feature.  You should 
> learn to use it or stick to -a, but please don't try to make Git into 
> what it was meant to be different from.
>
>> > What _you_ can do though, is this:
>> >
>> > 	git config --global alias.ci "commit -a"
>> 
>> But then when I accidentally use 'git ci' while having an index the
>> index gets ignored and all changed files get commited in one big mess.
>
> Not at all.  You will end up in the same text editor with the same 
> opportunity to abort the messed up commit as you are claiming above.  
> Except now this is your own burden instead of mine.  See?  One's gain is 
> another one's loss.
>
> However in this case this would happen because you mixed up an 
> index-using workflow with a non-index-using workflow.  While with your 
> suggested change the messed up commit could occur without mixing up 
> workflows.

No, with my suggested change (either change of the default or the extra
option) it would be smart enough to do the right thing on its own.

> So either you use the index or you don't.  And of course I'd strongly 
> suggest you truly consider using it.
>
>> Given how seldom I need an index (so far never) the risk of using 'git
>> ci' accidentally is way to high. Same with typing -a. I do it so often
>> that when I actualy don't want it I will probably type it anyway out of
>> habbit.
>
> This is a strawman.  If you do not use the index and never used it so 
> far, why are you so afraid of this ci alias?  Please get over it.
>
>
> Nicolas

You all say the index is such a great thing. So I might use it
eventually. Other people might use it 1 out of 10 times. Yet other
people use it 9 out of 10 times. Can you at least accept that the use of
the index feature is different for each person?

My suggested change, with the --a-if-empty option, would not impose
anything on existing usage. But it would benefit those that rarely use
an index and would like git to be smart enough to know when to use the
index and when not. Yes, it would mean the use of the index ideology is
not force upon people anymore. But isn't that a good thing? Free
software is about freedom. That should include the freedom not to use
the index method.

MfG
        Goswin
