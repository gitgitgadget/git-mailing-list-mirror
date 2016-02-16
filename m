From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 14/18] git-compat-util: drop mempcpy compat code
Date: Tue, 16 Feb 2016 01:05:41 -0500
Message-ID: <CAPig+cTD-xbtRmt+z+CTB_-KoY9MnB2J7bhQTfYtrnTQOSOeQQ@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215625.GN10287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:05:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVYle-00031U-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 07:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbcBPGFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 01:05:43 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33712 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbcBPGFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 01:05:42 -0500
Received: by mail-vk0-f53.google.com with SMTP id k196so125146929vka.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 22:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=t0xvpsPHv5q3t4cgTV//guGVYX2ZY23dV88iWD9/Lzw=;
        b=a4NSgH9D/wt/IGNdOb0gVofrx2PJt+8iKWbKRedChen2cTAW1sZJFsxgVqEtJILCX1
         l/HQH9ZFrA7Imv3W9WuwMw7MjlNCLYtiy20E7LSZhn9tz4b1Bpw+ntebz5IeG+wdJtp5
         nGQHy0x55hLd+9K4OJKUHze/cKHPaYv+Lrb1czoGpfsNj+qv365unQpmrB4GnHVhRbdD
         Dki+nUTIJM6oMj9ussGJEyTxguMio1ljGnT4rjTzEKktBhuDQg+IrY3sGb6N657RfKE3
         8g9ypcc1N8WjoqeokfwH8d799oKQzFkKk+8ceBXAnIgMOz5nhy37mpPEKC5D4TCZ04eF
         qe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=t0xvpsPHv5q3t4cgTV//guGVYX2ZY23dV88iWD9/Lzw=;
        b=YP1IOk6SbW0iH+83djaJkFwqs0a1fTA1XmGwK15YEJjXhehuWIylV5t/QjBlQ5kGV3
         jLcVA66t1fx7oO5TCtvzUSVCxi7YZYqvqn+CzozNwFsy1ZhEqRAaCm2Rb0wkgL8LQCdK
         mYF0Dis9pD4/7s3cpmMj79TSzg5zeYpKe2Iser/bsB8ioqgblpOUbviNfF8Ls8ec8z9v
         r8lYkEm9/pedBKqB3tWNwNd0bLP4MUKn2iPfVI6GOvenNHIXs6wAocOMJ08k9orwgJ0c
         yihx3cNagnCa4GfY2ARUfHly57qd/rpbfvJ2wOqqzeAsUUOVo3Q0+iG7F8IBIgk7YXvn
         mdOQ==
X-Gm-Message-State: AG10YOQI09ysle8hChf9ELGbeZ3a6FCLg+Or+796nHKRDH7q8DKh/z6EhQsQeAV/WgV0iWGhCDJomB+D9UxCtw==
X-Received: by 10.31.146.2 with SMTP id u2mr14281139vkd.19.1455602742016; Mon,
 15 Feb 2016 22:05:42 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 22:05:41 -0800 (PST)
In-Reply-To: <20160215215625.GN10287@sigill.intra.peff.net>
X-Google-Sender-Auth: 0VF1nzsEtnuYG7u_vasyU3-qkmM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286325>

On Mon, Feb 15, 2016 at 4:56 PM, Jeff King <peff@peff.net> wrote:
> There are no callers of this left, as the last one was
> dropped in the previous patch. And there are no likely to be

s/no/not

> new ones, as the function has been around since 2010 without
> gaining any new callers.
>
> Signed-off-by: Jeff King <peff@peff.net>
