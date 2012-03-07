From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass under
 Mac OSX
Date: Wed, 7 Mar 2012 23:04:43 +0100
Message-ID: <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 23:05:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Oyt-000392-S6
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523Ab2CGWFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 17:05:09 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65076 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030508Ab2CGWFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 17:05:05 -0500
Received: by eekc41 with SMTP id c41so2502424eek.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 14:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZqtoRUGMhfG1jo0TpWHMbq06LknLad/MjbDQPYPIMhM=;
        b=dfuDFq1ih94W8Q3VWAKyXiPSpbl4J0uuOyqzP8vAASE994LFngb7FXjOsVuEK/v7V7
         lW1NuWhwPXraaU4sK5Pp41iGX0V75WG7u2YA/9ce0SHfC1BeKZTgoKVhuTo/+6eGk9oT
         1p485Gxc/4pAGVKv18alYWSBGHyyvbxqmcMyR9s3qGr7UcdCmNA0wmwRqMKQPQnr0YDG
         NbeuRfBezAQdkZRXY7zq3HrMY1WNicPvDSBlRZ9ymDn2lmTbNZ/6FPfCVB/Z3vv9UflA
         OfkiyAqrVtSA9s+DfcAu/AmqFoEwiu7qRhZEDdQcZLjp9Pi5mc9W06kWr5ZAg2CjSMa1
         0y4w==
Received: by 10.14.127.76 with SMTP id c52mr1641367eei.37.1331157904293; Wed,
 07 Mar 2012 14:05:04 -0800 (PST)
Received: by 10.213.2.147 with HTTP; Wed, 7 Mar 2012 14:04:43 -0800 (PST)
In-Reply-To: <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192490>

2012/3/7 Junio C Hamano <gitster@pobox.com>:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Mar 7, 2012 at 22:34, Junio C Hamano <gitster@pobox.com> wro=
te:
>>>> I think it's important to be pro-active about trying to spot
>>>> any issues that might affect end users before they happen.
>>>
>>> The goal is noble, but asking the platform to perform an impossible
>>> task and subjectively judging if the failure mode is acceptable is
>>> not the way to do so, I would have to say.
>>
>> I leave it up to you whether you want to accept the patch to remove
>> it, but with it included we at least *know* what the failure modes
>> are, since we get user reports about it.
>>
>> That's the reason I put it in there to begin with. Because I have no
>> idea how all these pieces play together with systems in the wild, an=
d
>> I'd like to pro-actively find out about that.
>
> Are we talking about the same specific test?
>
> What you said above all makes sense and I agreed that it is a noble
> goal, *if* and only if the test is about the case we *expect* to
> work. =C2=A0This particular one prepares a message that cannot possib=
ly
> be transliterated to iso-8859-1 and asks the system to show it.
>
> What scenario do you have in mind that we (or the end user for that
> matter) might benefit by having this test?

E.g. if we find out that their implementation of gettext panics
instead of showing question marks that means we'd have to pay special
attention to that platform.

Anyway, I admit that this is an obscure edge case. I really just like
the idea of having complete knowledge (which we'll have in time since
we get ported everywhere) about how the various aspects of our i18n
implementation work.

Having that information doesn't cost us a lot, in this case we can
just amend the test to assert that on OSX the output should be the
same as under the UTF-8 output.
