From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the origin of a config value
Date: Tue, 16 Feb 2016 10:48:30 +0100
Message-ID: <BB209409-A43C-4C08-8691-B27FFDBDDB69@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com> <1455531466-16617-4-git-send-email-larsxschneider@gmail.com> <56C244D7.1030503@ramsayjones.plus.com> <xmqqio1pps64.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	peff@peff.net, sschuberth@gmail.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:48:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVcFN-0006Ul-Co
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 10:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbcBPJsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 04:48:37 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38743 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbcBPJse convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 04:48:34 -0500
Received: by mail-wm0-f47.google.com with SMTP id a4so90991420wme.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 01:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=diZUHRBR9N9fEEbMOq3gBhmdGfzfbBsQUFc+ItGSmgg=;
        b=MldhaV1ukogcoQc+cDwc+vfJIAJZgqsSGU4vGHW7jpki7+Zm66UPzJLh+p5jnQK+L0
         CLYu1FjuVFnlnUhBcol2kxLMOniq8bmh/hbGuOYeXG7hYXLjoSc2YzlmcQxGecso9Ggs
         SAwiFJGtYA60CRjMXFf8ft/D8BBsmNBTZygANoB2iTGOwM5WklJK/qaGC5G6/skQLmbS
         QdckDl2kq1kDhyJUxjjOve+FUyvOa95QPQAytF8NFFmfTnNH86BDiFBSXPjIjTuDhLMg
         /RN5kTmtpBvgTOvec6lGaXpTSpE3koC47HPk9eJ8kiqUj7J0dHclWMNh1oXs14+aUhqT
         rXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=diZUHRBR9N9fEEbMOq3gBhmdGfzfbBsQUFc+ItGSmgg=;
        b=VswTSG/vC72Ug36uJxHJXBe8MDfC1hJUs6SiVakYim3MH1+ZEmujbZbBDjZsYJJ7cT
         3QUpxRkYbRKeqs7u2dHtUIKb497smsQiDc6DbinLPEv8uOUnzqQtWmz7xW0hXe8xljTq
         WFWOy4bqCAttS1Lch4M4exKd4aM4+7hs85gQOh+uz8R+9OJluSa9hwc9tY7csqvB839G
         StPRjqCxOiHg84J3GITnKaLxae+v2vF7TvaIkvb//8fqM3RM4h/4RI6+GlZgc52PjDV8
         ZnHrTcZNHbgxl4jdAw1DjlZOK6HEb1ZOMbKgIuJMCvilSY8w/y5pbnUAbotHzKRTtoCr
         aKnA==
X-Gm-Message-State: AG10YOT7TwVQ72Rf3aV2DUajUs8YFWwr3VcxrKrOn+HcawB8tWXVWtZjkZ9UsKTf9HMl5w==
X-Received: by 10.194.71.70 with SMTP id s6mr20933759wju.1.1455616113798;
        Tue, 16 Feb 2016 01:48:33 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB43DD.dip0.t-ipconnect.de. [93.219.67.221])
        by smtp.gmail.com with ESMTPSA id e9sm29391641wja.25.2016.02.16.01.48.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 01:48:32 -0800 (PST)
In-Reply-To: <xmqqio1pps64.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286336>


On 15 Feb 2016, at 22:41, Junio C Hamano <gitster@pobox.com> wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>>> +--show-origin::
>>> +	Augment the output of all queried config options with the
>>> +	origin type (file, stdin, blob, cmdline) and the actual origin
>> 
>> file, blob, cmdline (hmm, maybe cmd-line? ;-) )
> 
> If we are going to spell it out, "command-line" would be the way to
> go.  "cmdline" is probably OK.

I think cmdline is OK, too. However, if the list thinks that there is a chance
that it could be incomprehensible to the user then I would prefer "command-line".

- Lars