From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Pitfalls in auto-fast-forwarding heads that are not checked out?
Date: Sat, 4 May 2013 07:35:27 -0400
Message-ID: <CACPiFCK=8KFX++Bg+LhymorSMnWgrj5Js+-f=UYyZnNY=n9WiA@mail.gmail.com>
References: <CACPiFCLnjCeCpt8wR71bFweFyA3rFCsnbEiR1yRD1n=X5K84Mw@mail.gmail.com>
 <5184B9F9.2010708@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat May 04 13:35:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYakr-0003Ma-Kh
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 13:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757915Ab3EDLft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 07:35:49 -0400
Received: from mail-qe0-f41.google.com ([209.85.128.41]:58235 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757150Ab3EDLfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 07:35:48 -0400
Received: by mail-qe0-f41.google.com with SMTP id b10so1343383qen.28
        for <git@vger.kernel.org>; Sat, 04 May 2013 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EXnmVHLFpiBrGgDja3f2S/ri1aSHBYcVzqp9aD4xd3Y=;
        b=Rbbb+3nJphIdL3o+Eb5SsUvSQY/qaw40nwzUm8vj4kFkBNarhErM6slEatcO2gCS5M
         meeeYgaLcaOmJS/l4roX/o6HC2xe3Hjdbf5TwuqrS3H4vy+xd2OVUZDNciQdIm0poiSf
         0lTY+gRzrEnS7e0NhvndC0J6enIcdxBKnMHsiq1FcjF3f/WMFnDn2Qh86ZDBanr5KW0s
         aUWNaHwEbpe8z41vb+LuZLy4Rp2Nx+5tkEIRbSMcpxiaXaaePCdNDTij7vcoOIfAdP0R
         He4ln5WDYDpywqbmrsGkuotuSL6VdOk09xZkT1Bb7P/wD7nZYpPM/p5bAzNirkfyetJq
         Lohg==
X-Received: by 10.224.173.6 with SMTP id n6mr16380031qaz.46.1367667347717;
 Sat, 04 May 2013 04:35:47 -0700 (PDT)
Received: by 10.49.75.198 with HTTP; Sat, 4 May 2013 04:35:27 -0700 (PDT)
In-Reply-To: <5184B9F9.2010708@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223365>

On Sat, May 4, 2013 at 3:34 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> You mean "refs/heads/master" and "!=" here because -ne is numeric
> comparison in a shell script.

thanks! Yeah, I fixed those up late last night :-)

> Since git 1.8.0 you can express this check as
>
>     if git merge-base --is-ancestor $production_sha1 refs/heads/master

Ah, that's great! Unfortunate it's not there in earlier / more widely
used releases of git.

>> Are there major pitfalls in this approach?
>
> I don't think there are.

Thanks...

>> I cannot think of any, but
>> git has stayed away from updating my local tracking branches; so maybe
>> there's a reason for that...
>
> I don't understand what you are saying here. What is "that"?

When I do git pull, git is careful to only update the branch I have
checked out (if appropriate). It leaves any other branches that track
branches on the remote that has just been fetched untouched. I always
thought that at some point git pull would learn to evaluate those
branches and auto-merge them if the merge is a ff.

I would find that a natural bit of automation in git pull. Of course
it would mean a change of semantics, existing scripts could be
affected.

cheers,



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
