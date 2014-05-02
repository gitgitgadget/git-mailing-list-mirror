From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 20/42] fetch.c: clear errno before calling functions
 that might set it
Date: Fri, 2 May 2014 07:48:16 -0700
Message-ID: <CAL=YDW=CEQedqJ2S=MrPG3YnavJVyVYg_X7FbE3QwpNDQ3Ofhw@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-21-git-send-email-sahlberg@google.com>
	<CAPig+cRa55472sncNsBnweR9Dj2HwTttu4t3GLP8buoTK59DyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 02 16:48:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgElB-0004DX-S9
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 16:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbaEBOsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 10:48:18 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50280 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaEBOsR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 10:48:17 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so5263275obb.5
        for <git@vger.kernel.org>; Fri, 02 May 2014 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=azlqu1G1CAqbC6ARPuueYPgYZKGmSL5fhUCpI5TbSyo=;
        b=KULotcqRpiTi7yxYl4gA0njahwWkggXIguBKGVKzL7KqbwT6iG3N35REIFw4RaXOD3
         2FkrsntlZWl3r1Pq5TgRnP6pwEwueJmPZhZ/Ivkxkfn1hZ2ATcEUdWuGuMJ82JyTIDc/
         8ouwZE2bfnidnKHR94fg7NMhOLfmghxEp6hX60OQxGHa3SU3WRErFIB7+m33jdIznphZ
         D/ddSSbhkuBzpKs8h7XQwYaHN/4lqQxluTVQRWdeEuEVrvPHjnBPyc8YxiinN9u2mWaT
         9FZc64MFzOYPKsPzs3+178rHduj/AbS0KI21AI0xJkoIRRXW2dmRW0MeBgqIgbu41TaX
         qZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=azlqu1G1CAqbC6ARPuueYPgYZKGmSL5fhUCpI5TbSyo=;
        b=If40bABRIvAL7ii6StsXFZxSnO0keTtHLnFG3PBswG7WcEVbwXy+PQ1WuTr2DPdDMA
         /jGXK+BLdE71rzjRBFSnXlUJ5CpvzIm61lBZPky5VEqYJTkoJZ1Bo6bDkEib3XX9u299
         kJGTiP1CZkU1pAEWm6jO2x7PveBT9LDvSRjHXz3Q/tVLrq7WCkUCmgPbv00C7aQSLgEk
         Q5F0U2BibAP2o7EUykqWdMZSvetL6rJ4PLSQ1Ej9m6ZuPhB4pgTgVxQk68CMDU97RAuW
         f6/ekigaiGUwoxncr8Ey1Ru7p+SDzB2fkxvpzv2D6Gb9JWJnlpxrGKGd0qCxb3abjj9m
         P1ZQ==
X-Gm-Message-State: ALoCoQnIcpLPemwFlSKnTjqGYt11xJDV3/uB4T7i0VwAmyQL/Ueg4ZIOz7wGuh1obF46hwExyked
X-Received: by 10.60.57.164 with SMTP id j4mr17356095oeq.24.1399042096470;
 Fri, 02 May 2014 07:48:16 -0700 (PDT)
Received: by 10.182.108.35 with HTTP; Fri, 2 May 2014 07:48:16 -0700 (PDT)
In-Reply-To: <CAPig+cRa55472sncNsBnweR9Dj2HwTttu4t3GLP8buoTK59DyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247935>

Fixed. Thanks.

On Thu, May 1, 2014 at 9:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, May 1, 2014 at 4:37 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> In s_update_ref there are two calls that when they fail we return an error
>> based on the errno value. In particular we want to return a specific error
>> if ENOTDIR happened. Both these functions do have failure modes where they
>> may return an error without updating errno, in which case a previous and
>> unrelated ENOTDIT may cause us to return the wrong error. Clear errno before
>
> s/ENOTDIT/ENOTDIR/
>
>> calling any functions if we check errno afterwards.
>>
>> Also skip initializing a static variable to 0. Statics live in .bss and
>> are all automatically initialized to 0.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/fetch.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 55f457c..a93c893 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -44,7 +44,7 @@ static struct transport *gtransport;
>>  static struct transport *gsecondary;
>>  static const char *submodule_prefix = "";
>>  static const char *recurse_submodules_default;
>> -static int shown_url = 0;
>> +static int shown_url;
>>
>>  static int option_parse_recurse_submodules(const struct option *opt,
>>                                    const char *arg, int unset)
>> @@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
>>         if (!rla)
>>                 rla = default_rla.buf;
>>         snprintf(msg, sizeof(msg), "%s: %s", rla, action);
>> +
>> +       errno = 0;
>>         lock = lock_any_ref_for_update(ref->name,
>>                                        check_old ? ref->old_sha1 : NULL,
>>                                        0, NULL);
>> --
>> 2.0.0.rc1.351.g4d2c8e4
