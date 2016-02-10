From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 14:17:58 -0800
Message-ID: <20160210221758.GC10155@google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <20160210214945.GA5853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:18:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTd5M-0004ce-As
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 23:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbcBJWSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 17:18:04 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33685 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbcBJWSC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 17:18:02 -0500
Received: by mail-pf0-f173.google.com with SMTP id q63so18727185pfb.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O09uwd7DvXSLQr/H5NlsIlG08hcAH9zwtsTFgw/Z9K4=;
        b=SexEcb5TEWAU4JbAW151jP2hmxUMYknvpSlRNGNK7Pb+rDKn1U8Y/VGludhnG53M69
         y1D4Go7ZMlSv9LIYX43tJ/yaRkwS87y2uZRaJ+jYY+BJ+btkZeB65OcumU6r+roMHclO
         48H8DppChqt7mvhMW77ECOZhW+JXfpheynGcjLJgMmIwIsiPQ1WOPbmOGsSZAnbGgRrL
         kS5FLhvLviuLnMQBlRcHrOyQciORz3ktV/JuNEqPpNONmZ6v/jzTDlTzsB0Ary+kBpJO
         hZ1lM4B9qmt9/+Mrc+BYvuvGCfZTgZH7MVGBL2em7ncNCi5MGm3zUSsmfTXh+cODh2O4
         mOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=O09uwd7DvXSLQr/H5NlsIlG08hcAH9zwtsTFgw/Z9K4=;
        b=BzyEaDuBU3TXELAwACHOgOaHmL5VGxWmuNw3J9w/4qA228Vft9qbFdWYxAfysRRhuS
         7tzMZRODrcUmWVyyTzBKOO7ZKKCBWWqtDzQWnRaZ6Ok8WKgXiyM/gDGbm0JlHkKQhvNS
         t5yTZWdhX1bHlH7qisSfwF/qj9j5hqDqcKAYvcEopzE3KZxGQPbvrtJdyweHx+KL0bK9
         DZy9zu4KvxQjTlyM82jbn1krxTWxCOP9V69zDqeiZKJIDFOtqwnXS9rLQ8Vca+W4MDEX
         OiHaLpuwgmTHnxvjbEd+I2uGTBjH3V0/vP4VBQ2NipIh/4hBia1eBrMuViJ+jPCZZT6M
         19WQ==
X-Gm-Message-State: AG10YOTP6V0YVUMIJE9JqWjoAEz0WR2svjxCZguufNZ2X2JINnFtAs7c9CAXXAn12iKbhQ==
X-Received: by 10.98.15.17 with SMTP id x17mr20635063pfi.52.1455142681510;
        Wed, 10 Feb 2016 14:18:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:986b:44f8:244c:add9])
        by smtp.gmail.com with ESMTPSA id d22sm7417735pfj.32.2016.02.10.14.18.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Feb 2016 14:18:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160210214945.GA5853@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285937>

Jeff King wrote:
> On Wed, Feb 10, 2016 at 12:11:46PM -0800, Shawn Pearce wrote:

>> Several of us at $DAY_JOB talked about this more today and thought a
>> variation makes more sense:
>>
>> 1. Clients attempting clone ask for /info/refs?service=git-upload-pack
>> like they do today.
>>
>> 2. Servers that support resumable clone include a "resumable"
>> capability in the advertisement.
>
> Because the magic happens in the git protocol, that would mean this does
> not have to be limited to git-over-http. It could be "resumable=<url>"
> to point the client anywhere (the same server over a different protocol,
> another server, etc).

Thanks for bringing this up.  A worry with putting the URL in the
capabilities line is that it makes it easy to run into the 1000-byte
limit.  It's been a while since v1.8.3-rc0~148^2~6 (pkt-line: provide
a LARGE_PACKET_MAX static buffer, 2013-02-20) but we still can't
rely on clients having that applied.

(I also haven't checked whether current versions of git are able to
handle longer capability strings with that patch applied.)

Another nice thing about using a 302 is that you can set cookies
during the redirect, which might make authenticated access easier.
(That said, authenticated access through e.g. signed URLs can work
fine without that.)

[...]
> Clients do not have to _just_ fetch a packfile. They could get a bundle
> file that contains the roots along with the packfile. I know that one of
> your goals is not duplicating the storage of the packfile on the server,
> but it would not be hard for the server to store the packfile and the
> bundle header separately, and concatenate them on the fly.

Doesn't that prevent using a git-unaware file transfer service to
serve the files?

It also means the client can't use the downloaded file as-is --- they
need to separate the root list from the packfile (that's not a big
deal; just some added complication to switch files at the appropriate
moment during download if you want to avoid temporarily using twice
the space).

That said, both these problems are avoided by serving the 'split
bundle' you described as-is instead of concatenating.

[...]
> And you'll notice, too, that all of the bundle-http magic kicks in
> during step 2 because the client sees they're grabbing a bundle. Which
> means that the <url> in step 1 doesn't _have_ to be a bundle. It can be
> "go fetch from kernel.org, then come back to me".

I think that use case brings in complications that make it not
necessarily worth it.  In this example, if kernel.org is serving pack
files, why shouldn't I point directly at the advertised pack CDN URL
instead of adding an extra hop that puts added load on kernel.org
servers?

Allowing an arbitrary "fetch from here first" capability is very
flexible.  I guess my fear comes from not knowing what the flexibility
buys beyond aesthetics.  (My motivation comes from the example of
alternates: it is pretty and very flexible and ended up as a support
and maintenance headache instead of being widely useful.  I think what
you are proposing is more harmless but I'd still want to have an
example of what it's used for before going in that direction.)

Thanks,
Jonathan
