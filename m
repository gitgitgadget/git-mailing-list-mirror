From: Stefan Beller <sbeller@google.com>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 09:51:07 -0800
Message-ID: <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
References: <566EFF11.6010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Nyberg <tomnyberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 18:51:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8XHG-0001pW-SC
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 18:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbbLNRvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 12:51:09 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34299 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbbLNRvI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 12:51:08 -0500
Received: by ioae126 with SMTP id e126so52202605ioa.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jBhMBxJU7u5gTeJShJQHRBpza1N8Gs6q7LsTXtjYvTY=;
        b=GFj0f8iFavhRib4+ETNyzqRGUnHuBuHVtYlYi70ZkRu631kR4vzsvNoRZ2hUos/UsB
         dlLtENabboLuR3BNHfYRUDCPqc4eS4XDZWIuQUxICs2gfvKH1RReVXQaWb5oRwvBKxWn
         uLoLZNvIRsco2f8wU11zav5vXsARdhfDRXkKKaY6Z2Ab8/FhYwrah84sVFLZkEX0vkna
         juTJZp6zrYuk9XmS1zmAo4RmYi3IGC8qcMuNTRpSLXgKBL+jYq55iF/6VqCHC4Qvc50G
         E3mdXXSsG/+kwmLr920RS/Bifi75PlsT0SHPb+xawpjmonZRWOi199xIvW8stJzoMg/Q
         UBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jBhMBxJU7u5gTeJShJQHRBpza1N8Gs6q7LsTXtjYvTY=;
        b=YYUYSnKtAhsSspAQ2cuIrrDgJokbpfXIVqFMcEnH1wXCvdTyNh6kdq8/ZYCgsoIcnT
         6/e/6eZ54oIHyJRfc9/ySAa0ynOa4xCXLV3iap5gmr4jCiZYoULspcZ4/FyXu1xQR0f5
         34a4YSy07hrL9gAx3k5HUxoHRPa26ebtB8Zcj3PiuK5Z9jG2hrMuxHBWL/cFftG84oM2
         UtnMtY6T7mnAjEVWfnW1nnCtUf6vCZrGyC1fcoF7Po+dF4AQ97m+DN/RNyOl46Po9N5Y
         FIaZZNAawb64Pfwmwj/OOUjlmeMrKsFbb5BeIsCBqu5vEyXwYycO9YXUm4FaSUaXA9X1
         lktA==
X-Gm-Message-State: ALoCoQm7ff/70zRux5at4fRhLCGy1mz9ko7irvJaGZGNMcmVMxGuqlBFfYgw3jOd0gRhI7rBaYUx9dUDMk3Ott+83kZV3n2g62SY7O7m+CBEVFFhHtfoFQg=
X-Received: by 10.107.152.142 with SMTP id a136mr36013566ioe.110.1450115467433;
 Mon, 14 Dec 2015 09:51:07 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 09:51:07 -0800 (PST)
In-Reply-To: <566EFF11.6010600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282373>

On Mon, Dec 14, 2015 at 9:40 AM, Thomas Nyberg <tomnyberg@gmail.com> wrote:
> Hello,
>
> I have a repository (which I unfortunately cannot provide access to) which
> is having some odd things happening with one (and only one) of its branches.
> This workflow repeats the issue (here `bad_branch` is one of the remotes
> branches; i.e. `origin/bad_branch`):
>
> (1) clone the repository
> (2) git checkout `bad_branch`
>
> Basically nothing happens. Nothing is printed and I stay on the master
> branch. I also checked $? and there is no error code that is set. If I
> choose any of other branches, it correctly creates a local branch, sets it
> to track the remote and then switches to the local branch.

Does that branch have a funny name? (i.e. is it ASCII only? Or is it
also utf8 characters?
Does it have some special characters in it like points, colons,
question marks etc)

Does it happen only with a single sha1 or can you apply commits on top
of that branch
and the error condition persists?

>
> It seems like there could be some sort of weird bug in the checkout or
> possibly somehow some corruption in the actual object tree. From my vantage
> point, however, the data appears totally fine. For example, in
> `.git/packed-refs` everything appears normal and if I explicitly checkout
> the commit IDs directly (i.e. just copy the commit corresponding to
> refs/remotes/origin/bad_branch and checkout $commit) it checks out fine. If
> I do this with the bad_branch I get a detached HEAD as expected and git log
> lists the commits that it should.
>
> This seems a bit odd to me. There's certainly some sort of error somewhere,
> but it's passing silently. I'm not really sure how to debug this and it's
> too bad I can't actually link the actual repository. I presume if I have the
> time I could try compiling git from source and seeing if it still shows up.
> I tested it on the following two versions of git get the same error:
>
> * 1.9.1 (installed as a package from Linux Mint 17.2 Rafaela)
> * 2.1.4 (installed as a package from Debian Jessie 8.2)

The refs handling code is in flux at the moment. (starting mid of last
year actually)
I cc'd people who did work recently on the file refs.c

So I think trying with a new version of Git would be a valuable datapoint!

>
> Also I should note that the original repository is hosted on Github.
>
> Thanks for any help. Hopefully the fact that I can't provide enough
> information for others to reproduce the issue isn't too large a bother...
>
> Cheers,
> Thomas Nyberg
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
