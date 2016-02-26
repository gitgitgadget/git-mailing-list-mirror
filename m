From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Fri, 26 Feb 2016 16:26:04 +0700
Message-ID: <CACsJy8CjOkNuEg=QRTATQLkYzMxpf5zryMXERZu6Zn59VDUB_Q@mail.gmail.com>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:26:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZEfZ-000233-RU
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 10:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbcBZJ0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 04:26:37 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35863 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcBZJ0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 04:26:36 -0500
Received: by mail-lf0-f66.google.com with SMTP id h198so3453757lfh.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 01:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xs94hB/wi/IVuF88kX3JwQ0HZtPDpEGSsrwRhSW1bCM=;
        b=RdQ9n8ee+KDg+9XkTrOJ92qZTGkxzu4074ddWxl4mbRonQrsY+zWdLtAmAGtZEqGJF
         fruBLt3hHQ7hRUVGv5KYru8Un64jSjifu7DaAK5Bn2dpfZou5mzLOQnMMJx13RNINIc0
         UZRz0KM3p3r4vX2Buym9Zk6lvgx6IOXoN9+8obbm31rlcbBhYZXKCHvlxRJlxlUvFnxG
         KA3nAK4WYq3XWc2rcfhm1Dzxw3tSlD4siJsXBUpszPRs3L7qnM9Ainikhk5/NmixVaIs
         nwwEoTf7nfw4b7uk/6W1QPa4irkKeaxJ4EzD9BQV9j49YoO1hM2UbEHdlQ4s+yaaH+NL
         +Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xs94hB/wi/IVuF88kX3JwQ0HZtPDpEGSsrwRhSW1bCM=;
        b=C+ZNud9xUe/S2FRLn140vu2ilfy8tFHUSTCtbiQkZIEC9+nqYjyiA6PfO2gHpNJ6EI
         WIpnc4AE6ORl5JqZ2xXPNYwxmFfEh62V/5FcQviIcU63mrPg0f2YBZpd1reG0li2r0bv
         /z+WMc2oJcROSdzZZkOwWfG/mNIXP86dqx8Kwmt8tDRCU5yqo4SnUlx5o3hVxFtnBP5h
         t5mL1nk3+S+ON/QTgESZrU/dVbsfidehnI9JKERYcoQDjqWCPhC1G50MFZNOwamfXayj
         +Q3s1KVxUcZziK1tgXIvgIba7IKFn09JdCauK1UH841hyy/UelOpoziS6X6MC3FHV/VJ
         gfcg==
X-Gm-Message-State: AD7BkJLg9tfm76czVPF/YHwNXdoYqxlcHK/XLBqAd3kbbsdvbTfueICoo1RqvZ08I5k0CNt0XZ9JRx93PRkX9w==
X-Received: by 10.25.4.7 with SMTP id 7mr211423lfe.45.1456478794515; Fri, 26
 Feb 2016 01:26:34 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 26 Feb 2016 01:26:04 -0800 (PST)
In-Reply-To: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287557>

On Thu, Feb 25, 2016 at 3:42 PM,  <larsxschneider@gmail.com> wrote:
> +ifdef DEVELOPER
> +       CFLAGS +=       -Werror \
> +                               -Wdeclaration-after-statement \
> +                               -Wno-format-zero-length \
> +                               -Wold-style-definition \
> +                               -Woverflow \
> +                               -Wpointer-arith \
> +                               -Wstrict-prototypes \
> +                               -Wunused \
> +                               -Wvla

With the exception of $(SCRIPTS) in Makefile, I think we prefer to
avoid \ and have one addition per statement

> +endif
-- 
Duy
