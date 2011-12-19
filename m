From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] t4018: introduce test cases for the internal hunk header patterns
Date: Mon, 19 Dec 2011 16:57:28 -0600
Message-ID: <CA+sFfMeogJ==ud6NdPj_KZFUKFeB--RBmPkLndjrQwhg15V5ig@mail.gmail.com>
References: <20111217012118.GB20225@sigill.intra.peff.net>
	<31E9klcRboMV0wSJY5WO-N7nIBOUOa_wr6MVfWY9AInImxJIqC0flahvpDrVGMIuZ9e7Ouha1HDuesbwTGaNQA4dgN-FShNJKkfMG_cHLUJAT2rE539shnQxzM0dQyZIb5661As6Tvs@cipher.nrlssc.navy.mil>
	<7vty4wkx19.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, peff@peff.net,
	git@vger.kernel.org, j6t@kdbg.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 23:57:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcm9G-0004HN-Sd
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 23:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535Ab1LSW53 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Dec 2011 17:57:29 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:54364 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751570Ab1LSW53 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 17:57:29 -0500
Received: by obcwo16 with SMTP id wo16so1998302obc.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 14:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FWtA7FOgWACZRAreqmUJVTGFj8SdJKCH4th5/EMgOTI=;
        b=lNmNQSQVYJB6n2VWlVs2wOeDrIxoLHTDBeTSX9s/B9sntxT++lV1IgW1H7q5cCqaGv
         +rfaFKbAe3ENpyeSRL8Hi9oriE8cdh+X603UsT7zlPhmQPB1mFQkBEM9BRzEsnKnn+B/
         ULx4Fen8WRztJ6Sb03qazWIIcJYcKCYkaXhvE=
Received: by 10.182.110.1 with SMTP id hw1mr11815379obb.38.1324335448270; Mon,
 19 Dec 2011 14:57:28 -0800 (PST)
Received: by 10.182.37.170 with HTTP; Mon, 19 Dec 2011 14:57:28 -0800 (PST)
In-Reply-To: <7vty4wkx19.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187482>

On Mon, Dec 19, 2011 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> =C2=A0 =C2=A0* test cases must provide a function named "RIGHT_funct=
ion_hunk_header"
>> =C2=A0 =C2=A0 =C2=A0- this is the function name that should appear o=
n the hunk header line
>> =C2=A0 =C2=A0 =C2=A0- the body of this function should have an assig=
nment like
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 answer =3D 0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0The test suite will modify the above line=
 to produce a difference
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0from the original. =C2=A0Additionally, th=
is should be far enough within
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the body of the function so that the func=
tion name is not part of
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the lines of context.
>
> Although I do not think of any language with a syntax rule where that=
 the
> overlong RIGHT_func... token is an illegal symbol offhand, this feels=
 a
> bit _too_ specific to the C language.

Good point.  "RIGHT_function_hunk_header" doesn't really have much
meaning for non-programming language patterns like tex and html.

> I would prefer something like this
> instead:
>
> =C2=A0 =C2=A0* a test case must have one (and only one) line that con=
tains "RIGHT"
> =C2=A0 =C2=A0 =C2=A0(all uppercase) and that line should become the h=
unk header for the
> =C2=A0 =C2=A0 =C2=A0test to succeed.
>
> =C2=A0 =C2=A0* after the line that contains "RIGHT" token, there shou=
ld be one (and
> =C2=A0 =C2=A0 =C2=A0only one) line that contains "ChangeMe". The test=
 modifies this
> =C2=A0 =C2=A0 =C2=A0token to "IWasChanged", compares the original wit=
h the modified
> =C2=A0 =C2=A0 =C2=A0result, and expects the "RIGHT" token above appea=
rs on the hunk
> =C2=A0 =C2=A0 =C2=A0header.

Both good improvements.

> Also I would prefer not to require "enough filler", as we might want =
to
> enhance the logic to consider using a line in the pre-context as the =
hunk
> header in some cases, e.g.
>
> =C2=A0 =C2=A0@@ ... @@ int RIGHT_function_hunk_header(void)
>
> =C2=A0 =C2=A0 int RIGHT_function_hunk_header(void)
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0- =C2=A0 =C2=A0int ChangeME;
> =C2=A0 =C2=A0+ =C2=A0 =C2=A0int IWasChanged;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("Hello, world\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0@@ ...

Yeah, I didn't mean to imply that "enough filler" was a requirement of
the test, just trying to point out the requirement imposed by the hunk
header logic.  I'll remove this statement.

Will reroll.

-Brandon
