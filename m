From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/20] Let Git's tests pass on Windows
Date: Thu, 28 Jan 2016 03:42:03 -0500
Message-ID: <CAPig+cQR11JtTrcHNAWytTRfdWis4qmzODs-Key-8c+8fgKoUQ@mail.gmail.com>
References: <cover.1453818789.git.johannes.schindelin@gmx.de>
	<cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:42:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOi9b-0001Nj-Ga
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 09:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967071AbcA1ImH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 03:42:07 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36226 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934121AbcA1ImE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 03:42:04 -0500
Received: by mail-vk0-f68.google.com with SMTP id e64so1263273vkg.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 00:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SDnsoVJ4i9lIERI8IlyKssnmHYO8o2znXeE9dR7pcTk=;
        b=usPbNMr1UuXuUvondht+PakH8g4NGu0JMGr3E2Q+RQ4qrX4+f35c/fMCgxwVo3XnNv
         96Df3thjijbp5VEMcPNPH0utvW8tx1A90aO16D6W9YvC3jjbfH/pdfe+fKWGQIWGHQUk
         JIfX/iIP2Blec2MfSckGcvUvTfLFTgEhQDeewI6CUYhc7KcIuPUUr7OQuBOTradjhlHw
         U0hfRzoqekRQVsXr/PNQVN1o3JZh1HnDVJPNXJnZiSrJF7J7Ukojn9ZxrRfWKH0PpHh9
         ewsC6JD/PUN0mjPYwEaI6i7krc7DkCSk22p9ejKZIJf+wWxdBYNxv4QzX8IOm/zivaEh
         h9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SDnsoVJ4i9lIERI8IlyKssnmHYO8o2znXeE9dR7pcTk=;
        b=hmKeDHIxFkLIKkdXw0aYe9YGpxRUQp5tGA/rPbhxkPLQpVbElcPK6P69fyfQXxZ+cC
         b4q90AvTd/E3Yx6t1Ur9nV6+MGq+GUFO7k7aF2pjMWBlScSGShJTJXCArTvvD3udr+/I
         dJN8YcHfMkesN6YSJedHXMZlXi8JdDvyBA7PZW9no3m2zOYlZTiYEs+vn3Z7JFpQqhtU
         vULcjKsF1/gYCQQ7Y7ZztDQfMZS0OtlXBy/TkESrauv0VI45detyY61LgPpv18L/fYvn
         0RchQfO2vqElVCC5jtghTtZHeTc9ZzUEHDgBARXzBauVEyzbp1NV/S+FrePVnNxDKEth
         128A==
X-Gm-Message-State: AG10YORzrIbquRnJTRSRStmipI1QdEgHYRJa1VCUaApyQFX196n8tXHNPINcvTBVeZ3sOdMAfijRSlVmDXyXEw==
X-Received: by 10.31.47.135 with SMTP id v129mr1218250vkv.115.1453970523222;
 Thu, 28 Jan 2016 00:42:03 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 28 Jan 2016 00:42:03 -0800 (PST)
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: E5VtpZWsmOMWgz1UCEaFJXdQcv4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284989>

On Wed, Jan 27, 2016 at 11:19 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Relative to v2, this fixes stupid typos that made the tests fail on
> Linux, a stupid copy-paste error pointed out by Eric Sunshine,
> unnecessary 'printf ""' calls pointed out by Junio Hamano, and I now
> use `test_have_prereq !MINGW` consistently, as pointed out by both Eric
> and Junio. This time, I also send the patch series with the character
> set set (sic!) to UTF-8. Oh, and this time, I also made sure that the
> regression tests pass on Windows & Linux alike.

For what it's worth, I ran the test suite on Mac OS X and FreeBSD, as
well, with this series applied and didn't run across any problems. I
also read through v3 and, other than the micro nit in patch 11/20,
didn't find anything upon which to comment.
