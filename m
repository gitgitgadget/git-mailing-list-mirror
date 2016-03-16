From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 21:57:16 -0700
Message-ID: <CA+55aFyFHmmoHMgRkuBqNUho=tiJ=VwxHWzcGw3pRjr+aGS7ZQ@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
	<CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
	<CA+55aFw8roOTTuFknzh3zRkCbgaMGmtxMRk-ctBdJ8Wsu041bA@mail.gmail.com>
	<xmqqzitz58si.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 05:57:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag3WL-0000Nd-RE
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 05:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934576AbcCPE5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 00:57:18 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34176 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934477AbcCPE5R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 00:57:17 -0400
Received: by mail-io0-f169.google.com with SMTP id m184so50467190iof.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 21:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=NARcZj6GTjXzDP3ERcfaPyVhmstwDhJCFLKHpICnAnI=;
        b=dW3Nthwn4R9B62QTqNRzigRWQXM+VjXSyOuKaRMME+pYyp2+ICiLWOJJcNlag6UTbY
         w8FjYhfQJe+3ozti9QTMfeL2muEAX+HljBd117279SeL5m2mhxcmXaTOlgSZqLQlx4wx
         lIbr+0JBLWe6AA6s6gg6Tg0ke2/9x9kS6vmomx3r8D+AuGYkiHnz/Q1A7ZbEXT8vdXGG
         UgIwx+D8GIivPB1DVAFacS51fCRNLjLFawvlFe+fofUr3/PPuuifiZ1SJ1Wqd5fjYt4J
         xk7CQVcLWl96WAaa77baxSJpsPo04/CfqcBIPFseVLDaXqZyftWM62S71klXL++e5BPw
         HUBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=NARcZj6GTjXzDP3ERcfaPyVhmstwDhJCFLKHpICnAnI=;
        b=UZtmo9YdE9i3ll173YKN76R/xVeW+iM0QVYTLByVt2T1rXJV9DWjwtJC9nunWANvN2
         dh22B4Y9ShIOz+RkOB9SGOwuMUe6F0Xtnm3mcVxAJEC1oxNw1OVJEJVuDbOKl4iyuL2R
         4bFhRMYpQtIQgltyYXwPoOhiG3bPd0zP/nQME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NARcZj6GTjXzDP3ERcfaPyVhmstwDhJCFLKHpICnAnI=;
        b=CPYfLimxdUsiNP5et6KwRu73OjQKq4QZnscBGMNqnfkQV4muv71LCQ8beioN1nQsQh
         W0ntpdvAuY5eb6EXOYfvKlNRoEPuq0/gtKkh1MpWrb6K7lBIFfOpCCs+BM9keYhAgTbx
         alFD2M/OeSjcUDzfzcsf7B1yEdCuiDzsgi7B+5CgkSKS9B/mjCQhvUzLTcU9JrVM1tBQ
         TtKwNg9CLz8/Vcj5I0hG4eMTQW2GsLMKRhqHRv7GEgvCPde9R/fYA2rdCHMDJEYyAQ/t
         ulO3tHxjfC8lodEz8OFEv+tT0jvFYkv06asL39ebavc3cm501H9T1gBZEuygN20ZMJDC
         mSnA==
X-Gm-Message-State: AD7BkJITwoWFgwPYPGIImFNJZMoCsKrL4bKi417WJmKfY9hQe77HHqqAuAsBMpv+pQadJmP6bhyRRQBYaUmTnA==
X-Received: by 10.107.5.2 with SMTP id 2mr2302923iof.89.1458104236165; Tue, 15
 Mar 2016 21:57:16 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Tue, 15 Mar 2016 21:57:16 -0700 (PDT)
In-Reply-To: <xmqqzitz58si.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: wHXszGtHqgoYGarJesvMLYwsbrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288946>

On Tue, Mar 15, 2016 at 9:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> It also ignores that byte counts of non-HT bytes may not necessarily
> match display columns.  There is utf8_width() function exported from
> utf8.c for that purpose.

Hmm. I did that to now make it horribly slower. Doing the
per-character widths really does horrible things for performance.

That said, I think I can make it do the fast thing for lines that have
no tabs at all, which is the big bulk of it. So it would do the width
calculations only in the rare "yes, I found a tab" case.

I already wrote it in a way that non-tab lines end up just looping
over the line looking for a tab and then fall back to the old code.

I might just have to make that behavior a bit more explicit. Let me
stare at it a bit, but it won't happen until tomorrow, I think.

                 Linus
