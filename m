From: Pascal Obry <pascal@obry.net>
Subject: Re: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 21:16:59 +0200
Organization: Home - http://www.obry.net
Message-ID: <4FE0D02B.2040703@obry.net>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 21:17:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh3vF-0000oT-M2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 21:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab2FSTRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 15:17:01 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34827 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab2FSTRA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 15:17:00 -0400
Received: by weyu7 with SMTP id u7so4669258wey.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 12:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=SN1lQfUFHVu0yg/hzg1iddZEvhZvFIXehXh6Str8RKo=;
        b=ZJGqyAsOiXTLZSnFAozCpExZyppea+KYCgkTU0HpzvOg63lCldxcmuroQXhZJmZhp3
         o4NYjLylmWdADtlU2OkG3UvYyP1v/evMcMa1ddxi1S40jX/xruO6mYUz7vIZZ6Tk3mIX
         FOASES+FVwGfwypQj3y3a+L7MqufMdKyaEN/TSRyAZUK7umGfpgiXGbW7w+41P6zpJZF
         8sSpitb/qMPB5ALJy+5yVTkgxS31ZEv7jP34yjde/FzTj1KHX7P8IQScpR5aPtE505i3
         NkffK7WeG4ynW3tH9LMl2aIhYUXGsfcqQzs/kB3j7KuP8JxD8RrrCSzDFw8VUfJVaEwI
         kWbw==
Received: by 10.216.213.22 with SMTP id z22mr11925900weo.184.1340133419023;
        Tue, 19 Jun 2012 12:16:59 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-102-20.w90-2.abo.wanadoo.fr. [90.2.120.20])
        by mx.google.com with ESMTPS id j4sm33890005wiz.1.2012.06.19.12.16.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 12:16:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQlkNpxDiZbTI8DddB4qldUTJRjMhn7w1UeltoZ/ZpJQXdpWf7RjdfV1J16+lFHBPIt3+8Ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200227>

Jon,

This is a known issue. I have since a long time left Windows world but I
still have some notes to "fix" this:

>From the ash shell (be sure that no Cygwin process are still running):

$ rebaseall
$ peflagsall

Try your command again. If it still doesn't work, try instead:
$ rebaseall -b 0x50000000 -o 0x80000
or -b 0xNNNN0000 where NNNN is any hex number between 2000 and 7000.
The -o option tell to leave more space between the dlls, it may also
help. It did in my case.

If you are curious, look at /usr/share/doc/Cygwin/rebase-3.0.README
for more explanation.


Hope this helps.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
