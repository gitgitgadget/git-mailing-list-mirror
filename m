From: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Thu, 26 Sep 2013 23:25:09 +0200
Message-ID: <CAEQewpp9tCAB_N8jzyeUC05fhHNBsgPyLyTqsRaDFMsq5JdqUg@mail.gmail.com>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
 <CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
 <CAEQewpqbf-sWSt0GS9eXQNi0yFz5-23NcO2JWKO4OgSFv3SXdA@mail.gmail.com>
 <vpqzjr1ujyn.fsf@anie.imag.fr> <CAEQewpoD2VRVtpEyG121TqAptoYfEXxt57CCthBX_EfN7LU0fQ@mail.gmail.com>
 <vpqzjr0pvfn.fsf@anie.imag.fr> <CAEQewpoRhGGnc7HMES1nNbduiRP-qLF4hKBJhRKy7CjMzXnGNg@mail.gmail.com>
 <vpqzjr0oemb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 26 23:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPJ43-0003ZG-SD
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 23:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400Ab3IZVZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 17:25:32 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49459 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab3IZVZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 17:25:29 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so1855326pab.8
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3UbkbH8DO9g1/VV/qHdGo8AXCLIzGA1ZonYP33P414g=;
        b=DMrFawq2s0hAx2a1vwalCm4i+uzF2iNl5QjRiKyr0gBAnT1nS2+zlWT0PQBJuaYXlf
         tZM+G6zq4OYzGWuAWvvh5Xpl3myRWYcYDKAF0+kPABVbbR4jSaK23XEXvwKp9vQPiEv9
         8hXlV2Fsrl7yuARL5QTp9F0P6RArGTbOb32OtsWlStm4UiAjyXO6CluTRBijcCM8LA2x
         gWgRu5E5EKl5jKtkI8cOdUfi+hfCdW5O1exkLb6s6xYQEY/LcFrECLrxODe0zOshAD7O
         iW0oKSlSZWrGPVW8UMpzIZbNBOCocpdEeOAAe1AOyjIdfcXDtHt47h3yjnMA9VtqRwME
         78sw==
X-Received: by 10.68.60.226 with SMTP id k2mr3548013pbr.146.1380230729247;
 Thu, 26 Sep 2013 14:25:29 -0700 (PDT)
Received: by 10.66.229.70 with HTTP; Thu, 26 Sep 2013 14:25:09 -0700 (PDT)
In-Reply-To: <vpqzjr0oemb.fsf@anie.imag.fr>
X-Google-Sender-Auth: zqOQCefK49yGEp19GCsgI-VkHEk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235438>

On 25 September 2013 22:01, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Jona Christopher Sahnwaldt <jc@sahnwaldt.de> writes:
>
>> Yes, I think the rules for the "short form" (the guessing when there's
>> no --) should be made simpler, or maybe the guessing should be dropped
>> altogether. I don't know. I don't know git well enough to be able to
>> be more specific. I just find the current behavior very confusing.
>
> It can hardly be "simpler" (in the sense "behavior that can be described
> with fewer words"), but it could be tightened to be safer.
>
> When a remote branch $foo exists, a local branch $foo does not, and a
> file $foo does, then
>
>   git checkout $foo
>
> rather likely means "I want to use git checkout's DWIM and create local
> branch $foo", but it currently means to Git "checkout file foo from the
> index". It would make sense to die here, and require the use of --.

That sounds good. A rule like "when A is true, B is false, and C is
true, then X" is probably too complex to be useful. It's probably
better to give up and say "sorry, I DKWYM (don't know what you mean)".
:-)

There are a few more ideas, opinions, discussions about all this at
http://stackoverflow.com/questions/18833617/why-does-git-checkout-remote-branchname-not-create-new-tracking-branch
especially in the comments.

Cheers,
JC
>
> No time to write a patch for this. Any volunteer?
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
