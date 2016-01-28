From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree behaviors
Date: Thu, 28 Jan 2016 19:11:00 +0700
Message-ID: <CACsJy8ABj+_iohtobRJxeVd3WfRcufFVPC4ZCzGqJDz=wJkjyg@mail.gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com> <1453808685-21235-2-git-send-email-pclouds@gmail.com>
 <xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	"Max A.K." <max@max630.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 13:11:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlQL-0001DS-2b
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 13:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbcA1MLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 07:11:33 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:33399 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbcA1MLb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 07:11:31 -0500
Received: by mail-lb0-f196.google.com with SMTP id bc4so1735134lbc.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8ve/6wQ1cP1G9apTMYJro0lMlK/3jQUJrhOPt0UiLAM=;
        b=ic3cFFhHYVo8iBCafGRGgElmUM1HuKPSyBJbTlMqFxcSyuSl0iiqoyUuHTW974dFna
         Rdvjz0M6xZmPMZhKafUrUdReW1oyQSmqFLBiK534eQByO497E0noyTl2sikshFgcW1yX
         xMOBvZHw+WLmtOeoN7fWR8eIYEfZV8bpXEvz5Tkfzs4ttvGYN1DMz1IJ8gUDMqXA0yyQ
         as7i2rdDRFPfOfUclqk5bUFo7q1yGj2D8nBMZJmLfBh6wZq/zsZapcbGHhjc73RAR8q2
         e900FW3HOf7fB0Yu+tZCp/vgpoeHPCcN64QW+UPrP3zrg0Z10IMTdG7V5Kpr5tWzT3B0
         lMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=8ve/6wQ1cP1G9apTMYJro0lMlK/3jQUJrhOPt0UiLAM=;
        b=W4EEq5sg/asezVJiJ+ArsvxgueYJDgO3AViijEzf1j0lONCHBBcwMWJhKUvMKbblHb
         FBT1X9J7QmDOUAu6s0EFQelV0nUEjBXS0YnRrl/URdFcYNwcOd7dVmk2rzScBxWhXg8c
         BVu+oTNnZF9brLkhAgvodHuNkQxh4I+CPGzAtsK9kEXEf6FhfeYja13m02nh9DfxMqtE
         DwH5j7bUyoawl2JMaUN2gKpfeAYK6WnK7nC/f/8OoJfWiul/4PEYBSIBBnBRvW1VvSDG
         /TsRWkxQLrsKNQ6mb3PsyaAADL6mKHVcUu8bdeo7CwEi8rTTGFweeVCvV4PpJ+SceXLm
         YSRQ==
X-Gm-Message-State: AG10YOQGkk4nYTHifktu8ZtAFml28HDvEZsztd4Bo/yzW78jQr81mQ6iaC4/fRnP++Ht6bdUbeG6WTTL9eFJjw==
X-Received: by 10.112.141.97 with SMTP id rn1mr1094994lbb.80.1453983089737;
 Thu, 28 Jan 2016 04:11:29 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 28 Jan 2016 04:11:00 -0800 (PST)
In-Reply-To: <xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285019>

On Thu, Jan 28, 2016 at 5:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +WORKTREE VERSIONS AND MIGRATION
>> +-------------------------------
>> +Multiple worktree is still an experimental feature and evolving. Every
>> +time the behavior is changed, the "worktree version" is stepped
>> +up. Worktree version is stored as a configuration variable
>> +extensions.worktree.
>
> s/stepped up/incremented/
>
> More seriously, are we confident that the overall worktree support
> is mature enough by now that once we add an experimental feature X
> at version 1, we can promise to keep maintaining it forever at
> version N for any positive integer N?  I hate to sound overly
> negative, but I am getting an impression that we are not quite
> there, and it is still not ready for production use.

I completely overlooked this config file issue in the first round, so
there's a good chance I will fail to realize it's still incomplete
again.

> It would be beneficial both for us and our users if we can keep our
> hand untied for at least several more releases to allow us try
> various random experimental features, fully intending to drop any of
> them if the ideas do not pan out.

Yes it's best if we can somehow communicate with the users about that.
If a line or two in release announcement is good enough, great.
Otherwise maybe print a line every time the user executes "git
worktree"?
-- 
Duy
