From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Thu, 24 Mar 2016 21:29:31 -0400
Message-ID: <CAPig+cS2qMZyUkf9Nekp+QaVkjc1oHXb4QF3wFDnBdF3WMU3iQ@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
	<01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
	<CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
	<CABEEbiBM-CTJdmOukLjfrmnmsSTwNzx+ELfO=BtgApT__QZu-g@mail.gmail.com>
	<CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Zhang Lei <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 02:29:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajGZK-0001Nw-7u
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 02:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbcCYB3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 21:29:34 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33841 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcCYB3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 21:29:32 -0400
Received: by mail-vk0-f68.google.com with SMTP id e6so6756467vkh.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 18:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=YRAdkCQ1BKkUtjWQwRFAqVK2CLjPWB/vN4mm6+T2zFk=;
        b=eQhsyI/uGwoXU9hfxx71mcWr6yCDyQ7XFfok1Hg/RI5X2tqlQdOVvz685GhjrVnFVo
         ouxnHkxOZGh5rCFGA3kyyZ7o/ewwoXE8ofFxANPUx4DtuIrE9V5AbQ7Pjj04aVNHhLLQ
         +a51g2i6QAdelAJQYbo+ia7Wzu3iEgh/GnsO/Q4atYeFOW7xajJuiOmG8NKyqfW0hMb6
         RqGGrOiVLk8kqTsH6Xy0Jh1gGgznXXFibX5XQcjR9JAYG61XvdkQoahkH9o10W68y1ji
         icoo7kh5betLp7T7NZ04UZZBFxn2JFFepb/LmOaKl8u8FYEtpQhMcI3yFY4ATxrSucGr
         cazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YRAdkCQ1BKkUtjWQwRFAqVK2CLjPWB/vN4mm6+T2zFk=;
        b=mvVfly7sLk1QHPyk10QrJhu1S8nktikHnCgXjc/wVXs3YZo6o33FIIndREqOzCBWJF
         BJm2kRYxXKCt/1VmrwlesSe+Zf/CiYRa0yZumB5AvDPY4eub8EiBcqMUKI6jKKQ/0iR1
         4s1PlUweqWHteLZNipK2ta8zVPWBjhfoyf7EDcbjVjTsiR0XXKwxe30woTB8qed6QPAw
         Rbt2akg7KuboxgmkWzW7C5ABgQwCwvM2T6w7pN+DZUW+3Cv4Un+dPZpT4JkUVTh3PQ1+
         vm9XFxR3qwn4Ng0MZDP0SjX7Qr0/WBbBac/aRYTEp5Zhw+gpXQtyaGRxG/rVK2vRpbeL
         1lrg==
X-Gm-Message-State: AD7BkJLpbhWNY4UGKEXn5PJ7rseNQlLc4i0wp1lKb7ExHJHbCWsLsm71DugrJz0bqyH24qfhWoodhbkipaDeuA==
X-Received: by 10.176.3.48 with SMTP id 45mr6290896uat.123.1458869371565; Thu,
 24 Mar 2016 18:29:31 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 18:29:31 -0700 (PDT)
In-Reply-To: <CAPig+cTtRgMz_6oEXmBN2MHG65arq51JsoBL9QeWBFNLgFnCmw@mail.gmail.com>
X-Google-Sender-Auth: Ig3ZTuuMoXvmOSBGDm39VrtLwIc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289842>

On Thu, Mar 24, 2016 at 9:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Mar 24, 2016 at 5:52 AM, Zhang Lei <zhanglei002@gmail.com> wrote:
>> 2016-03-24 17:16 GMT+08:00 Duy Nguyen <pclouds@gmail.com>:
>>> I think we can follow git-clone and use '-n' for this. [...]
>>
>> My PATCH v1 did follow git-clone -n, however, Junio C Hamano and Eric Sunshine
>> suggested that we should avoid doing so , as --no-no-checkout could be
>> confusing.
>
> My impression was that Duy was suggesting only that -n be recognized
> as shorthand for --no-checkout, however, git-worktree already
> recognizes -n as shorthand for --dry-run (as a consequence of using
> OPT__DRY_RUN), so -n as shorthand for --no-checkout is a no-go.

Ignore this. It's only 'prune' which recognizes -n, so it's possible
that 'add' could recognize it for an alternate meaning (though the
documentation would want to make this very clear).
