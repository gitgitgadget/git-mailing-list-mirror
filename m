From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: [PATCH v5 0/3] merge-recursive: option to disable renames
Date: Sun, 21 Feb 2016 12:07:18 -0300
Message-ID: <CALMa68rEM3a-h2my7QqntfFq8sxGA4Rp8LN07ujQHCu_-O58Jg@mail.gmail.com>
References: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
	<xmqq7fhya4v5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:51:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXY9y-0005r5-Ac
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbcBURvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:51:01 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:32870 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcBURvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:51:00 -0500
Received: by mail-io0-f175.google.com with SMTP id z135so156479798iof.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 09:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Gx3FTieUh4lKHwf5dfdoBVigrKQXoMEAITQDHxvY+WE=;
        b=OOlzAPzSHT8z0V1GXLDsAEZM5UhXDVC+Rd3fVhZuzzU4coguNv49lXXR4BOtywCy4B
         hVw5uyiLlQsIcxOUxvzGc8lWKtJdlNQqD3fZhh2jop5aGH15h1XQWvEwQS+Xq2qHfNjU
         ya8Vb4gyCRDyGFU7QrGlcO0xnJqaZKBnYfptmdwxWwrMHkvdVzQc0NA7DJJFy84/BgUY
         uwKsD3XHKKJHDQKj++f92gUyuCQCvwGJ1LIc6+uNnahCRs5BSOc8nA1TmpfCUlVITnXQ
         dQGv8BSQgXZYxRc+a4aTbPkaa/IUWgylCm7z16N6FX6PvPJvBV5s4m6PTHEKKyFLZ2yk
         eRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Gx3FTieUh4lKHwf5dfdoBVigrKQXoMEAITQDHxvY+WE=;
        b=i/tkEac5e/UidpqRfqXOl4U6G0aIplI0owr1Obls0hHFLFAY/YBqwm0iNjSJFTYCrl
         LrBFLSqVwZ271Uap/unVj0jr4Ribk+3SrYKu4OjH34HLiygrRhvBsgzKf7ApARSlxpBk
         xmqORh1jJWDdXOrQ+MvIKs4PVCot4lELD2ZWFUloxXDYiLnvEtJIrRmCpC6d+W5/41AI
         XoG65S/LSwbRCh9w/01ObUD7feGPJNYoP5FI/q33WSah0dxVny6KXbbn2M9pC/IvpH3N
         T6weJ1OodVbBHZ9E++YWkp1x+GzZQZhYKeO0VjN5RuhiFW9MzTHaPua2xEkXRL0kJG2I
         mJww==
X-Gm-Message-State: AG10YOQ5Txt7BbtWr63TKo/TSDMhtfPfjHETJBI6Yy9181oc8/Y7gVcBKMQClYGEnircQW5Vp2VEXcBDX64YvA==
X-Received: by 10.107.157.18 with SMTP id g18mr23570263ioe.151.1456067238784;
 Sun, 21 Feb 2016 07:07:18 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Sun, 21 Feb 2016 07:07:18 -0800 (PST)
In-Reply-To: <xmqq7fhya4v5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286809>

On 21 February 2016 at 04:40, Junio C Hamano <gitster@pobox.com> wrote:
> Yikes, your previous round is already in 'next', so could you make
> this series an incremental on top of what is already queued up to
> 1b47ad16 (merge-recursive: more consistent interface, 2016-02-17)?
>
> Thanks.
>

Oh, sorry. I did not notice that. I will submit a new series shortly.
