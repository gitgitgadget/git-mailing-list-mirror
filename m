From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] t1500: test_rev_parse: facilitate future test enhancements
Date: Wed, 18 May 2016 13:32:15 -0400
Message-ID: <CAPig+cTv8UNg+0taNF4B2wytn0d-jGboCntxBy8TPgY+1qW85w@mail.gmail.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
	<20160517193630.10379-3-sunshine@sunshineco.com>
	<20160518183827.Horde.e7PY7wuh3iXKFZgoQ0oLR3D@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 18 19:32:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b35KX-0003nc-P1
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 19:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbcERRcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2016 13:32:17 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34434 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcERRcQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2016 13:32:16 -0400
Received: by mail-io0-f196.google.com with SMTP id d62so10733492iof.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=tFpaNyRXLNCHDizHErVR9GtzPbh5UQ2t31BzwgSiiWA=;
        b=INyIrRbSOj397DBuirNnbtePzq7WNrlQZY4nfYS96qJCAAcqlGaK0xuw88vqEy9pRF
         ubV4kdup5Vmry0G3bxhDe7t9by/4+u9AiJahPKw7PUEGBRwgxaBFk2eXJJnvpoa8THPu
         JzKY8S6tmZd9gEGeT6508tApUsOBrew9vaAMExECF3omcy7RdLRKQnc6I4ePxRSLU/nn
         EgOhny3uUcq8wE7gEEq586dgUZbNaMOAxmBBq2dqi/8rx0eBEuX/ZfH4+9bD7cQc7pEZ
         RqvOHEsNAvhxvEkKgHvlScSHlbwZh9XSFWxhcNlULhUVDJCtJfMLKwEo4vHJlqmmN12j
         R+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=tFpaNyRXLNCHDizHErVR9GtzPbh5UQ2t31BzwgSiiWA=;
        b=PJpJCqlPLqevM+yGlNQmKaoApH/7L82N7vyMsVJHXieMn237T1i9Wzkgk8cM4CV8ph
         //CPrrCBzx0Ae39Oq02hA8NLTHEmOSZ7FbnhMlP0JtvsDIBZB7nluHRX3hogfxrP+O7v
         Rz+fInU2axQNKoQZad+y5OGsmZ7GPiMNQxdvXCQRPoZaQSjQBL94rNCrv7++6cFJ9/D5
         t4u0+n3muXvJJvCx7m4GtTmRTyMkYjB3a5RgeqG4stB3JBzOPB/2urFLPu0MUsv/uTYl
         PjKN+Yun0o63ZCfIJ9INrJU3uFgowqwPOLJKRxLCWlHdrqKt68cGF0eg4UFFzjK9OC8J
         E9NA==
X-Gm-Message-State: AOPr4FWuNzWh6b4HKTj6KkoKc0vXEU5qpvsLfFQbe7dAhFWpccKH7YyULYktkFklq39KiQrxu6bfvdEwqgb72w==
X-Received: by 10.36.31.65 with SMTP id d62mr6326214itd.84.1463592735936; Wed,
 18 May 2016 10:32:15 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Wed, 18 May 2016 10:32:15 -0700 (PDT)
In-Reply-To: <20160518183827.Horde.e7PY7wuh3iXKFZgoQ0oLR3D@webmail.informatik.kit.edu>
X-Google-Sender-Auth: 53ytVI4OpAHTeIdsCr5P6wYHbi8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294980>

On Wed, May 18, 2016 at 12:38 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> Quoting Eric Sunshine <sunshine@sunshineco.com>:
>> +       for o in is-bare-repository \
>> +                is-inside-git-dir \
>> +                is-inside-work-tree \
>> +                show-prefix \
>> +                git-dir
>> +       do
>> +               test $# -eq 0 && break
>> +               expect=3D"$1"
>> +               test_expect_success "$name: $o" '
>> +                       echo "$expect" >expect &&
>> +                       git rev-parse --$o >actual &&
>
> I think that "--$o" looks really weird, but that's subjective, of cou=
rse.
>
> However, the idea popped up in an other thread[1] that we might want
> something like 'git rev-parse --absolute-path --git-dir', which would=
n't
> really work with '--$o'.
>
> Even if we don't go that route, perhaps it would be better to list th=
e
> options to be tested including their doubledash prefix.

As this series is only about modernizing t1500, I'd prefer to keep the
conversion faithful to the original which titles each test "$name:
is-bare-repository", "$name: is-inside-git-dir", etc., and the current
approach does so without additional complexity.

I have no objection to upgrading the for-loop items to include the
leading dashes or updating the logic to support --absolute-path, but
such changes are outside the scope of this series and can easily be
built atop it. Also, due to severe time constraints, I'd rather not
re-roll only for a superficial and subjective change such as adding
leading dashes to for-loop items.

Thanks.
