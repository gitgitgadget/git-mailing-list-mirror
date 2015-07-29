From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the
 presentation layer
Date: Thu, 30 Jul 2015 00:14:14 +0530
Message-ID: <CAOLa=ZSjjmYOBs1=rg_paon0iUYAwEzoL6FVE5sGeydknXa3tg@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
 <vpqbnewxwcx.fsf@anie.imag.fr> <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
 <CA+P7+xrGjeXPg3Fbp3A3gJbFeK2E-CP0uXQHWBb3NbNVUHUe2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 20:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKWLQ-0005nH-Vn
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 20:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbbG2Soo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 14:44:44 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34414 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbG2Soo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 14:44:44 -0400
Received: by obre1 with SMTP id e1so14065152obr.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oZdkkLOR5mL5vaAjhdPklg6xy+aNBqJhGDqpjZJ4lMY=;
        b=ddkX528lhX99b8YX3CWDOd7wCmu8IHV2COhxl2VqAx7IPwcXV/2LBT3HE79jZdqWjb
         DWGKsG1o4crWNyneZyTjil2+Two/5T5E1RNHwgy9DqIZSPNYuvAFjY655DLrKi6TXCqU
         qqDwo/9Db1a0j3Kdd3ELjPwOsrDyWnVzzsi4LeEH/woN0hBavFjypN3BLfRa++341alM
         643D9eMDa/g1RrgiZENpqmMISd5PP5Ug7KcnZhGtWjCnYSZwadSDke2Y5yjdOTk+LE9f
         JKWybs5kJ0aD3j0LlzFQVjOsycGmVfGNxEwlOAt6xxl+gaaSpNAc87xvWwaSgTM/8MUW
         gQ7A==
X-Received: by 10.182.204.38 with SMTP id kv6mr41950553obc.70.1438195483375;
 Wed, 29 Jul 2015 11:44:43 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 11:44:14 -0700 (PDT)
In-Reply-To: <CA+P7+xrGjeXPg3Fbp3A3gJbFeK2E-CP0uXQHWBb3NbNVUHUe2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274934>

On Wed, Jul 29, 2015 at 6:16 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Jul 28, 2015 at 1:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Tue, Jul 28, 2015 at 6:39 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> We check if given ref is the current branch in print_ref_list().  Move
>>>> this check to print_ref_item() where it is checked right before
>>>> printing.
>>>
>>> This means that the '*' and the different color are coded in C, hence
>>> it's not possible to mimick this using "git for-each-ref --format ...".
>>>
>>> I do not consider this as blocking, but I think the ultimate goal should
>>> be to allow this, so that all the goodies of "git branch" can be made
>>> available to other ref-listing commands.
>>>
>>
>> Not sure what you mean here.
>>
>
> He means to make sure that any feature that was in tag, branch,
> for-each-ref, etc should be available as part of ref-filter and in all
> of them
>
> Maybe he misunderstood code or maybe you misunderstood the comment here?
>
> Regards,
> Jake

Ah, I didn't quite understand the first time. Thanks :)

-- 
Regards,
Karthik Nayak
