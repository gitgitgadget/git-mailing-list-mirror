From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Improve the naming of guessed target repository for 
	git clone
Date: Thu, 14 May 2009 10:45:11 +0200
Message-ID: <81b0412b0905140145i4093e742x9f8c762e2bf32624@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	 <200905121900.00625.Hugo.Mildenberger@namir.de>
	 <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	 <20090512172452.GA32594@blimp.localdomain>
	 <20090513180853.GB26288@blimp.localdomain>
	 <20090513205333.GA21631@blimp.localdomain>
	 <7vfxf81ppd.fsf@alter.siamese.dyndns.org>
	 <81b0412b0905132254n5046666t24f3887f1fd4e4d9@mail.gmail.com>
	 <7v8wl0xkcu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 10:45:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4WZF-0000mo-9E
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 10:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760376AbZENIpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 04:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760108AbZENIpQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 04:45:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:58396 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbZENIpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 04:45:12 -0400
Received: by fk-out-0910.google.com with SMTP id 18so563549fkq.5
        for <git@vger.kernel.org>; Thu, 14 May 2009 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NUlTaZJzUpT1onmWqj8FXIWDprNgkIr6oQ6JihAyJvA=;
        b=cXzTuA+PWAU2zARZZYxYpl/Eo28HDdxFC1K3NF0qttCKw908KqvwPn2YnqCqabicE8
         H9UgaSIzHkVBQcH1deSwo0qEZ7pU9jnaB/LVDIEWNRjWjJaJnC8LLDCS5JTpK29KaJ8c
         cOfPdZiCfjM1d3wAsv19ntoEnw/qRQoxsctV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X4gWdwBDkZHsbAPUbOqCAgvbtxTVJC4C4dAGEJaQLeowlrAdbuEeHLC0zbjbaTHG0c
         JauFcxdAyTaUlOUBqpF/bKWUkP+VBdCjgNBrvDfnqVGzI38JZttzd9CNd+PGhks+H0da
         zBABnYMHb1CaukixkwGns/uxJNA1dlSwCU+Js=
Received: by 10.204.68.10 with SMTP id t10mr1865282bki.182.1242290711705; Thu, 
	14 May 2009 01:45:11 -0700 (PDT)
In-Reply-To: <7v8wl0xkcu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119171>

2009/5/14 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>>> What's the point of this change, now that you have a fix in 1/2? =C2=
=A0Who are
>>> you helping with this patch?
>>
>> Without this the _automatically_ generated names for cloned reposito=
ries
>> have all the whitespace around them.
>
> Even if it has whitespace around its name, that's what you got from t=
he
> upstream (a valid source of clone), and wasn't it you who said someth=
ing
> about UNIX tradition of allowing LF and others in the filename?

Yes, when user explicitely asked a program about that. This here
(clone with only URL as argument) is not the case, I think.

> If clone reports "ok we created this new repository" so that the call=
er
> can capture it, then the whole process should be able to cope with
> automatically generated names with or without the patch, shouldn't it=
?

No, don't think so. You're not always able to capture the output of git=
 clone
(Windows again), and BTW - init-db output is not designed to be capture=
d
unambiguously.

> Or are you trying to help a human user who gives a pathname ridden wi=
th
> excess whitespaces to "git clone", and that pathname _happens_ to wor=
k as
> a valid clone source, creating a new repository whose name is ridden =
with
> excess whitespaces the same way as the input pathname?

Not really. I just try to make the _generated_ output, which the user c=
annot
predict anyway (nor does the user care much about it) to be less
problematic. Yes, I did say that LF-anything in UNIX filenames is a nor=
mal
thing. That does not mean that such names are so very convenient to use=
=2E
They do cause problems, even if just through scrambling terminal output=
=2E
They are "inconvenient". If our users don't expect precise output anywa=
y,
we can be a little more adhering to usual practices in choosing names.

> ... After all, the
> user deliberately gave them to us, and the repository we cloned from =
had
> these excesses in its name (iow, without the excess whitespaces the c=
lone
> itself wouldn't have worked). =C2=A0In such a case, is it really help=
ing him to
> remove these whitespaces as excesses?

I think yes. Otherwise the strict form of git clone could have been use=
d,
which involves absolutely no guessing and mangling.
