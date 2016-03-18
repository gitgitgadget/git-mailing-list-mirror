From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v9 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 18 Mar 2016 20:47:32 +0530
Message-ID: <CA+DCAeRe4ak1Ni7CADpJdd-=+dvKTTepHY6dYNfQV3ADpz5f6Q@mail.gmail.com>
References: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
	<1458233370-8343-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQHbGAB=XCVWtC1MuubWUFc0tT-+ZGD+hW18whJP_U0_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:17:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agw9k-0003Ss-Nj
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 16:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbcCRPRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 11:17:35 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33561 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbcCRPRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 11:17:34 -0400
Received: by mail-qk0-f196.google.com with SMTP id q184so3843116qkb.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=+H/xWDqYeaxpJMMdqRweUyxhogDuLTSOWPF4ZcCobm8=;
        b=tVobiQO/Q3hEl/X9xz8lZHUCUeITwwrymvjkAQUYdNCs4o8rvdhZegCWCqSajQpPfs
         09+bp6jYA+vG/HHr4+2mKzTF/11MikW3RjNeDnWMQLbZ+8iJmuNueLclNWxil8lS6lv+
         sm99bneXYm1SDU4XUnW2xYvJhfUVF/qL3eE12mkOfRJ+Ig93mN0VnxwDUz63gpvZeAA0
         F6/v5RwVGoKHK3i8UAk9JG9DJDCtpYJXvSCAfnoXOckln4YxPBGHiWXekBpFU7N/ncPp
         vG0fQgLLbOeREzP+pCvE0jYaCuFJ8w1IrYhEcyVE/5dzqwxPRHrpQ6ht38ybw67OZZC8
         bolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+H/xWDqYeaxpJMMdqRweUyxhogDuLTSOWPF4ZcCobm8=;
        b=CpkK3XcVn/VgC5HzC6UeaN5nqUBuvpWJ3EcI1Bz2kH2izaDf3ExPY+ta3FruuRFazm
         c5eNkcef80DQ/5J2LMJrqU+2lrCqFsbmqULUvsjHnuZ6LZReD5A6NgZM6fdjTkyMBUUk
         GzM72q1+apQF9s1kzaQ3gi3hx4UPxtKYPm/j7DOTQvHXt4Gvi45AnrhisayWSGgLQTwN
         5MW7lVG+d24ur/2fjda+q+E6Y1JSc7neDBa61BhIBrcrKx1Fa7FsEIs0jojACpWa8lIc
         uvLOHzhz1ELHHiQeIGzCil3RF8u7dhO/ttVj2jAk+lg/VIgKWN0CivXhl9T2+WfZ3dsY
         RTOg==
X-Gm-Message-State: AD7BkJKTOE/mvwYXBo7omzQpdd+0RUhC/UQzRXUaaT8TGsGbx9tBNeVIz3N9WQAwNTaQ9L/+Bt8AkDy8kOPcuw==
X-Received: by 10.55.215.208 with SMTP id t77mr22683297qkt.23.1458314253148;
 Fri, 18 Mar 2016 08:17:33 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Fri, 18 Mar 2016 08:17:32 -0700 (PDT)
In-Reply-To: <CAPig+cQHbGAB=XCVWtC1MuubWUFc0tT-+ZGD+hW18whJP_U0_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289222>

On Fri, Mar 18, 2016 at 9:54 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Since this is now a patch series rather than a single patch, another
> way to help reviewers is to use a cover letter (see git-format-patch
> --cover-letter) where you'd explain the changes, and, importantly,
> include an interdiff between the previous and current versions.

Point noted for the future patches.

>> +test_expect_success 'pull --rebase: --autostash overrides rebase.autostash' '
>
> Why do titles of some of the new test titles have a ":" after "rebase"
> while other don't?
>
> Also, how about normalizing the titles so that the reader knows in
> which tests rebase.autostash is 'true' and in which it is 'false'?
> Presently, it's difficult to decipher what's being tested based only
> on the titles.

If it's so then how about the tests titles to be the following:

* pull --rebase: --autostash works with rebase.autoStash set true

* pull --rebase: --autostash works with rebase.autoStash set false

* pull --rebase: --no-autostash works with rebase.autoStash set true

* pull --rebase: --no-autostash works with rebase.autoStash set false

Earlier I tried to keep it as less verbose as possible (and probably
made it hard to decipher). Does the above titles seems short and
informative to you? If so then I will use them instead of earlier ones.

> Finally, shouldn't you also be testing --autostash and --no-autostash
> when rebase.autostash is not set?

If rebase.autoStash is not set then config.autostash will remain zero
through out the process. What I want to point out is that rebase.autoStash
, if not set, is equivalent to being set false. So adding tests regarding
"--[no-]autostash with rebase.autoStash unset" seems equivalent to tests
" pull --rebase: --autostash works with rebase.autoStash set false" and
"pull --rebase: --no-autostash works with rebase.autoStash set false".

Thanks,
Mehul
