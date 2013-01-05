From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [BUG/PATCH] setup: Copy an environment variable to avoid overwrites
Date: Fri, 4 Jan 2013 21:15:55 -0500
Message-ID: <CAEvUa7mbs7rfGdfzbGb9p889K7GUbXFg9TUcFWFYKt8+8AKCiQ@mail.gmail.com>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
	<7vsj6gqvhc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 03:16:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrJJF-0005QJ-Lv
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 03:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab3AECP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 21:15:56 -0500
Received: from mail-vb0-f48.google.com ([209.85.212.48]:39098 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548Ab3AECP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 21:15:56 -0500
Received: by mail-vb0-f48.google.com with SMTP id fc21so16936534vbb.21
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 18:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=X2rBtXiwz3sbr77PNZKnDOq2P4QzRIoZeiobHoqRv+o=;
        b=eKov308WbhNKIbTTifKYin0CgGojPysaXqWKpjmM1W6A8h8sxDcnEsRQRY+fRHBOmK
         qt/OSs+3+Vt9+r51HPmArN8On+JD/Jde2FAQ5Gz9AT6BbGgT/bgkTJF95J0aPoPfXtyx
         OTtieyoe4MLwqvmAbR0nxdrhSbg9tj1hbeFc+nZXnC/KIlGU2jrZLweKIMAMwzTXIkHl
         zKj+HLRCJ+GfY+A/kKQb5kioYbRfyZbBAsQYGKzDmo1hLihn/NfASVmctBzfGu/k4VQW
         jJJ1VmblLvnnQCASnbotey8ttA/k7YST8Xcb8ddaCO2foSrG5Uq7oCGfrPE7VIK4N7Ud
         SMGw==
Received: by 10.220.205.195 with SMTP id fr3mr6333383vcb.1.1357352155189; Fri,
 04 Jan 2013 18:15:55 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Fri, 4 Jan 2013 18:15:55 -0800 (PST)
In-Reply-To: <7vsj6gqvhc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212659>

Hi,

On Fri, Jan 4, 2013 at 8:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> In fact,
>
>     http://pubs.opengroup.org/onlinepubs/9699919799/functions/getenv.html
>
> says that only setenv(), unsetenv() and putenv() may invalidate
> previous return values.  Note that getenv() is not listed as a
> function that is allowed to break return values from a previous call
> to getenv().

Before I sent the e-mail, I checked that very page to be sure I wasn't
entirely insane.  Specifically, the second paragraph begins with:

> The string pointed to may be overwritten by a subsequent call to getenv(), [...]

I read that line as confirmation that this is indeed acceptably
standard behavior.  Even the getenv man page on my Fedora workstation
says:

> The string pointed to by the return value of getenv() may be statically allocated, and can be modified by a subsequent call to getenv(), putenv(3), setenv(3), or unsetenv(3).

Am I misinterpreting these statements?

Thanks.

David
