From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-import: do not truncate exported marks file
Date: Tue, 17 May 2016 23:03:41 -0500
Message-ID: <CAMP44s06+V8_PvYA=wsqZ625hrMPLKuZ6v5eOmLBO97kTqwxvw@mail.gmail.com>
References: <1463521223-14565-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq1t50uxy1.fsf@gitster.mtv.corp.google.com>
	<CAMP44s1WDzRAFV8iNj_RYiiRwJdBcuUDVR-Ew5FF37qdpEO5Mg@mail.gmail.com>
	<CAPc5daVJCfnEfA1sHrAGsXaA-80kFV4_4Hd0tLOMocE+qVV=-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-fc <git-fc@googlegroups.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 06:03:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2si2-0000Dd-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 06:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbcEREDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 00:03:43 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34468 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcEREDm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 00:03:42 -0400
Received: by mail-vk0-f45.google.com with SMTP id c189so46080419vkb.1
        for <git@vger.kernel.org>; Tue, 17 May 2016 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=dDKxWgtcdl33TqqQBtHB4nOFuV94crrWR6H08jEQ6xI=;
        b=Voca8xahDAlcRbtSXboDlkGRr777QcXh7xmBV84tXYO4pv+J3c6WP5RnBgwnULx7Mz
         aVspiss7NMs1wCQ8H7BWaIkK5NDo+BkpQHVWCKoCwDxTyq4B/1ldY8WJuK4QPgd1onkl
         SxXsAEy4YyjltuQCD6d37HpWVWE/PbnWIw07MKoxBr6m6vZynCa9BntLbQ78ob2trdSc
         WZZga2Q2VxrqWXUPNeJFXTaZxxFTft8vCKe0QJy1FSp46lkAvdTpyOwO+DMA8FNWaKFH
         BIt5soeaag+FBNj2TbvzT+1iKxFbr5nxqQ/NY4A0qq7sNfM8spPwg37nQQewy+fZn7EQ
         z/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dDKxWgtcdl33TqqQBtHB4nOFuV94crrWR6H08jEQ6xI=;
        b=GTifS1phqJVxsXu43tS7h7LLTbihWjdBy7WtTchISAklBE8NmqtO/Okn7z/WRWYbHL
         c/DD8uEDfnk7Q1O8qg/uGXbHmK1fG07rr3DTQTFNbE5MYY4ypd9sQeakFHR/7iDWc5kl
         aWwpyDm/2C3CGzk/RNNnX19OsNQLrX5CMjnxr+Q55BAcIXsaCHKJIqlIjYVsUWnSxcKI
         ZgwrdPh45LCHdTMT5NSpKq6hJZiHFSW5pAjI+GHv8NLmnF5eC0wyrb/ciBZlTkZUd23O
         xbFLnFr6IB493rW48sUCo5jrEL7GXMHs7grOqNf//08YWjEnr7UkUQerSc3pIjspEK7v
         IDrw==
X-Gm-Message-State: AOPr4FUBadXldUOvJqtSizsdDkZ0lmt/E0pyGTD44ISZxDnZHy7hwO2mgyKYBBxNu62kFPi1tngqQYjm6e6tCg==
X-Received: by 10.31.188.73 with SMTP id m70mr2792557vkf.70.1463544221270;
 Tue, 17 May 2016 21:03:41 -0700 (PDT)
Received: by 10.31.192.137 with HTTP; Tue, 17 May 2016 21:03:41 -0700 (PDT)
In-Reply-To: <CAPc5daVJCfnEfA1sHrAGsXaA-80kFV4_4Hd0tLOMocE+qVV=-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294931>

On Tue, May 17, 2016 at 10:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Tue, May 17, 2016 at 8:31 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, May 17, 2016 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>>  - Even if we did not read from any existing marks file, if we are
>>>    given export_marks_file that names an existing file, wouldn't we
>>>    want to avoid corrupting it with a dump from this aborted run?
>>
>> If we don't run from an existing marks file, this patch has no effect.
>
> Yes, that is exactly what I was wondering if we may want to improve
> while at it.

This doesn't make much sense. Corrupted from where? This patch is
tackling the issue where the imported marks file is "corrupted".

-- 
Felipe Contreras
