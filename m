From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 08:45:14 +0000
Message-ID: <AANLkTim-yfjACM_VqR2oaOaB=mLtD=+3QiXiWpwcdH1z@mail.gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<20100905174105.GB14020@burratino>
	<20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
	<AANLkTinoEp55C3=hF6-LO5fwn2FpMxBZry-=2B6kvXc1@mail.gmail.com>
	<m3pqwrnay2.fsf@localhost.localdomain>
	<AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com>
	<AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 10:45:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsXKO-0006RT-L0
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 10:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab0IFIpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 04:45:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37327 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0IFIpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 04:45:16 -0400
Received: by iwn5 with SMTP id 5so4026913iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+g8HZNclgP4p7OR6oeoOyC9gPGS+PvLDAAuzn+jkNYI=;
        b=qUma6Q47qjCxffIwJJc10PbMAuB94UApaNNknU16oDXY+VBwMiuZ6v2DYSqJg0Pf1G
         x7hG543HEmPuwL80A+BK7z90hkpiVGQAocjeRiY6ow1fqeXZw35t5jc3dWfGbC+zn5ep
         sz/lha65G2l0BbaD1TyuiSiYD+2zISwRwWZpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AtdxVErveXqseuuCnLqeeo+PlV/C2Yvv41rsN37UyPoRY5FLoKRyg7Ok8uA7t6gec0
         jBBT8oD1vXvtuLtSfcz/B/jWmV5zd/NFWvA0LckwMQwvDEY3sGbrpMQhFnlwl2XlEb6o
         V9Slr3bG1gNjAZr4vsHTaatVkRpVbdzpxtGjs=
Received: by 10.231.85.206 with SMTP id p14mr685398ibl.89.1283762714714; Mon,
 06 Sep 2010 01:45:14 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 01:45:14 -0700 (PDT)
In-Reply-To: <AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155543>

On Mon, Sep 6, 2010 at 05:45, Sitaram Chamarty <sitaramc@gmail.com> wro=
te:
> On Mon, Sep 6, 2010 at 6:34 AM, Sitaram Chamarty <sitaramc@gmail.com>=
 wrote:
>> On Mon, Sep 6, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
>>>> <ilari.liusvaara@elisanet.fi> wrote:
>>>>
>>>> > AFAIK, HTTP errors don't have descriptions printed.
>>>>
>>>> I don't know if this applies here but HTTP error codes can come wi=
th
>>>> any free-form \n-delimited string:
>>>>
>>>> =C2=A0 =C2=A0 HTTP/1.1 402 You Must Build Additional Pylons
>>>
>>> And you can also send more detailed description in the *body* (and =
not
>>> only HTTP headers) of HTTP response, though I don't know if git doe=
s
>>> that.
>
> turns out all this was moot. =C2=A0It was *because* I was using somet=
hing
> other than "200 OK" that the user was not seeing the message. =C2=A0I=
lari's
> patch just makes the message *look* better/cleaner, but I still have
> to send it out with a "200 OK" status.

You can still send it out with a "200 <anything you want here>" if you
want to give a warning/error even on 200.
