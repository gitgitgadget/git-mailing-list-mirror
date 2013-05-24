From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sha1_name: implement finding @{push}
Date: Fri, 24 May 2013 21:59:11 +0530
Message-ID: <CALkWK0=LXNRaWz0vN_FwmJKbXT+W11mHABqzSJnbm_izQ0Ttrw@mail.gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
 <1369321970-7759-8-git-send-email-artagnon@gmail.com> <CACsJy8CV192WVW8u6YRnbf6Ue6tFbzyiCARwicwzapSZucaaMw@mail.gmail.com>
 <CALkWK0=XufbcwObBq7_MWX3jL63Nv3YeSvTUpOfXD+XoKkvMag@mail.gmail.com> <CACsJy8AHX0181uON5Aa7oJzX8j3qAA26Ymh5G3YEGidD4O5zvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:29:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfusO-0004aO-Et
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab3EXQ3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:29:52 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:39105 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab3EXQ3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:29:52 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so12646401iec.39
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZWudxnoY/4WmlFDfNy7FmQIIym4maRg3oPu2rDIwt8U=;
        b=e4H5AZ7kNuZat87TWdFuDctFg7yfdkD0Lle4Ze0EswJ8Vfsv0J/FAN4FXbqIXe+Aak
         g0h+vjKlwRpE91qCRwZLtyTJhPXElmlBRi4slr1ggPwDhomdcFmdn9P5YXSyDW+3BFzw
         mvce+IUjHYwDYdTtatj6qwKOd18FpRWuW2pEUh/+vfmsmTws3wPiM/NQPj048gGjOR7Y
         O7VIRiqxnZmqg+BHDupw7oSjfoJWFcKVA9RuCsTiMZFqzg1qBzGA9fTnAehfuftUdaU8
         f3Jc8MCNQjCwsMnkSPnGDNNX/yEtXeXCTgwNNKjDvsRQSD+0cmXTY+1P5xD9Pj2+XwZy
         f1Jw==
X-Received: by 10.50.66.140 with SMTP id f12mr2814724igt.63.1369412991475;
 Fri, 24 May 2013 09:29:51 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 09:29:11 -0700 (PDT)
In-Reply-To: <CACsJy8AHX0181uON5Aa7oJzX8j3qAA26Ymh5G3YEGidD4O5zvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225377>

Duy Nguyen wrote:
> Then "show @{p}" should show the tip commit of rr/master, not the ref
> name.

Yes, that is correct.

> rev-parse (with an option, maybe) may be a better place for
> this.

Er, no.  I actually want things like diff @{p}..HEAD.  I want it to be
a first-class revision, just like @{u}.

> I did not expect @{p} to printf(). If it's part of get_sha1(), how can
> it return an sha-1? And the cover letter said "7/7 is the meat". Not
> very informative.

I also said sorry for the horrible mess ;)
Yes, it's obviously not supposed to print and die() with a "Done!":
this was a development session, and I hit send-email as soon as I got
the right output.  It's supposed to behave exactly like @{u} (failing
to resolve occasionally).
