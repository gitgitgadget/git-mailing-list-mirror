From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Mon, 23 May 2011 14:09:40 +0200
Message-ID: <BANLkTi=ssDA=y1CnMAZtvk6dTyMmd4LjrQ@mail.gmail.com>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
	<1306058229-93800-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBIZWl0em1hbm4=?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 14:10:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOTxQ-00074e-C9
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 14:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab1EWMJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 08:09:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50705 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab1EWMJl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 08:09:41 -0400
Received: by fxm17 with SMTP id 17so3864855fxm.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SVP9KWUyFIEG6/8eGHFGftfMahZPtzyjDk7ZR9A/veY=;
        b=EV3ABBimw5x6eGEbcv9OJvJWJhTfvKyV6umg+HJBQlOhHSxBC7s26zp3PTV2gj1HIC
         BbjOr/bmmZzBu/AVycNQmQN8mmIwzbgT9V/wXyREpF9J2cERdBDeBzvOzZHn3CFtDA5F
         tlAfvDm3M5bsWa4i1j2g84cJdnBJRhEECHUnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BIORooJINo+JkPJdg3qZ2FvKhxD+QJE2464j/S0FTi2qVBxW9mXPSSYxxFUSbQAkS5
         fBxuNH0XemNYbS4rbPSPNh60LOq44qXdkfV/CYXge9C2U3ZZ9xQAjfzrZFD8cW1vyPiG
         KKJtMJ0t+SvICRlBmHPoXNkJSnrKNqmJUygqA=
Received: by 10.223.59.81 with SMTP id k17mr2333221fah.94.1306152580053; Mon,
 23 May 2011 05:09:40 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Mon, 23 May 2011 05:09:40 -0700 (PDT)
In-Reply-To: <1306058229-93800-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174239>

On Sun, May 22, 2011 at 11:57, David Aguilar <davvid@gmail.com> wrote:
> + =C2=A0 =C2=A0 =C2=A0 printf "#!/bin/sh\n" >diff &&
> + =C2=A0 =C2=A0 =C2=A0 printf "printf \"\$GIT_PREFIX\"\n" >>diff &&

If you're going to use /bin/sh (which might be a non-POSIX shell) it's
probably better to use echo than rely on printf understanding \n.
