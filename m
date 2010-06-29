From: Eugene Sajine <euguess@gmail.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
	commits?
Date: Tue, 29 Jun 2010 16:05:16 -0400
Message-ID: <AANLkTik61QMnAn7rEoIOHlCMAuWgpdXWvmGVLCTn9YD1@mail.gmail.com>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
	<201001071813.01187.trast@student.ethz.ch>
	<76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
	<76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
	<7v7hrtzbau.fsf@alter.siamese.dyndns.org>
	<AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
	<20100608183007.GA31293@coredump.intra.peff.net>
	<AANLkTik7bleuzqnMWMJoWljQ5zD0YbwBsFjZT5IzkV0q@mail.gmail.com>
	<7vocet8ws2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 22:05:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTh41-0003rd-FP
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 22:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab0F2UFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 16:05:23 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45240 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958Ab0F2UFW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 16:05:22 -0400
Received: by vws5 with SMTP id 5so4664vws.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v/YDklaEtqVk0jJIfunNOEd0Q1GZhMYmf/ZMHfkpTnQ=;
        b=K5IEZ1eIlTwcoQ8GNwvaWGQdfNbU28ioWfVkNnZ9radkbTxA2RSa3GlG426+PgCdSf
         9+haHlM9iRGJirf7Hsfgv1TWmp2pXeMii/HeGGPxXAw51sdGmnglZJk7Wjn91kfSoupN
         Pax/wCGSeeTYcmuD4XfdoSolGHliSHnfRAlbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V/ulU6wgEt8ZVRfAL82sOrd7F8dat72jv6Azrab2/R12YxFHdJTFeC1HQCgl2XsUU9
         iDgFy4suF7dGSXueg5I97QxGI8Fd9WO7m7FeQY+4g3OZ0wNQYxduzuaUsleCXRxjHFVm
         CBYdsneFV8EGX1mXmLVXbVgw81wqKB1Ma146A=
Received: by 10.224.27.215 with SMTP id j23mr5087419qac.224.1277841917041; 
	Tue, 29 Jun 2010 13:05:17 -0700 (PDT)
Received: by 10.229.46.68 with HTTP; Tue, 29 Jun 2010 13:05:16 -0700 (PDT)
In-Reply-To: <7vocet8ws2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149926>

>> Jeff, Junio
>>
>> Could you, please, advise if there is any resolution on the patch?
>
> I do agree with Jeff that what his patch tried to do back in August l=
ast
> year was introducing backward compatibility and potentially breaking
> workflows of existing users by updating refs in an unexpected ways.
>
> However, as I discussed in
>
> =C2=A0 =C2=A0Subject: Re: origin/branchname and tracking branch point=
ing to different =C2=A0commits?
> =C2=A0 =C2=A0Date: Thu, 07 Jan 2010 16:32:09 -0800
> =C2=A0 =C2=A0Message-ID: <7v7hrtzbau.fsf@alter.siamese.dyndns.org>
>
> I have a slight suspicion that such an "unexpected ref update" is not=
 a
> big issue anymore. =C2=A0So in principle, I think it is fine to chang=
e the
> behaviour of "git fetch $there $these_explicit_refs" to additionally
> follow the configured remote tracking ref globbing patterns.
>
> Because
>
> =C2=A0(1) the old patch was never tested in a production context (I d=
on't think
> =C2=A0 =C2=A0 it even hit 'pu');
>
> =C2=A0(2) I offhand do not know how much the codebase changed in the =
area that
> =C2=A0 =C2=A0 would affect the assumptions the patch made back then; =
and
>
> =C2=A0(3) we will be in feature freeze for 1.7.2 anyway;
>
> I would rather not be the one who is forward-porting the patch myself
> if I can avoid it, however.
>
> I could queue a version of the patch (with updates if necessary) to '=
pu',
> but not much more than that right now.
>
>

Thank you, Junio, for the update.

Eugene
