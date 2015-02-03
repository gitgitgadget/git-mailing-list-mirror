From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 3/4] apply: do not read from beyond a symbolic link
Date: Mon, 2 Feb 2015 16:08:49 -0800
Message-ID: <CAGZ79kbE2frDRgXkS0zGvufR1GP15wjgf9t49U87jPT83aTF0w@mail.gmail.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 01:08:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIR31-0008Jj-3H
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 01:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522AbbBCAIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 19:08:51 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35907 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313AbbBCAIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 19:08:50 -0500
Received: by mail-ie0-f178.google.com with SMTP id rd18so12271427iec.9
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 16:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X7TTYe5pjnJF7QmBgM15/4NJM8+bO+y1sC4aT1+z3S8=;
        b=PUoJ0FbeQbSyTYNxbqTcHvkYCbmdDzG5rGTknIUSUSsvLJRAmOmcI7ILj+j41R3AYe
         K91Q2QAZEFVmN6Wx1+X3WdNOTRWBjTC2uzqA0lbzcppcT2P3Zerh5Hj9FMZ6WjL0biMX
         YUyyc/MP1W5Se2qmKKZy2BM+NR0jxS2lh99ILdlvQ9mTAvXsrjninMkzEG43wQA956rT
         6b9tIlEisTnyXlfccqnO3i1FbkY8IIXN8db9q8nKWSrl1RhPC96KQzOLXbSrGMrkLPQI
         aaRPcP5sbsXYJ7pwADcBUX76V0MtSDYwKaq30fcJoltap/m73qP8PpmEr3xvMEVk5TJg
         XbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X7TTYe5pjnJF7QmBgM15/4NJM8+bO+y1sC4aT1+z3S8=;
        b=TXTvso8yiMgUsb+SCrrm0uiKd6dTM3kvbZo7yZXOqpaqQ3tGKOH+yq5UWK86v2d6Yj
         34/Z6lRa+/1ibaluods7UN2NZ+KAK5sgcx+pFcrnsWu8kRp+MFiV9BuROxqV7q56nopr
         oF0g0xfwwBiTL0cFFu0fQSm/rxEbbGJEV6tJKrWn7f4yelCRnYQEaasjxdqyYUwWFPLZ
         PfRr4sxuENrSc7pQwMlexk2eh+hTr15MGJ2jlzuRrOUez8W0PmHhgS+M86UxA7dbaU3K
         Mz4J0QVxYBXGzv4V4D+LQOOxCSW5rP9/1kM6Fqn3EcPKqs0uKv0CU7m83H5HmbQxW9uH
         WSLA==
X-Gm-Message-State: ALoCoQmeiBz/OKCWYxypBtYhEv+gHRAmZxgi+0LQUGhbetqHUQpg6zex853BmhFxPytYXZDhh5f7
X-Received: by 10.107.16.169 with SMTP id 41mr5866852ioq.33.1422922129910;
 Mon, 02 Feb 2015 16:08:49 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 2 Feb 2015 16:08:49 -0800 (PST)
In-Reply-To: <1422919650-13346-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263296>

On Mon, Feb 2, 2015 at 3:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> +       test_must_fail git apply --index patch
> +
> +'

Is the empty line between the last test_must_fail and the closing `'`
intentional?
