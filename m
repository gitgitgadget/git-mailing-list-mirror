From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 10:45:36 +0200
Message-ID: <s2v40aa078e1005070145p8e294a80l6013f3011a6199f0@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
	 <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, hasan.aljudy@gmail.com,
	torvalds@linux-foundation.org, prohaska@zib.de, gitster@pobox.com
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 10:45:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAJBn-0004nG-4t
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 10:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab0EGIpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 04:45:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40103 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab0EGIph convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 04:45:37 -0400
Received: by wyg36 with SMTP id 36so620016wyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=q2EAOkEBIsJyZwGODHjiqKpDlm/m1nJDgGMIJ6fJjT8=;
        b=FQhy0BWt7KAUcImizYuqjWTTOYj4IfinIoUAHWWQvDbDDdV6P4VFon8hKnOnTObFe9
         xwPuKN/7btQCMZj+9kLSjRkWQhtA3wqAFuykZkGr7l7cLndTye+WeTu82lgM/jhetRvi
         LK55lEEivGf5wTHThxhPhFzM0fwpxlRnckpLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=BL8z8Dx9yD3h4sGD5t5SbaZYljW434yBy7aejrjMLhO2xGe3Xjxmnbi3O1wmeIZ+u3
         VSTRTx/SAUXIhvZjCeP4X7D8+SK5f3p86NBHUiohd2Y2gf4KLhJv4kkCZbzqsoVD9Lwt
         KCUUJxNyCiBh4QIkVBMoaE981O3adZdFapN8s=
Received: by 10.216.188.207 with SMTP id a57mr6537117wen.147.1273221936189; 
	Fri, 07 May 2010 01:45:36 -0700 (PDT)
Received: by 10.216.51.79 with HTTP; Fri, 7 May 2010 01:45:36 -0700 (PDT)
In-Reply-To: <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146530>

On Fri, May 7, 2010 at 12:27 AM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> This discussion couldn't be more timely, as I've recently acquired a
> desperate need to solve CRLF problems at $dayjob. =A0This patch serie=
s
> introduces a new way of turning on autocrlf normalization by splittin=
g
> the configuration into two:
>
> - An attribute called "auto-eol" is set in the repository to turn on
> =A0normalization of line endings. =A0Since attributes are content, th=
e
> =A0setting is copied when the repository is cloned and can be changed=
 in
> =A0an existing repository (with a few caveats). =A0Setting this attri=
bute
> =A0is equivalent to setting "core.autocrlf" to "input" or "true".
>
> - A configuration variable called "core.eolStyle" determines which ty=
pe
> =A0of line endings are used when checking files out to the working
> =A0directory.
>

Beautiful! This approach addresses most (all?) issues I've had with
core.autocrlf in a very elegant way IMO! :)

--=20
Erik "kusma" Faye-Lund
