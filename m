From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Mon, 28 Feb 2011 00:04:40 +0700
Message-ID: <AANLkTim9EOHBtZj5h1+xs9C_WhpcycwoPbWZHrZ38w+E@mail.gmail.com>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org> <vpqoc5x4saj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 27 18:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptk3Y-0002ip-ST
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 18:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab1B0RFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 12:05:12 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54717 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab1B0RFL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 12:05:11 -0500
Received: by wwb22 with SMTP id 22so2211802wwb.1
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 09:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=JogBCUnWOlJE1RfYM6F1V03hySuGqPp/ijd5LGu1rq4=;
        b=qsTwUdsVRV0xtSVtdrcbkjX8kCPAJHEnicMpzxrnuPXFP7Fd4uLBtmAOI+9L9yjYwz
         IY/UUrXuDef4E5nuujgZt4A5GoGEIOY0oiewOWhskymb/qc/uwmKjPNrrS8o6OeaKuNw
         XNsEQLCxKSHeKcguOqm3ybV3G42UDq7Ou90Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=W9z4vrqYFr1l4x1ULcMCgUwo73tqKZEyKFgw4t2nlIlNmz1pRIT3/awQM4vV1XdOGq
         tAn6QkihmFYsLA4BUXTDj7egUlW14x/c0k3oOo4xdTTvlqgenGHmRlAg9caqvSOJPrv1
         jKOpzYjDhvEU0Zr8xSA5j7Zbtp0YkBXniDzS4=
Received: by 10.216.184.139 with SMTP id s11mr1440171wem.13.1298826310126;
 Sun, 27 Feb 2011 09:05:10 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Sun, 27 Feb 2011 09:04:40 -0800 (PST)
In-Reply-To: <vpqoc5x4saj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168046>

On Sun, Feb 27, 2011 at 6:43 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Step 2, two cycles (i.e. 6-8 months) before 1.8.0, provided if the
>> previous step is proven positive:
>>
>> =C2=A0* When "git add -u" is run without any pathspec, and when the =
user does
>> =C2=A0 =C2=A0not have the configuration variable, warn loudly that t=
he default
>> =C2=A0 =C2=A0behaviour will change in 1.8.0,
>
> I'd even say "error out", since the old behavior is still easily
> available with "git add -u ." (which should be mentionned in the
> warning/error message).

You wouldn't want scripts to break this way. Warnings can give script
writers some time to update (assume that scripts are installed system
wide, not in $HOME).
--=20
Duy
