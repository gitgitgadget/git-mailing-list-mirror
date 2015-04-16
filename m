From: Pedro Rodrigues <prodrigues1990@gmail.com>
Subject: Re: git-archive ignores submodules
Date: Thu, 16 Apr 2015 19:09:47 +0100
Message-ID: <CAL1ZDKbcmrer481fRY2NEHUQ1J5tjRbHz2yLEcszh3Q-NjcvcQ@mail.gmail.com>
References: <CAL1ZDKZs++NkLoHZ_w_YebQuZYG3rgAiH5SsaQfTmb9MPHjR3w@mail.gmail.com>
	<20150416175623.GJ21868@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 20:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YioEc-0007Pc-UU
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbbDPSJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:09:50 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34718 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbDPSJs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:09:48 -0400
Received: by qcyk17 with SMTP id k17so10978823qcy.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nKjz8DTg0lR9Y8PgMwxIcG70tw9cV/5UPy0En4+RiVI=;
        b=Ntg3XcFAUwFwLwaaFo6ZKj0Mt21aTn/s6iOm5WlXKYZozVXhn3YVgZ22c9tuJ93Krl
         dKftgjOs6Yj3HIwU4No6ZIBqMmQi4qfuYCfNL/nVVObDOrOOZteLhWWG0moIFhWFlEar
         enWJ3LKQR9WqbzIfe5ecHj0RwzxRknZVIR+TBjB/e0DkZc9S9spFXNu/qrdf9kzAEd3K
         AhVFNeqK2AaP1l5X1Mqg4K51I+U/yj5EbrxjBp8fsMG+fZcwBbOftLLtQxy1VTQQt8cs
         ue6yoPzC/nAtDBCYLdoTId3AShk0/jcRuguFKkLjdnjB9iEp3dP9qmFYK7GMdq5ZD+lG
         wwsg==
X-Received: by 10.140.101.214 with SMTP id u80mr38872883qge.48.1429207787634;
 Thu, 16 Apr 2015 11:09:47 -0700 (PDT)
Received: by 10.140.97.100 with HTTP; Thu, 16 Apr 2015 11:09:47 -0700 (PDT)
In-Reply-To: <20150416175623.GJ21868@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267318>

Good to know about git submodule foreach.

Simpler yet, I'm using:

zip -r ../project.zip . -x *.git*

Which essentially does the same thing I would need from git-archive
--recurse-submodule, zip everything excluding .git folders. Still
would be better to use git itself.

2015-04-16 18:56 GMT+01:00 Fredrik Gustafsson <iveqy@iveqy.com>:
> On Thu, Apr 16, 2015 at 06:35:38PM +0100, Pedro Rodrigues wrote:
>> I've been using git-archive as my main way of deploying to production
>> servers, but today I've come across a git repo with submodules and
>> found out that git archive has no option to include submodules on the
>> output archive.
>
> As far as I know this is an known limitation that's just waiting for
> someone to solve. Thanks for bringing attention to it.
>
>> This simply makes git-archive unusable on this scenario.
>
> Not completely. There's a simple workaround. Combine git submodule
> foreach with git archive and make an archive for each submodule.
>
> Not as simple as if git archive --recurse-submodule would have been
> implementet, but hopefully it can make things work for you at the
> moment.
>
> --
> Fredrik Gustafsson
>
> phone: +46 733-608274
> e-mail: iveqy@iveqy.com
> website: http://www.iveqy.com



-- 
Pedro Rodrigues
+244 917 774 823
+351 969 042 335
Mail: prodrigues1990@gmail.com
