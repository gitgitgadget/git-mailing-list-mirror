From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Query: Patches break with Microsoft exchange server.
Date: Wed, 11 Aug 2010 12:18:02 -0400
Message-ID: <AANLkTi=9xVdfXJXpkNPUMahc7AsbxjVbZFSxeBrzvbmS@mail.gmail.com>
References: <4C5F9B25.8080401@st.com> <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com> 
	<4C624AE1.30504@st.com> <4C62C5BD.3020808@mnsu.edu> <1281542305.5107.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>,
	viresh kumar <viresh.kumar@st.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" 
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Valeo de Vries <valeo@valeo.co.cc>,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>, mihai.dontu@gmail.com,
	richardcochran@gmail.com, "Gadiyar, Anand" <gadiyar@ti.com>
To: David Woodhouse <dwmw2@infradead.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Aug 11 18:18:33 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OjE0f-0000IQ-Il
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Aug 2010 18:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab0HKQSZ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 11 Aug 2010 12:18:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50747 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab0HKQSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2010 12:18:23 -0400
Received: by ewy23 with SMTP id 23so156582ewy.19
        for <multiple recipients>; Wed, 11 Aug 2010 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=axaZob1TkhXvDMPz4wBbldRWdMYF3npiTyPxosY2WB8=;
        b=NYbjOaKYnZDEGLuxMmzreva2FdC6gpQkjGOZPK6cEC9e/51UfJnUthRy67roMK9Zt6
         Gs9Wvnp8sWGPFPr7ZfD0XJDb+XXY+mTok0kCwlOXYUriO3sUVkxZ1rqwnMGWC3TN9t8Z
         9pKsKmS+3KIE1DIy/7wxQflOxHAHP3njYDjNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fPkmnTqAdYidm8Z+lxTQstkgYw2k1nMXMcakiAzEopvFI0P04PgoguZq0PLyQSN4WB
         QS9AOULePik0ZwLqdUt0A0bABFfQhlLOqlL1Ai1/GRkObFzLjwGWB6DTb5QgjvV8+MwU
         ghWM2LPNWOcRNY2Ya/E+Z7lNWdkY1VjCaA32w=
Received: by 10.216.35.74 with SMTP id t52mr1738731wea.41.1281543502252; Wed, 
	11 Aug 2010 09:18:22 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 11 Aug 2010 09:18:02 -0700 (PDT)
In-Reply-To: <1281542305.5107.11.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153263>

On Wed, Aug 11, 2010 at 11:58 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> In Evolution we have a workaround -- we don't just stop when we get to
> the reported RFC822.SIZE; we continue fetching more chunks until the
> server actually stops giving us any more. It's not as efficient (because
> we fall back to having only one more chunk outstanding at a time rather
> than the normal three in parallel), but at least it works around this
> brokenness of Exchange.
>
> http://git.gnome.org/browse/evolution-data-server/commit/?id=9714c064

Out of curiosity, why fall back to one chunk at a time?  It seems to
me that IMAP should be able to still support multiple outstanding
requests in that case, but you'd just get errors on the latter chunks.

It is just that there was no point optimizing the workaround case?

Have fun,

Avery
