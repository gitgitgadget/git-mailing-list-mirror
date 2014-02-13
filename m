From: Stefan Zager <szager@chromium.org>
Subject: Re: [PATCH v2] Make the global packed_git variable static to sha1_file.c.
Date: Thu, 13 Feb 2014 15:15:06 -0800
Message-ID: <CAHOQ7J_06UBEgitY7G8DTwvWToq2qfVyRYrzdBos4bsL7i7oew@mail.gmail.com>
References: <52fbc2d6.7kJdh2GOdWTzNcPK%szager@chromium.org>
	<xmqqioskm3l6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 00:15:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE5Uy-0002Dr-FV
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 00:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaBMXPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 18:15:09 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:41656 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaBMXPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 18:15:07 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so13614525oag.40
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 15:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/zXDalaISLUJN3PNEyDc1VTtvV345yR9uVb2mizGAjk=;
        b=Of7a0PCtC8ClBW3EBRzYqyxfayvwRPwFty2XseKyCpCwBosTU9MvIrzk8D1B9cfb3l
         EP1FWpeei1jxfcPyFRHMnk8940xoVfdcJtoiPn11VXm8aJXcY1oBPx1pZ8Ayi+AYCLdj
         UmBR57ptBeARUpsIMOpGWdwDFCUmxek8yy7OAyal0EcTixg+REGUnXpP4QkHX3upSfz4
         YVQ9bYPKoCOb1C6yY42eypuhfxp8WQlgAjRGQILYMOGebvAftrhK2Jv4tO5JOTzXamGW
         oRXh06+GT45ZLC5MSYY8Yxk1OGJLb7EhPW5D+y8WB4xdSkM98tBk9/csHpyzp6d/hwsp
         DDIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/zXDalaISLUJN3PNEyDc1VTtvV345yR9uVb2mizGAjk=;
        b=FNLHmZ0nCwepUbHw73Ry3iDZN022aK90lDd9ngXJe6L1sT1bTnkzyDO0TNSFw1laQ9
         GzSnki7wGwMMwNuXrS6TAWDbBL+eIuxBCOS8vxMfzaooBV0VAX8STgpFCnqUgiJhiIkR
         pjlnoYA1n24FrSz2wRJrM2fMsCF5TMvKJZSKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/zXDalaISLUJN3PNEyDc1VTtvV345yR9uVb2mizGAjk=;
        b=AFLAObzke5kh8VMm2/b1p7B8fM8w3iBwsQzYLesHVIzeVZfBlcJ1LfMm9yRLnnKmdW
         R8akeOkuA214lA4AoCMjL00rJjIOcOJA4/iu3i8niPs81sOIUsn7NDNDsb6vqj8CL3W5
         We6LE4EsIhPqRGnLp9Mx+wubLJLphUraXJGqU7wVHHr3gitW0ok3RaRUbqphvs5mtBxB
         yCwtaktpZVT4GPwEBUEkkiXZBQqGvtlwYZTPU/Hl1sqMZM6Vto/k+5UWeaisXdZzlxj0
         RZeRYYKNaF03LW9Yv0++a/d5z+Qz8JDSBu4QKNbLzy/19YQP7WVFmQ/YsNRyHVNJRA0+
         00lQ==
X-Gm-Message-State: ALoCoQnQjm9WupMOsHGMnTsp8UG13EVC+eLmSyhRfsKt5xraP1rXGQQ7cHQN2vumB+/NA86+4eKB2AZl9aKKfTLGH+9wSF4hxz3yMi4+J0F1hKUVfnQrrdnx2c5p/YPkUfo8MjnrRVs+68du4dQnnUcS3HK7W5EdxCEElxxJoOfjeyvD7vipfaMuOz2yJga9Unp0SJtPQesl
X-Received: by 10.182.142.5 with SMTP id rs5mr3468206obb.39.1392333307089;
 Thu, 13 Feb 2014 15:15:07 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Thu, 13 Feb 2014 15:15:06 -0800 (PST)
In-Reply-To: <xmqqioskm3l6.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: FhDsxkMmylsqMABKPDg00xEpKEc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242086>

I uploaded a new patch; a few comments inline below...

On Wed, Feb 12, 2014 at 1:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> szager@chromium.org writes:
>
> Also I'd suggest s/pack_data_fn/collect_pack_data/ or something.
> "_fn" may be a good suffix for typedef'ed typename used in a
> callback function, but for a concrete function, it only adds noise
> without giving us anything new.

Fixed this everywhere.

>>  static struct cached_object *find_cached_object(const unsigned char *sha1)
>> @@ -468,7 +469,6 @@ static unsigned int pack_open_fds;
>>  static unsigned int pack_max_fds;
>>  static size_t peak_pack_mapped;
>>  static size_t pack_mapped;
>> -struct packed_git *packed_git;
>
> Hmm, any particular reason why only this variable and not others are
> moved up?

No, just need packed_git declared before use.  I moved all the static
variables up, for clarity.

>> +     foreach_packed_git(find_pack_fn, NULL, &fpd);
>> +     if (fpd.found_pack && !exclude &&
>> +         (incremental ||
>> +          (local && fpd.found_non_local_pack) ||
>> +          (ignore_packed_keep && fpd.found_pack_keep)))
>> +             return 0;
>
> When told to do --incremental, we used to return 0 from this
> function immediately once we find the object in one pack, without
> going thru the list of packs.  Now we let foreach to loop thru all
> of them and then return 0.  Does this difference matter?  A similar
> difference may exist for local/keep but I did not think it through.

Fixed.



Thanks,

Stefan
