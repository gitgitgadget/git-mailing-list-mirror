From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] difftool: only copy back files modified during
 directory diff
Date: Fri, 20 Jul 2012 22:10:53 -0700
Message-ID: <CAJDDKr7103_S+=THQVLHHXFpiSPjLpDVm8j7Kb-nUh4G=bZa-Q@mail.gmail.com>
References: <CAJDDKr4Q+nQapO0aAQmmpj_guR=_tXwareWsn020BckZR5V+uA@mail.gmail.com>
	<1342686429-87847-1-git-send-email-davvid@gmail.com>
	<7v394nveni.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 07:11:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsRy0-0003yd-Vb
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 07:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177Ab2GUFKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 01:10:55 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40121 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2GUFKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 01:10:54 -0400
Received: by vbbff1 with SMTP id ff1so3487941vbb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 22:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=99ut4EpB1TV9RknpzFzLOpeJnNtzARqFbU6SYc5v5FM=;
        b=YabW4VUHYBFzGprpj5A2Bbj0gdSj2xRjoEpFFUX36eMplmDs7W84ttoN3iyBu11KoM
         COEAKSbCmTgUnSwd/oVTUg0o81HXun/5UPf5NP8nlueIBCYH64CJLF0oySXU2wqsu5XI
         93uoNoGmYCIJSao4Xa0mJjz7U0lfQqBYcfMpwBCS+SG8HRHsg6xEbuNjb2vqW/YgsMkK
         SMkl1F2Pa+i8wKAGPcEN0cRWHb6a9/QJlIk6TobRDbC8F8YusJqAFU4SAPhvTHPVmtIM
         RKQV02A3B7l+euL/hLeLpieI3tlOrzS/3ZCjZPQlOKljqNcSbjsy0E7R0AFnauIdIKAT
         +8vg==
Received: by 10.220.148.210 with SMTP id q18mr6467495vcv.6.1342847453565; Fri,
 20 Jul 2012 22:10:53 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Fri, 20 Jul 2012 22:10:53 -0700 (PDT)
In-Reply-To: <7v394nveni.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201803>

On Thu, Jul 19, 2012 at 10:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Perhaps something like this...
>
> Yeah, like that ;-).

Hmm.. this one was potentially data-losing.  Sorry for not catching
that in 7e0abcec103b3649943b236881cf88e8fd6cf3a4.

$ git tag --contains 7e0abcec103b3649943b236881cf88e8fd6cf3a4
v1.7.11
v1.7.11.1
v1.7.11.2

maint, please?

I don't like complexity either, but adding a --symlinks option (and
making it the default) to create symlinks instead of copies really
does seem like the way to go long-term.  Then we can avoid the whole
copy-back business when in this mode.

I'll start exploring this unless you beat me to it, Tim ;-)
-- 
David
