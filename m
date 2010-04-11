From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Take it easy on unallowed access to non-existent 
	repository
Date: Sun, 11 Apr 2010 19:49:15 +0200
Message-ID: <y2tfcaeb9bf1004111049m9703af3bs3dc668ec29ae3136@mail.gmail.com>
References: <20100409001322.GB23501@coredump.intra.peff.net>
	 <1270983682-12215-1-git-send-email-pclouds@gmail.com>
	 <l2ifabb9a1e1004110845l7cc89b70y9878dad9e1537e8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11Hf-0007Qd-Lp
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab0DKRtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 13:49:18 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:41978 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab0DKRtR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 13:49:17 -0400
Received: by ewy20 with SMTP id 20so1715624ewy.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PEOhBq89W21gkphwRxFZVQiVh5IE1yK2AV8HdC4FkaM=;
        b=UsMyDYurQZ+neLpX4bKBEahSmeFIcPsgKHk2aSuD5QO/WzOTlehZZMYithHD6nnzsZ
         QSSTYF9HBT1cY8nwLzPWb09G1ekwf2VsMHWFnKC1f9BEgdpJrQMJgnoHAegiukL2kuTR
         TuqDf/zKNIIZWS23tIjbUHxcNErh7X9IIvCbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g8qV4Mq1VEUGlk2iZFa95kIhJtWDVH3ANcUqvyOmbsYp9r0HLiTpAXuP/yIraoVZh6
         PtVs/YckdC2c/CDkimj49l0W077gmwM3fKM0vjmeI8D4pXY7LM7THX4DgCNhs4XJdndr
         4wU33FsEvdqB/9yMW1FFY9Yqa1HECl7OgRF1A=
Received: by 10.213.105.130 with HTTP; Sun, 11 Apr 2010 10:49:15 -0700 (PDT)
In-Reply-To: <l2ifabb9a1e1004110845l7cc89b70y9878dad9e1537e8d@mail.gmail.com>
Received: by 10.213.65.202 with SMTP id k10mr1861752ebi.63.1271008155780; Sun, 
	11 Apr 2010 10:49:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144667>

2010/4/11 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> 2010/4/11 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (startup_info && !startup_info->have_r=
un_setup_gitdir)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("internal err=
or: access to .git/config without repo setup");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warning("Broken r=
epository setup: early access to $GIT_DIR/config");
>
> This makes it sound like whatever is the problem is caused by the
> repository that is being operated on, rather than git's code, is that
> correct?

Gaah.. from a user point of view, correct. What do you suggest?
--=20
Duy
