From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Thu, 2 Sep 2010 17:11:30 +0200
Message-ID: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
References: <201009012054.20482.robin.rosenberg@dewire.com>
 <1283351989-19426-1-git-send-email-pclouds@gmail.com> <AANLkTi=wESk38u1XSTL1rd2__eQzHfSuq-EbqooxmcVw@mail.gmail.com>
 <7vlj7k42t7.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, robin.rosenberg@dewire.com,
	srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 17:12:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrBSL-0002tc-4y
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 17:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab0IBPL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 11:11:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45935 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab0IBPLz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 11:11:55 -0400
Received: by pzk9 with SMTP id 9so123906pzk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=WRKGt3bNXxoAu1ivc7FosgOM3vRi+kzzWTebL3rI0Rw=;
        b=nM7N0H22BVruNuBTx4//4NJGRUZ7+1wshvFwOXZnWMbxtGL3mMwmP0uCuMRBMniy3B
         IKzdf6bm3nnXc7Da4MdunwPHZpd3zBSsCWmeCObRqgBE/wJvGjU6AYMCQFGk4A9ESNKI
         H5juhscOlv6vvG/Esmm+BUCU4Y90HAj36zjpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Qr7bxMMlswBEYTo7ZTOD4B9rb0EO6Jdv+SO4OPyDzToQM6mQ48+MWDca75rvpD9Ipt
         07FoUulB9PnqpYkSS1oIas5JLrv7CS6ETEdRCxFqVh3pKBQ+cWyNfOJWZId7TxyZViLU
         e/bz1fx/hi/+Wt8dtvBMKQkYRgZrcv/Mqe9Ng=
Received: by 10.142.222.8 with SMTP id u8mr97838wfg.214.1283440313199; Thu, 02
 Sep 2010 08:11:53 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Thu, 2 Sep 2010 08:11:30 -0700 (PDT)
In-Reply-To: <7vlj7k42t7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155134>

On Thu, Sep 2, 2010 at 4:50 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>>> + =A032-bit ctime seconds, the last time a file's metadata changed
>>> + =A0 =A0this is stat(2) data
>>> +
>>> + =A032-bit ctime nanoseconds (modulo 1G)
>>> + =A0 =A0this is stat(2) data
>>
>> Maybe I'm missing something, but I failed to find where "modulo 1G" =
comes from.
>
> I think the above wants to say "seconds and sub-seconds are stored in
> separate fields, and latter is purely sub-seconds, never reaching nor
> exceeding a whole second" (gig =3D=3D 10^-9) times nano (=3D=3D 10^+9=
) is 1).
>
> I personally do not think it is a good idea to say " (modulo 1G)" the=
re;
> it is more confusing than without.
>

Perhaps "nanosecond fractions" would be a simple and precise descriptio=
n?
