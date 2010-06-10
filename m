From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Misterious warning about file system boundaries [It's a bug, not 
	a mystery.]
Date: Thu, 10 Jun 2010 10:52:40 +0000
Message-ID: <AANLkTikle0gxLvKkhr-APkt_6QCB0hVu7bIGm0sRcjVK@mail.gmail.com>
References: <4C0FF7B9.8040007@drmicha.warpmail.net>
	<4C109C4F.1030809@op5.se>
	<4C10AAC4.90405@drmicha.warpmail.net>
	<AANLkTimwhDGNTMiOaW8_AGGd4PvFtyILEikePdC4zGDo@mail.gmail.com>
	<4C10C02E.50502@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, Erik Faye-Lund <kusmabite@googlemail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 12:52:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMfNS-0004rF-L1
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 12:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758759Ab0FJKwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 06:52:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62137 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0FJKwn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 06:52:43 -0400
Received: by iwn37 with SMTP id 37so6893401iwn.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 03:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=HlPZLOV8yAidQPU32K7Dw0FnfyT1tZGd5OYLDkaTxEM=;
        b=w5UcSr5wrUP+RE5XZqxAWbmQn9pjMsFxkXrCbgzmljoexz2AP7+ruXZ/Dcu16RWMXk
         0lowvDxl6OjkJ/KoHI+xLp4BaPQF/gDXLjXX5USS85pNnl0BbJbklFywtOgcKnyXNoH0
         1AagjOoeT90elMnWTfQb45GNKDiVgykBe6c4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Tpi5xyajeb+w2M0rBokT1VLG1Y3uQFooCw7lhBNXyyTMoqf1flsWErYQ97PlDUM5Iw
         pusIkW++Rl8f670OcuxalqPRCUFIhOUV2ecQYQ2G5oQUPlUHJYIodKgJwyNsB7gnTv5b
         d4jZGWmADl8Ibg6idb8plK1eRS8aTiIeqovMc=
Received: by 10.231.194.223 with SMTP id dz31mr4087706ibb.87.1276167160955; 
	Thu, 10 Jun 2010 03:52:40 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 10 Jun 2010 03:52:40 -0700 (PDT)
In-Reply-To: <4C10C02E.50502@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148853>

On Thu, Jun 10, 2010 at 10:36, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I guess we need --I-really-mean-it-refresh.
>
> In fact, not even after recompiling with USE_STDEV=y that
> --really-refresh helps which stomps me.But what do I know.

The real problem here is the assumption in 52b98a7 that stat's st_dev
will stay the same for a given device, clearly that's not the case on
Linux if you reboot your machine.

Is there some way of working around that?
