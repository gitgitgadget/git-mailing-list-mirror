From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/8] cherry-pick: store rewritten commits
Date: Mon, 3 Jun 2013 15:55:44 -0500
Message-ID: <CAMP44s0=qDmSt9y1JOPmDcUqjez=bVbwvLxz2W6W21W04zn2mw@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-5-git-send-email-felipe.contreras@gmail.com>
	<7vmwr7do7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 22:55:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbnE-0007Co-BD
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753Ab3FCUzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:55:48 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33232 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757835Ab3FCUzp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:55:45 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so3878601lab.25
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WGiCS531j7gjL4NbiJaRl9a8D+uklXd1HZbXbX846OI=;
        b=tAI1mGGiIpLb2UwmnCwsQgkeCquBPzW7tXLxwiO97esAyZZeD9QjbI9H9U5Qg5yx5m
         suVL+96OD/e/N06yGbHBq+DyO8wlgyGi7vaQmiU2VPrTGvcSfbOz32CV/TVmlQ5PsTPC
         3XYhOq0i+f4C6g7Le/7sI5vyTUl9bSz2F6oD54eO14IqXiDpm1Zx0yn0WdxpC7kb97et
         2UsESciviCoir7RMJ9Om5fZXLM0CIdgoi2IhB5sh204R6Djsmf/JXSKXX/tFGbpPy42q
         FKhgPfKm3t0f53CKAGWtP5tXILcWA39Qhz5CQTIEoVABw8J4DW588tDQeN+2zXaDlGDR
         XdbQ==
X-Received: by 10.112.133.129 with SMTP id pc1mr8544448lbb.49.1370292944410;
 Mon, 03 Jun 2013 13:55:44 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Mon, 3 Jun 2013 13:55:44 -0700 (PDT)
In-Reply-To: <7vmwr7do7s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226289>

On Mon, Jun 3, 2013 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +static void add_rewritten(unsigned char *from, unsigned char *to)
>> +{
>> +     struct rewritten_list_item *item;
>> +     if (rewritten.nr + 1 >= rewritten.alloc) {
>> +             rewritten.alloc += 32;
>> +             rewritten.items = xrealloc(rewritten.items, rewritten.alloc * sizeof(*rewritten.items));
>> +     }
>
> Is there a compelling reason not to use ALLOC_GROW() here?

Nope, I just copied the logic from another part of Git.

-- 
Felipe Contreras
