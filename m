From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 00/13] the refs-transactions-reflog series
Date: Thu, 4 Dec 2014 10:49:09 -0800
Message-ID: <CAGZ79ka9swMKvYpSLC20kj0bj=QWS7syVDtQcOmuT5AC3SO+gw@mail.gmail.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
	<xmqqppbztfzj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:49:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwbSl-0001I5-Qn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbaLDStL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 13:49:11 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:55089 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbaLDStK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 13:49:10 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so15872421ieb.26
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZoCwjCYOFz8m6ymkLUgxdB7Qfw3fLPlYZOWStUVGAo8=;
        b=icY7uT8gRu3GAEmk12iU4RNad/HEFPjZokLLn2NOpaGFVjlmD07CYFWz2B1b4CcBpb
         P2VolxtosjzOFFAqUWOOu3gcbk3+hXq5/EQTTGjIgsRW2/eP32d9bZSO1/rvROAeOJLG
         +2wF+BqE6kEIlo1DybHv+ybsppgTG0cYaZuchpsbjYxU72CxnUyVvy/Dh7H1+dDD+p9j
         Ye80z2tvv82lU4UYhSAT/Wfz70yuNCYBcM/i0xyweBrG2/XQ1t64+AeFoX4Xo69lJPLQ
         yXkbGdnrxsRDcudufut2JQw9K1ovJR9TZkXJVPLYKC3OOZGvkga0tnr4Mq+9a91Tes1x
         MOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZoCwjCYOFz8m6ymkLUgxdB7Qfw3fLPlYZOWStUVGAo8=;
        b=Mip05308Fr5uzE2TsEl8VrgxehRVLb0b/j0ttp9+L9xC5+wuKbHIegucJDGZ6tCgc1
         wNW+pKCC0B4I8FbgjpVIhilydV/PuoaZUK+OQMb5NvyQ+SJ2EJ35pDLRgNRUaAiEnNAq
         /6ZXjxh8KLujHLDmB6w0S1jwLDgsYXgPfeGtR2IENFjuoznXSYve60hfFuy5ZU2MmjFa
         GawHiEZBEnGtLNo2v8ZZZ707p3pE62xT8lXOZW/9EBs5dMkmin2E5AlwZVs/hFGkJNXp
         oape/jAB8x/yS6caCVH/fcFOGzzASCoGSBvnqyU4KwmHPpBUotVz4Piz1fE7fkxqSYPV
         s1rA==
X-Gm-Message-State: ALoCoQlqYmp0OXrL2gR3KVRB9n9LASSRB9WMKTUFbypUWGzAXezzlsLYJT3pM2gKR2ktmuvCailO
X-Received: by 10.42.175.68 with SMTP id az4mr12651111icb.92.1417718949378;
 Thu, 04 Dec 2014 10:49:09 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Thu, 4 Dec 2014 10:49:09 -0800 (PST)
In-Reply-To: <xmqqppbztfzj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260780>

On Thu, Dec 4, 2014 at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This is the whole refs-transactions-reflog series[1],
>> which was in discussion for a bit already. It applies to origin/master.
>>
>> The idea is to have the reflog being part of the transactions, which
>> the refs are already using, so the we're moving towards a database
>> like API in the long run. This makes git easier to maintain as well
>> as opening the possibility to replace the backend with a real database.
>>
>> If you've followed the topic a bit, start reading at patch
>> "[PATCH 06/13] refs.c: add a transaction function to append a reflog"
>> as the first 5 patches have been discussed a lot separately and
>> can be found in origin/pu already[2].
>
>> The first two patches are deduplicating code.
>> The third patch is ripping some code out of log_ref_write and introduces
>> log_ref_write_fd, which does the actual writing.
>> The patches 4+5 are renaming variables for clarity.
>
> Thanks.  It seems that we have a bit of hashing out the approaches
> that is necessary between Michael's and this one.  I'll refrain from
> picking this up for today (even though I would read it through as
> time permits).  It might turn out to be necessary to drop those five
> early patches from my tree when this series gets rerolled to take
> input from the alternative Michael's working on, but that droppage
> does not have to happen today.
>

Ok, let's see how Michaels series evolves and if I can base the
transactions series
on that afterwards. Michael has picked up 3 out the 5 patches to get
his series started,
so maybe we can resolve it nicely.
