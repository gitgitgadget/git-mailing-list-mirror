From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC] git-commit: add a commit.verbose config variable
Date: Thu, 25 Feb 2016 13:58:12 -0800
Message-ID: <CAGZ79kaAv6yaDPU5roRCAniiq3+HqLXhyNEr7Bd4PwQTY_30QQ@mail.gmail.com>
References: <56CFBF19.6040004@zoho.com>
	<vpqmvqo1nx7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@zoho.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 25 22:58:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ3vO-0004o1-HD
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 22:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbcBYV6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 16:58:14 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:35080 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcBYV6N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 16:58:13 -0500
Received: by mail-io0-f177.google.com with SMTP id g203so103326113iof.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Hece62iryTJ334eCI34e8bYp2vHh4Kn+eyGrRAgRUeQ=;
        b=EqbK7zAlOrLphNqAHWHv1j+qA7a/LlErl53z5XLu/I9Rhu4UUGPiVQmRxoSS94KUK2
         3r8+1PSQNYzKFVWhTAmAmbwUyzvMdaqfJ3VQ0CI9StuRJQlylfZQMjBg6fkMcLbA7oKX
         sEMM+h5N6pXJPpEgQBOCfrROnHd48gRhyxwh3taU5Tk/hs1f/cbRL3vm0Gqp1jrPt8Ff
         KBeGi27tOI9tuOuicZeEg9biQQVhpiybY1JsnaL6gluaENRv5Y8NhlNpPHNtwPDRNpKs
         sGoyf8TYosnQBbm8jx//EkbaRaeRiJTpmTArPiTnomoph8aaiXHpI3Q/nJA+QqmxxEZd
         xeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Hece62iryTJ334eCI34e8bYp2vHh4Kn+eyGrRAgRUeQ=;
        b=iwcP7ORa5k7IEIG4hy4VdyEmn+9dgUfrCkYNGdVwbx/z7gRhrobeRwf8h0jAnBzzHJ
         HpeN1tz8dTsILk2dgSMxJsVXUBUpNN/YMXWoIB1U+YtArOXYybuMFdDkCNOPdqW7ryiD
         LhcH3ohws/6C5p6YKtnrT/h0GYut3UIYDK8WjUaYL+AOteOuA9nCdBuzQFS8EG687pq0
         GMo4ksAbnAgZxVj6UI5Na9mY5/R/V55S2XIJkx46iDi/7me48CCcOQBmLi+mfqJB3c5W
         KZFmTR32UiVOt3+JIyV1pM2Ul5ycYaNykYfVgIzrDy36Oci9iIK+Pb86z2puvNIzJ+gU
         /ohg==
X-Gm-Message-State: AG10YOTgwpHIp+Q3CYj4t9fVFm6TKyUwcQW5IVXx+HQNL7vjfdSP1/cT+eHg6xAK8VU20ifWF+ldK5cSRsVeEz3c
X-Received: by 10.107.168.149 with SMTP id e21mr5173683ioj.96.1456437493022;
 Thu, 25 Feb 2016 13:58:13 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Thu, 25 Feb 2016 13:58:12 -0800 (PST)
In-Reply-To: <vpqmvqo1nx7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287443>

On Thu, Feb 25, 2016 at 1:27 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> +commit.verbose::
>> +     A boolean to specify whether to always include the verbose option
>
> Boolean is usually written with a capital letter.

I disagree here, ("grep -riI boolean" suggestes to only capitalize boolean
at the beginning of a sentence.)
