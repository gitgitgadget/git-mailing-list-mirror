From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Re* [RFC PATCH 2/1] Make request-pull able to take a refspec of
 form local:remote
Date: Wed, 12 Mar 2014 19:18:44 -0400
Message-ID: <CAPig+cQTRFgbbyXsWraNTbL+nOY2y09KEJPfGc3wynFA+RWswQ@mail.gmail.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
	<CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
	<xmqqsises3u0.fsf@gitster.dls.corp.google.com>
	<CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
	<xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com>
	<xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
	<CA+55aFyWM+VDa4mdqseNy3tSnp23x=2sPtHf5KpxsfROeHbVGw@mail.gmail.com>
	<xmqqob1u6f5d.fsf@gitster.dls.corp.google.com>
	<xmqqvbvjmgys.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNsR9-0003vS-Vt
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 00:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbaCLXSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 19:18:47 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:57121 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaCLXSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 19:18:46 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so260832yhz.22
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FrJXSPYBQ8b1Yhw5uAkBNNiIVOuEVUhWgXt8DiMXwTU=;
        b=0aHlfqVrf5BwlPxKjE7m043jh+DAcdjTs7Y2PsjMrZyV/EDyir6tHhJzoiSe+tv716
         ZP/9dhOO7Gq4LHESH4da/ScQv2j8zTJ3oHxqgijSyCnOU4Ck44sDWipSWAA83ndwwEEb
         WmSwjQ6TriwvWDaLvTXPALa1OKpOWFRab7zhmV4pxG+HddEv13AQttQX2z+FXwQDv+bm
         B897zD2EZZkNVBUcJWUxM1lC3wxn7bxFdPvQrzrjNa664IRG4yNOezNN4nNKzoshwTR9
         M/oFJy8OFKNJq/tl9IP7qbIKLrHgPWgZ+397g5GCfiRocR8Rjffoub+yLT9wPvlPvVfY
         Jmtw==
X-Received: by 10.236.126.81 with SMTP id a57mr161898yhi.95.1394666324680;
 Wed, 12 Mar 2014 16:18:44 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 12 Mar 2014 16:18:44 -0700 (PDT)
In-Reply-To: <xmqqvbvjmgys.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: rmhwBM7nHdKuNDjPfHFNm9zC8jU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244008>

On Wed, Mar 12, 2014 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] request-pull: documentation updates
>
> The original description talked only about what it does.  Instead,
> start it with the purpose of the command, i.e. what it is used for,
> and then mention what it does to achieve that goal.
>
> Clarify what <start>, <url> and <end> means in the context of the
> overall purpose of the command.
>
> Describe the extended syntax of <end> parameter that is used when
> the local branch name is different from the branch name at the
> repository the changes are published.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-request-pull.txt | 55 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
> index b99681c..57bc1f5 100644
> --- a/Documentation/git-request-pull.txt
> +++ b/Documentation/git-request-pull.txt
> @@ -13,22 +13,65 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>
> -Summarizes the changes between two commits to the standard output, and includes
> -the given URL in the generated summary.
> +Prepare a request to your upstream project to pull your changes to
> +their tree to the standard output, by summarizing your changes and
> +showing where your changes can be pulled from.

Perhaps splitting this into two sentence (and using fewer to's) would
make it a bit easier to grok? Something like:

    Generate a request asking your upstream project to pull changes
    into their tree. The request, printed to standard output,
    summarizes the changes and indicates from where they can be
    pulled.

> +The upstream project is expected to have the commit named by
> +`<start>` and the output asks it to integrate the changes you made
> +since that commit, up to the commit named by `<end>`, by visiting
> +the repository named by `<url>`.
> +
>
>  OPTIONS
>  -------
>  -p::
> -       Show patch text
> +       Include patch text in the output.
>
>  <start>::
> -       Commit to start at.
> +       Commit to start at.  This names a commit that is already in
> +       the upstream history.
>
>  <url>::
> -       URL to include in the summary.
> +       The repository URL to be pulled from.
>
>  <end>::
> -       Commit to end at; defaults to HEAD.
> +       Commit to end at (defaults to HEAD).  This names the commit
> +       at the tip of the history you are asking to be pulled.
> ++
> +When the repository named by `<url>` has the commit at a tip of a
> +ref that is different from the ref you have it locally, you can use

Did you want to drop "it" from this sentence? Or did you mean to say
"the ref as you have it locally"?

> +the `<local>:<remote>` syntax, to have its local name, a colon `:`,
> +and its remote name.
> +
> +
> +EXAMPLE
> +-------
> +
> +Imagine that you built your work on your `master` branch on top of
> +the `v1.0` release, and want it to be integrated to the project.
> +First you push that change to your public repository for others to
> +see:
> +
> +       git push https://git.ko.xz/project master
> +
> +Then, you run this command:
> +
> +       git request-pull v1.0 https://git.ko.xz/project master
> +
> +which will produce a request to the upstream, summarizing the
> +changes between the `v1.0` release and your `master`, to pull it
> +from your public repository.
> +
> +If you pushed your change to a branch whose name is different from
> +the one you have locally, e.g.
> +
> +       git push https://git.ko.xz/project master:for-linus
> +
> +then you can ask that to be pulled with
> +
> +       git request-pull v1.0 https://git.ko.xz/project master:for-linus
> +
>
>  GIT
>  ---
> --
> 1.9.0-293-gd838d6f
