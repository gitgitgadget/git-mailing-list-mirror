From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/11] ref-filter: add parse_opt_merge_filter()
Date: Sun, 14 Jun 2015 12:19:38 +0530
Message-ID: <CAOLa=ZRJeajtHOMjvtVjdK1cCh8w4c8PJTxgGFEXbs1V0NKkTw@mail.gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
 <1434226706-3764-1-git-send-email-karthik.188@gmail.com> <1434226706-3764-5-git-send-email-karthik.188@gmail.com>
 <CAP8UFD1Qw+ctvz_CbBoE-jb5_bC3jogAsTgp-mgkVBFG1y7SiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 08:50:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z41kA-00022u-A0
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 08:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbbFNGuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 02:50:01 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34568 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbbFNGt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 02:49:59 -0400
Received: by obbsn1 with SMTP id sn1so45870196obb.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P1WnTjnqJ5Cmtszopw7PyWj5RjDDRX+GBkMi9fFpAwk=;
        b=fZOvSfp8busyyxEU7k4KuCDmmcV3qFyC/ApaHSvJDLlBiSSgFEmvr9AVU+DbXQzq+m
         UNLAdgYTyjGf5dSkP8rQ5ajiEq8P+B8ueyFzcbTIwTaWqW/rk4H10vBQgOcTiEaM3SLU
         Sme9Zt1AZVAOmnEIAlk5T1rZG0ccUCAA2UqkwhlQjTrze8UslRcLuR56mq0JwtiG5hBd
         RYvxBwQmnhkOaWNm/sq47wJeBmR+jPBnRHcH2ZGY6x0YwQ1b9uQ/0hI9y3Fc90RnelsV
         nxGs09hx3OYxR8XPyAdIESIsEVVFImSf6rkXwmUQJ2CwmHWV8n0uL0GUzApffsH1Nsi3
         2pKQ==
X-Received: by 10.182.128.6 with SMTP id nk6mr18960134obb.70.1434264598863;
 Sat, 13 Jun 2015 23:49:58 -0700 (PDT)
Received: by 10.182.28.5 with HTTP; Sat, 13 Jun 2015 23:49:38 -0700 (PDT)
In-Reply-To: <CAP8UFD1Qw+ctvz_CbBoE-jb5_bC3jogAsTgp-mgkVBFG1y7SiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271606>

On Sun, Jun 14, 2015 at 11:19 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Jun 13, 2015 at 10:18 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> diff --git a/ref-filter.h b/ref-filter.h
>> index c2856b8..799e118 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -50,6 +50,18 @@ struct ref_filter_cbdata {
>>         struct ref_filter *filter;
>>  };
>>
>> +/*  Macros for checking --merged and --no-merged options */
>> +#define OPT_NO_MERGED(filter, h) \
>> +       { OPTION_CALLBACK, 0, "no-merged", (filter), N_("commit"), (h), \
>> +         PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
>> +         parse_opt_merge_filter, (intptr_t) "HEAD" \
>> +       }
>> +#define OPT_MERGED(filter, h) \
>> +       { OPTION_CALLBACK, 0, "merged", (filter), N_("commit"), (h), \
>> +         PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
>> +         parse_opt_merge_filter, (intptr_t) "HEAD" \
>> +       }
>
> Could you reduce the redundancy in these 2 macros?

Yes, will do!

-- 
Regards,
Karthik Nayak
