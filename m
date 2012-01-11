From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Re* Regulator updates for 3.3
Date: Wed, 11 Jan 2012 08:23:01 -0800
Message-ID: <CA+55aFy679Skqi_D3x8=M=mwZiViMX9EbZrqP11riiLb_Hzb9g@mail.gmail.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com> <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com> <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <7vmx9v7z1r.fsf@alter.siamese.dyndns.org> <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com>
 <7vehv77xeq.fsf@alter.siamese.dyndns.org> <CA+55aFzuGtJkQFDooSGWQ2_NiJVHN2E7S5dmOnWTYn8_s8Gg3g@mail.gmail.com>
 <7vzkdu7miv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 11 17:23:38 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Rl0xc-0000VK-2z
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Jan 2012 17:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614Ab2AKQX0 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 11 Jan 2012 11:23:26 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46261 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab2AKQXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2012 11:23:23 -0500
Received: by wibhm14 with SMTP id hm14so497438wib.19
        for <multiple recipients>; Wed, 11 Jan 2012 08:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=ntXZER73eFpzMSbPfd1B6q3H6gTFNZqooZAHB4unr2M=;
        b=Celfa5XpwzAb0Krg78xY+EBw6cnvhwHHc72ktj59UuHhx6z7EcJQE3XfZg6BNC22zY
         XNhkY5c+i/EV8gxcyCJOw2SjVX9gCsVDUGG/1VbZQJk7Cx9u27loUVM0YoE3mdWFWtk0
         5ZG/fOf8fE0NIXFd0PLdl/wVJHlbAKDZ+/5Og=
Received: by 10.180.19.138 with SMTP id f10mr53946196wie.3.1326299002214; Wed,
 11 Jan 2012 08:23:22 -0800 (PST)
Received: by 10.216.172.213 with HTTP; Wed, 11 Jan 2012 08:23:01 -0800 (PST)
In-Reply-To: <7vzkdu7miv.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: x7lpfQ3WB0_YcDUmbICwHR-iPA8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188370>

On Tue, Jan 10, 2012 at 10:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> What makes me uneasy about the idea of running the editor by default is
> that many people still use Git as a better CVS/SVN. Their workflow is to
> build randomly on their 'master', attempt to push and get rejected, pull
> only so that they can push out, and then push the merge result out.

Sure. And I don't think we can do much about it. They'll either set
the legacy flag, or they'll just exit the editor without adding
anything useful (if you come from a CVS background in particular, you
probably never learnt to do good commit logs anyway).

So it will be a bit more work for the bad workflow, I agree - although
if it really irritates people, they can just set that GIT_MERGE_LEGACY
in their .bashrc files or something. But we can *hope* that even those
people might sometimes actually talk about what/why they are doing
things, or maybe even learn about that whole "distributed" thing.

I agree that is unlikely to ever happen, though. It's more likely that
they will change their aliases so that their "update" command just
adds the --no-edit flag. Regardless, it doesn't sound *too* onerous to
work around.

Patch looks good to me. I would personally have compared "st_mode"
instead of (or in addition to) "st_rdev", but I don't think it matters
all that much.

                                 Linus
