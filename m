From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: New feature discussion: git rebase --status
Date: Thu, 13 Jun 2013 07:52:56 +0200
Message-ID: <CALWbr2x-4_QSurvScYL+2Utn=-K3Knb7Kif9SAvV_V-ZdvPfCw@mail.gmail.com>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
	<20130611125521.GL22905@serenity.lan>
	<vpqbo7c4wen.fsf@anie.imag.fr>
	<CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
	<CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
	<fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
	<51B857B0.5030603@ensimag.fr>
	<3cafe99fe3b868e6fc025110d324b9c8@ensibm.imag.fr>
	<CALWbr2xhhUNTo54u7K5iFr+wSMSiX6JrgTX=QJsDQ6E30uwDzQ@mail.gmail.com>
	<7vzjuvynt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	=?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Users <git@vger.kernel.org>,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 07:53:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un0Sz-0004A3-CS
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 07:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568Ab3FMFw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 01:52:57 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:53196 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab3FMFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 01:52:57 -0400
Received: by mail-qc0-f179.google.com with SMTP id e11so1391220qcx.10
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lkXsZpCb6VTv215G4S3lpPSPHlC2LEtBjCx+urLE25M=;
        b=J+Il9ObxsbvMlFXJaNzLkMdNPtrS0bjGla8Ta9Rq8E9CC1YeorK7/9GIDyraeN7yBY
         Ks4mMpLMZDQG1WKziVLUF94HfxjE5ySSiJhZ2aRuKkVBR8rT97H4BZ/AFLyup7YqhRrJ
         dmpLxsJ8VDUABUVmlNZ/EPYyzPAEAfTh8+d6I0eGfR1iQhp+xIGiqlmsOQW+nOJp38bp
         hbzMiXDvn8Zf2ErQejyAy+nYNcZdKVgrYPW4JJoFKMkhPUt/1iUt4k5hAKNgMT1u+jD6
         IFrC0dhnkn6y5vRL/MIC8xNOhNgz7GLB/2GCpuSho3tC2rjGAa4pPurlNTqlcsFZpMgV
         5WhA==
X-Received: by 10.224.105.199 with SMTP id u7mr1355993qao.33.1371102776227;
 Wed, 12 Jun 2013 22:52:56 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Wed, 12 Jun 2013 22:52:56 -0700 (PDT)
In-Reply-To: <7vzjuvynt0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227698>

On Thu, Jun 13, 2013 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> Maybe we can display previous and next commits to provide some
>> context. Like we do for diff.
>> For example:
>>
>> $ git status
>> # HEAD detached from ecb9f3e
>> # Already applied 330 patches (displaying next 3):
>> #     b170635... my_commit_message
>> #     b170635... my_commit_message
>> #     b170635... my_commit_message
>> # Already applied 119 (displaying last 3)
>> #     b170635... my_commit_message
>> #     b170635... my_commit_message
>> #     b170635... my_commit_message
>
> I think you meant one of them to be
>
>     # Still to be applied 119 (showing the first 3)
>
> instead.

Of course,

> I am not sure if it is worth 8 lines, especially given
> that "git log --oneline -$n" would give you "Already applied" part
> that is beyond what will be shown in this message easily if you
> wanted to.  So it might be enough to show "The one that has last
> been replayed" (aka "HEAD") and "The one you are in the middle of
> replaying".

That's very true. The piece of information that is hard to get is
"what's left to be done".

So something like this would make sense:

$ git status
# HEAD detached from ecb9f3e
# You are currently editing a832578... my_commit_message [120/450]
while rebasing.
# 320 patches left to apply (showing next 3):
#       b170635... my_commit_message
#       b170635... my_commit_message
#       b170635... my_commit_message
#   (use "git commit --amend" to amend the current commit)
#   (use "git rebase --continue" once you are satisfied with your changes)

So that's 4 extra lines compared to current output. But should we make
it a default ?
