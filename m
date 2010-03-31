From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git cvsimport and case-insensitive config
Date: Wed, 31 Mar 2010 13:17:01 +0200
Message-ID: <p2mcb7bb73a1003310417u3821f8b1hd3df79e8b41502c3@mail.gmail.com>
References: <hoscv7$hmn$1@dough.gmane.org> <7vy6h9vhuk.fsf@alter.siamese.dyndns.org> 
	<cb7bb73a1003301105v691624sdcdadf6809c50b89@mail.gmail.com> 
	<7vr5n1v74x.fsf@alter.siamese.dyndns.org> <cb7bb73a1003301517r29aed329j4a5f38fbc9b515ca@mail.gmail.com> 
	<7vd3yls8pi.fsf@alter.siamese.dyndns.org> <y2kcb7bb73a1003302354wea191dd4iced4360b95d31a2a@mail.gmail.com> 
	<7v634cq0yj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 13:17:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwvvP-0005hr-Nr
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 13:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab0CaLRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 07:17:24 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:49254 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0CaLRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 07:17:23 -0400
Received: by ewy20 with SMTP id 20so1831592ewy.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WuG/JKk1JyMZsl85snBKccQLcSLB/0mKgwssB1orvqo=;
        b=m2isqN96opX4z4zHp5GgnPT/htCVEPbig5QcC8NrOAJVEcf9Y8BYR7B1Fvc0FDIqlk
         T1GdsnpViivssLC4D4AQpK7pzdY2ENwRfeYJHO2EXStNv0hkZTID+hm19ekvHPXJAYVB
         WJbxsYVN/FsYfeRZtTUQc9XCwltugpVxPehzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Lq4IFUp3LChrH4Qo1PoxBgJ1FPs4QQVPrFfqDgywUvMRW4TtpokG09A8Lm4S7xFXP/
         y2sdzIsMGrsvm6p+0l2OX0Dmk2JdKn1z9t7u1ZkzxX9TuhZybEB6G6OOclB6vEycR0wO
         Lk5To7Fdu+6glI1Fra317VOUOdbJ0sd9nn6xY=
Received: by 10.213.114.132 with HTTP; Wed, 31 Mar 2010 04:17:01 -0700 (PDT)
In-Reply-To: <7v634cq0yj.fsf@alter.siamese.dyndns.org>
Received: by 10.213.42.136 with SMTP id s8mr2162687ebe.78.1270034241127; Wed, 
	31 Mar 2010 04:17:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143660>

On Wed, Mar 31, 2010 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> What I wonder is: when would the heuristics not work? Are there git
>> repositories that have a cvsimport configuration with both -s and -S
>> specified?
>
> You are asking a wrong question. =A0Setting both -s and -S is not an =
issue.
> Not being able to tell reliably if the value you see for cvsimport.s =
in
> "config -l" output were specified for cvsimport.S or cvsimport.s is o=
nly
> by inspecting the value is.

What I'm asking is rahter: is it worth to worry about this?

>> I strongly suspect the answer is NO because such a
>> configuration would not work currently (at least not reliably as the
>> wrong value would be assigned to at least one of the keys.
>
> So this is a moot point, but people who specified cvsimport.S expecti=
ng
> that it would stand for -S option are not getting what they want and =
are
> getting -s instead, which is also a case where the configuration is n=
ot
> working currently.
>
> Silently converting it to an equally non-working configuration is eas=
y;
> just treat as if everything were specified for lowercase option.
>
> But that would not help users at all. =A0I was hoping that you were a=
iming
> for something better than that. =A0At least that "case-sensitive" pat=
ch was.

Well, I wasn't thinking about a silent conversion for the uncertain
options: in the case of dubious options which we can guess (a vs A, r
vs R), a warning would be given, and for the unguessable case we could
either still give a warning and continue or even abort the process
altogether. Better than the silent conversion (which would not break
anything that isn't broken already anyway), although probably not as
sophisticated as your proposal.

--=20
Giuseppe "Oblomov" Bilotta
