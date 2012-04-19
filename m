From: Junio C Hamano <gitster-vger@pobox.com>
Subject: Re: [GUILT] Preventing "git push" when guilt patches are applied
Date: Thu, 19 Apr 2012 08:19:58 -0700
Message-ID: <CAPc5daV4mK7aLRAm4Ow9TBPf5Tj3B=Qpf0=cRXjbeZoOuoYMKQ@mail.gmail.com>
References: <4F8FBD63.9050507@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ceder@lysator.liu.se
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 17:20:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKt9a-0007qp-NT
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 17:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab2DSPUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 11:20:05 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:60299 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533Ab2DSPUD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 11:20:03 -0400
Received: by wgbds11 with SMTP id ds11so1633414wgb.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rNLY2kE/CfqRTjz5j9WRlUyFfDfNRxT5/LOta9rJ0jw=;
        b=nksruADHYfWZDulQX4eLZ6SFQ9E748XKach/PaJoY/G/PAWnoZxQmO9j5tRQ5dC1Va
         GKY41hscnhb13ckQtuCgO+8Y1vW3jlHJSpuMKGNDsjCVi78z8p6KfzxYh3uGv0Zz782W
         VMqiRAl58dtyYvVHov8JsaYhww4zziToJS2AvJqbbws9zbpcRUxeTKYvnQcemiO0QGZ4
         AalkF6ERn80YdvDlEsF0qT4fvn0hEbRKhcuEfghmCvTLXK0Sn6k+wMsPtF0GZUSPrEPk
         //nXsSlcIDA0FBiLlKTts/SpybYvRu0JVMyHUaCU1C8BCzDJOfXLxGsOqLB7LeWv60l3
         8aXw==
Received: by 10.180.98.8 with SMTP id ee8mr6273184wib.14.1334848798145; Thu,
 19 Apr 2012 08:19:58 -0700 (PDT)
Received: by 10.216.216.16 with HTTP; Thu, 19 Apr 2012 08:19:58 -0700 (PDT)
In-Reply-To: <4F8FBD63.9050507@opera.com>
X-Google-Sender-Auth: Wu6eTNRPhzeaGFMBKCS7v9pW8Ho
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195950>

On Thu, Apr 19, 2012 at 12:23 AM, Per Cederqvist <cederp@opera.com> wro=
te:
> I have by accident done "git push" when I intended to write "guilt
> push" a couple of times. =C2=A0If there are guilt patches applied whe=
n I do
> this the result is that (part of) my half-finished patch series is
> pushed to the master branch. =C2=A0That is of course not good.
>
> TopGit avoids this issue since I'm on a separate branch when patches
> are applied.
> ...
> I'd like to add something similar to Guilt, to avoid making this
> mistake ever again. =C2=A0(It is quite embarrassing to clean up after=
 you
> push a couple of half-baked patches.) =C2=A0But I don't know how the
> feature should be designed. =C2=A0Some ideas:
> ...

Isn't the most obvious one (somehow missing from your list) from your
observation you
described earlier to have guilt apply patches on a separate branch?

Would it also work to set "[push] default =3D none"?  Then "git push"
typed by mistake for
"guilt push" (I am assuming that "$whichever push" does not take any
other argument,
and that is the root cause of your fat-finger-embarrassment issue)
would not push anything
out.
