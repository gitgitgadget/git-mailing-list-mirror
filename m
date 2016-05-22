From: Joseph Musser <me@jnm2.com>
Subject: Re: Subtree split unsquashes everything
Date: Sat, 21 May 2016 20:30:13 -0400
Message-ID: <CAKRjdd6JKxp3B1EaiyGUaHfHYRh_N2a8gGEW7k4K-Ng0FHR3ww@mail.gmail.com>
References: <CAKRjdd7Czj2iTKdwVCmz4x9fDNKCPZtLi=UjgHOsSPuYL_yLXg@mail.gmail.com>
 <87a8jjouvo.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Sun May 22 02:30:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4HI9-0005YQ-8A
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 02:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbcEVAap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 20:30:45 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36864 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbcEVAao (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 20:30:44 -0400
Received: by mail-ig0-f182.google.com with SMTP id l10so9926698igk.0
        for <git@vger.kernel.org>; Sat, 21 May 2016 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1fol2X3OtgETwe2+VzzzHkzvmJcizz20XN65me6AWJM=;
        b=l/QIBpBY41wzhPQNEGzqzOQ3BhHM5EnjRImGzykBNWzAuwk6r965gptoPjyHRA2hvW
         tBe/KTF2MsWRMqTRlNXzjdJYc/GvzG04hsE4n4touqt8T2cy42bIW0+/LyhB2DajH/Pf
         vRQmtPrcR0aX/xnpI42jAu81zFOaQD8eQCtW+pLNndKiKpAzuUDXWY/M59GnPJKUKsbA
         JHS7i172prFvCWfvO32Qe/RdHYC3xNmbQdVH2iDGfvhZa5mpFupjcZYxW/+aMDKXHW40
         aw3Prv9Ia2OAkwQpZeGg7RF3auSFAbGSn5Bx+ksXgBvM3c1fvV3tfVmy0MLr58F2a4ri
         atNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1fol2X3OtgETwe2+VzzzHkzvmJcizz20XN65me6AWJM=;
        b=LAlj63ouicAg6rEKit/P0MPRhKCJ1BnKc8LpVb2hjZKhrN/aXQBQRJefAz/2Vrmlgw
         UnyJ1dj4R9reEKmbfERcA4CC/x9q6UJCfCQnfDqFjXiR9qaxXvgFVR/v+JUV5T8ZCVym
         nPI9AJevSBTelTYR4wde3fMIlaTqnhZ4DKUnsj/dqZqP8SXUQsgr7jsSpEm2q/1gAMhf
         3aPMnOwom6ybAtzDYvfdvRAv2O2vyumRuJsHzIqK/ki36aUzgEsT+o0GQIR7dv8hopml
         nxoyBbyLfAElysmjSsLnsLNJqiT5N11jIvb64/GTtIYl7dAcemON1BObUg1/xzR+bTGY
         CYzg==
X-Gm-Message-State: AOPr4FVuLyLhBpAT3ebbspZ/NKdT7nIkD8wMOA0g04BLIkVum8t78BsMzKXWAX3kgpVIWeW37yhAZGPJkn7orw==
X-Received: by 10.50.177.73 with SMTP id co9mr8232945igc.38.1463877043316;
 Sat, 21 May 2016 17:30:43 -0700 (PDT)
Received: by 10.64.64.36 with HTTP; Sat, 21 May 2016 17:30:13 -0700 (PDT)
In-Reply-To: <87a8jjouvo.fsf@waller.obbligato.org>
X-Google-Sender-Auth: 9QcDtAkwAQYJNJa7ZfID_UwgIVY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295255>

Thanks for the response.

I began to wonder if indeed I was using the correct paradigm, since
the split operation would leave the subtree prefix as `/` which is an
impossible prefix when creating a subtree. Attempting to add a new
subtree with prefix `/` results in an error because the prefix
directory is not empty (it contains `.git`).

Long story short, I realized I probably had to start over without
using subtree at all and manually rebase and remerge. I discovered
that now that I'm not using subtree, I can no longer squash merge. It
works for the first merge but subsequent squashes do not remember what
the previous squash's parent commit was from the other repo. (The
subtree subsequent squash merge experience was perfect.) I decided to
be okay with that and give up the idea of squashes; I can use `git log
--author=jnm2` so that I can actually read my history, and in the
unlikely scenario that I can't access the other repo at least I'll
have full history.

The only thing I dislike is that I'm giving up the concept of that
separation between two repos in the same working tree- that some files
belong to one repo and some to the other. That's a cool paradigm.
Since my access to the other repo is read only, I suppose that doesn't
matter. I can't use subtree because the prefix would be `/`, and I
can't use submodule because my repo needs to track my changes inside
the prefix as part of my repo.

> I have not tested this, but I wonder what would happen if you either deleted that history from the host repository or you cloned the host repository to a new place and tried the split there.

I tried that in the course of my tests earlier; if I remember
correctly, I lost the squash merge history. Git log showed only the
parents from my repo. I couldn't do a new squash merge because it lost
track of the most recent squash's parent commit in the other repo.

> I never imagined that someone would *not* want to get the original history back

It's possible that what I was trying to do made no sense in the first
place. It's likely that I'm missing something since I'm new to these
concepts. I feel like I've settled for a less clean solution but I
can't put my finger on it. I'm willing to try a different
configuration.

Joseph
