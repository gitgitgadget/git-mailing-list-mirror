From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fix UTF Encoding issue
Date: Mon, 03 Dec 2007 04:06:48 -0800 (PST)
Message-ID: <m3prxougmx.fsf@roke.D-201>
References: <4753D419.80503@clearchain.com>
	<7v7ijwjd9o.fsf@gitster.siamese.dyndns.org>
	<200712031332.36187.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org
To: =?iso-8859-15?q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Mon Dec 03 13:07:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzA4t-0008TC-Sf
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 13:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbXLCMGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 07:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbXLCMGv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 07:06:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:51133 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbXLCMGu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 07:06:50 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2686405nfb
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 04:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=5YjEfAf6eu2kbz0WIdw4aUuutBftjx0k8+irtrqFqgM=;
        b=fohIrilukjz/p/t3r7YEPtEX2/ugVadiy4WInLuhLmo1iqISiTYKiYOxXYSc/GeidBGLeD7ahpsWwMcQyR/Q37vqP/Zop3YJef4L16EBwawyorSmDZI8ccwCDB5PBl1wsin52M5B//p6G0Ha1qTomjASHY9FAOHt/OlmVOEwYlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=agxwGro7rAIyQs1vNb9s5efCPKOfgUKJ1wPp85Ko/H7c49DtYiF5w/pkCl+UaBSWJVwIlW2rh6/TyonYkVG4tEvXm+QVPWWN5X2ep+G1b4mCGlIhxwgJ8iG7Ib6gyul5JEXLHbJ7Cq5EgnHuh4v3o+RSOnCdQLikT3YD0MgjbPY=
Received: by 10.86.50.8 with SMTP id x8mr10539344fgx.1196683608862;
        Mon, 03 Dec 2007 04:06:48 -0800 (PST)
Received: from roke.D-201 ( [83.8.225.86])
        by mx.google.com with ESMTPS id 4sm6107557fgg.2007.12.03.04.06.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Dec 2007 04:06:48 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB3C6dvR006579;
	Mon, 3 Dec 2007 13:06:43 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB3C6VjJ006570;
	Mon, 3 Dec 2007 13:06:31 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <200712031332.36187.ismail@pardus.org.tr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66915>

Ismail D=F6nmez <ismail@pardus.org.tr> writes:
> Monday 03 December 2007 Tarihinde 12:14:43 yazm=FD=FEt=FD:
>> Benjamin Close <Benjamin.Close@clearchain.com> writes:

>>> -	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
>>> -	if (defined $res) {
>>> -		return $res;
>>> -	} else {
>>> -		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
>>> -	}
>>> +	eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK)); };
>>> +	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
>>>  }
>>
>> I thought the standard catch ... throw idiom in Perl was to do the a=
bove
>> like this:
>>
>> 	my $res;
>>         eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
>>         if ($@) {
>>         	return decode($fallback_encoding, $str, Encode::FB_DEFAULT)=
;
>> 	}
>> 	return $res;
>=20
> I think this is correct, but the current code in gitweb doesn't look =
correct=20
> since it checks for $res and not $@.

=46irst version of the patch was created by Martin Koegler. I have
participated in creating the version which is now in gitweb, but I
have to say that I wrote it based on decode_utf8
documentation... which doesn't necessarily agree with facts :-(

I'm all for the "throw idion" version. Ack.
--=20
Jakub Narebski
