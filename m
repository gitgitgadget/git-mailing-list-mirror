From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/10] ref-filter: make %(upstream:track) prints
 "[gone]" for invalid upstreams
Date: Sat, 10 Oct 2015 23:49:10 +0530
Message-ID: <CAOLa=ZTvD5cXduPH3G0bGDba_hevLQsuwYsoZFtmfTd2SS4Prw@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-8-git-send-email-Karthik.188@gmail.com> <vpqa8rtnqzp.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 10 20:19:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkykC-0006W9-PG
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 20:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbbJJSTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 14:19:41 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35554 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbJJSTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 14:19:40 -0400
Received: by vkha6 with SMTP id a6so11297780vkh.2
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7qFZwsP05UKIPEA/D3HLDGOkkTurQvvN8Vb3Y+/XzoY=;
        b=nLwNGsaxI3QWQqK8DkOyHP0vs3K5Dq9x0qk9U6TKDC0KXvelHrx82LHzXOtTUM/YxC
         VtUUAXzafZzpit2SEM47Xd1oLBRroMlQBKAhwthiaUctLEIAYxslEkD9TK9661dsK9Su
         /DEQvhaGkYegpmOOKi2BWg4rT+Esx8qfWzF/OrjnnlR4ZV5q//SF9QLFJ70JUs3+ZKR/
         Z1Vbiz/8dTAFozXNK9LjPmXFAtrcqzmNvSSGZb2QJnr3b0PGLTQdiYEuRzUlH6dZ6MVW
         N8RIBeLJPMDqB0m/40KwWiFXB+BFZj7nFENi5xIqXIqM3oe9yL5nM9huBwXZOZqwYlTu
         5MKQ==
X-Received: by 10.31.173.136 with SMTP id w130mr12995137vke.72.1444501179739;
 Sat, 10 Oct 2015 11:19:39 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 10 Oct 2015 11:19:10 -0700 (PDT)
In-Reply-To: <vpqa8rtnqzp.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279330>

On Fri, Oct 9, 2015 at 12:10 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1118,8 +1118,10 @@ static void populate_value(struct ref_array_item *ref)
>>                               char buf[40];
>>
>>                               if (stat_tracking_info(branch, &num_ours,
>> -                                                    &num_theirs, NULL))
>> +                                                    &num_theirs, NULL)) {
>> +                                     v->s = "[gone]";
>
> My remark about translation still holds. The string was previously
> translated in "branch" and you are removing this translation (well, not
> here, but when 09/10 starts using this code).
>

I should have mentioned in my cover letter, I didn't really understand
what has to be done about this, couldn't find much reference to go
about this. What do you suggest?

-- 
Regards,
Karthik Nayak
