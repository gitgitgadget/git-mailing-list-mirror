From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 1/2] submodule: document handling of relative
 superproject origin URLs
Date: Thu, 24 May 2012 07:55:35 +1000
Message-ID: <CAH3AnrpBEnF8BGcfGccmbyh_X-7c4CBN2UOq_v9uDMeWbsnNEQ@mail.gmail.com>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
	<1337791554-31294-2-git-send-email-jon.seymour@gmail.com>
	<4FBD4F68.90305@web.de>
	<7vvcjmzjkv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 23:55:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXJWv-0003uK-67
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 23:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760831Ab2EWVzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 17:55:37 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57563 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab2EWVzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 17:55:36 -0400
Received: by wibhm6 with SMTP id hm6so5108409wib.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4sI53TbmvhL+t5bDT6kyHlu3K2I9hKW/QufgQVUQy/Y=;
        b=bBC6QebmhJJ8RuqCLyoqtlVHZ6VFg8tLbQ24UoJbl0jdByyWxsG2VmMAUHBJp9t3YL
         0md0f8Q3KMxE1mAbGx2oLjAQgAJEM5V4PQ0T2EKtEWcZDUeWQM4Tr/CGBPaExWbOKrA2
         3GuywiNqEIeh19uEPrVLCYymwSYBcIhldPkQDb7bs9sPsf/Ml72DYCHl0wuQ0hCa3F3B
         lWhJXA3Kli9Nuc6ZPOfp2o9tu5RDRfBYgj8U8jc6mEhG1d2Wo+4U2D/I/mG/okflrqTg
         cpKb+g9+Rby0EuG8qeiHj8Sg111Y2o1j70xkCriFcKfwGeAG/cvYnmiu3x9FG+vPGCmq
         rCvg==
Received: by 10.180.95.136 with SMTP id dk8mr4619323wib.0.1337810135242; Wed,
 23 May 2012 14:55:35 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Wed, 23 May 2012 14:55:35 -0700 (PDT)
In-Reply-To: <7vvcjmzjkv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198329>

On Thu, May 24, 2012 at 7:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Maybe the subject should rather be:
>> "submodule: document failures handling relative superproject origin URLs"
>

Jens: Sure.

>
> I recall correctly, the original use case for relative URL entries in the
> .gitmodules file (to be copied to .git/config as submodule.$name.path) was
> so that by looking at the top-level, the locations of the origins for
> submodule repositories can be known from where the top-level was cloned.
> The above cases do not seem to be relevant, so in the sense, they are of
> secondary importance (and I do not find the "sneakernet tool" example
> convincing---the sneakernet tool that is distributed in the scenario can
> be written differently so that it does not require the other repositories
> to be named relative to it).

Agreed, that this is not required for the original use case.

In the 'sneakernet tool' case, it makes sense for me to have ./mnt/usb
around in any case (for the purposes of repos that are being managed
by the sneakernet tool). Since that link exists, I can use it for the
purposes of managing the tool's own origin repo and doing so does, I
think, reduce the number of configuration items I have to tweak to the
absolute minimum, but you are right that I don't absolutely have to do
it that way.

>
> As long as you and submodule stakeholders believe this is a reasonable
> addition and does not break the existing use cases, I am perfectly fine
> with it, though.

Ok, thanks for that. Whatever the use case, I think the change is a
positive if simply because, by respecting an implicit invariant, it
makes the behaviour consistent and predictable.

I'll fix the tests, per Jens and your comments and resubmit.

Jens: thanks for the review.

Regards,

jon.
