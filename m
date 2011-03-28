From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 15:12:25 -0400
Message-ID: <AANLkTimR5XfOV-0RZjdyu72E9JdBfr1B+wc=q55V4qH5@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
 <AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
 <4D909DD1.2050904@viscovery.net> <AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
 <vpq62r3i1z4.fsf@bauges.imag.fr> <AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
 <vpqr59r6sg5.fsf@bauges.imag.fr> <AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
 <vpqvcz35cjk.fsf@bauges.imag.fr> <AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:12:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Hrx-0000pz-P9
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 21:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab1C1TMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 15:12:47 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38397 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab1C1TMq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 15:12:46 -0400
Received: by ewy4 with SMTP id 4so1279608ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=im3gEOor2pCatSLoor6hXgBR4mOZcGWB6au3vIIQjWs=;
        b=QoHmvTc4VejzIXwo3nWx7+aC59qW9OF6xlJlrrLHOh/6obx4sNJ6wWwVJ4KtCr7W5y
         ulGGnbiiFDSOp1fU334ZCCK9Vc4EDv+qI4lpZ+jC/yzFq+be2zQ13Pc6n3r1Qx7rsg24
         ySNC3q60ClfLyJ/2/oiktsWxO8bGbfRi++lqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=XvBcc7GpaZOnuO4C4d30TSwJc82iln0wpKuQreRUkDylkFMRhCRpStzN7I+Pbr9cWS
         O/MSFyCtxP2jxFdPtTL1HDrtUJGT4lD/wPCDOkbTtvYngHXOmVGTgO5NvTmuQUoc1EQq
         Bj+0Gj5Gp3CxbRVls739Of+jpd/pJLr0VCnNs=
Received: by 10.213.26.152 with SMTP id e24mr2005641ebc.125.1301339565169;
 Mon, 28 Mar 2011 12:12:45 -0700 (PDT)
Received: by 10.213.105.76 with HTTP; Mon, 28 Mar 2011 12:12:25 -0700 (PDT)
In-Reply-To: <AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
X-Google-Sender-Auth: uGSsFgVY76F1jMP3Sp45fPlLUjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170176>

>> What is the point is finding manually a commit *on the same branch* when
>> the tool can do that for you?

> Seems to me that this is trying to cram two questions into one:
>
> A) where did branch foo diverge from branch bar and
> B) which commit between that ancestor and bar did things break.

To find the answer to A, I generally just do this (using an alias):

git log --graph --oneline --all

It takes at most a couple of seconds... hardly what I'd call a manual process.
