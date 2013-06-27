From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Thu, 27 Jun 2013 09:07:38 -0700
Message-ID: <CAJo=hJvOq=CATrDeYAwi+jgkPpqjywWhuKeC1TVYeCXr6NVM6w@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com> <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
 <7vtxkl28m7.fsf@alter.siamese.dyndns.org> <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
 <CAJo=hJtJoizQUubriTPvs2bsjvw+N82MCPvw263fUB8vv8_VVA@mail.gmail.com>
 <CAFFjANSr2QRLE8DSPP2zZ_baEZUqR8dzkPzMwqyEqgFX=8cnog@mail.gmail.com> <20130627024521.GA6936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 18:08:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsEjt-00039R-2B
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 18:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab3F0QIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 12:08:00 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:65494 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab3F0QH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 12:07:59 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so1785178iec.7
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kccTvn2TAy7kIULsSmnFeWB3TTbfFVBz/Bca581nTf4=;
        b=aK321O47kGHK5tiq95IUo7b8gvYGHx1Yupqvfy5VbDdfnpyAr6n4O/xE69YY+55WC/
         ySwGVV3d70dkxEKt5LZ7cr9ew+EfmG4osyCRaKGiZbrEeNDyzRC4QeyDpcHzXY8IaX7i
         /kEWWf2j5owe2KQr4kIg3fvUTSLh/GqaQpuws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=kccTvn2TAy7kIULsSmnFeWB3TTbfFVBz/Bca581nTf4=;
        b=D6+s/9E6h207a5NGZ2K+ji7NVNXYlxBgUVc+sxKXf1abR5vYBIovb6nNawZ21KtnbT
         3LjHrVt6cCsf1j0uL4fqa0N9bTbq/YjWjoOSvEGNELzJZnX0XqJlstk6pqnKf9FEE333
         a7P1T4v7KVZ99RAglJkAu3Z0faxUN94AqsQpXHk+xriP06Zv6Pi3YMmVjN4zeZqXpsEN
         lvnsada+ah55PkAQnoegK/RMaIpkRinpkQagfZ9uwS/pnlBLzsuSHZvdslu1htCSAEnz
         Su0/Ws8zkHldtI7adS8jwLJqLQKc8HL0Rqng4hR1clKWnlWL4waybSpVhGN4ymFZfINZ
         UngQ==
X-Received: by 10.50.72.40 with SMTP id a8mr7413021igv.15.1372349278944; Thu,
 27 Jun 2013 09:07:58 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Thu, 27 Jun 2013 09:07:38 -0700 (PDT)
In-Reply-To: <20130627024521.GA6936@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQn8ncXqYrjFZOdaqFSYLotXMFB+3NrLBRCYe6z3ReZMonN29ywGtVumfijdmqtchDseoPFn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229113>

On Wed, Jun 26, 2013 at 7:45 PM, Jeff King <peff@peff.net> wrote:
>
> In particular, it seems like the slowness we saw with the v1 bitmap
> format is not what Shawn and Colby have experienced. So it's possible
> that our test setup is bad or different. Or maybe the C v1 reading
> implementation had some problems that are fixable. It's hard to say
> because we haven't shown any code that can be timed and compared.

Right, the format and implementation in JGit can do "Counting objects"
in 87ms for the Linux kernel history. But I think we are comparing
apples to steaks here, Vincent is (rightfully) concerned about process
startup performance, whereas our timings were assuming the process was
already running.

It would help everyone to understand the issues involved if we are at
least looking at the same file format.

> And the pack-order versus idx-order for the bitmaps is still up in the
> air. Do we have numbers on the on-disk sizes of the resulting EWAHs?

I did not see any presented in this thread, and I am very interested
in this aspect of the series. The path hash cache should be taking
about 9.9M of disk space, but I recall reading the bitmap file is 8M.
I don't understand.

Colby and I were very concerned about the size of the EWAH compressed
bitmaps because we wanted hundreds of them for a large history like
the kernel, and we wanted to minimize the amount of memory consumed by
the bitmap index when loaded into the process.

In the JGit implementation our copy of Linus' tree has 3.1M objects,
an 81.5 MiB idx file, and a 3.8 MiB bitmap file. We were trying to
keep the overhead below 10% of the idx file, and I think we have
succeeded on that. With 3.1M objects the v2 bitmap proposed in this
thread needs at least 11.8M, or 14+% overhead just for the path hash
cache.

The path hash cache may still be required, Colby and I have been
debating the merits of having the data available for delta compression
vs. the increase in memory required to hold it.

> The
> pack-order ones should be more amenable to run-length encoding,
> especially as you get further down into history (the tip ones would
> mostly be 1's, no matter how you order them).

This is also true for the type bitmaps, but especially so in the JGit
file ordering where we always write all trees before any blobs. The
type bitmaps are very compact and basically amount to defining a
single range in the file. This takes only a few words in the EWAH
compressed format.
