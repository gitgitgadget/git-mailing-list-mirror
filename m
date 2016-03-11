From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v7 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 11 Mar 2016 18:45:01 +0530
Message-ID: <CA+DCAeSvjyy6WO=n-wdo3_yHGSWmUC0Epbt-OYLF_fbuczeeKA@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-2-git-send-email-mehul.jain2029@gmail.com>
	<CACRoPnRESpiNL_=rEgw7kRdKjek8Z=qVjPH=BEWsWeYn22YryQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 14:15:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeMuL-0007iL-Ti
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 14:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbcCKNPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 08:15:04 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34700 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbcCKNPC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 08:15:02 -0500
Received: by mail-qk0-f175.google.com with SMTP id x1so47398214qkc.1
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 05:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FkhulyDbjz7sO3UNwxp6IX/VeD51yqBAbokqIE81f18=;
        b=Ra5O6fJJm5qZimHJIZMgEQu22oVnq3MOeDFG5jKnEHOAZsp9MzN6IVdUw3OYPIHt/e
         oiIt7vBDEqqlpa/TWIdRy4MaEUO9A/Kx+nHUTsKRmNlFy30Q6LgRT4lD9IEhu8QbLk3y
         rCjk+oWyPEDj/vfmZPfHcbYUCZrcmT14sNBo/6EKM/iU2MuirpxrFiVCFWWQlB26BzvE
         kBsV8QATzC46/mGd0JTEYmGHBZDvi5ITifD30gbs5Y11cZXRn5L3TTGGL43vRc26CMbL
         sJurG9v0Y7l1Z/O74fNxslZr0lmSidaLcx1+ztlvxf4N7IO72mbMrSmJQb2NgP/VUA+8
         Atww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FkhulyDbjz7sO3UNwxp6IX/VeD51yqBAbokqIE81f18=;
        b=aXfNkXFu3ledkaYT5FDDcyBI9g4At8CpLuFrvi37IXKO92pIaWomMe/oPM/Bu9+rkn
         ESqjs7yBUMCi9uLXc0Ru+ZWchks61MjzPE6aRVODzH2YjyQ8eem9MP/tru1iUNwS0fBF
         +5l1+vZHwVNM2IwhlDONssAKndSLQ++sJe7o96AOTo0tXZsr1oZpR/I9y1AvkEhmySO3
         oysEQzDlEmQ4SOmPydaMF5y9HISte9fot5kD5B7rh6sTG3dcjCQjCC3FoVZKmOC0Tr9D
         AaJQHhBHae/WkRiSEZrbm7KQhL6q9S3P7oPqVp8DfWocsytnQ3AcX1+B98t9RKif1xR8
         ivIw==
X-Gm-Message-State: AD7BkJJPITnXLRLHXJkwBrVpUKYP8S2iMcze15HwTzyJADU1T3kAV5YfH8eN8JIvQFDz2L2Cjy78DjXP4gArFg==
X-Received: by 10.55.54.201 with SMTP id d192mr11490397qka.23.1457702101216;
 Fri, 11 Mar 2016 05:15:01 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Fri, 11 Mar 2016 05:15:01 -0800 (PST)
In-Reply-To: <CACRoPnRESpiNL_=rEgw7kRdKjek8Z=qVjPH=BEWsWeYn22YryQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288678>

On Fri, Mar 11, 2016 at 10:21 AM, Paul Tan <pyokagan@gmail.com> wrote:
>>  static int config_autostash = -1;
>
> Hmm, why can't config_autostash just default to 0?

Previously Junio recommended not to explicitly initialize a
static to 0 (or NULL).
http://thread.gmane.org/gmane.comp.version-control.git/287709/focus=287726

Defaulting config_autostash = 0 will work too as you explained.

>> +       if (opt_autostash == 1)
>> +               argv_array_push(&args, "--autostash");
>> +       else if (opt_autostash == 0)
>> +               argv_array_push(&args, "--no-autostash");
>
> The precise testing for specific values of -1, 0 and 1 throughout the
> code makes me uncomfortable. Ordinarily, I would expect a simple
>
>     argv_array_push(&args, opt_autostash ? "--autostash" : "--no-autostash");

This looks good. I will change accordingly.

> Stepping back a bit, the only reason why we introduced opt_autostash =
> -1 as a possible value is because we need to detect if
> --[no-]autostash is being used with git-merge. I consider that a
> kludge, because if git-merge supports --autostash as well (possibly in
> the future), then we will not need this -1 value.
>
> So, from that point of view, a -1 value is okay as a workaround, but
> kludges, and hence the -1 value, should be gotten rid off as soon as
> possible.

That right! But until git-merge doesn't support --autostash, it's necessary to
have opt_autostash = -1 as default.

I wonder if it will be a good thing to add the following line to the
commit message
"Changes needed to be introduced:
Change opt_autostash = 0 as default as soon as git-merge supports
--autostash option, also display no error when "git pull --autostash"
is called."

Possibly it would be better to add gmane link of your review in the
commit message
for further clarification.

Thanks,
Mehul
