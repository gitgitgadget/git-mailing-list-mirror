From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 20:05:29 +0530
Message-ID: <CALkWK0kGF+d8Jk-TVfb6iwk6LuOcD-Uuuj6DHf-4YeVAFLSvuw@mail.gmail.com>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
 <87y592y67f.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jul 19 16:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Bn5-000064-KE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 16:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab3GSOgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 10:36:12 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55721 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab3GSOgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 10:36:10 -0400
Received: by mail-ie0-f177.google.com with SMTP id w15so1244635iea.22
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FMU9beHBZp+SqUJLBpfqJtWSpFJKh1NqE50TxpXLmUM=;
        b=sRDOE+bL8bpD5opygATtjpahuR1kuM0aQeIFGytMevs0/LyIkt5GS6ykm2e8Y7lkrL
         xLmR5xnQMAxcnXs3G4vrLf1RXsy0PnRPdTvJy4IIfNTfG6M93T5qJs9KLvAeW2wt/2Hj
         CHY0vTUcIO5yuHWV3NNbEFn+QiU1SuCz94vZQ4a8TttryhmScbT3QvkL2QcSicEW3NRm
         ggdNDEIjiUD9Dz45UJ5QHMpYGeJfsVUL+wPCpcg80EvgJH2T2YA4YtTFwS4sjoKraspk
         CcLw2q6FvjaiPT0fNIW5fJurdDfB/EVsL/YMOtnyFSkcNbcKz9jilIpFYMjN7B2U89b0
         q1bA==
X-Received: by 10.43.145.69 with SMTP id jt5mr10674813icc.65.1374244570035;
 Fri, 19 Jul 2013 07:36:10 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 07:35:29 -0700 (PDT)
In-Reply-To: <87y592y67f.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230808>

Andreas Schwab wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>   # er, what was the branch name again?
>>   $ git checkout -
>
> You could take a look in the reflog.

Yeah, or use the @{-N} revision to do that for me.  My scripted
version is essentially:

  test "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" || exit 1
  git checkout master
  git branch -D @{-1}

The main problem is the hard-coding of "master": I suppose I could
replace that with @{-1} too.

Not a big deal: I was just wondering if others use it often enough for
it to become `branch -Dc` in core; @{-N} is quite obscure.
