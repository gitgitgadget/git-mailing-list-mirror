From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are va_copy.
Date: Mon, 17 Aug 2009 17:56:17 +0100
Message-ID: <3f4fd2640908170956j556fcba7o1ec4c2107197dbd@mail.gmail.com>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
	 <4A898B27.3040507@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Johannes.Schindelin@gmx.de
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:56:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5VS-0007v2-Rj
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbZHQQ4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 12:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756895AbZHQQ4R
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:56:17 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:35531 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbZHQQ4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 12:56:17 -0400
Received: by vws2 with SMTP id 2so2566798vws.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fCA2xbJaJ+PIAim4hUa/gtyWTBpPZy8+bI8QIWOMa94=;
        b=PVzQS2e/C0KZ7WH9KvD1rkuxZ/ExF1qD27rn6DFLZYykK9ttc8ZROQ0WqWuplCFdiQ
         60Nwj+Svqo/h4ybJu0WlH17tDsqPRY7gQXm92KyK/X6SYu+UVlJwbdFEbPyyczqcG2ro
         szqky38bQzcoukK+eOXhx/CnJTwvI9Fhc2JAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gAuiTT07vMxrKjDkBaZOsrARuWa0OptQvWW4uWXVGKeLp6Dyni/60FJ3B3cJfTg8UW
         dbgArViIpwzavgae8hMkBb2KzsudWvCpJQmwFo8l+e+yj3EIXwfmvhDQsGWxeMZHu552
         2zk0mr9m+o8uKi8+hrt545Kw/WBU0vSFkNfk4=
Received: by 10.220.127.134 with SMTP id g6mr5037623vcs.35.1250528177489; Mon, 
	17 Aug 2009 09:56:17 -0700 (PDT)
In-Reply-To: <4A898B27.3040507@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126230>

2009/8/17 Paolo Bonzini <bonzini@gnu.org>:
> On 08/17/2009 06:04 PM, Frank Li wrote:
>>
>> MSVs have not implemented va_copy. remove va_copy at MSVC environmen=
t.
>> It will malloc buffer each time.
>
> ... but only a 257-byte buffer as dscho pointed out.
>
> In many places that do not have va_copy, a simple assignment works. =A0=
And
> va_end is almost always a no-op. So what about
>
> #ifndef va_copy
> #define va_copy(dst, src) =A0 =A0 =A0 ((dst) =3D (src))
> #endif
>
> if it works on MSVC?

According to http://stackoverflow.com/questions/558223/vacopy-porting-t=
o-visual-c
that should work.

- Reece
