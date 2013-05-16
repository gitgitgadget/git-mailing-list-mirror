From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 01:00:57 -0500
Message-ID: <CAMP44s2sKWCswB+wT6OiyrA5_oVqUkDptrkdZCjWCucUL3KrKA@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	<7vip2j8ozu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 08:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcrFQ-0006mv-Ha
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 08:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3EPGBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 02:01:00 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:45844 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab3EPGA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 02:00:59 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so1945162lab.22
        for <git@vger.kernel.org>; Wed, 15 May 2013 23:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=itaxYT8HHAuH4ofHhJ+jj63qOJ6uE2NKuka+AfHKJyA=;
        b=P3n+7vD2UdyeMk88CLL/7aUnxyHgphL17yISVZ/QNGluSd/Lz6BUApiDR02wNXURmV
         mKjgW2vWMRzk2yvkXmuZiqerw9brwwfn6vsWtMeXwgLx9TwxUicJJ9T9Jyqoc0Y9vwIr
         XlKii6m5L137eCbUYnqKY51PzgouLGb+CAxj8/F6kVKbjurFT3QpFRPmZccpeKcI3/1D
         GYoIs35l8+1Z2vyBx1xiimw+JLhWkTyDXmi9REX0i9pXeUo0AshHyI1JKoK2zf02WS1S
         HU8KPyA9Vi+NVhyba+Sdyy+bocT3cVFYUBoG7DZSPmt7BHpEqoQnGedEsNc7omOMJUqd
         ZSBg==
X-Received: by 10.112.145.72 with SMTP id ss8mr19415027lbb.12.1368684057967;
 Wed, 15 May 2013 23:00:57 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 23:00:57 -0700 (PDT)
In-Reply-To: <7vip2j8ozu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224482>

On Thu, May 16, 2013 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It doesn't make sense to push to the upstream branch, so create new
>> configurations for the notion of 'downstream' branch, which is basically
>> the branch to push to by default.
>
> It doesn't?  That depends.
>
> To people coming from (and people who are still using) central
> shared repository workflow, pushing to anywhere other than the
> upstream makes no sense.

Semantics I guess; you can say they are pushing to the upstream, or
that they are pushing downstream, which happens to be the same as the
upstream.

My rationale was that at some point in the future we might want to
remove the code that pushes upstream, and only push downstream. And
either way configure downstream when creating new branches with
tracking. But I'm not sure that's a good idea.

> If qualified with something like "When using a triangular workflow
> to pull from one place and push to another place" in front, I can
> see why having a separate upstream and downstream makes sense, and...
>
>> The upstream branch is remote+merge, the downstream branch is
>> pushremote+push.
>
> ... this is a perfect explanation of what a downsream is.

Cool. I haven't decided how best to set the downstream yet, but for me
it's more important that 'git fetch' works sanely (patch #1), and I
don't like the proposed patch, but I can't think of anything better.

-- 
Felipe Contreras
