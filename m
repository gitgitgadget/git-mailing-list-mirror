From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] t7510: do not fail when gpg warns about insecure memory
Date: Sun, 8 Mar 2015 22:32:34 -0700
Message-ID: <E72F95BF-BE00-433E-9D05-0DDF1CACCCC1@gmail.com>
References: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c> <CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com> <20150308220424.GD4245@vauxhall.crustytoothpaste.net> <CAPig+cTj_z0xpDmnSvb-S_wEbwzdcFsGwUkFdGWgcJhwZpfMFQ@mail.gmail.com> <20150309012214.GE4245@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git mailing list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 06:32:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUqJ1-0008Ua-Jo
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 06:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbbCIFcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 01:32:39 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:40494 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbCIFci convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2015 01:32:38 -0400
Received: by padfb1 with SMTP id fb1so60714667pad.7
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 22:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=pqeD3S8qWpxdoJbSwSMLdni/KFSmrCaSIvnEQIGVATc=;
        b=ZFO+8vHonuhowy2/7rh2vulZ6CLS2s4Fk3VzT0Uv02bKiqU4vxVY8SEP/TJi6/9pf0
         xnuCrZC5dLmvvN4nfgz8JWQ39u0bWDyZRevYhwGfWa0hUs9gowrFlpTdPlxNz4X99dWx
         Ro2W/OYk28GaJnTGoAFZCtnPAlsdW8ugwaAT7MsIifLg1n9xQ5OigPloMEStDrw8Rx+f
         NVn0gctgehHxaKp3fKlZoXaZCHXAv9eZDCAFNEKuuvRSpgpQV40vsC2VvozOehJg4AyL
         EjmNeeQh6iDHYd7FP4mdf93Xf4ltz3J9IIgKMWuEDmix8wKRpSQm6SHIaHdOsRHGZU/W
         FOXg==
X-Received: by 10.66.221.34 with SMTP id qb2mr49773489pac.42.1425879158067;
        Sun, 08 Mar 2015 22:32:38 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id r8sm16979375pdp.10.2015.03.08.22.32.36
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Mar 2015 22:32:37 -0700 (PDT)
In-Reply-To: <20150309012214.GE4245@vauxhall.crustytoothpaste.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265126>

On Mar 8, 2015, at 18:22, brian m. carlson wrote:

> On Sun, Mar 08, 2015 at 06:15:55PM -0400, Eric Sunshine wrote:
>> On Sun, Mar 8, 2015 at 6:04 PM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>>> Perhaps this is better?
>>>
>>> Unfortunately when running the test, that message is found in the  =
=20
>>> standard
>>> output of git show -s --show-signature, but in the standard  error =
=20
>>> of git
>>> verify-commit -v causing the comparisons of both standard  output =20
>>> and
>>> standard error to fail.
>>
>> That doesn't help me parse it any better.  It's the "but" without a
>> corresponding "not" which seems to be throwing me off. Typically, on=
e
>> would write "this but not that" or "not this but that". I can't tell
>> if there is a "not" missing or if the "but" is supposed to be an =20
>> "and"
>> or if something else was intended.
>
> The intended meaning is "and" with the additional sense of contrast. =
=20
> The sentence, if read with verbal emphasis, is, "=85is found in the =20
> standard *output* of git show -s --signature, but in the standard =20
> *error* of git verify-commit -v", thus demonstrating why the test =20
> fails: the pairs of output files don't match up.
>
> Maybe you can suggest a less confusing wording.

I like Brian's wording, but how about this slight variation, does this =
=20
parse any better for you?

Unfortunately when running the test, while that message is found in
the standard output of git show -s --show-signature, it is found in
the standard error of git verify-commit -v causing the comparisons
of both standard output and standard error to fail.

-Kyle
