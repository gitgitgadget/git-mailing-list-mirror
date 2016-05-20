From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Fri, 20 May 2016 13:22:45 -0400
Message-ID: <CAPig+cSxK0q_0AvB=npwpcWuMugg7QH9roQuK9kXyy=UK69rww@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
	<CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
	<573E30C8.4070600@sapo.pt>
	<CAPig+cRo3tjt9N0YO8sNn90dL3dP0asfmKTr5rerS9YLO6QBtw@mail.gmail.com>
	<xmqqbn40fzu8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 19:22:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3o8Q-0001LE-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbcETRWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 13:22:46 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33057 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbcETRWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:22:46 -0400
Received: by mail-io0-f181.google.com with SMTP id t40so61396040ioi.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=4vi4jK058kOsC7K1BcL9pKpGe+QMpqnugEz9TiotLow=;
        b=ggbQUHtn6v3d9enf91b2IVK2dzovlhr4Oon7eAcup/vGCetXxziRpYC2kP05r+AIAc
         fdNWXhYwQsK/p0s4mQUdTGV61r4AxL5AKWGI3ylrh0A+wr2LGfpFrwwVO+VYpYpJW7GF
         MsxrbezE7sjBgS/wyQL1ujot2aqZKFfo+dYScs7CyTO6KCNRjbeziBoN7ujqHjuzmxha
         91/G3SY/Byy1Qlnbw8h56CaW7yg2S7hkncRZy/I2M/zzRejcKMuo6ejl60R2lqYWM6E5
         P+Jig0Y74vKAh8Agr8Ow3Y0CXbsQH6ptfIlmWPCdijg7EEUlW7MIEmyeo0nLenaeboFD
         I52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4vi4jK058kOsC7K1BcL9pKpGe+QMpqnugEz9TiotLow=;
        b=OmutEVnqdlHb/QpH9NGYbMpzR7bcigJGaFYWrUjMhQdGz8R/OQVmfn2iopx8skNDGS
         cRpi8J/NTU4E2ZGaodwiny7EBbPHJCdh+XOC+dvAbH/y4hDPnRn51Ph7SQHJo/EZQH8t
         7AlWPF/z304LTUot4maRg52WJ5I8DuhfsFEBTkEbDrL5V3GRZac5LMxE8u2HWTPnwVUc
         hmWg+OV013VGPhcSTu5R4iBhASyGcGAu7BwBZ3W+pes11bt1t7HYTTgACtzn62G2jVx1
         o2GielqDSSp63nt5GTjZ5oxJQd5M4EaYsHFPihZnWWgB5VJQqCpEEXd0PdSQdvxACCSC
         nlIQ==
X-Gm-Message-State: AOPr4FVnHWu0SwihSIpfP10qKVIrTWDClAERXCf6RdhWrL65M/zKHNqEPasX6seWDcCPBrVXL2rd5yUZLOwF7g==
X-Received: by 10.107.47.37 with SMTP id j37mr3839994ioo.168.1463764965272;
 Fri, 20 May 2016 10:22:45 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Fri, 20 May 2016 10:22:45 -0700 (PDT)
In-Reply-To: <xmqqbn40fzu8.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 8fYd4dj_i5LjxibQRBg-GHLv5II
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295190>

On Fri, May 20, 2016 at 12:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> Indeed, the sed seems superfluous. The output of the test command is:
>>
>>     git: 'lfg' is not a git command. See 'git --help'.
>>
>>     Did you mean this?
>>         lgf
>>
>> And, the grep'd string, "lgf" only appears once, so grep alone should
>> be sufficient to verify expected behavior.
>
> Perhaps discarding up to the first blank line (i.e. assuming that we
> would not remove that blank, and also assuming that we will not
> rephrase "Did you mean this?") may be a good alternative.
>
> Or assuming that the explanatory text would not begin its lines with
> a tab, i.e.
>
>         grep '^ lgf$' actual
>
> (the space between '^' and 'l' above is a TAB) without using
> test_i18ngrep?
>
> I think I like that the best among what I can think of offhand.

Yep, I also considered both of these approaches and favored the latter, as well.
