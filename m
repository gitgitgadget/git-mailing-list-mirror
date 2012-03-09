From: Dominique Quatravaux <domq@google.com>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Fri, 9 Mar 2012 10:04:12 +0100
Message-ID: <CAJh6GrGEix8qfAuJamWzcr69=LjkZ-O9B=Vorvy_KTcJe3TcPA@mail.gmail.com>
References: <1331203358-28277-1-git-send-email-domq@google.com>
 <1331203358-28277-2-git-send-email-domq@google.com> <87399jnyxh.fsf@thomas.inf.ethz.ch>
 <7vaa3qewqw.fsf@alter.siamese.dyndns.org> <7vipiebv1r.fsf@alter.siamese.dyndns.org>
 <4F59AFA9.5030205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:04:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5vko-000591-B6
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954Ab2CIJEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 04:04:40 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:38400 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab2CIJEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 04:04:33 -0500
Received: by wejx9 with SMTP id x9so954326wej.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 01:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=uJIyQCAuMZraBE+hfLuoP/XYNIIj98E2pdXvK4v8uDc=;
        b=RQwfOQss/TbvdwnSlwo4TCQW4ok2JmrPQoWiIX1+ckJ/4doXYp/m6nCgdiVGrjpqiy
         IHODH+/pJAMZdlCctpTd5oUp2jsWvSUsmd7LuE7dclvkeDCXkMO5buFq1iZ5DImyapeA
         E9L5gUFWvd3H94PtX6eysa7T/E25XG64TscWYN4wcwaaTO7MigiwRENxpPqMqsvyPnn2
         X68Pn3h7t03CCSGGu1BEdvnEa6LYkQRvazN+PQi30qmtjnMg6RwcwVeX6sii5URZsKVY
         VHuuXuAwQXBYt7KOtbsVhHHTlqmUfj1IKHKCeK0IOGDZLftkebtELTJSYNRr9J1atBYc
         L2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=uJIyQCAuMZraBE+hfLuoP/XYNIIj98E2pdXvK4v8uDc=;
        b=H5FmywVBd2gjummzj1D2d2Z1fjGHe7NJkAKJlXUAHoT6ZR/KQ1OteNPJxIBBCaQMtj
         CVeClTTTzAmIt1WVrbAXVTV0+hgVocn3/Laf3v3zJDlwPLFHPZYQqy8A3GFxlNnjtQqH
         KUBdCpd7JCnsfOM2ZxVezcqpA1oE6LoHuO07VnR+WQBVrRcGeiFQEPYH1jBkGhFwVe2G
         eNy7gms0nhWEfj/SkuOQPVlGQIj7DWCV2IEE7rGUWUse95Vyn4MkqQlMOix56MMjPA+G
         56lnya4rWhi5b3BcmsxYeVSD1TYGpsjT9MvHyFwXb19JSitxiSbjdo1rjGkKbY9HGCV9
         c2OQ==
Received: by 10.180.82.132 with SMTP id i4mr2806464wiy.12.1331283872394;
        Fri, 09 Mar 2012 01:04:32 -0800 (PST)
Received: by 10.180.82.132 with SMTP id i4mr2806445wiy.12.1331283872298; Fri,
 09 Mar 2012 01:04:32 -0800 (PST)
Received: by 10.227.7.138 with HTTP; Fri, 9 Mar 2012 01:04:12 -0800 (PST)
In-Reply-To: <4F59AFA9.5030205@viscovery.net>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmFGj7ekXSztEv6fY8rptMEyRgtE7nw6iQdWrRt0sZUom8fkt5hkMXHZdiXc+2rqoZGavmfMPlBJDpTKRkUtn7Yx3ZQuloaaPF+gCOyjG5YeWuBvcRU18dmXd4420/JC/kD/dRZVMRJGYwCqKhiPflGlsYoSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192696>

Junio C Hamano <gitster@pobox.com> writes:
>> Today's "git rebase -i" wouldn't do something like that, and we will
>> not know how the user would interact with such a yet-to-be-written
>> tool, so it is too early to judge if using "topic~1" is the desired
>> improvement or not at this point.
>
On Fri, Mar 9, 2012 at 8:22 AM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Yet-to-be-written? Rebase -i happily linearizes mergy history, so thi=
s
> does have some merits even today.

Right, my personal itch is to "transplant" topic branches without their=
 merge
history getting in the way, eg go from


   M1 ------ M2 ----- M3 ---- M4                master
     \                  \
      \           B1 --- B2 --- B3              topicB
       \         /
        A1 --- A2 --- A3                        topicA

to

   M1 ---- M2 ---- M3 ---- M4                   master
     \                       \
      \                       B1 ---- B3        topicB
       \
        A1 ---- A2 ---- A3                      topicA


If I "git rebase -i --onto master topicA topicB", the rebase todo might=
 go like

  pick 1234abc Cool shiny new stuff
  pick 234abc1 Something something master
  pick 34abc12 Fix something something
  pick 4abc123 Fix shiny new stuff

With my patch (combined with Junio's suggestion, and some whitespace pa=
dding
for extra niceness) we would get instead

  pick 1234abc (topicB~2) Cool shiny new stuff
  pick 234abc1 (master~2) Something something master
  pick 34abc12 (master~1) Fix something something
  pick 4abc123 (topicB)   Fix shiny new stuff

Snip the lines that don't m/topicB/ with your text editor, save file, d=
one.

> I do share your concerns that naming to-be-rebased commits with a rel=
ative
> specifier such as "topic~1" could be dangerous. However, this is a pr=
oblem
> only when the rebase -i is not completed timely, so that you have
> sufficient time to mess with the ref "topic" from a different termina=
l.

I think that Junio's suggestion fixes that (at the expense of 8 of the =
precious
80 columns).

--
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
