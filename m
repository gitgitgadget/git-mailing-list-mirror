From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sun, 17 Jan 2010 02:43:13 +0800
Message-ID: <be6fef0d1001161043q2ace931fyb17c2b2b03fe2cf6@mail.gmail.com>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <20100116203557.95340c00.rctay89@gmail.com>
	 <20100116134656.GA4504@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rudolf Polzer <divVerent@alientrap.org>,
	Miles Bader <miles@gnu.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jan 16 19:43:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWDcE-0008Lw-3L
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 19:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab0APSnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 13:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755925Ab0APSnO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 13:43:14 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:41889 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150Ab0APSnO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 13:43:14 -0500
Received: by iwn32 with SMTP id 32so1299343iwn.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YuxSwDMQTy83HEeBXDy6HOtIrB+ZeIb4IxkZkv+lbPs=;
        b=xaJzDBR6tEiOr+KdEMEwb6jZUIaNyVaviRSMB9TZzb5EW/SoBbuZ3AioiMmLZhR29b
         fqfAQJPOGXZU2ynIuJD6zWxlzAX5eZ/jvdOHDO5eD/lAf81uNJtvXOcztvfEPfaSgSpb
         ZquNEfhmlsCLSkF2kGu/3ZcXRuwN8CPSxtZ3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cPNip4LMSg+s2TKdV1NeaX1XPJKAJnVHLSaDB9ow3ZDA8pCvw7Te4pWIcToiLPYZN+
         tIPPC3gMLEcRjmAiHkN1ed8LV7N5V6AkLX8RjByE15zaFhJhMKNHJPESVtkFFmEgMFTD
         ST+pS7P3Fc9awi7YAyHyrhRKq17yKuPm6B1dE=
Received: by 10.231.149.201 with SMTP id u9mr881783ibv.1.1263667393784; Sat, 
	16 Jan 2010 10:43:13 -0800 (PST)
In-Reply-To: <20100116134656.GA4504@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137248>

Hi,

yet again, this patch has gone through another iteration, so I'm
adding people from the 'git push --track' thread here.

--=20
Cheers,
Ray Chuan

On Sat, Jan 16, 2010 at 9:46 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Sat, Jan 16, 2010 at 08:35:57PM +0800, Tay Ray Chuan wrote:
>> Hi,
>>
>> On Sat, 16 Jan 2010 11:23:47 +0200
>> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
>> > + =A0 =A0 =A0 =A0 =A0 OPT_BIT('u', "set-upstream", &flags, "Set up=
stream for git pull", TRANSPORT_PUSH_SET_UPSTREAM),
>>
>> This line exceeds 80 characters.
>
> Broken into two (without breaking the message), it is still over 80.
>
>> Also, I think you should follow the case-style of the other option
>> descriptions and s/Set(?=3D upstream)/set/.
>
> Fixed.
>
>> > [snip]
>> > +static void set_upstreams(struct transport *trans, struct ref *re=
fs,
>>
>> I would prefer if you could follow the naming convention and say
>> "transport" instead of truncating to "trans".
>
> Fixed.
>
>> > + =A0 struct ref *i;
>> > + =A0 for (i =3D refs; i; i =3D i->next) {
>>
>> In most places, "ref" instead of "i" is used; ie.
>
> Fixed.
>
>> > + =A0 =A0 =A0 =A0 =A0 =A0* alreay up-to-date ref create/modify (no=
t delete).
>>
>> s/alreay/already/.
>
> Fixed.
>
>> > + =A0 =A0 =A0 =A0 =A0 /* Chase symbolic refs (mainly for HEAD). */
>>
>> Did you mean "Change" here?
>
> No. Changed to 'Follow'.
>
>> Regarding the checking of ref->status here:
>>
>> Is it possible to delegate this to push_had_errors(remote_refs)
>> instead? We skip setting up upstream tracking when there are errors
>> from pushing, so we don't have to check ref->status anymore.
>
> No. As documetnation says, the update or no update is done on per-bra=
nch
> basis.
>
> <snip patch>
>
>> (As a side note, if you apply this on top of 'tr/http-push-ref-statu=
s'
>> in 'pu', the result of push_had_errors() is saved in a variable
>> ('err'), so you could just use it and not have to call push_had_erro=
rs
>> () again.)
>
> See above.
>
> I'll sit on v4 for some more time to wait for more comments.
>
> -Ilari
>
