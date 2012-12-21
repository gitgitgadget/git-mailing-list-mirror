From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Pushing symbolic references to remote repositories?
Date: Fri, 21 Dec 2012 13:54:29 -0800
Message-ID: <CAJo=hJvqptfKqM+6J8Ddfb5qcqjAU8bB_JO9VB-XVsCCf64NUQ@mail.gmail.com>
References: <CAD03jn5ACZyxJM9LEOSJov3BsT3W1N0sV3WYwcerJciMSpmSPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:55:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmAYe-0003Wg-Sh
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 22:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab2LUVyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 16:54:52 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:60863 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2LUVyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 16:54:50 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so3821979qad.19
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O1EWvORifx1lFUG8tZw8jusurpzE7LIjHlTRzeETm5g=;
        b=VPKwvU4I7tozJ7keKoJMt6H+TXdWwqFL41bYsDfCT4gF0nhZUcCI/26Q981F7aTse5
         U5xcQhmsRzHPKmuvsUmU7anbauCXpAx1v4qIL9G+EKLXefJQju3z00NfSpxrE3e4iQ9+
         nZ8gKIBjwZrhQs1vwn9Tov/x9qlwFaj/FodiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=O1EWvORifx1lFUG8tZw8jusurpzE7LIjHlTRzeETm5g=;
        b=d6f3TPlieIkike+feF1AURQKqVbRA3S4W+z8KGf+kNYTr532nuLvj+89zg6uG6hsO0
         2oM6pWU80NjeItp6BCZk94Bk4utbvmitFCR6xlEuygdk+Ho2AdAJkUo3pCqDmLNZHalB
         BW8RiIPycf7cECnXDNpFpVIgNQotCQV28ZqeztZor850RdanWFF9mahEushPyAfuv4F3
         9SK+oZonkvoUKqMCVBP0GI0+ifZqjEDSqoPCsnM7wFrTjcvpUO2Gy/rlhxERpZ6yZXAp
         BHQ/e/Z8NmvP4AYDTZzFrcIg1OWyY4YJzHMJJLQgeljFpFTW8e5RJpZEPgc0GpmCcCBi
         27TQ==
Received: by 10.224.196.70 with SMTP id ef6mr7770502qab.14.1356126890083; Fri,
 21 Dec 2012 13:54:50 -0800 (PST)
Received: by 10.49.120.4 with HTTP; Fri, 21 Dec 2012 13:54:29 -0800 (PST)
In-Reply-To: <CAD03jn5ACZyxJM9LEOSJov3BsT3W1N0sV3WYwcerJciMSpmSPA@mail.gmail.com>
X-Gm-Message-State: ALoCoQkIKJ3xOIL0j8AKThxlgNbFZ9Y+z8dRewYOKn3lQnaua5S0mDT9r0rSmy3MP352dknp0Av1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212014>

On Fri, Dec 21, 2012 at 11:53 AM, Dun Peal <dunpealer@gmail.com> wrote:
> I need to share a symbolic reference - essentially, a named pointer to
> another reference - among multiple repositories.
>
> As shown in the code below, I can successfully create a local
> symbolic-ref `foo_ptr` to branch `foo`, but can't push it to a remote,
> in this case `origin`:
>
> $ git branch foo; git symbolic-ref foo_ptr refs/heads/foo; git rev-parse foo_ptr
> fbfec27dc6d42d48ca5d5b178caa34c666a4c39b
> $ git push origin foo foo_ptr
> error: dst ref refs/heads/foo receives from more than one src.
>
> Is there a clean and reliable way to do that, or are symbolic
> references just not meant to be shared?

There is no support for symbolic references in the network protocol,
so they cannot currently be shared by git push or git fetch.
