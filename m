From: Stefan Beller <sbeller@google.com>
Subject: Re: Tab completion missing for --includes and branch description in
 git config
Date: Wed, 7 Jan 2015 10:14:36 -0800
Message-ID: <CAGZ79kbNyXLyXMRPqk0HPpYK1XSbnL8tZEvXRaWW-rNK=OrQCA@mail.gmail.com>
References: <CAB7nPqRnDTEXWEDUHX7xJG_+QvoXdt2aA6RLRn4Hiq-rOZMEmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Paquier <michael.paquier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 19:15:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8v81-00026k-MH
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 19:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbbAGSOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 13:14:40 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:56093 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbbAGSOj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 13:14:39 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so5134921ier.6
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NzUK5I4w0/283TidR0XMol9gTEW281sLKP2IzZvHaxs=;
        b=afdR+NWT4NXYvvwdWVvM8ZgJ7tD3V34F+OYxyt9XN/0pojQeQdgM4hWcO5v4NPAYJW
         sbdoBgiRhBytC7xfWsYuex/qGBcZxjaKFJ+CC1easzU2EJKDBvmagVMcVhc/aKq4RRCK
         Ge1BdaOJlyPKG7T90jUzYS/anV0yO8dLHcU6IARkUTVfuhbIi5eMqo5OyNV6rFhs8QsV
         ZKZjoI67vL9tw2KKnO4b2tT8RCaZ8dL9ar2mBOYdiasqAX9oCtJf6Tv2T7HUfS9iTmlc
         qsBqv/chlmof/8256C26WjOD4QT52FvMzeswyLdkwsMOWX22+MDnRYHsFAG0BIqKZBK8
         fQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NzUK5I4w0/283TidR0XMol9gTEW281sLKP2IzZvHaxs=;
        b=C+XA9AfUd6AWYiTdJzr7kvA7JolI0CNPSgnc4aA9tu34cAGmCJG+il6k7WUUkFX07S
         I2cZrnRlh6DU2RxyhrMYbyoJwj1HXOl/G1AbKnHDYo7K6BncKnrO1HeYj1WJAC2lPwtq
         6LJPgLWm5agkdp2aAUW68pMbSvLjrSJ9lv0HTJhZhKGDiyYNjPzTAfTo1xlvO5+e59IG
         9Q6CcXsgI6/iOiWvBXHD7UcBDugxCRt46VBKAVam33+DbU2SGDqaeKjAM7dj2+twOedL
         PN3Rd4ihy1pI9dtRhk5o0vg1pPHzUGNEx+gkxmXgFg+NVNuVKAyK63itb95UaQLmdipz
         bZ7Q==
X-Gm-Message-State: ALoCoQmim3pgZUxdw7W4sai7UlQnjDS77Vsqns2IJvgia9+c156F+mYLBh/oDap+tOhjr5Lu563r
X-Received: by 10.43.82.72 with SMTP id ab8mr4434441icc.76.1420654476943; Wed,
 07 Jan 2015 10:14:36 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Wed, 7 Jan 2015 10:14:36 -0800 (PST)
In-Reply-To: <CAB7nPqRnDTEXWEDUHX7xJG_+QvoXdt2aA6RLRn4Hiq-rOZMEmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262140>

On Tue, Jan 6, 2015 at 4:58 PM, Michael Paquier
<michael.paquier@gmail.com> wrote:
> Hi all,
>
> While toying with the tab completion script for bash, I found a couple
> of things missing that cannot be completed:
> - git config --includes
> - git config branch.$BRANCH_NAME.description
> Attached are trivial patches based on master to fix those things.
> Regards,
> --
> Michael

Thanks for your effort on improving git!

Please have a look at Documentation/SubmittingPatches in git[1],
specially section "(4) Sending your patches." so discussion on the
patches is easier.

>Do not attach the patch as a MIME attachment, compressed or not.
>Do not let your e-mail client send quoted-printable.  Do not let
>your e-mail client send format=flowed which would destroy
>whitespaces in your patches. Many
>popular e-mail applications will not always transmit a MIME
>attachment as plain text, making it impossible to comment on
>your code.  A MIME attachment also takes a bit more time to
>process.  This does not decrease the likelihood of your
>MIME-attached change being accepted, but it makes it more likely
>that it will be postponed.

The easiest way to comply with all these rules outlined in SubmittingPatches
is to use git format-patch and git send-email (as they follow the best
practice).

I recently wrote about my experiences when sending patches to the git
mailing list,
including how to configure git send-email[2], maybe that helps.

Thanks,
Stefan


[1] for example it can be found at
https://raw.githubusercontent.com/git/git/master/Documentation/SubmittingPatches

[2]http://thread.gmane.org/gmane.comp.version-control.git/261900
