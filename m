From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] git: submodule honor -c credential.* from command line
Date: Thu, 25 Feb 2016 21:26:14 -0500
Message-ID: <CAPig+cRM_1JLfBiOqo+-EdKbXp--4VUbddKN_zpSCSLK8PT09w@mail.gmail.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
	<1456426632-23257-2-git-send-email-jacob.e.keller@intel.com>
	<20160226015510.GA5347@flurp.local>
	<CA+P7+xqyTUh60BOmY03JHE6HyVqY7iidVkUf3ji95_s3uE32cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 03:26:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ86m-0003Ik-Ou
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbcBZC0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:26:16 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33122 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbcBZC0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:26:15 -0500
Received: by mail-vk0-f67.google.com with SMTP id c3so4107031vkb.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 18:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nq+IzNrmMUP1dG2K8Me4tGwyEP1gk+DOfzf4bc4HfTA=;
        b=FAyaTbjLA1PLrzkofKUPKB632RrKP0udqhRvfP3P/kt5nbG9oifI9VO5WRh8n7WeRd
         mnrPZ50gk0CPoxo7OkbSkBdJamwZ5eeCXD7NIM6P2t0UStXOo9npimlPvxV18r2t3c5D
         /zfCUlOTNQv59+xoHVY68MtfUuTVRSPdly8ZWWYq/I2owN3E5mOdFULM0fbN5GN0pJHY
         RatLUFIaY4D9R8unpoK574+tukUwIOfOna4CTX1IHcewC8WJjzPaAdnhzPS7wqIKXZ71
         KZJugaIONskSrrfMYnGV/pFUYRW1320qytsBInzeil1JF1VD5VDHYqwC/VM3TXiHgJOW
         h7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nq+IzNrmMUP1dG2K8Me4tGwyEP1gk+DOfzf4bc4HfTA=;
        b=cEEEcFYorFCuwMi/CYzaD9SVVxkKLbQ1y6MU4YOG+0YoLeHPlEXCRg0tQamHGuvwcM
         E2BmVZ64YMrqVfl+DyAzG3FEFk4rdorPm5TGYBPSkLarfuNryo9ZExwhxinIDPUWORSo
         4stMsak2UCjzkKxAN1mvkUtAc4xp3cjaAekiFALEsIpXDd1nJ9c+fuwErdOY1a0v5Kk2
         VFYqEhLCH8atkSAKi2YW6qzc1igiCIJSaA6VUUos0GjV/sbOZC12kItinwMGlXLJ4klE
         gg9lx0GAdaxTe0ZF6SoYYicA1Z22QMjFPKpFw6QpgP7eAzLc9Bn4SOh6TvuLgJPttT5M
         ryqg==
X-Gm-Message-State: AG10YOQbzpkYttqH9OvLdPDSqKMgjm75zlBjnvaogyCrUYIrsy15TA6lK5FI+C7ilPxH7Gq7FvETQtQ+Pr6r7Q==
X-Received: by 10.31.141.2 with SMTP id p2mr40080448vkd.37.1456453574881; Thu,
 25 Feb 2016 18:26:14 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 25 Feb 2016 18:26:14 -0800 (PST)
In-Reply-To: <CA+P7+xqyTUh60BOmY03JHE6HyVqY7iidVkUf3ji95_s3uE32cg@mail.gmail.com>
X-Google-Sender-Auth: fVez87LlLdlvdJRqFw3-QeNT7yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287532>

On Thu, Feb 25, 2016 at 9:19 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Feb 25, 2016 at 5:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Not worth a re-roll, but these quote sequences are brain-melting.
>> Easier would have been to double-quote the second argument of
>> test_expect_success() and then do either:
>
> They are. I fiddled with things till I got it working. I wasn't sure
> if double quotes would cause a problem or not, since most other tests
> seemed to avoid it.

You normally want variable interpolations within the test to happen
when the test is actually run rather than when it is defined, which is
why single quotes are normally used. But this test doesn't use any
variable interpolations, so double quotes won't hurt it.

> However this re-roll forgot to check argc in submodule--helper so
> maybe worth reroll to fix both things?

Possibly.

One thing I elided accidentally was that when changing the second
argument of test_expect_success to double-quotes, you would altogether
drop the double-quotes around "helper" in:

    git -c credential.helper="helper" submodule--helper [...] &&

to become:

    git -c credential.helper=helper submodule--helper [...] &&
