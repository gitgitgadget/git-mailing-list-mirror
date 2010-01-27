From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Fix git rev-list --reverse --max-count=N
Date: Wed, 27 Jan 2010 23:17:11 +0100
Message-ID: <fabb9a1e1001271417w1c26fffdy379f8b845e4098b1@mail.gmail.com>
References: <1264622600-20981-1-git-send-email-spang@google.com> 
	<201001272309.26054.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Spang <spang@google.com>, git@vger.kernel.org,
	"Junio C. Hamano" <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:17:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaGCg-0001mi-Nb
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 23:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab0A0WRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 17:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756130Ab0A0WRc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 17:17:32 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:55155 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116Ab0A0WRb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 17:17:31 -0500
Received: by pxi12 with SMTP id 12so27106pxi.33
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Bd7dBK5gW2kmsyiJs8SjMKpNwufNJxR0czP4ymX/GHA=;
        b=gLgtbvlGtTbg7x1we6C2DCh072OsvMj3/GuH6ISAsC/Vlevj3aaLZ6e7taWTbIifzw
         L9OgcEj3hzXne4dYp5Br6gFTT6Z6NVkISLD5nBeMlBvoYvwM3Mb2s/sE/08FLgHCr0aS
         vwTxdB8SkS4k7gZ8ZtHYu1yjOk1xK303oyOUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RmHvp5oJP6ZlCxX6uxDVE3lkaR7z8/BgH8yNmIYlSao4lB/FYlLHYPbNB5imzLEqxC
         +V5P5mND8g/DDJsw6DFbhGRp1WpKNSAshXFwbYEnigKsIBvcJP2CO9qgIWdwT/mIWV6F
         Fz+ZYVx03eKWfdO+9PSNefPYryPBEmGAmrvTk=
Received: by 10.143.153.24 with SMTP id f24mr4320147wfo.307.1264630651260; 
	Wed, 27 Jan 2010 14:17:31 -0800 (PST)
In-Reply-To: <201001272309.26054.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138200>

Heya,

> So when you have this history (A is oldest, D is newest):
>
> =A0 A--B--C--D
>
> and you say
>
> =A0 git log --max-count=3D2 --reverse D
>
> then you want
>
> =A0 A
> =A0 B
>
> but I want
>
> =A0 C
> =A0 D
>

And the current behavior is

B
A

Isn't it? I agree btw, that C D is the 'correct' result.

--=20
Cheers,

Sverre Rabbelier
