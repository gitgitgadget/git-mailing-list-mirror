From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] t9200: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 19:04:22 -0500
Message-ID: <CAPig+cSQkjjLKAQvd1HR+1p9Gni_V7YXB-MK7qsh4yP1USzyLg@mail.gmail.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<42c95c23bffcbb526aaae302f80667867d164876.1456075680.git.john@keeping.me.uk>
	<CAPig+cQkcUPD5+0rUPkKCcJSzRC0NkuRYKHmW54eZ041PqaqmQ@mail.gmail.com>
	<20160221234345.GB14382@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 22 01:04:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdzP-0001n7-4u
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 01:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbcBVAEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 19:04:25 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35863 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbcBVAEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 19:04:23 -0500
Received: by mail-vk0-f53.google.com with SMTP id c3so115903419vkb.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 16:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2x09+7xUcPuPCCnLxj7cQGtrrRz9RO1Q7nYKbBzhex0=;
        b=hUF9TZIEA22wVIxqEQMiHU848ViUNTR/jmVmjU8rTBt6BPRTs/G/gO8gaMwsTpv9QV
         6F+xFiNVXeQLbb738Z+4Q0p7Ftaw7H2dxejvuw+st1hUm3uEWsx5CHcfhYzr6y1KFx1X
         ISdz34853HUy/yAYf9UO7C7CEfk4DKIoGPfPADMuiT7CWj1/aOJXX227rCDLmRay/h0q
         5II/LnysTMY+i7B6RfUzDJlZ7t8aj1AgJEEDc1Hcna8Y6PDX6NJd0v803CTDC2Ub1HBk
         48oZoiDhZg0UAEXBYiMyO9NstmkjcTAP/aVOuOp2XinOGne4yXkyof8cTOQzVUTuv9G+
         tl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2x09+7xUcPuPCCnLxj7cQGtrrRz9RO1Q7nYKbBzhex0=;
        b=MJmz0ksnJJrnJe2jVEqC6xT6yLWDcWUgbAAvcuQwStZCnwetA8VUzug3mbtXktybtq
         eb8plwYQFoa/JZcnLqyr9yXc2BZvStd8sAtjf9oFpXbNRI2Nxn23hbmMWPcSPpqCohCy
         xpThRPfzDPrWYfRbO06rmFZbhkQEPRQ0ORLr4R8xfQQHFtpc2y6EVnuwkq9OQeSIeTmj
         S24t7cteuCzwgISCUde80WRHtiYVnt3E3gMqCBq3LA4hfGXyk0u0aZvbFOlTlTCZ3nin
         ff+L/57IbpdpAzG+9qil448+oKSSa0u1avvwd9I0+DvBbr5p3YZ2Q71AMx8DbTq7vJyI
         mEcQ==
X-Gm-Message-State: AG10YOTgW//14c1UOrpwkWvG3h+0qZDsSdZhh09Mrk8Ku8Wv9yyfq2B4oGTTKqcIaqWpslrQrinpqONfrn4ivQ==
X-Received: by 10.31.182.143 with SMTP id g137mr20531988vkf.45.1456099462932;
 Sun, 21 Feb 2016 16:04:22 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 16:04:22 -0800 (PST)
In-Reply-To: <20160221234345.GB14382@river.lan>
X-Google-Sender-Auth: FWVNPGWfNtuTvrQ7XhWa9SxNE0I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286854>

On Sun, Feb 21, 2016 at 6:43 PM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Feb 21, 2016 at 04:15:31PM -0500, Eric Sunshine wrote:
>> On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
>> > GNU grep 2.23 detects the input used in this test as binary data so it
>> > does not work for extracting lines from a file.  We could add the "-a"
>> > option to force grep to treat the input as text, but not all
>> > implementations support that.  Instead, use sed to extract the desired
>> > lines since it will always treat its input as text.
>> >
>> > Signed-off-by: John Keeping <john@keeping.me.uk>
>> > ---
>> > diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
>> > @@ -35,7 +35,7 @@ exit 1
>> >  check_entries () {
>> >         # $1 == directory, $2 == expected
>> > -       grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
>> > +       sed -ne '\!^/!p' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
>>
>> This works with BSD sed, but double negatives are confusing. Have you
>> considered this instead?
>>
>>     sed -ne '/^\//p' ...
>
> What do you mean double negatives?  Do you mean using "!" as an
> alternative delimiter?  I find changing delimters is normally simpler
> than following multiple levels of quoting for escaping slashes, although
> in this case it's simple enough that it doesn't make much difference.

Nice, I learned something new today. If I recall correctly, historic
sed did not allow the delimiter to be changed (or it wasn't documented
or I simply forgot about the capability). So, feel free to ignore me.
