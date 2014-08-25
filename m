From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [BUG] resolved deltas
Date: Mon, 25 Aug 2014 10:19:53 -0700
Message-ID: <CAJo=hJvF6dZdN9Y0CGuLFX__UQuRgYtM0xP7Ly2yCofxC1Yg2g@mail.gmail.com>
References: <53F5D98F.4040700@redhat.com> <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de> <20140823105640.GA6881@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:20:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLxwb-0002U5-1o
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbaHYRUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 13:20:16 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35793 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260AbaHYRUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 13:20:14 -0400
Received: by mail-ie0-f169.google.com with SMTP id rd18so10307825iec.28
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5JKecwRxZ7ikSlPFPyDB8v3FOU/sV04vGTDmz2lyu1o=;
        b=Iw6T4pykYcvRPUdOFbuovA7tvYXPTMqfMSK1Hg2KQ/sn46ZbWH0Naf0Taad18Ibs6d
         SKQUXXbN3oKeEiHvkFpF+zpuYzhBwug/1bVMRIAY7IohpOvwQatBvd3c+frE5disYb/M
         mQL9g91QHYkLk0T+UIw41M1HJe32/xc+6rEXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=5JKecwRxZ7ikSlPFPyDB8v3FOU/sV04vGTDmz2lyu1o=;
        b=ht9uLLiAPvOom3RxYFVBnEuH0URxhf/4iVb5mzodMcmLpHQdfwGapctBuoPhisI19B
         6K8ceFc1yEMR+5bcQ1/BX1AAAkSo2f/974+NLCtueHglWTXtJKW7l/6nuJl0MIOzJR5D
         3Bk1erI7hy3hBIXlYZ4zr7XAqhomqpk2pt4TVwAnJcv3uOzKhQsvRN6NrXub2rDsvyVx
         K/QbINxYL9b4WSEo7qoYHlzZ9TTlL7m6NBl65rg7djxGwWTGuEwTUv/MtWCoW3zsQRVr
         ImzafgpXdqXSRfskDeAK4WkVtstUAnn6FPA+9ecnG59d0kVCADlDbkaVZ70C8Q0KE6gj
         lUMg==
X-Gm-Message-State: ALoCoQlKqA5wpRr2KIbLGUOAiImjRZaOkVWn+zTEr0xpi8quxVqQM4uRt9hHn0oPgn+pnHAJMWu/
X-Received: by 10.43.101.199 with SMTP id db7mr1534210icc.95.1408987213556;
 Mon, 25 Aug 2014 10:20:13 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Mon, 25 Aug 2014 10:19:53 -0700 (PDT)
In-Reply-To: <20140823105640.GA6881@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255838>

On Sat, Aug 23, 2014 at 3:56 AM, Jeff King <peff@peff.net> wrote:
> [+cc spearce, as I think this is a bug in code.google.com's sending
>  side, and he can probably get the attention of the right folks]
...
> My guess is a bug on the sending side. We have seen duplicate pack
> objects before, but never (AFAIK) combined with a missing object. This
> really seems like the sender just sent the wrong data for one object.
>
> IIRC, code.google.com is backed by their custom Dulwich implementation
> which runs on BigTable. We'll see if Shawn can get this to the right
> people as a bug report. :)

Thanks. This is a bug in the code.google.com implementation that is
running on Bigtable. I forwarded the report to the team that manages
that service so they can investigate further.
