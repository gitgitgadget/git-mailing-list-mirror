From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Bug? Files are losing history after subtree merge
Date: Wed, 2 Oct 2013 22:44:17 +0200
Message-ID: <CAN0XMOJqmia4uTvOTBk75FcidD2hn6NbWf6a5R5GXPk1iDz4gQ@mail.gmail.com>
References: <1380741617-14593-1-git-send-email-ralf.thielow@gmail.com>
	<vpqsiwjlarx.fsf@anie.imag.fr>
	<CAN0XMO+y3Cwsz5LwbmzHBe31Rf-RwMykynLmvmqUsxY8f+1dsQ@mail.gmail.com>
	<vpqy56bjuen.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 02 22:44:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRTHY-0008MW-6B
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 22:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab3JBUoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 16:44:19 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:46862 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab3JBUoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 16:44:18 -0400
Received: by mail-we0-f171.google.com with SMTP id p61so1631881wes.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CCcgZsbuI4kQZ41qjjgc0ON40TIrg8Rt5FqwUYjba2E=;
        b=Zft0+5YT/B/jlsFDCmDWp2yVwzUIc73KJSAkbDaEHS4hwcK2F34LLU4d9ifcXGMWgY
         VM+zWEaxjtFLrWk92fmqOdu0AkGXAyoV3hobI74rcJ42BL4p7LVMBlDrMf+MDBugps//
         sXlPpmMX4Fuq7K3xjnwFDNDmWyG5dGbpt++d5Ql/r1uW+nXd7Pldz6Pztb6B8GRzWOoC
         +FBLyRSFpUL2CVsqG1zCuNnUwZ664G0t7Wv7njl4q00sOeH/cPYts1NxcQz2cx3ZNS4X
         SK7n4yga6vzq7wdOiM0qnipPncJl7M2/WTgYmEYO3TmrOrN0EL+o7iJggzUX/GpKZBPa
         3H4A==
X-Received: by 10.180.73.109 with SMTP id k13mr3678400wiv.35.1380746657623;
 Wed, 02 Oct 2013 13:44:17 -0700 (PDT)
Received: by 10.194.165.163 with HTTP; Wed, 2 Oct 2013 13:44:17 -0700 (PDT)
In-Reply-To: <vpqy56bjuen.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235674>

On Wed, Oct 2, 2013 at 10:21 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Thanks for explanation.
>> I knew the history of the repo is there, but the history of single files
>> (and the ability to look at it)
>
> There is no such thing as "single file history" in Git. Git knows about
> the history of the project, and knows which files were there at each
> commit. Then, some commands can walk through history following the
> history of a file. "git blame" is very good at it, and should work with
> subtree merges. "git log --follow" is a quick hack that nobody bothered
> to fix up to now (sadly).
>

Yeah
From a user perspective there is a "single file history", isn't it? And in
this case the history is gone. At least in the subtree case...

> You can use workarounds like
>
>   git log -- '*git-gui.sh'
>

"My" users are using gui tools, so there's sadly no chance to change the
commands.
I just wanted to mention the issue but I've worked around it so it's
no problem anymore.

> (from the toplevel), to view each commit that touched a file whose name
> ends with git-gui.sh. It won't follow actual renames, and may show false
> positive if you have several files with the same basename. But it may
> help.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
