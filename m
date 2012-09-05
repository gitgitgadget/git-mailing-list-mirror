From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Wed, 5 Sep 2012 17:25:25 +0700
Message-ID: <CACsJy8CPaJKGU0Lyjr93s9JEc_VBuLrHNH=nRa42K8Ohj3OWFA@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org> <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com>
 <7vmx15bsxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 12:26:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Co8-0000wT-RD
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 12:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab2IEKZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 06:25:57 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52937 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab2IEKZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 06:25:56 -0400
Received: by ieje11 with SMTP id e11so767332iej.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+J/HTGNrltQdv3v9RO9oC1Sb/erSGX5AgbtQq85jfmo=;
        b=uF560xC20uKdSchUB39w/Z6IdUYHZ7Hwn26kUl3nSUE7OK8/IJ8qOzcTnraIgjBdwY
         3um522qyqiTYR6ktoSaCwRiuFhwEPXkbqa+TUn18zEYluYP+mkYJd1RFJvQOU8HSuy8z
         L7Q6FU/PGX1p53/lhbrq7S4FFzmH4JW27FY1VI+9+BtHbzGr+59iLu0eqpF6oSO1cjcm
         NFWca47PKcMm+cNgS0WkTzBT1bclIkrXb39KqTEaCNAFUxaZTLHkdyC8HQOdGTGg+okS
         QNDEEjpSeZA3zWenypUMwoTzIB9eOyPAWAJRVm5oacpwtsSma7ayAsyGL3lImh26sEoW
         P9EQ==
Received: by 10.50.237.38 with SMTP id uz6mr17178458igc.2.1346840756251; Wed,
 05 Sep 2012 03:25:56 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Wed, 5 Sep 2012 03:25:25 -0700 (PDT)
In-Reply-To: <7vmx15bsxj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204808>

On Wed, Sep 5, 2012 at 12:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>>> +static void output_exclude(const char *path, struct exclude *exclude)
>>> +{
>>> +       char *type = exclude->to_exclude ? "excluded" : "included";
>>> +       char *bang = exclude->to_exclude ? "" : "!";
>>> +       char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
>>> +       printf(_("%s: %s %s%s%s "), path, type, bang, exclude->pattern, dir);
>>
>> These English words "excluded" and "included" make the translator me
>> want to translate them. But they could be the markers for scripts, so
>> they may not be translated. How about using non alphanumeric letters
>> instead?
>
> I agree they should not be translated, but it is a disease to think
> unintelligible mnemonic is a better input format for scripts than
> the spelled out words.  "excluded/included" pair is just fine.

Not all mnemonic is unintelligible though. "+" and "-" may fit well in
this case. I'm just trying to make sure we have checked the mnemonic
pool before ending up with excluded/included.
-- 
Duy
