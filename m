From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: skip test with COLUMNS=1 under mksh
Date: Fri, 27 Apr 2012 09:08:16 -0700
Message-ID: <xmqqehr99mz3.fsf@junio.mtv.corp.google.com>
References: <20120426223422.GC22261@camk.edu.pl>
	<1335518725-19728-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	Lucian Poston <lucian.poston@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Apr 27 18:08:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNnia-000751-Ff
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 18:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825Ab2D0QIT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Apr 2012 12:08:19 -0400
Received: from mail-ee0-f74.google.com ([74.125.83.74]:37489 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab2D0QIS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2012 12:08:18 -0400
Received: by eekc41 with SMTP id c41so46835eek.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 09:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=HKJ7PV58rLkEP9zm6l2zvgLWilXLDi3QCjOQuwXL4u8=;
        b=fAUiEYn+bxTHHM0bKQUCVynjrY3e9taBlSRMXYy3CSJ9BsCzkyqqE/ICIZ1jpq6v5s
         TDrXO2PhZ1J4faHolL0JLqYcIDDd9NHR/dG6J1MSCbWsugvDB+D7zsXSefvOWHH40Y2y
         bz6Xu1kddF/wI6dyPUI0/uD78BJAXttaxhl4fqRKiA1whrQ/2YYfkpR5AYFVv+4D7o8Q
         Q0q2xr2P9j17mfj8TYjg4BXueGcwO9AvPwUq8MRYm+IMcJIF9U4SedFH/PJUL63j2jCC
         Ek45gSwxrdLRmMhP1UEvcV/hsSq7yRwmQMPdGNoAe/F1REc1HfIzuALoEAvrZtE3xuMh
         SQlQ==
Received: by 10.14.188.12 with SMTP id z12mr3153283eem.8.1335542897338;
        Fri, 27 Apr 2012 09:08:17 -0700 (PDT)
Received: by 10.14.188.12 with SMTP id z12mr3153261eem.8.1335542897175;
        Fri, 27 Apr 2012 09:08:17 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si6611219eei.3.2012.04.27.09.08.17
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 09:08:17 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 00CF1200681;
	Fri, 27 Apr 2012 09:08:17 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 51D8CE125C; Fri, 27 Apr 2012 09:08:16 -0700 (PDT)
In-Reply-To: <1335518725-19728-1-git-send-email-zbyszek@in.waw.pl>
 ("Zbigniew
	=?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Fri, 27 Apr 2012
 11:25:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQktExfvkPbdc0+B2GT2TwGecSOWdaVDfbqmeYI9vAGmmW5kQljTY6xgtTGSQPYeS0e5g5A44dsrXATntJc71cnSDU+TmCbd5seU/s7YYUYSpwDWriCAPCxrWSA/JhzktoPGw//U7fIwfp1kpMRQZGufviQfD0d4O4RRay4q75xl1F5KaJg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196478>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> mksh does not allow $COLUMNS to be set below 12. Quoting mksh(1)
> $COLUMNS is "always set, defaults to 80, unless the value as reported
> by stty(1) is non-zero and sane enough". This applies also to setting
> it directly for one command:
>
> $ COLUMNS=3D30 python -c 'import os; print os.environ["COLUMNS"]'
> 30
> $ COLUMNS=3D20 python -c 'import os; print os.environ["COLUMNS"]'
> 20
> $ COLUMNS=3D10 python -c 'import os; print os.environ["COLUMNS"]'
> 98

I'd hate to say this, but that shell is broken.

> Let's test if we can set COLUMNS=3D1, and if not, skip the tests that
> want to use that. A prereq is added, which is set if $COLUMNS can be
> set.

And I think that is a sensible workaround, even though COLUMNS_CAN_BE_1
might not be the best name for it.

> +( COLUMNS=3D1 && test $COLUMNS =3D 1 ) && test_set_prereq COLUMNS_CA=
N_BE_1

This is different from what you wrote in your log message, but I trust
that it will fail under the problematic shell?

Will queue; thanks.
