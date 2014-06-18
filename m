From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v18 11/48] refs.c: make remove_empty_directories alwasy
 set errno to something sane
Date: Wed, 18 Jun 2014 14:41:16 -0700
Message-ID: <CAL=YDWn0NtnjZXeiXKkJHhU1UM0K=0RFwi4g_Ns5kbVfnM1Dhw@mail.gmail.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
	<1403020442-31049-12-git-send-email-sahlberg@google.com>
	<53A1FDD6.3030202@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 18 23:41:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxNbd-0003Ss-Fq
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 23:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbaFRVlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 17:41:17 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:64524 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbaFRVlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 17:41:16 -0400
Received: by mail-ve0-f180.google.com with SMTP id jw12so1477519veb.39
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0So7XqEnbcTMR6h8CNI7oEkTBg95IzI0ZVj/9//kQts=;
        b=AEJOItIU1ThvLgoVp4cTqujdGGCri3EXrhyd4CxvVyQtaB/Pz3hhU2O55Ljc5Qk1GQ
         cUOISCfPd1uQ9/E/ySZ+DwdRProPVdPHTQ6kIlT9vyBPvmHao8/u+mB3lHEMYET84KD0
         Cn0IVfAIQETC1DwXF31lnxCINuMSqjs9CeBjJCPuFlT7LtUFOASd+skuIPdfgASv2KV4
         jSX71XuOr3l+C9R1gSiuBYR2xH5Qte5OOnyJ3gXWR/5Go6EPRsg+IQnfyl+uMvnpUKbl
         joQsG0tEQ/eRRdM57rK9lV92O57eC3VOZ/8/87tm12e96tfDB2arlB4/fcZBZOskR0qr
         fAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0So7XqEnbcTMR6h8CNI7oEkTBg95IzI0ZVj/9//kQts=;
        b=aYIil0T6/MHhHAUaffA+iuC3IRJg1DqGYVC+5Z7XwIZmc4DzYz5heP/teJeoncX3jE
         H4yIi8gLs6fsVMYndAw9IlZyYWkmiFC0EmyQmd0IUP59zF4GhpWlGULqBgunAUXHTY0a
         thO5gmUusrSWW2ftowDG0mWq5CD+67vA9h3FGknwAK+ZdPOpAa7OWJXR/PNH9nnZVvuI
         L9swg1zOIs4o8fhmzMgHLSX456x6Rp5iLegdgOyEYbXILNWhIMt77OVcqOo9qrJXc7vy
         P3YBhUwOAK8Phsy011vx05fr9MqNZ0ckpSvn8pQM1Lc4xrhoXGMQpETOcamPY93k4OZD
         rPYA==
X-Gm-Message-State: ALoCoQmlUFq5zfD7UKZtG3EUsM76APKxeg5l+BTn+GPX5tYG8E5XZTSoZT48O1sFDDoTEcQ0iFtN
X-Received: by 10.58.30.1 with SMTP id o1mr360348veh.37.1403127676074; Wed, 18
 Jun 2014 14:41:16 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Wed, 18 Jun 2014 14:41:16 -0700 (PDT)
In-Reply-To: <53A1FDD6.3030202@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252075>

fixed

Thanks


On Wed, Jun 18, 2014 at 2:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> There is a typo in the commit log subject line:
>
> s/alwasy/always/
>
> Michael
>
> On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
>> Making errno when returning from remove_empty_directories() more
>> obviously meaningful, which should provide some peace of mind for
>> people auditing lock_ref_sha1_basic.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/refs.c b/refs.c
>> index a48f805..cc69581 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1960,14 +1960,16 @@ static int remove_empty_directories(const char *file)
>>        * only empty directories), remove them.
>>        */
>>       struct strbuf path;
>> -     int result;
>> +     int result, save_errno;
>>
>>       strbuf_init(&path, 20);
>>       strbuf_addstr(&path, file);
>>
>>       result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
>> +     save_errno = errno;
>>
>>       strbuf_release(&path);
>> +     errno = save_errno;
>>
>>       return result;
>>  }
>> @@ -2056,6 +2058,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>>       return logs_found;
>>  }
>>
>> +/* This function should make sure errno is meaningful on error */
>>  static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>                                           const unsigned char *old_sha1,
>>                                           int flags, int *type_p)
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
