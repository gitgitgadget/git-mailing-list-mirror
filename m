From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 15:34:07 +0200
Message-ID: <81b0412b0608100634j4f82d486nd8ba6dd3ac85b0e7@mail.gmail.com>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 10 15:34:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBAfu-0005dX-2c
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 15:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWHJNeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 09:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWHJNeK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 09:34:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:63564 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161270AbWHJNeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 09:34:09 -0400
Received: by wx-out-0506.google.com with SMTP id s14so417119wxc
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 06:34:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s3Pnw9NnB4JJFNrEIkUeNxLpzlrFnmZUQPTyAgplJRcllKEhH//oNijwDWb4jXOC1ddjfNzX30FULmGIY5eAOKdRewVgxs0YGT9ZNoVj8Lk9L9wl3M3dLH3dibsjVGGJTKPS+/CCp9rl4ltcSuMHfu1dT1SkYSLZHVAxnNutMGk=
Received: by 10.78.183.8 with SMTP id g8mr1280932huf;
        Thu, 10 Aug 2006 06:34:07 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Thu, 10 Aug 2006 06:34:07 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25183>

On 8/10/06, Junio C Hamano <junkio@cox.net> wrote:
>   - A new merge strategy, merge-recur, which is a rewrite of
>     merge-recursive in C, by Johannes and Alex.

It still has problems devouring that monster merge I have (~20k entries,
with around 40 changed in the other branch, around 100 revs ago. Big
binary files involved. Renames and copies).
Perfomance is nowhere near usable: ~20min on Windows/3GHz/2Gb,
~4Min on Linux/1.4GHz/384Mb ;) I agree that Linux is much more bearable
but 4Min is still too much (especially comparing to that "stupid" resolve).

I noticed that it spends a lot of time finding renames (diffcore_std,
in particular).
Why doesn't it take that much time for "diff-tree -M -r base head1" +
"diff-tree -M -r base head2", I wonder...? (~30 sek, for that windows box).

Sorry, I can't provide the tree. I suppose Mozilla tree can be compared
to that thing, when it becomes available. Linux kernel is no good for
reproducing this problem: it's too clean and compact.
