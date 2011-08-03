From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Wed, 3 Aug 2011 23:29:00 +0530
Message-ID: <CALkWK0=sisjQ5TrLfhB6XonDQ5dmqZAyyjkvVEZRXf7W_Z4OLw@mail.gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-18-git-send-email-artagnon@gmail.com> <201107311751.52965.chriscool@tuxfamily.org>
 <CALkWK0mrx+3jdCQD9xya3AWMsPpSiZzEz+Z9XVxZNzw3UdKMVw@mail.gmail.com> <7v4o1ycsi4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 19:59:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qofj5-0004le-2g
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 19:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab1HCR7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 13:59:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51664 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968Ab1HCR7V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 13:59:21 -0400
Received: by wwe5 with SMTP id 5so1094749wwe.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6sSWW05OzD3I0fZkBgdmLMdfjQbTMzlSjpLevgmt/94=;
        b=w1a61lhTryfl53Ao57mjl384CyGoydAF1eT9+jAc6wqmuyGMDRK1Ff+AGuhu/PjWDe
         SiaoRNfHKwyNk/NVsyNMLLt9Miv14MkfkzeKTqd/+2LRgZMIoI0T550MIDkd+RIGtVGe
         Hp+nXfAmCgDw45/rqcaEKQRUjlK85aKZWVen0=
Received: by 10.216.153.149 with SMTP id f21mr3019656wek.109.1312394360080;
 Wed, 03 Aug 2011 10:59:20 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Wed, 3 Aug 2011 10:59:00 -0700 (PDT)
In-Reply-To: <7v4o1ycsi4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178601>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>>> + =C2=A0 =C2=A0 for (p =3D buf.buf; *p; p =3D strchr(p, '\n') + 1)=
 {
>>>
>>> This relies on a "\n" at the end of the last line...
>>
>> Yes, that was intentional. =C2=A0Every editor I know of inserts a '\=
n' at
>> the end of the last line,...
>
> Why do you think "diff" has a special codepath to report "No newline =
at
> end of file"? Because some editors do leave an incomplete line incomp=
lete.
>
> When working on a "buf" with an incomplete line at the end, the last =
round
> of the loop will assign "(char *) 1" to "p", try to see "*p" is NUL a=
nd
> segfault, no?

Thanks for the excellent explanation! :)
I'll fix this and re-roll asap: I'll take the opportunity to include
the other changes that Christian suggested.

-- Ram
