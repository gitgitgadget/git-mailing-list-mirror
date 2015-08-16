From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: feature request: better support for typos
Date: Sun, 16 Aug 2015 00:19:48 -0700
Message-ID: <CAKDoJU7qx7xuzc5X4zJE6-9wvr9dB_h-_u0gYZN9p7ORK-u_mw@mail.gmail.com>
References: <CAN0XMOLDamBeWswDi0cn_naZ2TX+gd89+g48zNwPPKxTh+ZTww@mail.gmail.com>
 <CACsJy8DGUo0-zFm2xtAKE6wy0c2GdbiOe-X2+B0HnCNg3SKa8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 09:20:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQsFN-000894-NH
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 09:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbbHPHU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 03:20:29 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34044 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbHPHU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 03:20:28 -0400
Received: by obbfr1 with SMTP id fr1so90038405obb.1
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YF/2K+XqwETuuiahR9ueDV49z4hX+siCNKCvxn1nlXw=;
        b=dJc8fecOZ5WmD+iN0HEeH57OPnSgYh2exh1FTwOgvslrR/yUeE9FHUDH03nk/ZJd6u
         mi15ZaHpqjoEYr5bmgbI3kDv5ER0G9rMGAvFQaDHWF3olNuiiIUs6+Vk0XsQ7i4bOlk/
         32bJGV0wQg+mPxxDYs0ev/scAB2rzubaigFVu7Mz+XgjALhpPvMdfR4EdwEny6XR+QzK
         Sw8R1Ltq1PyliJ7wl1A+7nVd4phlKAW66ALYlkiPKDffwkERRF+v0mqCA6BtDhmmJ2pN
         Ptpp5Xs4VuB2/mG4iBpPLqW1CGZVwFxlJNCwO0ofe1VAEiZmZW5HHXDdPFQR1ZrWTuTx
         f92Q==
X-Received: by 10.182.87.69 with SMTP id v5mr45421991obz.37.1439709627884;
 Sun, 16 Aug 2015 00:20:27 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Sun, 16 Aug 2015 00:19:48 -0700 (PDT)
In-Reply-To: <CACsJy8DGUo0-zFm2xtAKE6wy0c2GdbiOe-X2+B0HnCNg3SKa8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276013>

I believe They mean that if you type "clone --branch mister", it
should ask if you meant to "clone --branch master" instead, or
something.

Basically if you type a non existent branch name, calculate edit
distance for each branch name, probably either using a timeout or edit
distance to stop if something is too different from any branch so you
don't run for too long, and then, if a branch is within a certain edit
distance from the typo, suggest it.

Lawrence

On Sat, Aug 15, 2015 at 2:12 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Aug 8, 2015 at 1:12 AM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>> Hi,
>>
>> when a user made a typo, Git is not good in guessing what
>> the user could have meant, except for git commands. I think
>> this is an area with room for improvements.
>> Let's look into branches. When I "clone --branch" and make
>> a typo, Git could show me what branch I could have meant. It's
>> the same when I try to merge or track a branch.
>
> Good candidate for those micro-projects next year.
>
>> It might even
>> be possible to show suggestions for options for all Git commands.
>
> You mean if you type "--brnch" it should suggest "--branch"? I was
> bugged about this and wanted to do something, only to realize in most
> cases git would show "git <cmd> -h", which does a much better job
> because it would explain what --branch is for as well.
>
>> What I'm trying to say is, there are arguments with a limited
>> amount of possible values that Git know, so Git can show
>> suggestions when the user made a typo for such an argument.
> --
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
About Me: http://about.me/lawrencesiebert
Constantly Coding: http://constantcoding.blogspot.com
