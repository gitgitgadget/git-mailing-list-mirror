From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] Spaces not allowed in directory names in .git/info/attributes
Date: Tue, 24 May 2016 08:37:33 +0700
Message-ID: <CACsJy8DXW-K-iNO65yuzMLPZS_8+R1gsQgNftwei1XUZNxhicg@mail.gmail.com>
References: <CAO8RVveOwrS6+pTnHY36d1Nk_B_VJD022W9i8STnNb-KyMkqNg@mail.gmail.com>
 <xmqqmvng8qle.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nathan Collins <nathan.collins@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 03:38:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b51IQ-0001EJ-9x
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 03:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbcEXBiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 21:38:05 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37512 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbcEXBiE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 21:38:04 -0400
Received: by mail-ig0-f174.google.com with SMTP id l10so3087928igk.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4gUWsPme9DaVU49idXb6YHAbCPSqJ4XYCXZL1eM6rF8=;
        b=VQMZBL+gZrscYd1u/++mfwLNGyH0OfGVhtkC2qxJke/69arVyZQ2UXO8nZSIK9aNxK
         YTX0vN6CaUUPa107ixImQxn5eTKOtAxk4s4wUFLXBqV+8755aeE/Ne6bbXfkyKS3xrpu
         FUSTgF/8zBK3+REHUUfpxJ3PiaMp7Zvifc/WJTJZjrRzaZcjm7WGHwF3ocR5wTQJqU/r
         GgHB6fpscphMWRSVqHh46sdMZYbK1aMpW70yqgeM4TBZYcxRP41M6+6bt3TCAFAGXvbs
         nYXmEX/pFnE3ish5DaElGBtJMI6hnvY9G4LkoyGVrp4QuIJ1Fsp9vxSFbugpX/TppAGD
         L6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4gUWsPme9DaVU49idXb6YHAbCPSqJ4XYCXZL1eM6rF8=;
        b=VNA8VtsL5ZHP8Zr7DFVUitU6OOQcz4z0v1Te8J+aUEFp9Hp3XhvijOEAO03b+n9jXz
         ZOB48VfhFumqpxyZiOPWc/r6GNVcDGPzt3DzLqBP9yTd5E6yTYsSVc8IcXdquQeWOl0x
         0CkPlYQaL5uQjUHyD7Z4wAz3SXGJeAQnWivZsGz1f+OrmckXT+OBZnqZB3Gg5UHXNT8r
         nKg5gDKzItridWa54lgDvu8HgGDpg+jMRGTW6U0/zO9KcwLJHbH78ySKvsAUd1GU6Vy9
         ovCPabRghVW0/YUFhOOgNQawrsdbkG4QnSb2Ni86Bu0/1wDXBT80S9MjA8+GpFF7aDKE
         i0VA==
X-Gm-Message-State: AOPr4FV8/5d0ACa9WzzQceUMX5F1ioyGorP7fcY+Od5FgyvEGTenUTxhaw9HV93/tB2Bj2U33VrFReL+ubssjw==
X-Received: by 10.50.50.135 with SMTP id c7mr14571252igo.33.1464053882915;
 Mon, 23 May 2016 18:38:02 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 23 May 2016 18:37:33 -0700 (PDT)
In-Reply-To: <xmqqmvng8qle.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295410>

On Tue, May 24, 2016 at 3:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nathan Collins <nathan.collins@gmail.com> writes:
>
>> Example session:
>>
>>     $ git init test.git
>>     Initialized empty Git repository in /tmp/test.git/.git/
>>     $ cd test.git
>>     $ mkdir "dir name"
>>     $ touch dir\ name/file.txt
>>     $ echo "dir\\ name/file.txt -text -whitespace" >> .git/info/attributes
>>     $ git add dir\ name/file.txt
>>     name/file.txt is not a valid attribute name: .git/info/attributes:1
>
> That's because spaces are not allowed in paths there.
>
>         echo "dir?name/file.txt -text" >.git/info/attributes
>
> may be an easy workaround for now.

Maybe bring back [1] (cquoting paths) and optionally optionally with
backslash escaping? The conclusion at the end of that thread seems to
be "ok, we may break rare setups, we just need to be upfront about
it". Another option is the pathspec way: match quotes literally as
well.

[1] http://thread.gmane.org/gmane.comp.version-control.git/160597/focus=160720
-- 
Duy
