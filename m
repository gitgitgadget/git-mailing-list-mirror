From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Thu, 4 Aug 2011 01:24:12 +1000
Message-ID: <CAH3AnrpPaUY1fj9thMybPUgeM=mBEN3FjawjiR2vhw4S-v6qyg@mail.gmail.com>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
	<1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
	<7voc07ct9z.fsf@alter.siamese.dyndns.org>
	<7vk4avcsk9.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrtfhU1r1DWO8ski5Jd=cLXcj3Wq-MowB8QKv+r1-BT_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 17:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QodIx-0005s2-7d
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 17:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab1HCPYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 11:24:14 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47574 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab1HCPYN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 11:24:13 -0400
Received: by vws1 with SMTP id 1so388387vws.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tgqYpm8i/t7WVta1sretDiIzoPZkyLgPm5sKfnmBxxI=;
        b=rFGOLf71KvFqOS0W8KpmXcOtfIq5Z+r/ADLNF2/aJ5qWpzePabGlH0Z6rrNnjf0jzr
         2v263m89lMZ/lm8taLXyazEDwEkuN/dmfZ0qeUGLAUJQV95IrS0HcR1RptPo+O+GAoCK
         MD+9YUhFHanl0XQwrVolUErUz4SvG209RObxQ=
Received: by 10.52.98.197 with SMTP id ek5mr6792359vdb.298.1312385052572; Wed,
 03 Aug 2011 08:24:12 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Wed, 3 Aug 2011 08:24:12 -0700 (PDT)
In-Reply-To: <CAH3AnrrtfhU1r1DWO8ski5Jd=cLXcj3Wq-MowB8QKv+r1-BT_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178590>

On Wed, Aug 3, 2011 at 11:16 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> On Wed, Aug 3, 2011 at 9:16 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Jon Seymour <jon.seymour@gmail.com> writes:

>>
>> Further polishing we may want to do while it is still in pu/next I c=
an
>> think of off the top of my head are:
>>
>> =C2=A0- In this mode, I can bisect the history even inside a bare re=
pository,
>> =C2=A0 as the whole point of --no-checkout is that the mode does not=
 require a
>> =C2=A0 working tree. I however suspect "git bisect" requires working=
 tree. Is
>> =C2=A0 this something we want to fix?
>>
>
> I agree, that would be useful. Haven't tried it yet but I'll see what
> happens.I may issue changes for this as separate commit that can be
> squashed later, if required, =C2=A0once it has been reviewed.
>

I had a quick go at doing this, but haven't been able to test it
fully. At a minimum it will require that we relax the barriers in
git-bisect.sh and git.c that prevent git-bisect
and bisect--helper running without a working tree. Other paths in
these modules will need to  be checked to see that they don't have an
implicit assumption that a  working tree is available.

I  won't have time to tackle this properly until the weekend.

jon.
