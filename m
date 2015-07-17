From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: A few "linked checkout" niggles
Date: Fri, 17 Jul 2015 19:49:57 +0700
Message-ID: <CACsJy8BZEhMJPdw4K_kihA1kTPBVsAt=zW-cemzO7V+xfDih8Q@mail.gmail.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com> <55A8F4B1.9060304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 14:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG560-0002yn-HO
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 14:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbbGQMu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 08:50:28 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33141 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757205AbbGQMu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 08:50:27 -0400
Received: by iggp10 with SMTP id p10so34289706igg.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6dtQ0UIJiYzsBEtt38fxskKbBvhCPwS4AtLPGcnz78c=;
        b=JfGKWisD/ObCcS9jE2sREbTSdMjf9D76o9WBTzYVMOVKCmKNUJggodyVq8uElIZNEc
         UBM2OewUC/Oo94NKZQFPPdXnkBVhdPQG7tz7XbZkVy9Q7oymkYfIYE9r89JOiTaFwihk
         KwWGYJgSwLVllqyWy90Vv1qJsymeViQiySrcxZycsGEnDhKloKjaNKP9dKiwPs/89K6i
         hgeOue/FtG4Y1LDqecnf0sKEAAbvboBG2CjLN93rYFem9qmg+A3JKMLIR4b/C+r0KSmn
         itswLL7rOsOpjWkNNmHpUnYb+MSIuV4Yo+29dKtOutYvavTeP4m+CniuQGHCqnLPoD1d
         4XFA==
X-Received: by 10.107.168.99 with SMTP id r96mr16726142ioe.141.1437137427107;
 Fri, 17 Jul 2015 05:50:27 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 17 Jul 2015 05:49:57 -0700 (PDT)
In-Reply-To: <55A8F4B1.9060304@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274068>

On Fri, Jul 17, 2015 at 7:27 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Two more observations:
>
> $ git worktree add /tmp/gitwt
> Enter /tmp/gitwt (identifier gitwt)
> Switched to a new branch 'gitwt'
>
> Now I'm in /tmp/gitwt at branch gitwt. Right? No. I'm in the original wd
> at the original branch.
>
> So either we cd to the new location or quelch these messages or add a
> message that we're actually back.

s/Enter/Preparing/ ?

> The other:
>
> linked worktrees are prefect for short term tests on detached heads.
> Even the manual page advertises detach. But:
>
> $ git worktree add  --detach /tmp/gitwtt
> Enter /tmp/gitwtt (identifier gitwtt)
> fatal: '--detach' cannot be used with '-b/-B/--orphan'
>
> Maybe it's the auto-naming logic stepping on detached toes ;)

Problem with master (but not with pu) because "-b gitwtt" is
automatically added. I think this is 1eb07d8 (worktree: add:
auto-vivify new branch when <branch> is omitted - 2015-07-06)
forgetting about --detach. Actually it's still a problem with 'pu'
because the branch 'gitwtt' is created unnecessarily.
-- 
Duy
