From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/4] test-suite: adding a test for fast-export with tag 
	variants
Date: Sun, 29 Mar 2009 23:44:10 +0200
Message-ID: <40aa078e0903291444m3a29662j3162ed511eee0ac8@mail.gmail.com>
References: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
	 <40aa078e0903291305p28ec2ae8xf0cb465e593af0b0@mail.gmail.com>
	 <7vwsa8ow10.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 23:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo2p8-0007VT-4q
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 23:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbZC2VoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 17:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbZC2VoO
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 17:44:14 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:46632 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZC2VoN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 17:44:13 -0400
Received: by ewy9 with SMTP id 9so1821612ewy.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fYcjjpA0Sf99Ha+rYlsAMqUV+L0ggFpjmHYha8QYGIs=;
        b=hXBW4HzmPZpPSOOlVfyoCeCWx21b47TF0zsuivE6/dVzPsjzdbo4LqhqSnk1EEZ7FI
         jXC2oZJao89FJE/TtQehSuhU14O5WCPBu3DI/DHN6X0YmgBLrzBvWGtn4KxagoumC9+c
         MmcMhfUzQj9z089u8bdZN0GqzkUT+P9oukPL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jfQ/G9pwtBKx3ekK4QtXct5hM2x4KKIpHWddd4HNi1gzvVmOZ2GhWXiysmtuPOZJ3q
         HGIRgPGtfbWQal3V496qAmwBa3Morp0W0o79hM3k5LkWSZPMP9rBOqWd65/fPdtBFbyd
         KqHw1/RW2j+efmWfiHo6riu9hmfDlujeOEizY=
Received: by 10.210.127.13 with SMTP id z13mr2076609ebc.93.1238363050769; Sun, 
	29 Mar 2009 14:44:10 -0700 (PDT)
In-Reply-To: <7vwsa8ow10.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115039>

On Sun, Mar 29, 2009 at 11:32 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Even if the tested program crashes, it is Ok to test them inside
> expect_failure, so I'd suggest not commenting the first two out.

OK, the reason why I didn't want to do that is because the test
appears to succeed on windows when it crashes. But you might not care
too much about that ;)

> But running the tests with the first patch applied to the same base a=
s
> where v1 was applied gives this, which is a more serious issue:
>
> =A0 =A0$ sh t9301-fast-export.sh 2>&1 | tail -n 2
> =A0 =A0* still have 4 known breakage(s)
> =A0 =A0* failed 6 among remaining 15 test(s)
>
> In other words, the changes to the set-up part seem to break unrelate=
d
> tests. =A0Why can such an update supersede the previous one?

That's weird. I did test it properly before I applied it, and I don't
recall having any failures on Linux. On Windows, I get lots of
failures with vanilla git.git, and I don't have access to my Linux-box
right now, so I can't easily verify this until that box comes up
again. I did see that another patch (ebeec7d) has made it's way into
the test since I submitted it - perhaps these two collided?

But OK, I'll have a look at it when that box comes up, and see if I
can come up with a good patch-series.

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
