From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Portability patches vs 1.7.0.2 [5/6]
Date: Tue, 9 Mar 2010 18:08:15 +0100
Message-ID: <40aa078e1003090908o74593fafw59bd992eda2b2b12@mail.gmail.com>
References: <20100309161906.GF99172@thor.il.thewrittenword.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 18:08:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np2ut-0002R5-TL
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 18:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab0CIRIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 12:08:18 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51777 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab0CIRIR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Mar 2010 12:08:17 -0500
Received: by wwb39 with SMTP id 39so388769wwb.19
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ihMsMgz5elfP/MiLOjlfg1JxOVg3qq/G9hljrvIcpxc=;
        b=u8N9mDV1Uel/VyKalNX1NWvYTVVOljRnOjXcodLe+vSkkA6a/uxCl3coHXZdV4qzzt
         8pHesXx75kBbXlJ7dh830Cb92alXTiQ5du/AaFcjlLIjdMyJS7ekPOKLYiPO7dZ1CW2T
         kWAYFFGMESfb9WLx+Vg9EFWIoUkUM7kjpkV2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=ccKudkprbwzjubVHbQC9y3c8IxsrRDqb5UeZMjDAr4yfsA/1bQgkIMPn613uqP2WKS
         eNHKIaZ6gT4mL9Uu6O2llt08VWzRTkrR4Gd+r30o+KtAgCccDWpykaVO9ZiHlo5izwJm
         5cICvvs2qzLNzhVJWiLqpktboFQltK6h0UyZQ=
Received: by 10.216.163.11 with SMTP id z11mr70333wek.24.1268154495594; Tue, 
	09 Mar 2010 09:08:15 -0800 (PST)
In-Reply-To: <20100309161906.GF99172@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141832>

In the future, please read Documentation/SubmittingPatches before
sending patches. Patches should be inlined, for one.

On Tue, Mar 9, 2010 at 5:19 PM, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:
> Actually, I'd like some advice on whether this was a good idea? =A0Wa=
s
> the change to the code in git-1.7.0 introduced in response to a bug
> (latent or reported) that is fixed by the code I reverted in this
> patch?

I'm the author of commit 15515b73, who introduced that change (due to
a bug). This is something that git-blame could have told you, and you
could have CC'ed me. It's pure luck that I had a look at this patch.

Simply doing memcmp will not work, since sockaddr_storage contains
both the IP-address and the port, but the port should not be compared.

> =A0If so, what is the right way to fix it (assuming you don't
> want to introduce a dependency on gnulib and Automake into git)?
>

If ss_family doesn't exist, does that mean that the platform only suppo=
rts IPv4?

--=20
Erik "kusma" Faye-Lund
