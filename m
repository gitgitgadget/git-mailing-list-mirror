From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Thu, 21 May 2009 14:29:12 +0200
Message-ID: <200905211429.13831.jnareb@gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> <m363fukb3j.fsf@localhost.localdomain> <fcaeb9bf0905210344h7ac8e10bx311bf9d714573eeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 14:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M77On-0005JZ-Mq
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 14:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbZEUM3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 08:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbZEUM3S
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 08:29:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:51927 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZEUM3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 08:29:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so349156rvb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=w/fzA1R6i5OF8vT1MkqIZYz/Bim9eR7zwRzBnxvxcxE=;
        b=Mo4vS0PEeC3KibtfHc13/HfZWEVrurIFUUAPVB2irYFtkLDzvLr+sLNnXURcN6M3ML
         sPqwSLSZHRg8JWpgEC3ir2oiMPO3nw+yN/RFSFBq5o2HlU8W8jhgied7/9g0x7CWqXyz
         QNXo5HaHhoVq822OHI97hMM0YTRYWKuNA2ePc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pM61LfmipEEqhu7zo6haGMMe+2bSiEmkQQQznRmxz7vy96BHpY5gqWJULd9q0XZiOJ
         uhJgxFey7VOgl5P59zLEK++FvtY1xvMkb7pn8gLach5YJBzdO3Wx4dT0PhiplsAMB9Cc
         GiIm6gdlj3FODourwwIw/CJf+IUoKA05BIDPw=
Received: by 10.141.211.8 with SMTP id n8mr1130283rvq.94.1242908959153;
        Thu, 21 May 2009 05:29:19 -0700 (PDT)
Received: from ?192.168.1.13? (abwg97.neoplus.adsl.tpnet.pl [83.8.230.97])
        by mx.google.com with ESMTPS id k41sm6800401rvb.37.2009.05.21.05.29.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 05:29:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0905210344h7ac8e10bx311bf9d714573eeb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119674>

On Thu, 21 May 2009, Nguyen Thai Ngoc Duy wrote:
> 2009/5/21 Jakub Narebski <jnareb@gmail.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0 =C2=A0<pclouds@gmai=
l.com> writes:

>> [...]
>>> +#define REBASE_ABORT =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0001
>>> +#define REBASE_CONTINUE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x0002
>>> +#define REBASE_FORCE =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0004
>>> +#define REBASE_IGNORE_DATE =C2=A0 0x0008
>>> +#define REBASE_INTERACTIVE =C2=A0 0x0010
>>> +#define REBASE_MERGE =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0020
>>> +#define REBASE_STAT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0040
>>> +#define REBASE_NO_VERIFY =C2=A0 =C2=A0 0x0080
>>> +#define REBASE_PRESERVE_MERGES =C2=A0 =C2=A0 =C2=A0 0x0100
>>> +#define REBASE_ROOT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0200
>>> +#define REBASE_SKIP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0400
>>> +#define REBASE_VERBOSE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0800
>>
>> I see misaligns here...
>=20
> Hmm.. it's perfectly aligned in complete source form. Probably
> because of TABs.=20

Yes, it is because of using TABs to align (and not only to indent),
and probably because of changing tabstop because of extra character
('+' at beginning).  I don't know good solution for this problem.
=20
>> [...]
>>
>> Couldn't you use parseopt also in subcommands?
>=20
> I don't understand. You mean parseopt for --continue, --skip and
> --abort?=20

Yes. I don't know if it possible, and if it would make sense, but it
seems strange to me having both parseopts in main, and strcmp
comparisons for other parts...

--=20
Jakub Narebski
Poland
