From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 2/8] update-index: add --test-untracked-cache
Date: Wed, 2 Dec 2015 20:17:01 +0100
Message-ID: <CACsJy8ChATsTatRdz2wM23vfXy_8o1V5FEwMXo+PBqTBzZBBQA@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org> <1449001899-18956-3-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:17:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4CuG-0000VW-UL
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbbLBTRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 14:17:33 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35822 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbbLBTRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:17:32 -0500
Received: by lfdl133 with SMTP id l133so63537469lfd.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vAIHg0L9K/SONorc+pRnFXRlB440xPBCw4yNp+nWXVc=;
        b=R9kJuF9H2XS1F/A9awk12bHWKEYJH+8tfCuqnJFvhHb+9WDf/SR1esktoeYTuNlVuW
         B2B+kZ+Q0qcOHcvDjucIrnVo9xMI5Ma1lKiG04+b/OWAl7NAQ0MAxtFP1EglJPIWVGR9
         yBMfGtiFPepS+JnlTghImJDtFgl2xlgULB1ytKz14jRTotHp6Cqqz12soBrbrjjAxdTC
         zuWqv1Gu0Vf/IG0C1r7lY/WQpFlQYrV8HZEIKcLeIGM3x+1f2GYdBlkmndY3gBRx6zGi
         M3EPkY2z2ocqtE0M5dlCUX1C63WJ9vB7/LEnUee2thvrvEi/Ii1LSzSZmjPCme3qAEDQ
         heTA==
X-Received: by 10.25.212.140 with SMTP id l134mr4029040lfg.118.1449083850816;
 Wed, 02 Dec 2015 11:17:30 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 2 Dec 2015 11:17:01 -0800 (PST)
In-Reply-To: <1449001899-18956-3-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281908>

On Tue, Dec 1, 2015 at 9:31 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index e568acc..b7b5108 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -996,8 +996,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                         N_("enable or disable split index")),
>                 OPT_BOOL(0, "untracked-cache", &untracked_cache,
>                         N_("enable/disable untracked cache")),
> +               OPT_SET_INT(0, "test-untracked-cache", &untracked_cache,
> +                           N_("test if the filesystem supports untracked cache"), 2),
>                 OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
> -                           N_("enable untracked cache without testing the filesystem"), 2),
> +                           N_("enable untracked cache without testing the filesystem"), 3),
>                 OPT_END()
>         };

I think we got enough numbers to start using enum instead.
-- 
Duy
