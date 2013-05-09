From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fast-export: improve argument parsing
Date: Thu, 9 May 2013 18:33:15 -0500
Message-ID: <CAMP44s1GAeu5v5xqLu8BgisprmWN=C8zoFYNidoyBPXmu-cvJQ@mail.gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-2-git-send-email-felipe.contreras@gmail.com>
	<7vzjw37q7o.fsf@alter.siamese.dyndns.org>
	<CAMP44s2RYPENwsPAcoaKjmHxkuVA52vvRrQ_stmT_qY-Pmt6HA@mail.gmail.com>
	<7vy5bn68eu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 01:33:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaaKv-00005e-5e
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab3EIXdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:33:17 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:58984 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab3EIXdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:33:16 -0400
Received: by mail-lb0-f172.google.com with SMTP id y6so3656599lbh.3
        for <git@vger.kernel.org>; Thu, 09 May 2013 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=5EBw+g9Ugcns8oMvobAq9p0V+1tdvO6VOFS6JaUBg2s=;
        b=lcP55jDyBoKIAfZyl7Cx91hiqgWe/bWq/HWdSSeKMa1m2Npf/YJrljr4le1ESD6ckl
         hPNZoqGGPZh8wXcbnf75FvYaUvV4aK0i5Yb3YB2lP+bjxlnHVddCSFyCSF8JZpCY+jqI
         JHsmiQ4LWyDv2R3snJqF4QXkGPaJNDkN8QjH9mV4n6P2ziD1OFDqS/57wzWbj/S0WVTf
         aJJj/6gjt4oaXe0LXiDjUr8Fi6eIssGJYyrb3QeSqsAlFsbGBmid8gAZzOAcNoxyr/by
         k2s53efCISVIzjGYPn7r2caZpkk5xPxaX22Cj706b6xQWmKiW5Kzoy4NKpavn+1wuJQP
         Pi4A==
X-Received: by 10.112.145.72 with SMTP id ss8mr6539499lbb.12.1368142395343;
 Thu, 09 May 2013 16:33:15 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 16:33:15 -0700 (PDT)
In-Reply-To: <7vy5bn68eu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223806>

On Thu, May 9, 2013 at 6:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, May 9, 2013 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> We don't want to pass arguments specific to fast-export to
>>>> setup_revisions.
>>>
>>> Interesting.  What bad things happen with the current order?
>>>
>>> Does "fast-export --export-marks=foo" causes setup_revisions() to
>>> mistakenly eat --export-marks=foo and barf?
>>
>> No, apparently it skips them. But try 'git fast-export --export-marks
>> marks HEAD'.
>
> That is the kind of thing that needs to be said, not in the
> discussion but in the history, either in the log or in a new test,
> or both.

If only I had known that when I wrote the commit message.

-- 
Felipe Contreras
