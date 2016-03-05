From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v4] pull --rebase: add --[no-]autostash flag
Date: Sat, 5 Mar 2016 17:56:13 +0530
Message-ID: <CA+DCAeTsh8Ff8ifiE+e4_ng0tDB7z2uvkT2Nf5OhtZOBaoj9Kg@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457171545-14496-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 13:26:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acBI5-0007lX-5a
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 13:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760788AbcCEM01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 07:26:27 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34580 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760774AbcCEM0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 07:26:14 -0500
Received: by mail-qk0-f193.google.com with SMTP id u128so2592686qkh.1
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 04:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=9EUut2+7eOQo8umWzWEYBDoOaOZH7oXtxMioXhzHlws=;
        b=MCir82/3jusyYdnfgHiNhVSpEYRuP/Ix+oozGlei8SYi1rV39u1cciqmQj+MNBEN0F
         EGk15ps1rg1fJA723wi6lcIiFCufJEMaS5uCkUlJj9SS2zlHY+6kdxewglyQokmhWcwJ
         b9hUVWwQP94sNotRbkMP54raV9uE9FdO92OgB9GE+aF1Nkzc4NNggzTYTiveAjL/uJB/
         E8a+rXLCjchG9PufVZovi9yHSmKsPOXnxIg0LoBNrfO0OD8R8FAxKnY39wZNkArtt8/r
         GtnKmJmyIIIq5bvRUfMUueWJS7h5hsqlHwEsGIHUZ9HtHElwuWFZXMxdjOk7u0gNBVlL
         c7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9EUut2+7eOQo8umWzWEYBDoOaOZH7oXtxMioXhzHlws=;
        b=nNo/JsvaVqvKFUmnhX8cgeKO/wcfCIy++rdMwpddrFvOl3fM7WV1hg4T43lGhwNcw5
         JAC2hVEvr+XIizn9ZlwaxFDCOBP5Wz30gtuCB6SbnRNvkzQrlS9tSFQyAIzd02yHeZS/
         WnipIR8RSc9kHsEpStOnyBrUar3GGxV+kkPdXDtQuh0dFW7K4IzButJiLwaN4GPDIg24
         ALrHCDghuwyIXfJIxpuuPN6eWk6q6Uq3kRJgmbeFMcSVMzWFMi3eksP6RRCYBLre0Rfb
         AIqe0VEaN+m7c475vsR2R5BXqfrGqNaGPvbz7w0+EKBddoOOqoLJWN0v19zL8ClKpVbB
         z+cw==
X-Gm-Message-State: AD7BkJL9hjG102kvNGt+iFXlY9fu1kP/6VbnQ+NXR9JtYLN0NqYCBD5kNu/bGeuSaeEYS08M8WKRFLVHiK8+Dg==
X-Received: by 10.55.54.201 with SMTP id d192mr16388018qka.23.1457180773309;
 Sat, 05 Mar 2016 04:26:13 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Sat, 5 Mar 2016 04:26:13 -0800 (PST)
In-Reply-To: <1457171545-14496-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288313>

On Sat, Mar 5, 2016 at 3:22 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:

> Changes:
>         * --no-autostash is passed to git-rebase (suggested by Paul)
>
>         * Error message changed when "git pull --[no-]autostash" is called.
>
>         * If rebase.autoStash is unset and user don't pass --[no-]autostash
>           flag then nothing is passed to git-rebase (i.e. if rebase.autoStash = -1),
>           as it should be left to git-rebase to decide what to do.

I'm sorry. Here instead of " ... (i.e. if rebase.autoStash = -1), ...
" it should be " ... (i.e. if opt_autostash = -1), ... " .

Thanks,
Mehul
