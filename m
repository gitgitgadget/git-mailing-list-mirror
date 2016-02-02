From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 03/12] ref-filter: bump 'used_atom' and related code to
 the top
Date: Wed, 3 Feb 2016 00:20:19 +0530
Message-ID: <CAOLa=ZRcsR4t8MEUuMibbN=SLs3PXCpgDhsh3HafAcGLEzHo5Q@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-4-git-send-email-Karthik.188@gmail.com> <xmqqvb68t6j6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:50:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQg2Q-0007Un-3v
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 19:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbcBBSuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 13:50:50 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36441 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933805AbcBBSut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 13:50:49 -0500
Received: by mail-vk0-f54.google.com with SMTP id n1so104102572vkb.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lUP88IdhXOl9YXjToU0oYdm15jpm1H8MrWMH6eWbkd4=;
        b=0tcQqAI5uqrfunaEtR73TPq40OTjdPUcRDvUdeYx+ewNYNWMF+LQQyYL7ST77qFAub
         DB0jsLC9yuTtC2+xbCFUHCnfn7Dmn7W9yfj7YMMY2BXlme9QEKMYyhMD9rHmeuk4vaAT
         kKhsNFLKbFhYw0UH574GxdPZZF9sszWPA4LI7lzqTOZy8Or3bSAMxBE9/ijDzK2Kv6Q/
         6xlYaIOpedraO9pSIEOFqDGaKSRdG8jqjPrPKBaBufFJh8jyAVVTtzMcEItj8AZlvJBX
         kQlf7YLjUIiLdWPTGjfnhxB7M7rPNfsLcQpkJbpk/dcd3b91Lz8DSnOpIM/Bu+nJEBUb
         AK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=lUP88IdhXOl9YXjToU0oYdm15jpm1H8MrWMH6eWbkd4=;
        b=X4wZArvwXXQ8SE8FiBgFluq9x1WhCWaXftYQmXoYyMavzfliCwNvAMk2FbFn42BHXQ
         d9sHxxVKsAVyiURVJhT2f1EQ6p1wBPDovWAhWGcmZM/4VIe2BIaYOUJk+scpCwvYAWJZ
         9lcbgYfa/hgTrCnfZmrK+QPbXQv72jsiU/ZU7g9lQNdBcLctvMXL595Ae+eA5Wi9Qrkc
         jEIMOCcTCH6dEF/ubdJRpidQCghsk/z8iB/YgGtxLvJvfe9jIBFC/XQqx/ef/eLgL27K
         GhLoGk1jjJ+CaNyFYjeR8PhuIOPgA/oHd/vp3UqNPPaBbrLYwTuESCQ5q7PCu3a3qLcX
         FjvA==
X-Gm-Message-State: AG10YOTQYIBU1M23X4zInm2u+vBMoCukLwuTkamXf8PivuyLmwgqiJcB3S1Ojr7yCU9h4On9wkLNtbJ6fSgZnQ==
X-Received: by 10.31.54.75 with SMTP id d72mr20545386vka.30.1454439048332;
 Tue, 02 Feb 2016 10:50:48 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Tue, 2 Feb 2016 10:50:19 -0800 (PST)
In-Reply-To: <xmqqvb68t6j6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285296>

On Tue, Feb 2, 2016 at 3:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Bump code to the top for usage in further patches.
>> ---
>
> Sign-off?

Shall reply with patch, missed that somehow.

>
>>  ref-filter.c | 30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 38f38d4..c3a8372 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -16,6 +16,21 @@
>>
>>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>
>> +/*
>> + * An atom is a valid field atom listed below, possibly prefixed with
>> + * a "*" to denote deref_tag().
>> + *
>> + * We parse given format string and sort specifiers, and make a list
>> + * of properties that we need to extract out of objects.  ref_array_item
>> + * structure will hold an array of values extracted that can be
>> + * indexed with the "atom number", which is an index into this
>> + * array.
>> + */
>> +static const char **used_atom;
>> +static cmp_type *used_atom_type;
>> +static int used_atom_cnt, need_tagged, need_symref;
>> +static int need_color_reset_at_eol;
>> +
>>  static struct {
>>       const char *name;
>>       cmp_type cmp_type;
>> @@ -92,21 +107,6 @@ struct atom_value {
>>  };
>>
>>  /*
>> - * An atom is a valid field atom listed above, possibly prefixed with
>> - * a "*" to denote deref_tag().
>> - *
>> - * We parse given format string and sort specifiers, and make a list
>> - * of properties that we need to extract out of objects.  ref_array_item
>> - * structure will hold an array of values extracted that can be
>> - * indexed with the "atom number", which is an index into this
>> - * array.
>> - */
>> -static const char **used_atom;
>> -static cmp_type *used_atom_type;
>> -static int used_atom_cnt, need_tagged, need_symref;
>> -static int need_color_reset_at_eol;
>> -
>> -/*
>>   * Used to parse format string and sort specifiers
>>   */
>>  int parse_ref_filter_atom(const char *atom, const char *ep)



-- 
Regards,
Karthik Nayak
