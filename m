From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Wed, 26 Aug 2015 11:18:37 +0100
Message-ID: <CAE5ih791vqnyk_J8Sq9LXq+WZW31OwEuCiD6-wwVLo-tXxHOMA@mail.gmail.com>
References: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com>
	<55DC111A.6090501@diamand.org>
	<55DC285D.9030500@web.de>
	<23CB37E8-9704-4A9D-8CAB-2812AD59394D@gmail.com>
	<CAE5ih7-o6eVF-z2GORxHa_TdDaXgexLpW3jctESTnL46Mfdo8w@mail.gmail.com>
	<B7632D9A-BB8B-41E5-9C3D-F7376A0C81D3@gmail.com>
	<55DCB2E0.5090605@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 12:18:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUXn1-0001kr-1s
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 12:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbbHZKSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2015 06:18:39 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36096 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbbHZKSi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2015 06:18:38 -0400
Received: by oiev193 with SMTP id v193so118421658oie.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ACVNtjKixoo0MuxgYbkfwFXn25JgymZud3p5NkAvYCs=;
        b=If05Rlypg/35fHNjMtgDw64gN3zDN4/CgJpjZrxR/naH34xfZBN7kJszSRFTNFtZv8
         WZtwfeVqc876X6/GubKqw7IrHIbJQaXW7gn5vDXndaZu32P3G5KoToiJY1vvgshJyAo2
         CJu2L2h0HLxIcGNGLJrWKKsQpdGcNrOmMAve4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ACVNtjKixoo0MuxgYbkfwFXn25JgymZud3p5NkAvYCs=;
        b=juPC0+E0eF/fa8eGnDdwOfP26ASqkaIHQppYysuMWgzeqOTdk/cNxKmQlh1YajEQhe
         GCB7tjf6EjgttC3WhPmEDpdPNlye5i8o3elfATmtMMfhIRcZxh/sgjyMIrH/n4bGLkxi
         chon7GM9y/BbMiGwxPFOMXOVN5mjmfPIDmzA2tAJSFADvBnGFxasExQ3zYBjHqFN5wrc
         TFMpsOHSeEfo62EtVnO3ItONvGBVKs7O5u1xsFWJx7kSdPZxPNHJ5qcub9oveeEkiCOV
         2hY2p+GIJSP+dJXJrssal/xJ2Rz6VEKTwYfnx47ot8ZhopqWy8iAhUzGuYcwRVcDv8KH
         lt9A==
X-Gm-Message-State: ALoCoQkiJbNr6+a5GrT+uoqq/rKJ/09uOMQYucAiSOi6x6+m2ds6EEuCJe6SwTnERORsdGRDup20
X-Received: by 10.202.87.8 with SMTP id l8mr30352288oib.91.1440584317653; Wed,
 26 Aug 2015 03:18:37 -0700 (PDT)
Received: by 10.60.162.5 with HTTP; Wed, 26 Aug 2015 03:18:37 -0700 (PDT)
In-Reply-To: <55DCB2E0.5090605@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276605>

On 25 August 2015 at 19:24, Luke Diamand <luke@diamand.org> wrote:
> On 25/08/15 14:14, Lars Schneider wrote:
>>>
>>>
>>> So the choices are:
>>>
>>> 1. A new command-line option which would silently set core.ignoreca=
se
>>> 2. Users just have to know to set core.ignorecase manually before
>>> using git-p4 (i.e. Lars' patch v5)
>>> 3. Fix fast-import to take a --casefold option (but that's a much b=
igger
>>> change)
>>>
>> I vote for 2 because that solves the problem consistently with the
>> existing implementation for now. That means we don=E2=80=99t surpris=
e git-p4 users.
>> In addition I would try to fix (3), the =E2=80=94casefold option, in=
 a separate
>> patch. Although this (3) patch could take a bit as I have two more g=
it-p4
>> patches in the queue that I want to propose to the mailing list firs=
t.
>
>
> That works for me. Ack.
>
> Thanks!
> Luke

Lars - could you resubmit PATCHv5 as v6, with Acked-by from me added
after the Signed-off-by: line.
It then this from SubmittingPatches:

> After the list reached a consensus that it is a good idea to apply th=
e
> patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" th=
e
> list [*2*] for inclusion.

Thanks
Luke
