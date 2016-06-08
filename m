From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Wed, 8 Jun 2016 23:34:58 +0530
Message-ID: <CAFZEwPO+E7zzPoBnEbfZtW1RfXWzTbzAGzE_WXW8BNfhTb+urw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
 <CAFZEwPMJbKAOdffWs7QedB+4j32LaBZeV1iGpUuGntMjXeN3hg@mail.gmail.com>
 <CAPig+cTiqRAnhBx6eCifdOmES1uD3piPYgsRHNMVFCO07W1nTg@mail.gmail.com>
 <CAP8UFD0Q7WnKpoY76w5Lqr4P6fCo4KboiwfrZ-L+q+h5Lhysjw@mail.gmail.com> <CAPig+cQ5z+-59BCjPXNaSQWkSyTt56yAnRo49Lba6_wjkWRp-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:10:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhqq-0001Ol-O5
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699AbcFHSFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:05:01 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35663 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615AbcFHSFA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:05:00 -0400
Received: by mail-yw0-f182.google.com with SMTP id o16so15085982ywd.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dwfd1g3t9pLh9lh1Bn0HTL3A9TZnhMl4VnJzCColVtk=;
        b=flt94+SiyBBLk92gK3oP2qKjvQmoZ6huYSysKV1iLBOs5ps6gEefSA0qDdbEZr/CKG
         6e4RWQ8XbLjWGZtUGEKGfDl/yvfzY268gTRdgo0ayO5hpXUhO8LPUcyCB8NagGmq6uiu
         EAqeW/6ZQ0KC6KcjA//hifX3WY9RMR4WPWh1azcMhPMpKSgLO/FfEpbq5A5Or+SVXlut
         kQT3P2tMV1PZoc3lXTEqkJ6zI2ZCvVahj3cY26/bx4gTaCBIqsd9Offa7EzNuirzcZcP
         yBZ5baAAVaOFUgd4c/6OcHl5QmXTe9VQ152RIFk4d6do462bnlUURG9Ds1f+KkkV/Y9s
         oQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dwfd1g3t9pLh9lh1Bn0HTL3A9TZnhMl4VnJzCColVtk=;
        b=YQlTm5Fn75anGrw9i8IE3Y1YopofnFfuuEzWqxd8xwBeVKbDdxB4jBiOVgfV4P576L
         u4XV3cLmSh+0x+HpUHp/QxMhaKGNnQvoviTTsOI4NB1v7UFXXkOo3vzvj9nXecHproyH
         8aijOsgAWsB1hWRtHhJvOuJXlhSyZqPif+vS2GrAcTB4SqnRNNEuXFzffkUKxrviofJ/
         AWfy8IjJWl2AtYrxZnc9NasPtiVEHfFGKEBw5kTNAYYu9a06pYUIFoGwGxi++1Tu31If
         B7Nwg3ssfINX5RKitFA0OUD32XzsULhGsZJS1I/7Cscxrhjnp2eyIXMox4CV8fSvJQ6b
         qLgA==
X-Gm-Message-State: ALyK8tJTZgxia09s4dY8/yP9YxPbFLT/fx1fRSvnx3xCVYZccw3VVSFkE6xcMEMiCWQwM7C0UbFX83hT1QXoPw==
X-Received: by 10.37.57.143 with SMTP id g137mr3437489yba.131.1465409099415;
 Wed, 08 Jun 2016 11:04:59 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 11:04:58 -0700 (PDT)
In-Reply-To: <CAPig+cQ5z+-59BCjPXNaSQWkSyTt56yAnRo49Lba6_wjkWRp-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296822>

Hey Eric,

On Wed, Jun 8, 2016 at 11:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 5:41 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Wed, Jun 8, 2016 at 10:02 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Jun 8, 2016 at 3:46 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> On Wed, Jun 8, 2016 at 4:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>>>> +       struct string_list *refs = cb_data;
>>>>>> +       char *ref = xstrfmt("refs/bisect/%s", refname);
>>>>>
>>>>> Here you're allocating a string...
>>>>>
>>>>>> +       string_list_append(refs, ref);
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +int bisect_clean_state(void)
>>>>>> +{
>>>>>> +       int result = 0;
>>>>>> +       struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>>>>>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>>>>>
>>>>> ...and the allocated string gets inserted into a string_list which
>>>>> itself duplicates the string (STRING_LIST_INIT_DUP), so this is
>>>>> leaking the string you created with xstrfmt(), isn't it?
>>>>
>>>> Yes nice catch. I would prefer using the string_list with
>>>> STRING_LIST_INIT_DUP and free the ref.
>>>
>>> That's unnecessarily wasteful. Better would be to to use STRING_LIST_INIT_NODUP.
>>
>> In this case it is not possible to append "BISECT_HEAD" to
>> 'refs_for_removal' before calling delete_refs() like this:
>>
>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *)
>> &refs_for_removal);
>> +       string_list_append(&refs_for_removal, "BISECT_HEAD");
>> +       result = delete_refs(&refs_for_removal);
>> +       string_list_clear(&refs_for_removal, 0);
>>
>> And I think it's better to delete all the refs in the same call to
>> delete_refs().
>
> string_list_append(&..., xstrdup("BISECT_HEAD"));
>
> perhaps?

Seems reasonable!

Regards,
Pranit Bauva
