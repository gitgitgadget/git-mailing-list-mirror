From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] branch: colour upstream branches
Date: Sun, 14 Apr 2013 21:27:05 -0500
Message-ID: <CAMP44s0wLH0hyrj9xSn+LDS=nLbWuHavNeXv_U4NSYWyK5WncA@mail.gmail.com>
References: <1365982707-25455-1-git-send-email-felipe.contreras@gmail.com>
	<20130415004746.GA6477@sigill.intra.peff.net>
	<7vd2tw4l2e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 04:27:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URZ8U-0003Lc-6W
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 04:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472Ab3DOC1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 22:27:08 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:38564 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab3DOC1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 22:27:07 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so4088890lbi.39
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 19:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=D6BrtEA5tlREtqPbRpfrCYT1CyLZCyaDIZNREVPc/K8=;
        b=xQ1VBdNsx8ZLSLsDCXr3sQv4TMniEpYPCdPMjDalniGOkyP8IJIiJkqz06eezEhEok
         hNybJNWGthEokMotT3dtfzx1iKHjvEoXqyKsgAJrOZEvkdZpXqsFYJ4m6VTEe3i2rr5y
         oNDOK4yUSRSwOjQjWqzVSNMUJDVi2LnEIUKwJrTInkocCcmBqxrQO0NavYUrsPQp6N45
         Cm5bGFJGhjrLLKq/UTJZ363qJyjDG6CmnUkVeD/b7agV2gx24ZB4yWeKCQc0zJbFfPEX
         9r3IyPA1orrMfsnNi/ETFWc2XpBe3AHlxhOxbcKzecz8aV7bZ20dyt1WJ7zjPnB6ztdl
         s3iw==
X-Received: by 10.112.133.198 with SMTP id pe6mr9344146lbb.103.1365992825940;
 Sun, 14 Apr 2013 19:27:05 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Sun, 14 Apr 2013 19:27:05 -0700 (PDT)
In-Reply-To: <7vd2tw4l2e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221183>

On Sun, Apr 14, 2013 at 8:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sun, Apr 14, 2013 at 06:38:27PM -0500, Felipe Contreras wrote:
>>
>>> +            if (want_color(branch_use_color))
>>> +                    snprintf(fancy, sizeof(fancy), "%s%s%s",
>>> +                                    branch_get_color(BRANCH_COLOR_UPSTREAM),
>>> +                                    ref, branch_get_color(BRANCH_COLOR_RESET));
>>> +            else
>>> +                    strncpy(fancy, ref, sizeof(fancy));
>>
>>   $ man strncpy | grep -C1 Warning
>>   The strncpy() function is similar, except that at most n bytes of src are
>>   copied.  Warning: If there is no null byte among the first n bytes of src,
>>   the string placed in dest will not be null-terminated.
>
> Is there a reason to avoid strbuf_addf() here?  We are talking about
> output for human consumption and not performance critical code, no?

It's not about the performance, it's about the amount of code. But I
already agreed to do this.

-- 
Felipe Contreras
