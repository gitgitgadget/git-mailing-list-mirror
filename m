From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 09/11] ref-filter: move code from 'for-each-ref'
Date: Mon, 08 Jun 2015 11:08:58 -0700
Message-ID: <xmqqh9qiax8l.fsf@gitster.dls.corp.google.com>
References: <1433598496-31287-9-git-send-email-karthik.188@gmail.com>
	<1433673294-16243-1-git-send-email-karthik.188@gmail.com>
	<vpq4mmiw2jy.fsf@anie.imag.fr> <5575CD35.4030705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:10:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z21Ul-00060v-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbbFHSJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:09:09 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34849 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234AbbFHSJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:09:00 -0400
Received: by iesa3 with SMTP id a3so103722006ies.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KUW9QeaNW4x4AqzQn+LgibXbWULaLZekvxE+7FTIwdg=;
        b=GjjVQLyL2xRK42Du8LGBPphLeOBpIQNzqXYtTsewsuIasGIIAc6J289rFFi2cEf8S2
         fKu5qrG4nSVCQcGL2XwcoSJw/61GOeKg+YsAxz3u9SA1JmoW62UY+FRptIbqTP6rmY/P
         kPwjD38ZOshDbT6K2TSeWABkT3QahCvJVxO45MbTjfD7f9eEjpZKCaMpFuKcjGWm2B/c
         jZDsJYZOvwDwaGhPZOytB/YVU4nW1JmO53JrHbMtXOrbHtXwMUhZMI/QlxEPzmQ4qbjS
         ZGJWRtxRe+tGioYhYdBsN8BF8jUpWo/92r/CTcFgE7XS25/DBJgTLRPnIjpqGgJmCxxj
         /KIg==
X-Received: by 10.50.36.73 with SMTP id o9mr15054843igj.25.1433786939865;
        Mon, 08 Jun 2015 11:08:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id 191sm2210869iof.18.2015.06.08.11.08.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 11:08:59 -0700 (PDT)
In-Reply-To: <5575CD35.4030705@gmail.com> (Karthik Nayak's message of "Mon, 08
	Jun 2015 22:43:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271100>

Karthik Nayak <karthik.188@gmail.com> writes:

> On 06/08/2015 10:38 PM, Matthieu Moy wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > --- a/builtin/for-each-ref.c
>> > +++ b/builtin/for-each-ref.c
>> > @@ -1129,7 +56,7 @@ int cmd_for_each_ref(int argc, const char
>> > **argv, const char *prefix)
>> >
>> >       memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>> >       ref_cbdata.filter.name_patterns = argv;
>> > -    for_each_rawref(ref_filter_handler, &ref_cbdata);
>> > +    filter_refs(for_each_rawref, &ref_cbdata);
>>
>> This seems unrelated from the rest of the patch. And you haven't
>> introduced filter_refs yet!
>>
> That definitely is, this happened after fixing merges I suppose.
> Ignore it for now, I'll fix it.

I am not sure which one of two copies of 09/11 is being discussed,
but I'll stop here for now.  Most of the patches up to 08/11 looked
sensible, if the renames were a bit too noisy.

Thanks.
