From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 16/24] read-cache: read resolve-undo data
Date: Sun, 18 Aug 2013 21:59:24 -0400
Message-ID: <CAPig+cSZDGfNh0-jJeozrQhVHEZ924EeJtXXezPbhxiTZN+xaw@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
	<1376854933-31241-17-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 03:59:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBEkk-0004HD-O8
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 03:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab3HSB71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 21:59:27 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:40626 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab3HSB70 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 21:59:26 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so2830600lab.25
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 18:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yaFuWNZLDWqlZQly7h3B15VU9DzHxF/tHwcs/UPnbXw=;
        b=bxTNpOz9brmfGC2TmCow9xpl/fg2r9Bk6EiTp2/6FYoG62Mxw7/mG92PRNf6qsH/1L
         jaBHt+GrD2ftA1rCMr7XmL0nZ4cfGxgXmHCZjACaRR9Qp69yTNrCCssz80eNHzyAG/34
         1rqIp2vUE8NscrfiUiyheq11sLreX041UGuOBMH6NxxKDgnkzUHBeJP0pRzgQMZhSzIW
         IuGZbE6mo5yFYXBmqhK45fLmj8G1Ba1IGzXqzBu5yj+djLJTKl7P/QRjWGUKl+02QAO8
         t8+IUzGQlgikLw/Wnz7Mkkp/709kaYg/o2FlVEWtcd6l7Ch1hDEZ6eX2pyWKKxVCt6WH
         Vkjw==
X-Received: by 10.112.64.36 with SMTP id l4mr9336135lbs.15.1376877564518; Sun,
 18 Aug 2013 18:59:24 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 18 Aug 2013 18:59:24 -0700 (PDT)
In-Reply-To: <1376854933-31241-17-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: 3dUeKkBhSCV5eLXn67uTY17oYmY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232528>

On Sun, Aug 18, 2013 at 3:42 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Make git read the resolve-undo data from the index.
>
> Since the resolve-undo data is joined with the conflicts in
> the ondisk format of the index file version 5, conflicts and
> resolved data is read at the same time, and the resolve-undo

s/is/are/

> data is then converted to the in-memory format.
>
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
