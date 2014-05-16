From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Fri, 16 May 2014 11:17:18 -0700
Message-ID: <CAPc5daUzcQvPCY8UQE4-OuNOswKxTMBNTddGV9YWXwONXoV3Qg@mail.gmail.com>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
 <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
 <20140515050820.GA30785@localhost.localdomain> <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
 <20140515184808.GA7964@localhost.localdomain> <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
 <xmqqmweiessl.fsf@gitster.dls.corp.google.com> <CANQwDwffdbqD96OadyECFs=6WY_t+_0b63L5yAZVQ8aXrMvHHA@mail.gmail.com>
 <xmqqmweibjjo.fsf@gitster.dls.corp.google.com> <CANQwDwe8Eb+ORiRyuq3+kKw72Jath_DGySmws1Rvt8bmuHoXVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <accounts@mwagner.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	git <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 20:17:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlMhU-0007Iq-GX
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbaEPSRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 14:17:40 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:61908 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964AbaEPSRk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 14:17:40 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so2235549lbi.1
        for <git@vger.kernel.org>; Fri, 16 May 2014 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=lzZ1GURs9Qob/eBLudc7xFVhpGjkuKXXBXMfmM8rVCE=;
        b=qWXPqa57GU34r6Z6J27bzZs04/12rTGl5H5YppUmWSgevYhRCiS65pIIUC2J+HBa+X
         IYFyHexe9mYT6/TxWpqmCuv4lnPOJ7VhIAsCNuIaBAetydYtLVLFfairg9S9F9Eg/Q2U
         oISnPyk1jW1B1IQL71caJOSL8F0bHO9ga+7Fm22i3YFMRjsLOIsLFdrW/giyXuzP+3MB
         Du1bTvDL+9nr4Va6oIIi0bV0vTNxvmLQAF1peO8lCWGGPI5aHjyjGPXGm3Gvl2s7moBL
         JkS336KlQA8pjzD12HQ4y3y7nFG/PG8P9bhRlOIx/vhsBsnR9P1zU2SuZUbBNlpvd1Jk
         D+Vw==
X-Received: by 10.112.217.10 with SMTP id ou10mr12478297lbc.20.1400264258492;
 Fri, 16 May 2014 11:17:38 -0700 (PDT)
Received: by 10.112.17.98 with HTTP; Fri, 16 May 2014 11:17:18 -0700 (PDT)
In-Reply-To: <CANQwDwe8Eb+ORiRyuq3+kKw72Jath_DGySmws1Rvt8bmuHoXVw@mail.gmail.com>
X-Google-Sender-Auth: Q_1bPlREeyeMUBwVPLEt-mziftE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249403>

(sorry if you receive a dup; pobox.com seems to be constipated right no=
w)

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> Correct, but is "where does it appear" the question we are
>> primarily interested in, wrt this breakage and its fix?
>
> That of course depends on how we want to test gitweb output.
> The simplest solution, comparing with known output with perhaps
> fragile / variable elements masked out could be done quickly...
> but changes in output (even if they don't change functionality,
> or don't change visible output) require regenerating test cases
> (expected output) to test against - which might be source of
> errors in test suite.

I agree with your "to test it fully, we need extra dependencies",
but my point is that it does not have to be a full "HTML-validating,
picking the expected attribute via XPATH matching" kind of test if
what we want is only to add a new test to protect this particular
fix from future breakages.

=46or example, I think it is sufficient to grep for 'href=3D"...%xx%xx"=
'
in the output after preparing a sample tree with one entry to show.
The expected substring either exists (in which case we got it
right), or it doesn't (in which case we are showing garbage).  Of
course that depends on the assumption that its output is not too
heavily contaminated with volatile parts outside our control, as I
already mentioned in the message you are responding to.

But it all depends on "if" we wanted to add a new test ;-)
