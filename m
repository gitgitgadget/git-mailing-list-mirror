From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] git-svn: support fetch with autocrlf on
Date: Sun, 14 Feb 2010 02:04:30 +0100
Message-ID: <40aa078e1002131704g90463bbq864138fee8d4ce01@mail.gmail.com>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
	 <1265997155-3592-2-git-send-email-kusmabite@gmail.com>
	 <20100213122532.GA31653@dcvr.yhbt.net>
	 <40aa078e1002130616u478397c0xf757d5424630e6cf@mail.gmail.com>
	 <alpine.DEB.1.00.1002140055550.20986@pacific.mpi-cbg.de>
	 <40aa078e1002131627x10fb9dfaq479b731f16d816aa@mail.gmail.com>
	 <alpine.DEB.1.00.1002140140510.20986@pacific.mpi-cbg.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 02:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgSuh-0003BM-OL
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 02:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab0BNBEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 20:04:33 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:13439 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758171Ab0BNBEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 20:04:32 -0500
Received: by ey-out-2122.google.com with SMTP id d26so926614eyd.19
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 17:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=VY8jXpkIbKg5m4qJtesHUMwM/1IBbjvV88kLntjCCEs=;
        b=jeTRfwdh5eRM+QwadwFYQ0h0O57e6TaDkF216U+mH39rBKjVvSQOquoqX9V0jmvLUN
         +xo4X4pYCRMkeZ+2WQTiusLFABy9075vGTVU4nSLtL3MweP2viqBxvHTzdIaQ5BeaxBR
         5hsA289JyPUO1Z7YQoO7JU17i58m2vg+1tzsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=Lb2/dES8CCghaq9zgeu6PIOUhG2iKo3sXfH3DuariHw5yX+adacUuTTTlC7vdZ7YWY
         Nbk9++dpNfKcPAwAjvk6yQ03N/tlDqdmq5rpSSnPgPJheKyfyXhSXv8rXJhh9F7Rl7mH
         18MzzQmb7VkJt1t+TKvzb/w63te9vVXf55LMk=
Received: by 10.216.86.85 with SMTP id v63mr2030438wee.32.1266109470647; Sat, 
	13 Feb 2010 17:04:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002140140510.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139874>

On Sun, Feb 14, 2010 at 1:46 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 14 Feb 2010, Erik Faye-Lund wrote:
>
>> On Sun, Feb 14, 2010 at 12:59 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Sat, 13 Feb 2010, Erik Faye-Lund wrote:
>> >
>> >> I don't think it affects svn dcommit in any way, except from the
>> >> implicit svn rebase that svn dcommit performs. d3c9634e sets
>> >> core.autocrlf to "false" on init, but re-enabling it hasn't shown any
>> >> problems in my end. I'm using git-svn with these patches and
>> >> core.autocrlf enabled every day at my day-job.
>> >
>> > To elicit a warm and fuzzy feeling about your patch, you will have to
>> > analyze the code paaths of dcommit, and how crlf affects them. Then
>> > you will have to describe why dcommit does not have a problem with
>> > crlf with your patches anymore.
>> >
>> > Remember, the idea of a commit message is to optimize the overall time
>> > balance, i.e. avoid the many to perform what the one can do for them.
>> > And since you have to do that analysis for yourself anyway, it makes
>> > sense to write up the result in the commit message.
>> >
>>
>> I'm sorry, but I'm confused. What missed from my commit message?
>
> I had the impression that you sent a mail asking to revert the commit that
> hardcoded autocrlf to false for git svn. For that commit, you would have
> to provide the information I requested.
>

No. I sent a patch series that fixes this issue properly instead of
just disabling core.autocrlf. I added a comment that mentioned that
the hack possibly could be reverted. I didn't ask anyone to revert it.

>> The question of dcommit was a question that Eric asked, and I'm not
>> really sure why he did. I tried to explain why in my reply. d3c9634e
>> never was about dcommit the way I understand it, but about clone:
>> http://code.google.com/p/msysgit/issues/detail?id=232
>
> Well, technically, you are right, it is only about clone.
>
> But.
>
> If you set autocrlf to false in every git svn clone, then of course,
> dcommit is very much affected by the setting. Along with all other git svn
> operations.
>

Wouldn't any such changes be bugs that d3c9634e introduced?

> And since your patches aimed at undoing that patch, i.e. no longer setting
> autocrlf to false upon git svn clone, you have to show that git svn in
> general can handle autocrlf = true (or = input) just fine.
>

My patch aimed at allowing me to use core.autocrlf. I don't care what
the default for core.autocrlf in a git-svn clone is, I'm just sick of
accidentally checking in CRLFs into my company's SVN repo because
enabling core.autocrlf corrupts my local repo.

> And by "to show" I do not mean just test it. That is not good enough,
> because your workflow is more than just likely to miss out on ways other
> people use git svn. You have the source code, and you can look all git
> calls and analyze them for potential autocrlf problems.
>

What makes you think that I haven't properly analyzed the issue? I'm
wondering especially about this, considering that you yourself
described your fix as "so obvious it did not even need testing"...
What's the required amount of analysis here?

I'm sorry if I misunderstand you here, but I'm still not understanding
what's lacking...

I guess "This patch tries to fix the same problem while allowing
core.autocrlf to be enabled, by disabling filters when when hashing"
could be rewritten into something like this:

"This patch tries to fix the same problem while allowing core.autocrlf
to be enabled, by making sure that filters aren't applied while
importing files into the git-repo"

Perhaps I should add a paragraph explaining why the issue triggered in
the first place (before d3c9634e)?

-- 
Erik "kusma" Faye-Lund
