From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 13:34:46 +0300
Message-ID: <CAMP44s0_WQNpkVi0yMfaDgzBaUWOhRiS-2qxLtCHFzx71yKrSw@mail.gmail.com>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120413091236.GC2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 12:34:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIdq9-0000F8-91
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 12:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935183Ab2DMKes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 06:34:48 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36451 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961Ab2DMKer convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 06:34:47 -0400
Received: by eekc41 with SMTP id c41so730411eek.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dVM9Xi8JrHLwKiJQs2Swi/6ZL7FbTqUUvXxmuTFL1nI=;
        b=TdhTPKkhJjLf5T+90LwYcvNNlCDZss28fSCoLh8sYR6rCwi6MzyNbFbcReRFn6snM2
         r1UiSVn+t8iS/wbbw12k2GdqzpRI148Qy66QiyGVdtfSm6tesqXLNB04Q2SqcGkmz3Ny
         k6mKLkKAeMMXNKm57x2xe8x6YgHLGSdbO8AX8WzxFKV8lCowKSMIBwIFOOFiyPmLgStw
         NncJT2UPze5v9fkApiSiUvuaKNY08b8QXDIjGPe2rlYnlkLnFb1QqfciLXQBM+CqOo7N
         rIYD6OpQzO/NxjEP4LefL++9vO6AmFf9dsfn15POdTfZw2KARrt9Eeh/OdhSW+KHnM75
         HTmg==
Received: by 10.213.16.140 with SMTP id o12mr85100eba.150.1334313286424; Fri,
 13 Apr 2012 03:34:46 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Fri, 13 Apr 2012 03:34:46 -0700 (PDT)
In-Reply-To: <20120413091236.GC2164@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195407>

2012/4/13 SZEDER G=C3=A1bor <szeder@ira.uka.de>:

>> +test_expect_success 'basic' '
>> + =C2=A0 =C2=A0 run_completion "git \"\"" &&
>> + =C2=A0 =C2=A0 # built-in
>> + =C2=A0 =C2=A0 grep -q "^add \$" out &&
>> + =C2=A0 =C2=A0 # script
>> + =C2=A0 =C2=A0 grep -q "^filter-branch \$" out &&
>> + =C2=A0 =C2=A0 # plumbing
>> + =C2=A0 =C2=A0 ! grep -q "^ls-files \$" out
>
> The && is missing here at the end of the line.

Right.

>> + =C2=A0 =C2=A0 run_completion "git f" &&
>> + =C2=A0 =C2=A0 ! grep -q -v "^f" out
>
> grep is not a git command, so I'm not sure, but shouldn't these use
> 'test_must_fail grep' instead of '! grep'?

I'm not sure. Junio has already queued this, maybe you should send a
patch on top of that.

Cheers.

--=20
=46elipe Contreras
