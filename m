From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http: add_fill_function checks if function has been added
Date: Sun, 8 Mar 2009 04:49:13 +0800
Message-ID: <be6fef0d0903071249s42ac7f94o82461ca32dcdfcd5@mail.gmail.com>
References: <49B266B0.4020304@gmail.com>
	 <7vy6vhm6it.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 21:50:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg3Tn-0001KP-Go
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbZCGUtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 15:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbZCGUtP
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:49:15 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:51450 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbZCGUtP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 15:49:15 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1021174rvb.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 12:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y3srIkBHhoWOJc+HhF/htzGkUwXYbBU2EbFS9jjegPM=;
        b=VFeiGNWOqX+pmCGj2ViOrjCx17gfx/KCep0DsWPDnfaFYFzjClv9hgQ0VoS2YH2yjU
         UDwHR0IIoIvk5oWuKo8QF3nnSimIA7T+IpJttyDrFhMAAEu7DnfKYsevzUu6dYPz0hCV
         E9NqdrHuBalEpyHodGE13FyEj+z4VYcLoNgk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RoL24x+eAwwbxaoLbkZxN5aim/cZO00XufD1QF8uu2/VxG+mkpnLWIMTB81iJ1xFCx
         8W8A2lW1nKLQTPdfLJFy8fSfzmC01j9lVe0eehC4FiP7wJcpyXg8DOlk6yOiGPMpBHKW
         T/qqGWG3qzaIQ0J6jmO3QTONb1yRsaRAs/fIg=
Received: by 10.115.59.4 with SMTP id m4mr2415280wak.204.1236458953089; Sat, 
	07 Mar 2009 12:49:13 -0800 (PST)
In-Reply-To: <7vy6vhm6it.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112580>

Hi,

On Sun, Mar 8, 2009 at 4:18 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Could you care to explain the following a bit better?
>
> =A0- what "possible issues" you are addressing;
>
> =A0- what changes in the behaviour that are not "obvious" we would be
> =A0 suffering from, if we apply this patch;
>
> =A0- in what situation the performance _might_ be affected, in what w=
ay and
> =A0 to what extent.

(note: "repeatedly" here means looping over it, eg. while(condition)
fill_function(). )

Thanks for taking the time to give this clear and detailed example expl=
anation.

However, at this point of time, I couldn't come up with a convincing
instance of where

 *a fill function is added twice or more, and as a result

 *something breaks as a result of invoking the function repeatedly

that was why I used the word "possible" as in "possible issues",
because this patch doesn't solve any existing issues (at least none
that I know of now).

Calling a fill function repeatedly won't break behaviour, because fill
functions (those that are currently defined in git) are designed to be
called repeatedly. But it's just useless to call the same fill
function repeatedly without any reason.

So should I still address the "THIS and THAT breakages"?

--=20
Cheers,
Ray Chuan
