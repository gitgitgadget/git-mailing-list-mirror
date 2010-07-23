From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Fri, 23 Jul 2010 14:10:36 +0000
Message-ID: <AANLkTinsixPihZRtduuB_0puX_ucC0HYqHPU0UJMX2e-@mail.gmail.com>
References: <201007231518.31071.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	jstpierre@mecheye.net
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 23 16:10:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcIxY-00027W-6Z
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 16:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab0GWOKi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 10:10:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51954 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab0GWOKh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 10:10:37 -0400
Received: by iwn7 with SMTP id 7so250039iwn.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=luzwC17F14Lx1wHFMjjn60yJYFCIqrVmUI50EJZHVNg=;
        b=vnrUFc1uSa9qrOx3hzEATZy62pJrm4M5EFCstDxyOWOUOvF8vXm2jC2l3f99GduyoP
         xT8RlpybGFmG5XcXfIDYnKhX9vpK2j9AjqtowPW/nRc3K8luZkfnvBi1cP/vJPnVZwIp
         RW1zS3CxEQWoUqb4NUiSzArVbQKNJGMgWspqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q/T+gRZzYj1GJuxTM/Oxaj2AP7Uk3tYxnvaMzIHV7EFcMclf5oxFu89tQRo7PgmLw8
         Rquo0D8GD7F+Sk6hpz5XkcpTC3JE08vwerlQKSpF5ddeRrVnYd0sPklr3KIPWOAKMjj3
         PCuaDsXnOAn2GQOPq+ee1qHjoIgmWLtGu1A3M=
Received: by 10.231.170.3 with SMTP id b3mr3704501ibz.122.1279894236558; Fri, 
	23 Jul 2010 07:10:36 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 23 Jul 2010 07:10:36 -0700 (PDT)
In-Reply-To: <201007231518.31071.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151532>

On Fri, Jul 23, 2010 at 13:18, Thomas Rast <trast@student.ethz.ch> wrot=
e:

> doesn't say much about + and the only escaping defined is the usual
> %xx style. =C2=A0So is there a standard that mandates this, or was it=
 just
> a well-meaning but unnecessary backwards incompatible change?

+ and %20 are as far as I know only interchangable in *query strings*,
so having to clone 'git://git.gnome.org/gtk%2B' where you could
previously clone 'git://git.gnome.org/gtk+' is a bug. Git shouldn't be
changing that + to a %20.

I haven't followed why we need to escape + to %20 at all, even in the
query string. E.g. curl(1) doesn't do that before sending requests to
Apache, which can handle either one. The + v.s. %20 duality is always
handled at the server AFAIK.
