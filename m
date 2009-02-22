From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: Re: [PATCH/RFC 1/6] tag: read signature
Date: Sun, 22 Feb 2009 20:25:21 +0200
Message-ID: <e29894ca0902221025t5e015c96ycb90afaec4a33124@mail.gmail.com>
References: <e29894ca0902221006y4b0e29e7ucc8a04e8e6e42f4@mail.gmail.com>
	 <7vskm6xrm7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJ2T-0001nk-Dc
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbZBVSZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 13:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbZBVSZY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:25:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:1817 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbZBVSZX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 13:25:23 -0500
Received: by nf-out-0910.google.com with SMTP id d21so369560nfb.21
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fUcY71NKXD0TFXohWAuy5/x8Mf8yK2SF4rSRclVFOsA=;
        b=MrUeNLc96tj2gVIJF0iPChrB7E9auf3rcKnYt8ao4M3TwipU5ZzlFEVnHQIARPrEpE
         PshWXIjjzCAZJMGknki1nm/cZ82LGVbUG/a8s6Mz+nYDRGVE70QL1ZRd87s97/nQO7X6
         ZkGMmKRyOIh4+QGtYps2KwcEzPY85u4U7mjk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TY4xpX23p3HK61i8522ustDSFiTM2f8QLHm9tS97vg1ljEBTCp50rqLUcXoxzTgWak
         vJNgftgrQ1wnD7VZ51UuP2wGMXsoGz9J4cdkqy0rxyyqAsxnX5EYv1PlxIiuX+TMe+I9
         p5hShIOayTCP4p8rVjDrpmlMkO+RBjtFt2AFw=
Received: by 10.210.112.4 with SMTP id k4mr2736775ebc.0.1235327121514; Sun, 22 
	Feb 2009 10:25:21 -0800 (PST)
In-Reply-To: <7vskm6xrm7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111042>

Hi

On Sun, Feb 22, 2009 at 8:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> diff --git a/tag.h b/tag.h
>> index 7a0cb00..bc2cab3 100644
>> --- a/tag.h
>> +++ b/tag.h
>> @@ -9,7 +9,7 @@ struct tag {
>>       struct object object;
>>       struct object *tagged;
>>       char *tag;
>> -     char *signature; /* not actually implemented */
>> +     char *signature;
>>  };
>
> I do not speak for Daniel, but I think the original intent of "signat=
ure"
> is about the GnuPG signature, not the "tagger" field.
>
> And this is not an objection.  The use of GnuPG is accidental and at =
the
> low level of the object layer like this codepath we would not necessa=
rily
> want to be married to it.  Grabbing and parsing the tagger field like=
 your
> patches 1/6 and 2/6 did would be more appropriate.
>
> But then we would probably want to rename this field "tagger" (and th=
en
> the timestamp field you add in the next patch "tagger_date").
>

Yes, I though the same. But when I saw the way it was parsed before
(the value of sig_line), I was not sure about naming.
I agree it would be better to name it "tagger".

regards,

--=20
Marc-Andr=E9 Lureau
Sent from: Helsinki Southern Finland Finland.
