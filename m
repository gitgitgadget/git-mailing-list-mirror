From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Eric Sunshine mail delivery failure
Date: Sun, 23 Aug 2015 14:24:06 -0400
Message-ID: <CAPig+cR3zZK5BJmG0S2K0PLcY9p-1Ko4ynR9GzM2wLq8xjn36g@mail.gmail.com>
References: <20150811104056.16465.58131@localhost>
	<55CBA140.7050301@web.de>
	<20150813022545.30116.44787@localhost>
	<55D8C824.6000704@web.de>
	<CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
	<trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
	<55D993F8.4080506@web.de>
	<20150823171622.GA28700@zorg.kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 23 20:24:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTZwT-00057q-2t
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 20:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbHWSYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 14:24:08 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33380 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbbHWSYH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2015 14:24:07 -0400
Received: by ykll84 with SMTP id l84so115066015ykl.0
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=OfzGqhL5aum/9j2kyHujy0UmG22RiOwUhIx2JvdjJuc=;
        b=s5hRhie/UhcXT5AIyp0doEAVNuzotos0WxyzEaId/U5hFpT1nSHEOSGimluBEFeu2A
         cEzgk79zRDxDM+6YqFbY/c6STskAGoBI5PLbe4iqd96XBSXuhNnX/9vx8cXGghXe+m1r
         abbFD7NNoKpoAsWubHpTk0f7HSWMsvLkzXW2Xtlj8Bg7ZF+yBroEC/q28Yr+CJPW8oHL
         GSqI2S1BQU3pTFsMxv4PDmiIG3bA/5UP0DmtXakGSz8eZ55bghjCqQZBK0eV1qIkp46Q
         6rhsnNY/51zF25Z7JboESWUbSEOo2eihNFriTsnGtrMx3PH8JUotA38WMIffcFpX/ozi
         98lQ==
X-Received: by 10.13.202.80 with SMTP id m77mr25453019ywd.166.1440354247018;
 Sun, 23 Aug 2015 11:24:07 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 23 Aug 2015 11:24:06 -0700 (PDT)
In-Reply-To: <20150823171622.GA28700@zorg.kyriasis.com>
X-Google-Sender-Auth: GkodwNyu-ICJbZEXh1IFL0pIneo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276419>

On Sun, Aug 23, 2015 at 1:16 PM, Johannes L=C3=B6thberg
<johannes@kyriasis.com> wrote:
> On 23/08, Ren=C3=A9 Scharfe wrote:
>> Eric, hope you see this reply on the list. Direct replies to
>> sunshine@sunshineco.com are rejected by my mail provider on submit i=
n
>> Thunderbird with the following message:
>>
>>    Requested action not taken: mailbox unavailable
>>    invalid DNS MX or A/AAAA resource record.
>>
>> And with this one when using their web interface:
>>
>>    A message that you sent could not be delivered to one or more of
>>    its recipients. This is a permanent error. The following address
>>    failed:
>>
>>    "sunshine@sunshineco.com":
>>    no valid MX hosts found
>>
>> It seems web.de wants you to get an AAAA record before I'm allowed t=
o send
>> mails to you.
>
> Just an A record would be enough. The issue is that mail.sunshineco.c=
om has
> neither an A nor an AAAA record, it is a CNAME to sunshineco.com, whi=
ch is
> invalid according to RFC2181.

Interestingly, the default configuration for all domains managed by
this service provider is for the mailhost to be a CNAME. While the
restriction in section 10.3 of RFC2181 makes sense as a way to avoid
extra "network burden", in practice, email services seem to be pretty
relaxed about it, and follow the CNAME indirection as needed.

I suppose it's possible that web.de is being extra strict (although it
seems that such strictness would be painful for its users), or this
could just be a temporary DNS lookup failure. It's hard to tell based
upon the errors Ren=C3=A9 reported.

I did change the CNAME to an A just in case, though who knows how long
it will take for the change to propagate over to web.de's server.
