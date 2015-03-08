From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t7510: do not fail when gpg warns about insecure memory
Date: Sun, 8 Mar 2015 17:43:41 -0400
Message-ID: <CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com>
References: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:43:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUizG-0003oT-KZ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 22:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbbCHVnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 17:43:43 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36508 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbbCHVnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 17:43:42 -0400
Received: by ykp9 with SMTP id 9so1812447ykp.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KMnY1ERulgBxQqKq2ItHQ4dyk2debesOUKBtZ/u0q2Q=;
        b=wyExNZ8lK6WXzNO4C45SDXFIFwAM7z++B9sd2ge86dSM/pO+gUmCIZF+RnJTD9dDon
         BUVyEvY9sPTTGuACCon8ZU6d16ERAgDKjF3KMT9NQ4k0li7ZwvmQyOtmSfpnhVtwlGde
         Y+qFyfIxJcp0MFp6j2lrPzwYxFDV3oVmqyWrS2YwQOPhlBIOpxxFwaReYjCKkR9eqbt/
         dshX113CoJ26+veuG7YQ7fCM3wVFOUGom+O4aXj/7IET3o9orD/ur3GAINFqAB0Q6tnd
         0+LkMcOgSfQVOrcPcrJ82OSXtgiwSfPxEOASPvntjeFuxmBFwkFId5Gm0uKQWgZLiA6r
         9vag==
X-Received: by 10.170.136.19 with SMTP id d19mr27874228ykc.2.1425851021464;
 Sun, 08 Mar 2015 14:43:41 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 8 Mar 2015 14:43:41 -0700 (PDT)
In-Reply-To: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c>
X-Google-Sender-Auth: eGCZDeZv2f68vmAXFMnc5lQqbtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265110>

On Sun, Mar 8, 2015 at 11:40 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> Depending on how gpg was built, it may issue the following
> message to stderr when run:
>
>   Warning: using insecure memory!
>
> Unfortunately when running the test, that message gets
> collected in the stdout result of git show -s --show-signature
> but is collected in the stderr result of git verify-commit -v

I'm having trouble parsing this. Is there a word missing?

> causing both the stdout and stderr result comparisions to fail.

s/comparisions/comparisons/

> Since checking for secure memory use by gpg is not the point of
> this test, filter out such messages to allow the test to pass
> even when gpg is "using insecure memory".
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
