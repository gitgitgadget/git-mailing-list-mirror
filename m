From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFCv2 01/16] stringlist: add from_space_separated_string
Date: Tue, 2 Jun 2015 10:54:08 -0700
Message-ID: <CAGZ79katiDViBzC8sMJaDqaekc4+KSyTnfdYD-uni9K72iAVpg@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-2-git-send-email-sbeller@google.com>
	<CACsJy8BEEvgP_YzVnbPaLL9QBs48sd2fn6CeicXD_9U92=9UnA@mail.gmail.com>
	<CAPig+cTsBU2t=NJEe16N2CMyYrWgbP-NvoKxNQ9QdPiokXj+hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 19:54:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzqOE-0003pw-CL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759551AbbFBRyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:54:10 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33376 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369AbbFBRyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 13:54:08 -0400
Received: by qkhg32 with SMTP id g32so105400764qkh.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WCqyofry0nR9wmk2R7sKaQQtbw0J5tIT3SGc8RgST8o=;
        b=lHV2zFXyE1poU8R6kuBRJmK9Xo6wBhoh6p8L/GK0YK66QA6dkp2vLkrcRfugTdqFdS
         WIaEhwffnbwZxyK34gLJ7Ke5xDyFODo1KZZj62woIWVRvHDQGibteSgGpcmniO7O4liU
         /JDsZ6TErGrFTU+0ctBJyNj0hXgmi9L7R/+UH/1xupUho3KL65FKg271giF8HlS/YBYM
         uACRd4rCPWVvGr9/6S8biHgMLNOZYJR3zG+Mc7N8zAk4PgCr32pbTdR/f1RpZlB58qJg
         a2dfwoegDLZFNx2bG5cOoLQuDHS5uj0fbeMteHPLgEFO1RZ3gTJM7sdqaUbKL4kgcpEg
         S7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WCqyofry0nR9wmk2R7sKaQQtbw0J5tIT3SGc8RgST8o=;
        b=PnxbWLBxNdr/kG0hfbLnXRnJKKmCRyA2q0Sjq6gHwoj4GROXpRHZm5I+hVl/M5qW7M
         0+EfBDMxLY2cSxmEDgrRfOfGfgTUfwvQBDvjCXiKQ/eeV/0E39GZtrBuY10UQEsMYAv3
         KsTPpbAUpjSMRSIurjWfudb9CAPt/rd67BirAWr3ZIu69TtRQcz679DsgEiAPKfsJ//i
         QY0inKd/1O+Nn0YhkcvQUwfxSVe4CMU8Ga8vc9WO+I8yG80BOnrEWZTd9YND3z+AzbuL
         BPDlQqVaHVNhAoLfblTd39RHPfLJCl2JKJ55qLJHldS+wHifqwKgl1uqy6ASNi6EedZQ
         PZug==
X-Gm-Message-State: ALoCoQkt1EDOQwxYOmuFTM0GlUC0kfMZGqiGvGJl2Qq67q98KFCOxDzu5WmWJvaqq5CT1G1Mr7nN
X-Received: by 10.140.196.140 with SMTP id r134mr31169887qha.60.1433267648144;
 Tue, 02 Jun 2015 10:54:08 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 10:54:08 -0700 (PDT)
In-Reply-To: <CAPig+cTsBU2t=NJEe16N2CMyYrWgbP-NvoKxNQ9QdPiokXj+hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270573>

On Tue, Jun 2, 2015 at 8:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 2, 2015 at 5:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Jun 2, 2015 at 7:02 AM, Stefan Beller <sbeller@google.com> wrote:
>>> diff --git a/string-list.h b/string-list.h
>>> index d3809a1..88c18e9 100644
>>> --- a/string-list.h
>>> +++ b/string-list.h
>>> @@ -19,6 +19,7 @@ struct string_list {
>>>  #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>>>
>>>  void string_list_init(struct string_list *list, int strdup_strings);
>>> +void from_space_separated_string(struct string_list *list, char *line);
>>
>> The name feels out of place. All functions in here have "string_list"
>> somewhere in their names. The implementation looks very close to
>> string_list_split() but that name's already taken.. Maybe
>> string_list_split_by_space()?
>
> Indeed. If you really want to go the specialized route, splitting only
> on whitespace, then Duy's suggestion makes sense. Alternately,
> string_list_split_ws() might be easily understood while still
> remaining somewhat terse.
>
> However, why make this so specialized? A more generalized function
> could be more widely useful. For instance, you could introduce a
> function very similar to string_list_split() to which you supply
> multiple delimiter characters (as a 'const char *') rather than the
> single delimiter character accepted by string_list_split(). The
> function could be named string_list_split_any() or
> string_list_tokenize().
>
> Also, it's ugly and inconvenient to require the incoming string be
> non-const, and feels as if you're letting the interface be dictated by
> an implementation detail (underlying use of strtok_r).

I see. I think I can even use string_list_split here, and drop this patch.

Thanks for pointing out the flaws!
