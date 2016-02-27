From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] environment.c: introduce SETUP_GIT_ENV helper macro
Date: Sun, 28 Feb 2016 01:10:55 +0600
Message-ID: <CANCZXo5aLD_9cjzwPK5zw_ZHmevxmX8c_e9ONPyByF7jn_zF7Q@mail.gmail.com>
References: <1456593215-16302-1-git-send-email-kuleshovmail@gmail.com>
 <xmqqpovighxk.fsf@gitster.mtv.corp.google.com> <xmqqsi0ef0mz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 20:11:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZkGu-0005Il-KV
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 20:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbcB0TLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 14:11:17 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35365 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbcB0TLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 14:11:16 -0500
Received: by mail-wm0-f43.google.com with SMTP id l68so12462687wml.0
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 11:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RLQmJV+0sWMNNbrwW3gfkXh3CnRVkEvCnnBZ2O3MPZQ=;
        b=SETjcomCiGE8Nqas/6XiF1nZH2XOVbTatsbM4LgUdo+NWVzgefEX2A3Go1qCOm7/Dl
         RGF65cvD5oriZBrsDVVC3sqiqUMirAEv/HbQXrMLRQX6jC8n6HFoXh9jnT8kBzrY4nl1
         K+VxJ4y7CVH3IuDKzIZHy+ZS+BDC0QTUS26gNO553u1fWz6rNqsbooeLj7B7y3wdaCbr
         E2cC8i/T5jeChlPyCDCP8x63KkCST/JiHGQIOrS2SNM5MD3y49wZX983lUhNXMcB2I+5
         9IklXpN+ioomM9IxUY1P6zGNJxpe+8PsJnDL3HqmhQ/QMjvGzbMP2ZIqJ5qOaWmRbfSA
         GpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RLQmJV+0sWMNNbrwW3gfkXh3CnRVkEvCnnBZ2O3MPZQ=;
        b=NiUiVJKNPXQxe40GK1IlUIVFN/OcjytcDt9Qzlr6TO4+mOrcaIwR9i/JWcO1TyknBr
         bWtUuPJ9yhPDmMD6YMslCxk7Tshep0HdIjuMCV4kQJBcLv1E0xq55KH7gWJm1ne2Wusf
         g3TQMQMMkUCqIZUJswkdRIHtSQGyIYnTydQziGdRP2fLsGhSh8TDjx4oX88GUetRnOMr
         bVcFbpCTEhR4oaLTvRVvVfq7XwckEe/eHcJ8R8q4GdpHZ+piRhVc/pZ2HDuSVm9Zj6D8
         3Bens+RzaVtJcFCpJfZBsLGQ8eXTFffSkNhw070YR3OC5LoKOvic9Aag0901omJc0ssP
         z2XA==
X-Gm-Message-State: AD7BkJK9v1m1beTclIZarmChB2KgGShDNcZ7L9DGg4zoRrUUtn6WArMaCGgaHa3zKg6oufH/EFQTdzwhNff48w==
X-Received: by 10.194.246.35 with SMTP id xt3mr8136850wjc.57.1456600275026;
 Sat, 27 Feb 2016 11:11:15 -0800 (PST)
Received: by 10.27.7.141 with HTTP; Sat, 27 Feb 2016 11:10:55 -0800 (PST)
In-Reply-To: <xmqqsi0ef0mz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287724>

Hello Junio,

On Sun, Feb 28, 2016 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>
>> Please don't.  A macro that hides "return" makes things harder to
>> follow, not easier.

I will consider it next time.

> Having said that, I do think a higher-level macro that encapulates
> the whole thing may not be such a bad idea, i.e. making the above
> into
>
>     DECLARE_GIT_GETTER(const char *, get_git_dir, git_dir)

Yes, it is better. Will resend the patch.

Thank you.
