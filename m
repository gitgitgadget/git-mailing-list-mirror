From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 1/3] t: do not hide Git's exit code in tests
Date: Tue, 16 Feb 2016 10:36:42 +0100
Message-ID: <C99C00B1-B782-4CCD-A1B5-B83CE50DE6C8@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com> <1455531466-16617-2-git-send-email-larsxschneider@gmail.com> <20160215174157.GA26443@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:36:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVc40-0006JU-Ik
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbcBPJgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:36:50 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38897 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbcBPJgr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 04:36:47 -0500
Received: by mail-wm0-f42.google.com with SMTP id a4so90540258wme.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HGL8YN9DA/zg3DZ6aXBNRPmrFtwVDCk4jMrK40PeaSU=;
        b=ooNWOZtNVWa6sUW0kS01F52TQSRP1ptz6lTVp8q+MwD5fWRfJfJ02UhW3+1Es2NJ/S
         dBuKf6qlP0BBJ8g4vil77IddTarJwVcL7x6N5k1Gwhzit0cJ4V+FJbzNoiUXPgS3fuS1
         mIa4qmb6GVnC78Ad80MtDAf9/jOYX45SmAo7k+PiCQ6Jgla/7w34wS1y6jpq09CFozQU
         vvPVUmXI8YqPaFxCXhOTFG7YuqOSbLlZ5bcD8NRcEdb46z9BNJi088i8+kiyeucmjLu3
         5KDgGaIGSQ+BTtPl4iljnZYzOAMsPWOc3XWjBZk0DZw8b0jWxPq8boWa2Df/tAEmpukm
         nrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=HGL8YN9DA/zg3DZ6aXBNRPmrFtwVDCk4jMrK40PeaSU=;
        b=T2MLK1pe7A3DUJQg3lzsZsnEwOOskzEdewYEDprGuSRF3tlyPo2Q+W/xQEOrZHL0iT
         USrQVTSgsICnVnVuf1zSO994CHYSamQ2IqkLuDUptJPq+6CsdsGe0FrKuRGJ4bfPIvQD
         yFpNivVpT/E8V92GRTwQ5CNWeFIk6C+lfYlQH68iRN+ZfXlVATOBrSkWSoFD78r8sHTU
         mCUOS1dFKBsqrD0wH2zZQ+wz+s6yldau3zBWbzA+5ZqQk/cAHhXYYGqCvqOE0UcxmGg5
         0dpGkF6DYKyJf/qQuO0sNC8OANHdX5fugohPI0wKlCnEA0PEntgMp8+PD42WeGVaVtBR
         8j5A==
X-Gm-Message-State: AG10YOQG+aDoXL/VieR7fkpTgm9T0RfGcolRWuk8no8ccghxqHhMy3AJMn8pKwaJ4tE4cA==
X-Received: by 10.194.2.202 with SMTP id 10mr24053153wjw.94.1455615406638;
        Tue, 16 Feb 2016 01:36:46 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB43DD.dip0.t-ipconnect.de. [93.219.67.221])
        by smtp.gmail.com with ESMTPSA id ll9sm29354856wjc.29.2016.02.16.01.36.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 01:36:45 -0800 (PST)
In-Reply-To: <20160215174157.GA26443@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286329>


On 15 Feb 2016, at 18:41, Jeff King <peff@peff.net> wrote:

> On Mon, Feb 15, 2016 at 11:17:44AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Git should not be on the left-hand side of a pipe, because it hides the exit
>> code, and we want to make sure git does not fail.
> 
> I think this is a nice cleanup.
> 
>> There is one more occurrence of this pattern in t9010-svn-fe.sh which is to
>> evolved to change it easily.
> 
> The final sentence in the commit message needs s/to/too/.
OK!

> However, I'm
> not sure this is the only remaining case. Doing:
> 
>  git grep -E 'git.*[^|]\|($|[^|])'
> 
> shows quite a few. I guess you just looked for "nul_to_q". There is
> certainly no need to fix all of them, but you may want to note the
> extent of your grepping in your commit message.
Yes, I looked only for nul_to_q... there are more than 1000 other cases. 
I thought about a clever sed script to fix the easy ones but I don't
think it is worth the effort.

Thanks,
Lars
