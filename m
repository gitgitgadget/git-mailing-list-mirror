From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 2/2] Testing the new code
Date: Mon, 3 Aug 2015 09:23:11 -0700
Message-ID: <CAGZ79kYBvQ9vfmDNs2_WTLU0OrHShS7_fLnjHgYxX9C29PdDsA@mail.gmail.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
	<1438384147-3275-3-git-send-email-sbeller@google.com>
	<xmqqio8zakhv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 18:23:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMIWH-0004y6-SD
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 18:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbbHCQXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 12:23:15 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36650 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbbHCQXM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 12:23:12 -0400
Received: by ykeo23 with SMTP id o23so17829060yke.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BHjkEVGdlC7PpdEBZMJBTxX/STgjLgClBw7e9oI7bIY=;
        b=TZBZKNhDKe5tOb++LESMQnxOFwu6rHczzOBBwzUn77Rx5iAeh8Spdz3jD4WpyiBICS
         fGySKfpMFWubgRT2clxj2zQejJ4zjg6JYA7hogbrnT+AjMWw7SQfwOJT4T4b1P2bNgWH
         SlcuGFcLQQyJC2QBxDwTXEyyBpTdMJlAt2K4xxxiJS4k0jueKDAc5hJOpz3lnuu7Q6Hv
         V5XvkcfoDz67o9vO/bNmDb/xBxO6uWKCo4LxJfOPK47Pz4UkiVU3eSbeh2gRrGURcvrQ
         HOOX5e3oGNj39PSSfxWY7ApG4iRN/5HMSBuuXYTL1e/qqqH1UP8WM9Mwb5o0LOFgB8Mp
         Q4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BHjkEVGdlC7PpdEBZMJBTxX/STgjLgClBw7e9oI7bIY=;
        b=HsmEoEyKsahiD4nDHvzSrhBUym41WykT41yAhvzv2tr9DPCtG/RkVzSuLalUIj366F
         a+ZUepFUzQhmhlvT7WRjHVUCjYZVDrIV8XZVBNENUet3a8q7MFj4frzi+WbvV62NrCnL
         MfRUtePqSsh2b865XezCBLo/DJsRJZlO0Vn9E0lETz7YRggZeSGkyMfxcFhjhvORlZMR
         mp1Mrjv9Tu2I6TUsKNsIoqlJNhyvRj5PYFN2YcQtfB2rgq7/x4q/3o+g/7/vQnLh9Hnq
         4i5Kel7kkpscpxXoKvzigEsKeV5Q9Pboo/QMm5aZiA/ugpIQVwp26lVybwpfunpX0H4w
         hwqQ==
X-Gm-Message-State: ALoCoQkPWJPkd8iQuPxg4B+zclEo3OnrJ9iVJCdbVtWcgAi5B+sbkhD1ot4P9LS+kLpx0HW3jLfJ
X-Received: by 10.129.116.134 with SMTP id p128mr21274701ywc.1.1438618991677;
 Mon, 03 Aug 2015 09:23:11 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 3 Aug 2015 09:23:11 -0700 (PDT)
In-Reply-To: <xmqqio8zakhv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275171>

On Fri, Jul 31, 2015 at 6:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> -module_list()
>> +module_list_shell()
>>  {
>>       eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
>>       (
>> @@ -187,6 +187,29 @@ module_list()
>>       '
>>  }
>>
>> +module_list()
>> +{
>> +     # call both the old and new code
>> +     module_list_shell $@ >/u/git_submodule_module_list_shell 2>/u/git_submodule_module_list_shell2
>> +     git submodule--helper --module_list $@ >/u/git_submodule_module_list 2>/u/git_submodule_module_list2
>
> You seem to be discarding the double-quote around $@ in both of
> these two places.  Intended?

No, not at all. This was a bit sloppy.
This patch was rather showing off how I intend to test the previous patch.
The idea came from a talk[1] at oscon which presented refactoring code with
this differential strategy (except that they used it on a larger code base and
collected the diffs between the new and old code for a while in production
instead of just relying on the test suite passing).

[1] http://www.oscon.com/open-source-2015/public/schedule/detail/41888
