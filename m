From: Elliott Cable <me@ell.io>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Thu, 31 Mar 2016 19:49:26 -0500
Message-ID: <CAPZ477MmUCmTF+Pyn0wAHVjj3LsZ9M3-v2fPb3+vD9r+rEfwBw@mail.gmail.com>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <20160329203425.GA24027@sigill.intra.peff.net> <CACsJy8BAW0E36qKjJqvLL0ZHKdh3+7G1axt1jD46Yv3atfL7fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 02:49:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alnHc-0004oa-Ue
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbcDAAts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 20:49:48 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33357 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbcDAAtr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 20:49:47 -0400
Received: by mail-yw0-f170.google.com with SMTP id h65so124076005ywe.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NVlckgqe/+XsNk+Af9NholQLtfMl09QOLD/L1/MlJ6Y=;
        b=Wb0D3SdEAruvE5dzY/IAngcVKQNGv0JEjqK3buARJQSHYekTGOcZrC7Gc+/h+qjt74
         wvfp6NKLDKbNBMYZ82pJtCPYBQh7n6bNdQufwTpVJ/1Aw/p2NDJy+EnBmUaXmXavAFKB
         OMggUjUdMNuX7PRL8H/cs6gLuFx1NxvLGYmmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NVlckgqe/+XsNk+Af9NholQLtfMl09QOLD/L1/MlJ6Y=;
        b=caXLOigmiRpB1n5H/0dO4PIZ1Wmmwbhwq7QGJRnu6BwvBEVPvKstDC0YpxDOa9NAmr
         GYAw5jndvAl37bUxeu2AH+jxjTrwzPyOR8LJKcEewCxJPyqTpJJE6D/nRIZ9lZ3aFnMR
         dQVJ8JCgCZCRpjyxnfhLVFVY486ryYiHV9Oc6XbkzHxZ5xe3oFsW/Rz7qwAtvyqsqkXx
         L+XajBNR8eNW1xvBGtWKRfWQT0qVHCcD6pdBEcrqrxZsxfyU9RwCsjrqMKtgIRdcAxU0
         4KE01obIQB6f97BAqfx/N7DivXTub25i4Tj+Kbnm4l/zuGvBXh/KPSHiSqLYw3N47Eyt
         x0dA==
X-Gm-Message-State: AD7BkJKAR7W92D6LlTNShsvesvG0t5JFicWkBAaNbBijaV1EvACfAjzWEw/ViRak4pj7Jq7Y+78tuaQ7rUT/nw==
X-Received: by 10.176.3.81 with SMTP id 75mr881820uat.137.1459471786551; Thu,
 31 Mar 2016 17:49:46 -0700 (PDT)
Received: by 10.31.92.206 with HTTP; Thu, 31 Mar 2016 17:49:26 -0700 (PDT)
X-Originating-IP: [70.194.71.174]
In-Reply-To: <CACsJy8BAW0E36qKjJqvLL0ZHKdh3+7G1axt1jD46Yv3atfL7fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290502>

oh, wow, this got over my head *real* fast. Okay,

1. Yeah, my `$GIT_WORK_TREE` was def. an absolute path; I typed that
example code without running it *precisely* that way (entirely my
mistake! I'm so sorry for the confusion it caused, and all that typing
you did!); if I remember correctly (not at the machine right now), I
had run `git rev-parse --show-toplevel` from a different directory,
with `$GIT_DIR` set, while trying to narrow down this bug, so it gave
me an absolute path =E2=80=A6 and then copy-pasted that path, and then
replaced my copy-paste with the original command to make the
bug-report example as concise as possible? oops. But, yeah, it fails
in the manner described above with an absolute path. (Which it looks
like you two figured out above.)

2. Re: intentions, again, it seems like you've changed your mind, but =E2=
=80=A6

   >  So it is a misconfiguration if you only set GIT_WORK_TREE
without setting GIT_DIR.

   I really, really hope not! Half the usefulness of `$GIT_WORK_TREE`
existing is in that mode. In fact, that's how I found `$GIT_WORK_TREE`
documented and explained, in [this blog
post](https://git-scm.com/blog/2010/04/11/environment.html) on the Git
site. That usage seems pretty damn useful, so I do hope it's
eventually explicitly supported =E2=80=A6 (and if that's *not* going to=
 be the
case, it should be explicitly documented in the `GIT(1)` manpage,
alongside the other documentation of the environment-variables, that
the behaviour is undefined is `$GIT_DIR` isn't set first. =3D)


=E2=81=93=E2=80=89ELLIOTTCABLE=E2=80=84=E2=80=94=E2=80=84fly safe.
=E2=80=83=E2=80=89http://ell.io/tt
