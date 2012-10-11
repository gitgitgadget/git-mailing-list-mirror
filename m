From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Thu, 11 Oct 2012 18:56:55 +0700
Message-ID: <CACsJy8B2JJmUbjAauMwbg95fCvPdUYqy4CKZp3ac44XHoh1NLQ@mail.gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <7vd30panxo.fsf@alter.siamese.dyndns.org> <7v1uh5aar7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 13:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMHOU-0004O6-I7
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 13:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758593Ab2JKL52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 07:57:28 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64513 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758543Ab2JKL50 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 07:57:26 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2755253iea.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 04:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=A3tHUWFmdYjAvIhFwNZ3XuMZl6YTUm1WQlR6IczVtE4=;
        b=UQVp/AWkX0Vd8YiWVDjp3JDYjhjRmPoTBshpk/EU+2I0bu8o071tGtgTgWP5g0xKlT
         XTOBWcAE738GttZPZb2U+VfWzjd/Im3GaFyXelOOGAlBW3poVHtxTPWYhNzhVAyYWUm/
         1GCxcVjKen/5FsnDKlRbfjRMglBDKogBro9Jjw8qgZfGSNmvhiGfbtTlQnDAkNqrKb3a
         f3diJAoJLCq8T8zlJCKvx0+uT8ki/EUcya4A9ugyweR7R/oxYVAl7Xxh7Kfm+PgwKkCV
         Wk0jDslL8P434x5SA3aHaG104LPDDukAXQVFcKWkWwCtHL43PAgqjjJwsimX8S3sfJZ6
         ZS8w==
Received: by 10.50.185.231 with SMTP id ff7mr512980igc.40.1349956646405; Thu,
 11 Oct 2012 04:57:26 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Thu, 11 Oct 2012 04:56:55 -0700 (PDT)
In-Reply-To: <7v1uh5aar7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207474>

On Thu, Oct 11, 2012 at 11:33 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Really small updates. I did not want to resend it this soon but thi=
s
>>> may fix the compile errors for Junio.
>
> t3070 seems to break TAP,
>
>     *** prove ***
>     t3070-wildmatch.sh .. Failed 1/151 subtests
>
>     Test Summary Report
>     -------------------
>     t3070-wildmatch.sh (Wstat: 0 Tests: 150 Failed: 0)
>       Parse errors: Tests out of sequence.  Found (76) but expected (=
75)
>                     Tests out of sequence.  Found (77) but expected (=
76)
>                     Tests out of sequence.  Found (78) but expected (=
77)
>                     Tests out of sequence.  Found (79) but expected (=
78)
>                     Tests out of sequence.  Found (80) but expected (=
79)
>     Displayed the first 5 of 77 TAP syntax errors.
>
> This probably is due to this part of the output:
>
>     ok 72 - wildmatch 1 1 [ab] [\[:]ab]
>     ok 73 - wildmatch 1 1 ?a?b \??\?b
>     ok 74 - wildmatch 1 1 abc ^G^Hok 75 - wildmatch 0 0 foo
>     ok 76 - wildmatch 1 0 foo/bar/baz/to **/t[o]
>     ok 77 - wildmatch 1 1 a1B [[:alpha:]][[:digit:]][[:upper:]]
>

It seems to prove fine here with perl 5.12.3, Test-Harness-3.230,
bash-4.0_p38. What version do you use?
--=20
Duy
