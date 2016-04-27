From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] trailer: load config to handle core.commentChar
Date: Wed, 27 Apr 2016 16:33:04 -0400
Message-ID: <CAPig+cQWOr5rQ65RJkyJZGPjYDWMv7nhL8Pbh55KGD9wZzrDHQ@mail.gmail.com>
References: <1461785062-23523-1-git-send-email-rafalklys@wp.pl>
	<CAP8UFD1O+V64dr-j9bu7D1mrLxEy3zG017zdJahJTx-MUYv5Pg@mail.gmail.com>
	<xmqqlh3y94l0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Rafal Klys <rafalklys@wp.pl>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:33:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avW92-0003YE-5i
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbcD0UdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:33:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35850 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbcD0UdG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:33:06 -0400
Received: by mail-io0-f194.google.com with SMTP id k129so8197873iof.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=xcxo4P1wLHwDUZKu6+4gLEC6BBcIKCNtPpg3fsVMQRE=;
        b=l7rwaGBx9XuPHvF+UcFjV+VZHg0Iw/VYiiRJkU9OOVX+J4J+u5k2+K96B3FmVbIW4S
         Ehb+CA6Oksx66yZbcM6Qeo3H/WyNgLqr7zTSmDv4iMneWBP8fP3oP7y970cUkU8YGJxi
         8S6c0pDKY14oLDDYstulAiEajE1OYWqC2DsHcpwpx/SE/2U7zpFgGt7Ww5TxzMgzox2R
         c6W1QMPDfNnoZBKLeen9oYu9wUKn1n5rFvPKKsRRrMhwyBWQKIf0D3/ehOCqwICcNMVU
         6fjoukeWx8LP+FF5CvZyvj+EJhIYjt44UxQy7NcFD/GglwSBfdzuhp8hNIMrqBIX4G0s
         jOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xcxo4P1wLHwDUZKu6+4gLEC6BBcIKCNtPpg3fsVMQRE=;
        b=jypaPJzqjUA7qOX4MgNErtWYjY0YsPNI//fzG1JxVBR7jWrcE0yDrbr7FlZt3PMDN9
         Xl6jjcjtd3OXJUFnZENptYV3GSq79vMoLmo9vbbAeVCaY2UeOufTFkOHFCYAx/eX0RUE
         DbZ41M7qUY05HA/HIXoA2AGN9P7pGe+n95pLu06zCZc0Dw7t0HzusO9EXI8UMufjY9kS
         8TqYqrW+tGnT1vYWXiyiJ+1535AetASYaCtI4GTCgZ/gcU6YdiTu45D0yASniN2ZRR76
         99F6vIfSrXjQcdDs6rYzr23Mhb06Nup9SENM7f2M59wqWnn+IoAuRueBEATC8N0WCthv
         wj0Q==
X-Gm-Message-State: AOPr4FUFN6Ta2YhQRcmEF4yUrZx4Ac6byJNMUCkKnvGLs0nIZIMjWPIbeBdXprgu04d0/0Ep2eOdbb/HzttYAg==
X-Received: by 10.107.134.93 with SMTP id i90mr13550516iod.48.1461789184768;
 Wed, 27 Apr 2016 13:33:04 -0700 (PDT)
Received: by 10.79.0.97 with HTTP; Wed, 27 Apr 2016 13:33:04 -0700 (PDT)
In-Reply-To: <xmqqlh3y94l0.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 2FaRcqarGc5_2vvimiDXQ8M5jYs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292817>

On Wed, Apr 27, 2016 at 4:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Wed, Apr 27, 2016 at 9:24 PM, Rafal Klys <rafalklys@wp.pl> wrote:
>>> Add call to git_config(git_default_config, NULL) to update the
>>> comment_char_line from default '#' to possible different value set in
>>> core.commentChar.
>>
>>> Signed-off-by: Rafal Klys <rafalklys@wp.pl>
>>> ---
>>>  trailer.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/trailer.c b/trailer.c
>>> index 8e48a5c..a3700b4 100644
>>> --- a/trailer.c
>>> +++ b/trailer.c
>>> @@ -888,6 +888,9 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
>>>         git_config(git_trailer_default_config, NULL);
>>>         git_config(git_trailer_config, NULL);
>>>
>>> +       /* for core.commentChar */
>>> +       git_config(git_default_config, NULL);
>>> +
>
> I can sort-of see why the original (logically) reads the
> configuration files twice by making two separate calls to
> git_config(), but I do not think we should add a third round like
> this patch does.  Shouldn't git-trailer-default-config have a
> fallthru call to git-default-config instead?

Thanks, I was going to say the same thing.

Also, would it be possible to add a test?
