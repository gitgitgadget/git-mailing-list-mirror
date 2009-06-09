From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 09 Jun 2009 03:02:02 -0700 (PDT)
Message-ID: <m3prdd4t6s.fsf@localhost.localdomain>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	<7vskidcf9s.fsf@alter.siamese.dyndns.org>
	<200906070932.36913.chriscool@tuxfamily.org>
	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	<4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
	<c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 12:02:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDy9l-0001l5-50
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 12:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757991AbZFIKCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 06:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757279AbZFIKCE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 06:02:04 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:35844 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168AbZFIKCC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 06:02:02 -0400
Received: by ewy6 with SMTP id 6so5020236ewy.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=iSdFJZKFZTysr/yvLlVAsepkSb6GrTJjoVevD5yDcvA=;
        b=FfNd1Ta4P1ZS32u8MWE94X3e2aVLsLiswErARf06oYBrAEQ2sdkRS0LS8o3SF+JPs8
         SxEI0ZZSXooP7OGMSmmKhvskhIZcDKzaft8PMx+Jdo3k5d91R/a9HnjyGU1UD19IHqx8
         KEyALLtT/iyKLwmg8JW4mXvFDB3YOaaXK57SY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=sGOPiEerp536FXv/c2Yi+Amr82ZWIM2PfIEUODEEkslqNrAaUBm+ybkR3ZocOvvR1O
         v+ooprAc9r796IcmgS/MY/gldsujQY/N7A40ubQl52SpjgbpQvTCp8STM1OU40WosWr9
         OcGUNGT7NvRoSVIv95hgvrcYUhEU7TKY139QA=
Received: by 10.210.36.8 with SMTP id j8mr2165241ebj.40.1244541723323;
        Tue, 09 Jun 2009 03:02:03 -0700 (PDT)
Received: from localhost.localdomain (abvq34.neoplus.adsl.tpnet.pl [83.8.214.34])
        by mx.google.com with ESMTPS id 28sm1482476eyg.54.2009.06.09.03.02.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 03:02:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n59A6rfo008006;
	Tue, 9 Jun 2009 12:06:54 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n59A6poA008003;
	Tue, 9 Jun 2009 12:06:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121163>

Christian Couder <christian.couder@gmail.com> writes:
> On Mon, Jun 8, 2009 at 11:02 PM, Junio C Hamano<gitster@pobox.com> wr=
ote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>
>>> The advantage of that -- and I have to admit I don't know if it wil=
l
>>> ever matter in practice -- is that using an actual PRNG:
>>>
>>> a) is less likely to get into pathological capture behaviors.
>>> b) doesn't make people think later that there is something magic to=
 the
>>> =A0 =A0arbitrary chosen numbers.
>>
>> My gut feeling agrees with you that both are likely to be true; thes=
e are
>> good points.
>>
>> Christian, what do you think?
>=20
> Here are some reasons why I think my algorithm might be better:
>=20
> - using HPA's formula I get on average 0.86 bits of information at
> each step when alternating (against 0.72 when using a PRNG)
> - I think that if the branches in the graph merge often between each
> other, then on a big scale it's like when you are on the linear case
> - I don't think we should try too hard to avoid pathological capture
> behaviors, because I think we can't avoid them anyway in some cases,
> like if the first bad commit is near many untestable commits


By the way, I have asked question about best algorithm for "bisect skip=
"
on StackOverflow[1], but didn't get (yet) any good responses...

[1]: http://stackoverflow.com/questions/959324/

--=20
Jakub Narebski
Poland
ShadeHawk on #git
