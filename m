From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] versionsort: support reorder prerelease suffixes
Date: Mon, 9 Mar 2015 08:01:21 +0700
Message-ID: <CACsJy8Bpta0rw1rjN8ROcUykPK508bvH_bvAJzLQQa6L6OmH7w@mail.gmail.com>
References: <CAPc5daVJJcC--mwq0PfAczge3zG44ToDKP853FkyZ3x1KUfsig@mail.gmail.com>
 <1424947441-19134-1-git-send-email-pclouds@gmail.com> <xmqqvbinhw7l.fsf@gitster.dls.corp.google.com>
 <xmqqmw3s5j1y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:02:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUm51-0008Ja-4j
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 02:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbbCIBBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 21:01:54 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34927 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbCIBBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 21:01:53 -0400
Received: by iebtr6 with SMTP id tr6so25724888ieb.2
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7qOVPIsRegUtBzwbynPDrZ6yNVz4qupuzSqj+cHus8c=;
        b=X2ExtPByY0e6xYsLmw1mT79B5pGuhzHG+DvrB5wQRdZQGrS8fV+Q55WcT94N9uP4zI
         47d2hXK7LLJ5NjAlgPyZR6g5WzV7DpUJUEP5jh76zqVHCC6O8hi2pEph3uFplCAZzVfb
         xEE8/hXxEUAiK45SiRUrcrMc2gKpFpgeeGw5RCW77wwh91E9WB2xGQ+Y8aqVAs4nrRM5
         lNHlbGSPNhJi3VFUs85dNVye6LBjhLx6CXzlTrbC0ZWkPhRYjkeQrRCiRWrQCIArZ784
         k/DZzhKfx/iEkNw0NENagC6sx2LX23mJf4R46XBsFuvyPWpRK6KXSKbnBnULoSzrrBMW
         ZOpg==
X-Received: by 10.107.35.140 with SMTP id j134mr43818949ioj.11.1425862912705;
 Sun, 08 Mar 2015 18:01:52 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sun, 8 Mar 2015 18:01:21 -0700 (PDT)
In-Reply-To: <xmqqmw3s5j1y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265121>

On Thu, Mar 5, 2015 at 8:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +versionsort.prereleaseSuffix::
>>> +    When version sort is used in linkgit:git-tag[1], prerelease
>>> +    tags (e.g. "1.0-rc1") may appear after the main release
>>> +    "1.0". By specifying the suffix "-rc" in this variable,
>>> +    "1.0-rc1" will appear before "1.0". One variable assignment
>>> +    per suffix.
>>
>> I think the last half-sentence want to mean that
>>
>>       [versionsort]
>>                 prereleaseSuffix = -pre
>>               prereleaseSuffix = -rc
>>
>> is the supported way to write, and not
>>
>>       [versionsort]
>>               prereleaseSuffix = -pre -rc
>>
>> but it probably is unclear unless the reader already knows what it
>> is trying to say.  The reader also needs to learn somewhere how the
>> order of the entries affects the result.
>
> This is already in 'next', so could you fix that half-sentence in
> the documentation via an incremental update?

How about..

".. "1.0-rc1" will appear before "1.0".  This key can be specified
multiple times, one for each suffix. The order of suffixes in the
config file determines the sorting order (e.g. if "-pre" appears
before "-rc" in the config file then 1.0-preXX is sorted before
1.0-rcXX). The sorting order between different suffixes is undefined
if they are in multiple config files"
-- 
Duy
