From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are pending
Date: Sat, 30 Jul 2011 01:26:38 +0530
Message-ID: <CALkWK0=qXBteRjj5vXDEWGVausQ3ssOvy4hyHHz84ORFzDaHaQ@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com> <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
 <20110727141006.GA24785@elie> <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
 <20110727154830.GA29924@elie> <CALkWK0mUGiCRQoW6UM+mF5tsn4DxRuaiXn0TS2CcEsR0OeusKg@mail.gmail.com>
 <20110729191654.GA2368@elie.dc0b.debconf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 21:57:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmtBB-00036y-1W
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 21:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab1G2T5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 15:57:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40052 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab1G2T47 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2011 15:56:59 -0400
Received: by wwe5 with SMTP id 5so3897493wwe.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cHmRLVV6F3NLBWsLEGoqAg6zJ1caLFkFAJf+FGt3i2o=;
        b=V6B0EFyJpYTaMgzt/Do5dgr53GGQEKFskY77aWRMtzgKQSMGgHLFcSRNdjlzcYsdhi
         cZu0+l3shjQX1UhCCzKQL/JBQTNXOecCYbqs9LSB0gLB0jNtDJE6WawhklyXdixHm1Jy
         UmRvg4oE89mq9aCc05F1X1o8QkN9h2G9UTLho=
Received: by 10.227.57.209 with SMTP id d17mr2202194wbh.94.1311969418140; Fri,
 29 Jul 2011 12:56:58 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Fri, 29 Jul 2011 12:56:38 -0700 (PDT)
In-Reply-To: <20110729191654.GA2368@elie.dc0b.debconf.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178162>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder writes:
>>> If "tight coupling" means "builtin/commit.c calls a function declar=
ed
>>> in sequencer.h", then yes, I think it should be fine.
>>
>> My bad. I'll first have to figure out a way to expose the todo parsi=
ng
>> functions (and dependent functions) without touching much else.
>
> That's the wrong way to go. =C2=A0One right way would be to expose a =
single
> function, representing "here is what to do after successfully making =
a
> commit". =C2=A0Think of it as an invisible built-in post-commit hook
> (see githooks(5)).

Okay, I don't follow.  Wouldn't this function need to parse the todo
sheet and figure out how many instructions are left?  For that, the
todo parsing functions can't be buried in builtin/revert.c, no?  Hence
I said "expose" them -- or move them to sequencer.c.

-- Ram
