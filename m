From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] completion: Add sequencer function
Date: Mon, 01 Jun 2015 07:38:07 -0700
Message-ID: <xmqq6177a3zk.fsf@gitster.dls.corp.google.com>
References: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
	<1433001710.5113.8.camel@virtuell-zuhause.de>
	<20150530210103.Horde.YoJthfdQJy5oq9wT_oOl3Q1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 16:38:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzQr4-00037a-31
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 16:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbbFAOiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 10:38:13 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34383 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbbFAOiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 10:38:10 -0400
Received: by igbhj9 with SMTP id hj9so62804647igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=womDP29GrGd3jINIffhQq25OY7OrPlX87oGBzBmcXvU=;
        b=Cwmy9VJjkzbxB4D2mrf/F3Cpklzl/GkPAut3oZs/wuw3jeSdOyvySkKZ0CasAnjz0T
         rrq9Od9mdI9R8FJHYi/qnqAB42+C/rt0HLr+Iu4EcPrNcqc+eg3H6/El6/MdOD2zlO55
         3I4htxohzl5epbDp+mp/LV+a+q3tMI5RZp3s/G7AllwemagCbvfDIdlT6x8b+HCdAf92
         r+f04XxqrV/Gx90y3Sa2kWNkHtUAzulMwcE24XYYjwVyMWDADn/CppbcumwhTwFfqMQu
         K5h5EH74Ve5otuI49/Lv52JM2qSFADxgwFjL0cL5A2BD6E6b2y+Dgol1EHP0yaA5kEM9
         uGtw==
X-Received: by 10.107.3.210 with SMTP id e79mr27391597ioi.50.1433169489427;
        Mon, 01 Jun 2015 07:38:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id fm3sm8076806igb.1.2015.06.01.07.38.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 07:38:08 -0700 (PDT)
In-Reply-To: <20150530210103.Horde.YoJthfdQJy5oq9wT_oOl3Q1@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Sat, 30 May 2015 21:01:03
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270416>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> I don't see the benefits of this change.  This patch adds more than =20
> twice as many lines as it removes, and patch 2/2 adds 8 new lines =20
> although it could get away with only 5 without this function.  To =20
> offer sequencer options we currently go through a single if statement=
, =20
> with this patch we'd go through a case statement, an if statement and=
 =20
> finally an &&.
>
> G=C3=A1bor

Perhaps, especially given that I'd imagine we won't be adding 47 new
commands that drive the sequencer in the near future ;-)

I presume that you are OK with Thomas's original version, then?
