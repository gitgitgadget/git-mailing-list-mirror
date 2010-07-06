From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 7/7] t/README: Document the do's and don'ts of tests
Date: Tue, 6 Jul 2010 12:50:08 +0000
Message-ID: <AANLkTimvyxNq3GAnwNZJEm6U5Jn7TlaedLZk12O9g8xe@mail.gmail.com>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com>
	<1278082789-19872-8-git-send-email-avarab@gmail.com>
	<7vaaq58hhb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 14:50:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW7bN-0003iH-2i
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 14:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab0GFMuL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 08:50:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47140 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab0GFMuJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 08:50:09 -0400
Received: by iwn7 with SMTP id 7so6610792iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 05:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/ZHiUeJrO2NcpEtMBkiVVnpLehRY2P6q31dV/JL9b9o=;
        b=GuF2BmS+RQxHLm9CNx96wAHZ1mpouMtYJZ+WUzG7aHRC3/hM02BuahdSF+UalZu99w
         umLVcdhqO4zammApEf3B6xUNXtoly3ajSRD+40uV6FG5+JfGxyGB0KY7VuZdWMyJzfSW
         k1VrtfNyP1G7Oc54qRWW7enWM0WpWfeZSUuZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dBDz0xdv4AWfD9F1roPlrYapYD0kwnYQatPqJr37bNLkJ3Hfn5XFqZR/9h7gg+HWB2
         5wHkYEwSPUr+KqQakwXEf1mla3fm6Wjg1Gcsl326hcneAm9gFFv5sFXn3myWzmxr5nSd
         FCEGW5MiljDl8P3SV2JMVvZmdZ7l0Xce8Fvhw=
Received: by 10.231.85.206 with SMTP id p14mr2565125ibl.89.1278420608919; Tue, 
	06 Jul 2010 05:50:08 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 6 Jul 2010 05:50:08 -0700 (PDT)
In-Reply-To: <7vaaq58hhb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150349>

On Tue, Jul 6, 2010 at 02:35, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> +Do's, don'ts & things to keep in mind
>> +-------------------------------------
>> +
>> +Here's a few examples of things you probably should and shouldn't d=
o
>> +when writing tests.
>
> "Here are" perhaps?
>
>> +Do:
>> +
>> + - Put as much code as possible inside test_expect_success and othe=
r
>> + =C2=A0 assertions.
>> +
>> + =C2=A0 Even code that isn't a test per se, but merely some setup c=
ode
>> + =C2=A0 should be inside a test assertion if at all possible. Test =
scripts
>> + =C2=A0 should only have trivial code outside of their assertions.
>
> Let's make it even stronger; "should only have trivial" -> "shouldn't=
 have
> any ... unless there is a good reason."
>
>> +Don't:
>> +
>> + - exit() within a <script> part.
>> +
>> + =C2=A0 The harness will catch this as a programming error of the t=
est.
>> + =C2=A0 Use test_done instead if you need to stop the tests early (=
see
>> + =C2=A0 "Skipping tests" below).
>> +
>> + - Break the TAP output
>> +
>> + =C2=A0 The raw output from your test might be interpreted by a TAP
>> + =C2=A0 harness. You usually don't have to worry about that. TAP ha=
rnesses
>
> I'd recommend dropping "You usually...about that" =C2=A0You do care, =
but the
> limitation may be not so severe.
>
>> + =C2=A0 will ignore everything they don't know about, but don't ste=
p on
>> + =C2=A0 their toes in these areas:
>> +
>> + =C2=A0 - Don't print lines like "$x..$y" where $x and $y are integ=
ers.
>> +
>> + =C2=A0 - Don't print lines that begin with "ok" or "not ok".
>> +
>> + =C2=A0 A TAP harness expect a line that begins with either "ok" an=
d "not
>> + =C2=A0 ok" to signal a test passed or failed (and our harness alre=
ady
>> + =C2=A0 produces such lines), so your script shouldn't emit such li=
nes to
>> + =C2=A0 their output.
>> +
>> + =C2=A0 You can glean some further possible issues from the TAP gra=
mmar
>> + =C2=A0 (see http://search.cpan.org/perldoc?TAP::Parser::Grammar#TA=
P_Grammar)
>> + =C2=A0 but the best indication is to just run the tests with prove=
(1),
>> + =C2=A0 it'll complain if anything is amiss.
>> +
>> +Keep in mind:
>> +
>> + - That what you print to stderr and stdout is usually ignored
>> +
>> + =C2=A0 Inside <script> part, the standard output and standard erro=
r
>
> Splitting the above into two sentences (or a header and a body) makes=
 it
> unclear that your "usually" comes from the earlier "Do Put as much co=
de
> inside test_expect_success...". =C2=A0I think you can simply drop "Th=
at what
> you print ... ignored".
>
> Everything else in the series looked good. =C2=A0Thanks.

All of these rewordings (the "t/README: proposed rewording..." commit
in pu) look good.

    Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
