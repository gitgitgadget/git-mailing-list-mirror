From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3/GSoC 3/5] git-credential-cache: put socket to
 xdg-compatible path
Date: Fri, 25 Mar 2016 22:28:55 +0800
Message-ID: <CAKqreuzwa+ztwsF3CRb++J-iqW=_evfBQ7Q7veyYU2ydJXnpcg@mail.gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-3-git-send-email-huiyiqun@gmail.com>
	<20160325100041.GC8880@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:33:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajSjV-0007jE-Eo
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbcCYO25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 10:28:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35386 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbcCYO24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 10:28:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id r187so10277040oih.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=dE9oeMtkCYF5S6Ph07HIm2+HA+lQ3UAiDFS/7J5SJqs=;
        b=HOsANrkI7afK09WmQWYzDGJ8AS10G4AEI1fg6jGjA1vb6V6hrjTEem75J7ak/H7ImM
         UjStdOgoxsxvNAagQauHQyR8G4cDwz21rLTjNu8jHaXeagICj4QkLU2/W2wWpXSD8rsX
         HwLHN7m2ZkfQoe6c7fgLrWNlqURazLV9mQENrsVt28wrZIUBPKOron7aP1twlJJWFlJM
         QXx3iCykJjrwC2a6bVw7FQc2PlDhwDqq114XoUfp1j7tLtsvHy7/GJ3HINZMaxxBdqz+
         NOHkxrDlFXvfH6GrlgqPkyXLZGR3j9s73T/tS5e705NeYhTWbin58LIdmhysqUtHYilJ
         azVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dE9oeMtkCYF5S6Ph07HIm2+HA+lQ3UAiDFS/7J5SJqs=;
        b=a8BLwecMZh73Lo3MSG+lg4mJMOhlGIutCg8QSUS9FQ7q1DtgpictvtLH1BBkm6O/2I
         5vo6R2+gs0EFHJwS+xUnLOG6hgKswbkHCCdS3h4Mr+7xVGN5UPio4YHeU0BscnnXdfd8
         qLI4obkocTQkMn+VxGG2vrExkfBg9U0csRAjhjcO53C3dvmR4CtYCDR5nfqh3U5DjbWi
         hVZ8/lQ05nZTfY/L90lOcf2Kf7lRTib3x3GuRty0ZNv1dvZRj9tKJJdqO9kb79tPBhJi
         oYi686U2yFKC1fl8OzOg2mFMoXN1HkgUb274G96NRaSa3jZmC23/eFS/XsN4x8ID+MwO
         MBYQ==
X-Gm-Message-State: AD7BkJJt/FxgOcbZ/s2GYydkrXRkCVMG+NTc+w1sLITT7MnHCZHVhxnoUht7mQHTODoAkQcmvpRbAJRNLJIWCw==
X-Received: by 10.157.17.72 with SMTP id p8mr7711562otp.162.1458916135939;
 Fri, 25 Mar 2016 07:28:55 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 07:28:55 -0700 (PDT)
In-Reply-To: <20160325100041.GC8880@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289890>

2016-03-25 18:00 GMT+08:00 Jeff King <peff@peff.net>:
> On Wed, Mar 23, 2016 at 06:13:23PM +0800, Hui Yiqun wrote:
>
>> move .git-credential-cache/socket to xdg_runtime_dir("credential-cache.sock")
>
> Motivation?

I will improve my commit message.

>
>> diff --git a/credential-cache.c b/credential-cache.c
>> index f4afdc6..40d838b 100644
>> --- a/credential-cache.c
>> +++ b/credential-cache.c
>> @@ -105,7 +105,7 @@ int main(int argc, const char **argv)
>>       op = argv[0];
>>
>>       if (!socket_path)
>> -             socket_path = expand_user_path("~/.git-credential-cache/socket");
>> +             socket_path = xdg_runtime_dir("credential-cache.sock");
>>       if (!socket_path)
>>               die("unable to find a suitable socket path; use --socket");
>
> We do our own mkdir and chmod in credential-cache; this should be
> redundant with what xdg_runtime_dir() does, and can be removed, right?

But user may specify another path via --socket <path>, this path may have
wrong permission. I'm considering how to handle this situation.

>
> -Peff
