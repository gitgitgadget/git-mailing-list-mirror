From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Fri, 16 May 2014 09:54:58 +0200
Message-ID: <CANQwDwe8Eb+ORiRyuq3+kKw72Jath_DGySmws1Rvt8bmuHoXVw@mail.gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
 <20140515050820.GA30785@localhost.localdomain> <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
 <20140515184808.GA7964@localhost.localdomain> <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
 <xmqqmweiessl.fsf@gitster.dls.corp.google.com> <CANQwDwffdbqD96OadyECFs=6WY_t+_0b63L5yAZVQ8aXrMvHHA@mail.gmail.com>
 <xmqqmweibjjo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <accounts@mwagner.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 09:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlCzX-0001xO-HX
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 09:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645AbaEPHzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 03:55:39 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:49697 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbaEPHzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 03:55:38 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so2572831oag.20
        for <git@vger.kernel.org>; Fri, 16 May 2014 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fJT3XS+CywDA8Ob+jBGKAePDuF6fU1Z4yjuqNln6TqI=;
        b=h2vFgbWzDqxNLPDNS6vl9YPAoW1FS19cwwqsslS6LhEx7riYZ3/K154pqmKjEWUIhQ
         IRsdgu4SHJKNv6PpjINvK/8MVVC7PfOJwyC98OEpQugf/xMB6NkY87CrzTgzN743LiCB
         0K7RX4eKOD3TXKbd7PJOQlizEQDZ8ZYyvMgXfdV8LpcXOmDEATt/JnC0ntCrSaL16CLl
         4YUY+Zi8pvhUt3+7Dh6hBgRT0t1gZOuDpvq8m49sf9ghMDR9ne3fD504l6rzA/aPL4HX
         SZbYBH8712ZDkoOJ8o96qSV/8qaJbDRjpnc1rGTNz6sXz8g6x1mO4pmlmi28jR4HUZwz
         IbYA==
X-Received: by 10.60.92.132 with SMTP id cm4mr15115265oeb.49.1400226938213;
 Fri, 16 May 2014 00:55:38 -0700 (PDT)
Received: by 10.76.132.4 with HTTP; Fri, 16 May 2014 00:54:58 -0700 (PDT)
In-Reply-To: <xmqqmweibjjo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249273>

On Fri, May 16, 2014 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>> On Thu, May 15, 2014 at 9:38 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>>>
>>>> Writing test for this would not be easy, and require some HTML
>>>> parser (WWW::Mechanize, Web::Scraper, HTML::Query, pQuery,
>>>> ... or low level HTML::TreeBuilder, or other low level parser).
>>>
>>> Hmph.  Is it more than just looking for a specific run of %xx we
>>> would expect to see in the output of the tree view for a repository
>>> in which there is one tree with non-ASCII name?
>>
>> There is if we want to check (in non-fragile way) that said
>> specific run is in 'href' *attribute* of 'a' element (link target).
>
> Correct, but is "where does it appear" the question we are
> primarily interested in, wrt this breakage and its fix?

That of course depends on how we want to test gitweb output.
The simplest solution, comparing with known output with perhaps
fragile / variable elements masked out could be done quickly...
but changes in output (even if they don't change functionality,
or don't change visible output) require regenerating test cases
(expected output) to test against - which might be source of
errors in test suite.

Another simple solution, grepping for expected strings, also
easy to create, has the disadvantage of being only positive
test - you cannot [easily] test that there are no *wrong* output,
only that right string exists somewhere.

> If gitweb output has some volatile parts that do not depend on the
> contents of the Git test repository (e.g. showing contents of
> /etc/motd, date/time of when the test was run, or the full pathname
> leading to the trash directory), then preparing a tree whose name is
> =C3=A4=C3=A9=C3=AC=C3=B5=C3=BB and making sure that the properly enco=
ded version of =C3=A4=C3=A9=C3=AC=C3=B5=C3=BB
> appears anywhere in the output may not be sufficient to validate
> that we got the encoding right, as that string may appear in the
> parts that are totally unrelated to the contents being shown and not
> under our control.  But is that really the case?

Well, I guess that any test is better than no test (though OTOH
Heartbleed and "goto fail" bugs shows the importance of negative
tests).

> Also we may introduce a bug and misspell the attr name and produce
> an anchor element with hpef attribute with the properly encoded URL
> in it, and your "parse HTML properly" approach would catch it, but
> is that the kind of breakage under discussion?  You hinted at new
> tests for UTF-8 encoding in the other message in the thread earlier,
> and I've been assuming that we were talking about the encoding test,
> not a test to catch s/href/hpef/ kind of breakage.

One of tests possible with HTML parser (e.g. WWW::Mechanize::CGI)
is to check that all [internal] links leads to 200-OK pages, which
accidentally would also be a test against this breakage.

--=20
Jakub Narebski
