From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: --replace-all with one argument exits properly 
	with a better message.
Date: Sun, 15 Mar 2009 12:26:30 +0200
Message-ID: <94a0d4530903150326u34a0715v38269417e2785db8@mail.gmail.com>
References: <1236998552.9952.2.camel@luis-desktop>
	 <7vtz5vakrp.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530903141434w2fb8aa28we087465482a12e41@mail.gmail.com>
	 <7vab7na6wb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 11:28:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LinaJ-0001J2-57
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 11:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116AbZCOK0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2009 06:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbZCOK0f
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 06:26:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:44860 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbZCOK0e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2009 06:26:34 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1045672fgg.17
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0OhhvoYB+Fw/k3n1NbyNuMYkwBT8+fL5yualzdWtmm0=;
        b=OiDgMja86/gua11wuiTNREppilBaHRWoy2As/8IQyr/ztl5qhRrb2A/TNouF2BelsI
         Q2yTDTHivOVETqAskyor43H3VZg6+9dvREcCXJ46Dcdwc44CntUJ6MCkBz7mPxLRqd/e
         Z0S+9r0OflRo5kbqaYxuCrOzievuzmxh0MIG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=suYvjNUXms5cAR73JT+xgWX+tS0SyCec0Dux7SuWvUqDCmMJRDsxHPo/dRluQ7LyAO
         0i+FVt2Apq5CMdiA/Zi8l302cI+M3f0wTbBjXOqmtPC2RwDz+KpLlaINPjZVt/RG+Hmp
         2yiyyD2q1whfJPn8UFSDHmPq4/dViPIt0sc18=
Received: by 10.86.59.2 with SMTP id h2mr2034403fga.73.1237112790658; Sun, 15 
	Mar 2009 03:26:30 -0700 (PDT)
In-Reply-To: <7vab7na6wb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113279>

On Sun, Mar 15, 2009 at 3:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sat, Mar 14, 2009 at 10:53 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> Carlos Rica <jasampler@gmail.com> writes:
>>>
>>>> 'config --replace-all ONE_ARG' was being treated as 'config NAME V=
ALUE',
>>>> showing the error "key does not contain a section: --replace-all".
>>>
>>> Hmm, I am getting "error: wrong number of arguments" followed by th=
e long
>>> and somewhat annoying "usage" from the parseopt table dump.
>>
>> If you find it annoying why don't you remove the usage?
>
> Because the primary target audience of the help text is not me?

Ok. I don't think it makes a big difference to leave it on or off.
People not familiar with 'git config' might find it handy, but I admit
that I also find it a bit annoying, mainly because the error message
gets lost in the noise.

>>> Can you work with Felipe to see if this is still needed, or needs t=
o be
>>> fixed in a different way? =C2=A0It could be that your tests may alr=
eady pass
>>> over there on 'next'. =C2=A0I didn't check.
>>
>> The new code is already checking correctly that --replace-all needs =
at
>> least two arguments. However, the "usage" is incorrect and of course
>> the test will come in handy.
>
> So perhaps you can pick a part of it and send in an update to your
> parseoptification series? =C2=A0I think the series is ready for 'mast=
er'
> sometime next week if not sooner.

Or maybe Carlos can beat me to do it since it seems he is interested.
Otherwise yeah, I'll do it.

--=20
=46elipe Contreras
