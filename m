From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: [PATCH 2/2] show color hints based on state of the git tree
Date: Mon, 15 Oct 2012 12:34:24 +0200
Message-ID: <507BE6B0.4020306@nieuwland.nl>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org> <20121005211030.GA5414@simaj.xs4all.nl> <507BC7F1.3080506@drmicha.warpmail.net> <507BD0EE.5000107@nieuwland.nl> <507BD3C1.4040807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	spearce@spearce.org, artagnon@gmail.com, schwab@linux-m68k.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:41:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNi76-0000aA-ST
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 12:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab2JOKl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 06:41:26 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:47660 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751703Ab2JOKl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 06:41:26 -0400
Received: (qmail 20043 invoked by uid 453); 15 Oct 2012 10:34:33 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Mon, 15 Oct 2012 12:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <507BD3C1.4040807@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207731>

On 10/15/2012 11:13 AM, Michael J Gruber wrote:
>
> It really doesn't matter much what works for you, and it doesn't matter
> what works for me either. The point is: What works for most users?

Obviously, that was my point as well ;-)

>> I'm quite unfamiliar with the color coding of git (I hadn't enabled that
>> option), I suppose consistency would be better, but then you'd have to
>> add some code to figure out which color is used for what in git's output
>> and convert that to the code setting the colors here.
>
> As a starter, you could use the default colors which git uses. Querying
> git for the colors could be the next, optional step.

I suppose it would be a start.

so how should it be?

all committed: green branch, no characters
only staged changes: green branch, colored characters (yellow/red?)
only unstaged changes: red/yellow branch, colored characters (red)
staged and unstaged changes: red/yellow branch, multiple characters in 
red/yellow?)
detached head: red commit-sha1 (abbrev.), characters as above?

What is the most useful thing to show in case of a detached head?
-the commit hash of current head?
-"detached head"


>
>> As for the characters used, I think there's a good reason not to use the
>> ones git uses in the prompt. The characters in git status output are put
>> in front of the files they apply to, in the prompt you only get a
>> summarized output. And perhaps that argument could be extended to the
>> use of the colors as well, I prefer to know whether I have uncommitted
>> changes and in that category I want to know whether I already staged
>> them or not.
>
> Well, sure. The prompt could show any of AMCRD if you have any of those
> changes. * + are shortcuts saying you have any of those.

How do you suppose that should work?
Add another configuration parameter like GIT_PS1_SHOWSTATUSSBCHARS 
(please give a better suggestion ;-) or the other way around 
GIT_PS1_SHOWSTARPLUS (either of which could be the default)

>>> I think it's very confusing to have completely different schemes (not
>>> just themes) for two versions of the same information: concise status
>>> information.
>>>
>>> So, please try and follow "git status -sb".
>>
>> I think there are different levels of conciseness. And I see "git status
>> -sb" uses green for staged modified files, which would be confusing to me.
>
> ...only because you don't know the color coding scheme. It's green
> because those changes are saved somewhere (in the index) and would even
> survice a branch switch.

I suppose you could see that as green (I usually view a yellow traffic 
light as green as well ;-)

Isn't it best practice to commit the staged changes ASAP? (But let's not 
diverge in this thread to discuss best-practices, so consider that a 
rhetorical question for now ;-)

> No, I said red for unstaged, green for staged for the characters, i.e. a
> * would always be red if present, a + always green if present.
>
> For the "branch name", it would be red for detached head and green for
> checked out branch.

using green for staged changes could be acceptable for me, but I'm 
slightly worried that a colored character would be too slight a hint.

OTOH, a detached head would show up with or without color...

>
>> Perhaps, but that would be confusing to me ;-)
>
> If that is case, you can try and propose changing that scheme...
>
> But there's really a good reason for it. Cached (staged) changes are
> "safe" because they are saved in the index, and also they are "good to
> go into the next commit", i.e. the commit traffic lights are green!

I suppose I knew that in the back of my mind, but not as clearly as you 
spell it out here... Tnx!

/Simon
