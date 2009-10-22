From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: Updating a branch.
Date: Thu, 22 Oct 2009 16:31:53 -0400
Message-ID: <32c343770910221331q2b419d7dvc5c89ab3864348ca@mail.gmail.com>
References: <26015707.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: elyod72 <elyod72@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 22:32:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14KF-0007SQ-PJ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbZJVUbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 16:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755820AbZJVUbu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:31:50 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:39246 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbZJVUbt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 16:31:49 -0400
Received: by ewy3 with SMTP id 3so1025020ewy.17
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=1nF57JAzLhpRBLPF84DgZeLa0cLQpNGuZNfo8IHvhsg=;
        b=K/HM0CxjOCjyIoXJo0of4WllaafekWDcBKI0AgrBhvBbAHMCwRd7aFXqnOtTMP68fT
         i0SYCfRMRNfmzJ92MbiH+QBKH6529crqOcySjmBLS+Ht/t2+87BIku5oVTNaXBuDPrhG
         el4sAuwpHv5Fh9y21Qf0RJcsPRFMH30VRnyz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FgA7l8xoIxxdxDMXdWaVFr01U9JoGFHMCrVXN3+xG73Je6kgksaKFDKiS/Y9QEVKuP
         jA+qBUd2FkVMu90ZoUUOmPYI9tyY1JjW2sfoAOuZRMiBRHkVQLCZlTxY6svZEs4VHfTL
         f3Ol1v/Vi8rZyCR+IbuwWwMdNo9xDaWPruTSI=
Received: by 10.216.87.11 with SMTP id x11mr3464443wee.16.1256243513618; Thu, 
	22 Oct 2009 13:31:53 -0700 (PDT)
In-Reply-To: <26015707.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131053>

On Thu, Oct 22, 2009 at 3:21 PM, elyod72 <elyod72@gmail.com> wrote:
>
> I am a newbie to git, so please bear with me.
> Here is the scenario that I am struggling with:
>
> I have my Master branch.
> I then create a new branch named Test.
> I then make changes and additions to the test branch.
> At the same time I make changes to the Master branch.
> Now I want to update the Test branch with the latest information from the
> Master branch.
>
> How do I go about doing that?

In general, the following is recommended:
  1) If possible, complete your work on the Test branch without merging
     the changes.  Save your merge (and any potential conflict resolution)
     for when the Test branch is complete and fully tested.
  2) If Test absolutely requires the changes made in Master, then perform
     a "git rebase master" from your Test branch.  This operation replays
     the commits you have made to Test on top of your latest commit to
     Master.

See the gitworkflows man page [1] for further information.  The section on
"Topic Branches" should be helpful.

This post [2] on StackOverflow has some helpful info as well.

-Tim

[1] http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html
[2] http://stackoverflow.com/questions/457927/git-workflow-and-rebase-vs-merge-questions
