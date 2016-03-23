From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] add option -n (--no-checkout) to git-worktree add
Date: Wed, 23 Mar 2016 13:43:13 -0400
Message-ID: <CAPig+cTRa5YmbHdbXFNKNPN3GKpGOBUdVk774u9446J1qnYpfA@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
	<xmqq7fgtdwgb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ray Zhang <zhanglei002@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 18:43:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aimoR-0000eX-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 18:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbcCWRnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 13:43:15 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36710 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbcCWRnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 13:43:14 -0400
Received: by mail-vk0-f54.google.com with SMTP id z68so28675413vkg.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=EvVJqovqJZbVyTBMYQdW1YGx13H68RAaUycfdcHmE+M=;
        b=MhMEWdVy7UscC85VQtBiJzUzhNmlbXUDEfBMbeQAOgpIVjz/bg8X3E7SElA8wsxiYt
         +htQRuzsmhqwUkyKnjnOSxPZyZRFVYmVm6iSPuktJNe0bRBi+ec53t5pcfjpe2PFWidq
         5IqI0OBkutUPAfJLjSOCvPKXh7CGPv/ezfjoR3SO2ip22NqjVVOKbKIsRXKyaYTwWXDK
         +It1tg1xWJBVHSLVbGzWWz6AKPcaY6syyruQdAX6ysdwxeBdwO9o95jJ3JBhoyIzqCkU
         gmo6MnaUCzby3dPaFdpKK/idK1Z5kDgacsPUWuLoU7P6duO9wn5cXzb3aPkgGBdhttpy
         3KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=EvVJqovqJZbVyTBMYQdW1YGx13H68RAaUycfdcHmE+M=;
        b=SwGoixDPm+Ps2RarWrnOA98Bj8zjYYHHXoEsKlNG8NfP1ZL3gyEedZJSS26be6e5cj
         3aUmrssx5RNCHxFGv54TrGI5gFEseFyF9QeUoQGBYCH2EqIOiUeHTQD4+8e4yp1wPOEY
         XOAAck4COW/Y/Q26s/eA2JB16FqbSLs0EGFB7UeqbzGbo+RVJPR+YzOsIpbjAd4EkUmb
         KFg7TqISUt2rL2e3Eaq5NIzLwzEEHLVht87uUKnLr3PIFqBdkXJeLJwpFcfRcDrZ+KNA
         yEgwF3h/Xd6KWcQ3JxyeWDoxRf/dB09WeL9xJH5SQpR2HG20QptPCNst/JJHrtYGnv3D
         OOSg==
X-Gm-Message-State: AD7BkJJbummBdKaP1Q4I+W+2HoCFv39LgkM0supXXAsjhzYu/8HHRS8qEWAPdThXQO/MCAr108do0M5LIcNclw==
X-Received: by 10.31.21.4 with SMTP id 4mr2248251vkv.151.1458754993943; Wed,
 23 Mar 2016 10:43:13 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 23 Mar 2016 10:43:13 -0700 (PDT)
In-Reply-To: <xmqq7fgtdwgb.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: OpcoBMA_wOI_XKpVGyR9PIS0hsc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289671>

On Wed, Mar 23, 2016 at 11:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ray Zhang <zhanglei002@gmail.com> writes:
>
>> @@ -320,6 +323,7 @@ static int add(int ac, const char **av, const char *prefix)
>>               OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
>>                          N_("create or reset a branch")),
>>               OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
>> +             OPT_BOOL('n', "no-checkout", &opts.no_checkout, N_("don't create a checkout")),
>
> This would allow --no-no-checkout, which is idiotic, wouldn't it?
>
> How about
>
>     OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree"))
>
> and set opts.checkout to true when initializing?

I think this code was copied verbatim from builtin/clone.c, and, as a
newcomer to the project, it's understandable that Ray Zhang imitated
existing code, but I agree that it would be better to avoid repeating
the misbehavior.
