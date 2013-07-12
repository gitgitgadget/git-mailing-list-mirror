From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/4] t4203: test mailmap functionality directly rather
 than indirectly
Date: Thu, 11 Jul 2013 20:35:51 -0400
Message-ID: <CAPig+cS7rxFzY8Q3gfTtJkggp-K62SVqsjCotbM3Bkm47L44gg@mail.gmail.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-4-git-send-email-sunshine@sunshineco.com>
	<7vhag0rk3u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 02:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxRL4-0000GA-1d
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 02:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795Ab3GLAfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 20:35:54 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35368 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756613Ab3GLAfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 20:35:53 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so7247370lbd.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 17:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=YvTrp0tDKsXcun0im1qM7aWHIOU2JPXa8xhfyAk2Xz8=;
        b=hlE/r2y345n68lqK4OR0F9Tt1aqxUNgnQboc0839zbCw9VsBlHjVU3FduqxbyjOJWd
         B7O/CLaxiFcKvoogHYsKNQ7Duzfv0DgnibXYgQwvqXKn3wA0RLUJQ5CQ7MiOBmK493DS
         MLgXF1FK1Fc0RfaiB6/6f35HCLbH5VskXPWGhq0TPKwaW28zTUTMPZjnPAs+cHlzhnq6
         ll7VD82jBOWescymPDObcDL8E7XUfiE/am331mtVRivARuiHQlVLNT1txFfDvO1thenb
         +Cm2t5TSYk2ofmDVGsZfdbOuTcZBKYcyTcFoMVob/bwvoEVnDzGqVn0t8qoS0rhioise
         RbZg==
X-Received: by 10.152.6.228 with SMTP id e4mr18092563laa.61.1373589351725;
 Thu, 11 Jul 2013 17:35:51 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 11 Jul 2013 17:35:51 -0700 (PDT)
In-Reply-To: <7vhag0rk3u.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: XNYBuldJ2sx0pDh-5gxWYzINPd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230155>

On Thu, Jul 11, 2013 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> With the introduction of check-mailmap, it is now possible to check
>> .mailmap functionality directly rather than indirectly as a side-effect
>> of other commands (such as git-shortlog), therefore, do so.
>
> Does this patch mean that we will now ignore future breakages in
> shortlog and blame if their mailmap integration becomes buggy?
>
> I am not convinced it is a good idea if that is what is going on.

I meant to mention in the cover letter that this patch was open for
debate, however, it does not eliminate all testing of these other
commands.

The tests in which git-check-mailmap is substituted for git-shortlog
all worked against a simplistic two-commit repository. Those tests
were checking the low-level mailmap functionality under various
conditions and configurations; they were not especially checking any
particular behavior of git-shortlog.

There still remain a final eight tests which cover git-shortlog,
git-log, and git-blame. These tests do check mailmap-related behavior
of those commands, and they do so using a more involved seven-commit
repository with "complex" mappings, so we have not necessarily lost
any checks of mailmap integration for those commands.

Would this patch become more palatable if I stated the above in the
commit message?

-- ES
