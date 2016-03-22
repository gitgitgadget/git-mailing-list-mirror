From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] branch -D: allow - as abbreviation of '@{-1}'
Date: Tue, 22 Mar 2016 14:57:35 -0400
Message-ID: <CAPig+cSuRkBxUNY_nA4Ha6g3k-8VtmfFM80+gTmdM23n4e6Uxg@mail.gmail.com>
References: <1458635056-26633-1-git-send-email-elena.petrashen@gmail.com>
	<xmqq1t72jvac.fsf@gitster.mtv.corp.google.com>
	<xmqqwpouigin.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Elena Petrashen <elena.petrashen@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:57:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiRUu-000893-48
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbcCVS5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 14:57:40 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36520 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbcCVS5g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 14:57:36 -0400
Received: by mail-vk0-f66.google.com with SMTP id z68so8559183vkg.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=ASsoIIUNQ/XLNi0PVa4WOObCxGBiI0evJQTxm9ejgbs=;
        b=obLpudohCh8t9BRezCna4tcJw1cXd5f1KyNJPGXQld3HtJf16PKuz0Lw/KN0k+PUAe
         CEoC/UvzbGkuLynTHCFJhmiN8vC7YrnD6TKZ3Y5ahjklUtyeitFGRAbmS1oUTIya2v+m
         b6z9/C+SVUvmuauidXN5g0gcv0sjsTlFRcblVjOfZInKLpbcJJOJg96mBls+kfq255Qy
         N8KMpUgNU8bTB+F4+6ZAsZnqKzFlsB8msFBgZLCFIY/DLg2XOO9Do60AH0fcSz8rCOiY
         oflQ79xJpk+9Y728oj/BXfZA/WUU1XO1Hzl61rR1bVxgWWTHjmBymqxxib941gPTHRLk
         mUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ASsoIIUNQ/XLNi0PVa4WOObCxGBiI0evJQTxm9ejgbs=;
        b=TSYy4CYMjy7Wrsi9TxEz28BG+0CuE7Bw3a0tJgEyyQR+ewe+taJIs7sdmV8FcTP8KJ
         JPM814bFz0ZHiD+KDVLAvAyWaA/lBh97mry7D+BZ5x8Y0xyj4MiBgJL8dbeNP66nn/Jw
         UCd++DvxI+P60ch4Igarzx8D0ihw8AINn2Ku/3jAuXXIPK5m5hURQf+dFJ/Xakg4Mvuw
         P8/08ZMR/Pusx3y3lFT31UV32miyHUozcZn58z26Gp13jdwErl1qJAdGP9yeA5pxrjlJ
         EShVYElvhap6crWVH7EZWTk6m/TVSrWDgi+Db7p43BgFWBNQlxKZ62dIhkE3xAWbkJ3Z
         pr7w==
X-Gm-Message-State: AD7BkJL370vEXqzIhm593fClvggFBKAAKS5ubf1h8sHI1/PwmE19M7XPhOpTa6DRKwCIL+I/gXe6oxeoC2h4yw==
X-Received: by 10.159.33.138 with SMTP id 10mr4528844uac.14.1458673055707;
 Tue, 22 Mar 2016 11:57:35 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 22 Mar 2016 11:57:35 -0700 (PDT)
In-Reply-To: <xmqqwpouigin.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: YC02_GjDAfNY4vX0Vrk1_Pt9eVQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289544>

On Tue, Mar 22, 2016 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> I _think_ strbuf_branchname() leaves "@{-<N>}" when you do not have
>> enough branch switches in the reflog, so perhaps ...
>
> This is a tangent, but the value returned from strbuf_branchname()
> is not well documented, and nobody looks at it.  It might not be a
> bad idea to change the return value from the function in such a way
> that it can signal "I saw @{-<N>} syntax but there weren't enough
> branch switches" and also "I saw branch@{upstream} syntax but that
> branch does not have an upstream configured for it" to its callers.
>
> That way, the suggested "perhaps like this..." patch does not have
> to do an ugly hack: if (starts_with(bname.buf, "@{-")).

In case it's not clear, when Junio says "this is a tangent", he is not
saying that he expects you to make this change as part of your
microproject. Rather, he's just putting it out there as "low hanging
fruit" if someone wants a small project to tackle (and indeed, it
might make a reasonable microproject itself).
