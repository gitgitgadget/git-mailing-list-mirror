From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 23:51:45 +0530
Message-ID: <CAOLa=ZR83_79YTPA1QAB8wOPUDFu_RV2za4P4s9eO_PCgpXdNg@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com> <20160216192231.GA16567@sigill.intra.peff.net>
 <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
 <20160216204954.GC27484@sigill.intra.peff.net> <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
 <CAOLa=ZQO065j5VfJabbV6jww5Z2f3jbaRQDfDcG9NY4x2txrFQ@mail.gmail.com>
 <CAPig+cTrh4u7vgQRXOT0a-5St2a6TV4qfhOMCVSetbQD0kGTrQ@mail.gmail.com>
 <CAOLa=ZQ4-Qwp84XgTS9joGW4rJRiw8VMTf+Y1Dzo5M-ZNPZXuA@mail.gmail.com> <CAPig+cQzkQ2G2EbrkDXHq4eytywFbJKPO2kxFTOxrcACQJCZ6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:22:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6k2-0002Xx-8k
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbcBQSWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:22:18 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36343 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030312AbcBQSWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:22:16 -0500
Received: by mail-vk0-f42.google.com with SMTP id c3so22299646vkb.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i49tEktGATbWTIuAiaQj6O6RihtYnzCdEls9s0ObmGs=;
        b=YlXBzTsA67LMlr3dCNnUJQQtiYMzBPo2MDfssERcESN9Zd143NfZf0JgHkG1zGE0QN
         1Ow597A3fqmyGiiVKuI6XLxIwtCotMp0o3u5rCTArGcq8zJssfZh6VmpATx4ZSMc/Q43
         T/9S07QT884ua6Mx0T8z7Jaeili2o7/0XslEvJm9jdfDg4g1l4W3UunTYfQeSsFC8Mu5
         q0aaZFZFAJQatJiOKhlvZJaGlIXTbk9J0K8fwOBLOgJmstQXIu1iRt2FHk8+T7O/ElYC
         FN4HC1ycIYetXMO3A85N6akYuuZV12vrDV6WEf/awMe/+qj3Dbca9OqUYCn3HFhjDah+
         oLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=i49tEktGATbWTIuAiaQj6O6RihtYnzCdEls9s0ObmGs=;
        b=IXiCPIeR2kjSJIgOxV2QfO53nfnGzek+UTXfsm/3wy4zUS1bLche6hxJb8nvDSlaxb
         sXMNVaCkqFMr8TeDKgO+SBgLh5RMVFUjY66lyJP/aBXqxMZ2FO7YyMyJVXYn0MOnPiL7
         XgHMyEbJBQRlkxg3QuM7V+uv61u349rSJFvsDOsAX4Al8CPhOiG2/C8yJjWffK497XOO
         Lw0xplFyVwrftNqLDhE80WrHfzqW8wmeXSfR68spWfiC0hVGlxMgpDBJk1HScVs48eoU
         xR+JtjOb+bFpo/QD2zzNmU/xzXz/V6kyrunrx7y4mZ/6eSQxU9v7s9wgnLyt4hRVGZz9
         9APA==
X-Gm-Message-State: AG10YOSTeSDuy2iYxBuMhbyN14h0McB/k3fi/Y1ZJKlmq9Eo69iTHWbTwq6Ui681inXIwC0mAfuF5nI9SrSuPg==
X-Received: by 10.31.142.203 with SMTP id q194mr2431291vkd.95.1455733335400;
 Wed, 17 Feb 2016 10:22:15 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Wed, 17 Feb 2016 10:21:45 -0800 (PST)
In-Reply-To: <CAPig+cQzkQ2G2EbrkDXHq4eytywFbJKPO2kxFTOxrcACQJCZ6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286531>

On Wed, Feb 17, 2016 at 11:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Feb 17, 2016 at 1:07 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Wed, Feb 17, 2016 at 11:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> I reviewed the entire series again, including Peff's changes, so this
>>> entire series is:
>>>
>>>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>>>
>>> Karthik, feel free to include my Reviewed-by: in all the patches
>>> (including Peff's) when you post v6.
>>
>> Oops! I just pushed v6 before I even saw this mail.
>
> No problem. Junio can add my Reviewed-by: if he wants when he picks up
> the series.

That would be great :) Thanks for reviewing this series.

-- 
Regards,
Karthik Nayak
