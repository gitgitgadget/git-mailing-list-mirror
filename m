From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] MSVC: vsnprintf in Visual Studio 2015 doesn't need
 SNPRINTF_SIZE_CORR any more
Date: Tue, 29 Mar 2016 21:20:18 +0200
Message-ID: <CAHGBnuNkuiyk1uvJqT1_1UWOhpVTg+TxJ2QvepuMBpvOD8AyFw@mail.gmail.com>
References: <56FAAC78.2040304@cs-ware.de>
	<CAHGBnuP1Y1F-CrQJx9zNKSv1KP7gH86WSKo7tbmcYT3Vf2cQ_g@mail.gmail.com>
	<56FAD3DD.4060009@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	blees@dcon.de
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:20:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzBh-00085m-E5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbcC2TUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:20:20 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35781 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcC2TUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:20:19 -0400
Received: by mail-vk0-f66.google.com with SMTP id e185so3552683vkb.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=AVZpP6ZK23fG4PT3Bf4Y0G2AKi02aEDqcL5Dmv1jngc=;
        b=LvqD3rQnPQ4muePw6EqSuL6Gl91p4D9wiV7u0MT7p45ikp6itL66vh1bDTclN2OCIf
         VLqh9EkPdImM6HhOGX8GW9TGs7Nk5gBqmGE0+zZwRXKGcHfjNv/nG2jenJoFr3PPeKM8
         NWfa7SCPSPTgzJYCB0odLjQiTQMgTRI0h0OyPe6KXzadW9xNVAlE0KfOEtJ0xwB478lh
         aZO0yG+Uhl0ZtneNF4g5GfXIAEWf/L6xGy8XPGAXvv7bNrVyoUlPkEb2hgun/00yz5ci
         r0ysQCVc6f7onUmre+bvocC6+zudwDCUb7PFBUrOZINHILNbpstSExhpFX5W5rc5MV1A
         LhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=AVZpP6ZK23fG4PT3Bf4Y0G2AKi02aEDqcL5Dmv1jngc=;
        b=TzrguQmV8qmgjcfhrOk2fBiC/4kM4L8F5jvd6uvgBJI1UilBCD9e6V6EOXEU4Dw4Fg
         gTTRQzyoLTC6S0cJd2wix9SbRf3Zjn5vfz1gU7RickGh+Cf7U4b3Ymx2mB4UMnFCqWKa
         8V5FRiJ+rm7n87zffkbGQTF7uDBcJgC++/gEOou840KoZvHn7MZRjKHULIQgEvyDhHuL
         3awGGnnUiR8x6eDeuRlYm6ZNEBljXSO1VcZxUHand/lfP8nKDQ6BSTp52F1Ddp5G1aJ0
         yCFT/Qe13Y8ZiLYdaoiM8eVNF7i+i6auwr8N4u7tDGH3jNcVuq8l/EC0dYwH2KpE1sCu
         FiWg==
X-Gm-Message-State: AD7BkJJdQiGfWlOwFyiwxbzbCjpKHVUAjzmcVkmRKVFiWrYFHXn2ingNlJ2097pGVMQniW7T4Bc7cwmF5K7FwQ==
X-Received: by 10.159.36.39 with SMTP id 36mr2318414uaq.16.1459279218195; Tue,
 29 Mar 2016 12:20:18 -0700 (PDT)
Received: by 10.176.68.6 with HTTP; Tue, 29 Mar 2016 12:20:18 -0700 (PDT)
In-Reply-To: <56FAD3DD.4060009@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290166>

On Tue, Mar 29, 2016 at 9:13 PM, Sven Strickroth <sven@cs-ware.de> wrote:

> diff --git a/compat/snprintf.c b/compat/snprintf.c
> index 42ea1ac..0b11688 100644
> --- a/compat/snprintf.c
> +++ b/compat/snprintf.c
> @@ -9,7 +9,7 @@
>   * always have room for a trailing NUL byte.
>   */
>  #ifndef SNPRINTF_SIZE_CORR
> -#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
> +#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4) && (!defined(_MSC_VER) || _MSC_VER < 1900)
>  #define SNPRINTF_SIZE_CORR 1
>  #else
>  #define SNPRINTF_SIZE_CORR 0

I wonder if the logic is (and was) sensible here. We assume that every
non-__GNUC__ and non-_MSC_VER compiler on Windows requires the
correction. Wouldn't it make sense to not assume requiring the
correction unless we know the compiler has this bug? That is,
shouldn't this better say

#if defined(WIN32) && (defined(__GNUC__) && __GNUC__ < 4) ||
(defined(_MSC_VER) && _MSC_VER < 1900))
#define SNPRINTF_SIZE_CORR 1
#else
#define SNPRINTF_SIZE_CORR 0

-- 
Sebastian Schuberth
