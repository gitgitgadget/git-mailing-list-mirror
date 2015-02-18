From: Eric Frederich <eric.frederich@gmail.com>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 13:27:50 -0500
Message-ID: <CAAoZyYOst-5cD7qtV=T3Oahja1JN1ZmeyAcELrn7xD0bMc7Mrg@mail.gmail.com>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
	<CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
	<CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
	<CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
	<xmqqfva341sf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:28:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9MP-0004Js-76
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 19:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbbBRS1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 13:27:53 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:43683 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbbBRS1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 13:27:50 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so5343111obc.6
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 10:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CO+ktko6I0ddNjOpTruiDwuBtxUzhPckwG2PuHtuQYo=;
        b=tu+kgDcor5bA1sQrbx6U4EuvS3VsaLfxMJvJjofMz4VOp3rDxVOjIcrFc03jD7Slga
         YONWobFifry1mdpR5TUkkUp1kTXyrwHvmcMsXmivo2e3SVJtGAKnQJSCV0y98t1IHxe8
         RJ3I3MBFPsfN1sVgAywG6THNfqAzWwNHDxTZi30qSjN1iDsCA+PZeysanen3C241O2yG
         kgeJP/co9lj8SFEjrnp71fx24xEHOU64cvhxjiAQk2+bOPrndAjdmdLnHTubag0/L5bI
         KoxiaoX6w9VkV1pqarpjCXPfgXUQ7bjyiWgpcZHeUbWGoHVKy9JvI71SKbBMCGJs/yw1
         M2UQ==
X-Received: by 10.60.16.230 with SMTP id j6mr481710oed.8.1424284070279; Wed,
 18 Feb 2015 10:27:50 -0800 (PST)
Received: by 10.202.12.193 with HTTP; Wed, 18 Feb 2015 10:27:50 -0800 (PST)
In-Reply-To: <xmqqfva341sf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264037>

Thanks for the reply.
My immediate concern is not to fix the documentation but to get some
sort of status or diff.
I want to avoid using an index because I want to allow multiple
processes to do different diffs at the same time.

Right now I can put trees into the repo and get trees out without
using the index but I had to write routines that use the lower level
commands.
If I could use the index it would be a couple of out of the box
commands and I wouldn't have to write my own routine.
While I've already written ones for "git add" and "git checkout" I'm
trying to avoid writing one for "git diff"

I looks like this is unavoidable.
Oh well... thanks for the help.



On Wed, Feb 18, 2015 at 11:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Frederich <eric.frederich@gmail.com> writes:
>
>> This is from "git help diff".  It seems to imply that I should be able to do it.
>> It mentions nothing of the index.
>
> Most of the documentation on early subcommands (and "git diff"
> certainly is one of the early subcommands) were written back when
> everybody knew that Git almost always talks about _tracked_ files
> that are known to the index, and the only time it even cares about
> untracked ones that are not in the index was when it tries to help
> users by reminding what the user may have forgot to "git add".
>
> Documentation pages do not bother repeating "this only looks at
> tracked paths" for this reason; Git is about tracked files by
> default.
>
> Perhaps you can suggest how to improve the description of commands
> without being too repetitive?
>
> Thanks.
