From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Query: Patches break with Microsoft exchange server.
Date: Wed, 11 Aug 2010 12:39:53 -0400
Message-ID: <AANLkTi=6hXj_a1X-HwYWvWt4_pBto_OQgkWE3VsDmEsJ@mail.gmail.com>
References: <4C5F9B25.8080401@st.com> <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com> 
	<4C624AE1.30504@st.com> <4C62C5BD.3020808@mnsu.edu> <1281542305.5107.11.camel@localhost> 
	<AANLkTi=9xVdfXJXpkNPUMahc7AsbxjVbZFSxeBrzvbmS@mail.gmail.com> 
	<1281544234.5107.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
X-From: linux-kernel-owner@vger.kernel.org Wed Aug 11 18:40:28 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OjELr-0004Vt-GW
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Aug 2010 18:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab0HKQkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 11 Aug 2010 12:40:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48627 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab0HKQkO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2010 12:40:14 -0400
Received: by wyb32 with SMTP id 32so317757wyb.19
        for <multiple recipients>; Wed, 11 Aug 2010 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g5eQtqHPd0ZVDTGQNqp3qJ543gfVsvxcAWGAkO4flN0=;
        b=WK3za2P7gARtoKmOJA76OnE6G9iHBy8ZR+MS5myLDQRfNemjEnJo7DaAbwLSX35SAZ
         UKe2J/hQ2CYLTk40VC2XKEHCVsYa/H5EAJEgVWeqg65VjwptaQWV+1ids3Zy8txhFNIS
         tDTvIvDVfLKCaEdWBkyLc0+95hsOp1YrGQzRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UPb9SpWT6Eb3j+4jx6xEW4U9qfo5LtzBVNvJzKlRb3caACaYXDzQtVWVLiXOVdJNq4
         mlsPHbSN96sxpdKHDLuObV7PL5GrBALX8EksiKkNRF+MY8omY0rM2s0rx5azKHYZWt9C
         L6CfyFFTFSNN+sKHaAesOFJ4563U5lE/T8pKY=
Received: by 10.216.232.229 with SMTP id n79mr16935893weq.52.1281544813150; 
	Wed, 11 Aug 2010 09:40:13 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 11 Aug 2010 09:39:53 -0700 (PDT)
In-Reply-To: <1281544234.5107.25.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153267>

On Wed, Aug 11, 2010 at 12:30 PM, David Woodhouse <dwmw2@infradead.org>=
 wrote:
> On Wed, 2010-08-11 at 12:18 -0400, Avery Pennarun wrote:
>> Out of curiosity, why fall back to one chunk at a time? =A0It seems =
to
>> me that IMAP should be able to still support multiple outstanding
>> requests in that case, but you'd just get errors on the latter chunk=
s.
>>
>> It is just that there was no point optimizing the workaround case?
>
> There wasn't a lot of point in optimising it.

Say no more :)

I code on some IMAP clients occasionally and I just wanted to make
sure I wasn't missing something important.

Thanks!

Avery
