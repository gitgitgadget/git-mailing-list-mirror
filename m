From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: when does git start caring about symlinks?
Date: Wed, 24 Nov 2010 13:48:13 -0600
Message-ID: <icjq8q$519$1@dough.gmane.org>
References: <ichk2q$bbu$1@dough.gmane.org> <AANLkTi=O0pZ97kRt0jGfy20znfvfp3UTydTBn_aMBxE+@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 20:50:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLLz-0005El-3c
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 20:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab0KXTuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 14:50:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:40095 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab0KXTt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 14:49:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PLLLp-0005Ax-Pd
	for git@vger.kernel.org; Wed, 24 Nov 2010 20:49:57 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 20:49:57 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 20:49:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162074>


>"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote in message 
> >news:AANLkTi=O0pZ97kRt0jGfy20znfvfp3UTydTBn_aMBxE+@mail.gmail.com...
>On Wed, Nov 24, 2010 at 6:50 AM, Neal Kreitzinger <neal@rsss.com> wrote:
>> I have a question on how symlinks work and at what point git starts 
>> caring
>> about them. If dirA/repoA/.git has no symlinks and I copy it to
>> dirB/repoB/.git (ie. cp -rp /dirA/repoA/.git /dirB/repoB/.git), but /dirB 
>> is
>> a symlink to /x/dirB does that mean that repoB contains symlinks (I 
>> suspect
>> that repoB may be made up of all symlinks at this point)? In other words,
>> if I parallel test repoA and repoB am I running a true parallel test or 
>> are
>> the repos different because repoA has no symlinks and repoB has symlinks?
>
>There should be no difference between repoA and repoB until you make
>changes. Symlinks outside worktree do not matter. Symlinks inside .git
>dir may cause problems when you start updating repos. But I don't
>think recent git creates symlinks. There are other forms of symlinks
>in .git dir though: .git as a file that points to real .git dir, or
>.git/info/alternates comes to mind.
>-- 
>Duy

Thank you for clarifying this for me.  I see that I mistyped my copy 
command.  It's actually "cp -rp /dirA/repoA /dirB/repoB", but you understood 
what I meant anyway when you stated "Symlinks outside worktree do not 
matter".  :)

v/r,
Neal 
