From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 11:15:57 +0530
Message-ID: <AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<20100905174105.GB14020@burratino>
	<20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
	<AANLkTinoEp55C3=hF6-LO5fwn2FpMxBZry-=2B6kvXc1@mail.gmail.com>
	<m3pqwrnay2.fsf@localhost.localdomain>
	<AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 07:46:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsUWv-0002Z9-E8
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 07:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab0IFFp7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 01:45:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36353 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0IFFp6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 01:45:58 -0400
Received: by gwj17 with SMTP id 17so1431425gwj.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MokV8hmDA3VEcVB8StlRhgoUGAHqvEA31ax3ORG316E=;
        b=NXZx+vGxas/wVe7gdutuD8uDtHqgK/RJm4zPanmq1HQnBcfyY0JKs322RGa9WxQna1
         I1UPC+XjwUZsx4TyF91Nk3p0LXg3FN7pETR1hjlSVTW+dA9Vu+humvyPMbPWMCdvOLP3
         6tCeWrP59fALXAJt8ICliYuQOD37KSTsSdnbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=etgptX4jVaVr9Owh03yr6cWza66aJZWD+KcKGlTrFvLKmnckd17vuqoWiCufGSTgBh
         0cdGnafVD3jFK94FJtbV/1vclnvhtfrOwb4r5DLybx4TKMH6+xxVoIbeYBjU3aHbTz1e
         Z7HGB3SA8E94rgLoRWmBvJVmZeLZXEMFE0GY0=
Received: by 10.90.92.5 with SMTP id p5mr295398agb.142.1283751957702; Sun, 05
 Sep 2010 22:45:57 -0700 (PDT)
Received: by 10.90.209.12 with HTTP; Sun, 5 Sep 2010 22:45:57 -0700 (PDT)
In-Reply-To: <AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155530>

On Mon, Sep 6, 2010 at 6:34 AM, Sitaram Chamarty <sitaramc@gmail.com> w=
rote:
> On Mon, Sep 6, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
>>> <ilari.liusvaara@elisanet.fi> wrote:
>>>
>>> > AFAIK, HTTP errors don't have descriptions printed.
>>>
>>> I don't know if this applies here but HTTP error codes can come wit=
h
>>> any free-form \n-delimited string:
>>>
>>> =C2=A0 =C2=A0 HTTP/1.1 402 You Must Build Additional Pylons
>>
>> And you can also send more detailed description in the *body* (and n=
ot
>> only HTTP headers) of HTTP response, though I don't know if git does
>> that.

turns out all this was moot.  It was *because* I was using something
other than "200 OK" that the user was not seeing the message.  Ilari's
patch just makes the message *look* better/cleaner, but I still have
to send it out with a "200 OK" status.

That was... a surprise :-)

Thanks all

sitaram
