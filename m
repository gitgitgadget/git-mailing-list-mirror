From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Thu, 22 May 2014 15:52:08 -0700
Message-ID: <0E298290-243D-46E5-A177-C6D3553D7153@gmail.com>
References: <20140521102524.GA30301@sigill.intra.peff.net> <20140521102742.GB30464@sigill.intra.peff.net> <AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com> <20140522055852.GA16587@sigill.intra.peff.net> <xmqq38g1oe2y.fsf@gitster.dls.corp.google.com> <20140522184113.GC1167@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 23 00:52:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnbqT-0003nS-I9
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 00:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbaEVWwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 18:52:12 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43150 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaEVWwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 18:52:12 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so3123693pab.36
        for <git@vger.kernel.org>; Thu, 22 May 2014 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=+DYmFySG+JLaab9gz5J2QQGZYJqaxxvQ861f/vHONPE=;
        b=Mbrmm//PXFlIQR4TblCmiNQ5lHy6v4dEHoWNRlviF6T9Bf0151nSRMLC4pBgcRPZCz
         pyWmsS0s+MLg584sA1p4Sqnsl+ZTSmeRfbTDDhdpGpglCJdPqaX4n5dB907eiXLfPCDm
         8FmpIoZ75QqBB0GCQHr1y1SQSptrkxZNuNOHLojvNsRJzDSW6P7GoJU3Kq94f1H2bCxp
         vi9x32gZGy3iJ7LGTCtQgQxBzG3M6W9N7jiKnUk+JSHDjqmJyXRyvQ+o7HsQX6gj8WoU
         kvbhLBLIlwt0B7zOcjyaH+7stq5XETRtqEaFVj8yjU1vECIzzksQinxfh2Jv3TMw/5ib
         qOyw==
X-Received: by 10.66.122.101 with SMTP id lr5mr911188pab.130.1400799131090;
        Thu, 22 May 2014 15:52:11 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id tu3sm4928482pab.1.2014.05.22.15.52.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 15:52:10 -0700 (PDT)
In-Reply-To: <20140522184113.GC1167@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249954>

On May 22, 2014, at 11:41, Jeff King wrote:

> On Thu, May 22, 2014 at 11:36:37AM -0700, Junio C Hamano wrote:
>
>>> Yes, and that would be fine with me (I actually wrote  
>>> strbuf_tolower for
>>> my own use, and _then_ realized that we already had such a thing  
>>> that
>>> could be replaced).
>>
>> Do we forbid that sb->buf[x] for some x < sb->len to be NUL, and if
>> there is such a byte we stop running tolower() on the remainder?
>
> Christian brought this up elsewhere, and I agree it's probably  
> better to
> work over the whole buffer, NULs included. I'm happy to re-roll (or  
> you
> can just pick up the version of the patch in this thread),

The only reason I brought up the code difference in the first place  
was that the comment was "This makes config's lowercase() function  
public" which made me expect to see basically the equivalent of  
replacing a "static" with an "extern", but actually the function being  
made public was a different implementation than config's lowercase()  
function.  So it looks like the original PATCH 2/9 version of the code  
is best, but perhaps the comment can be tweaked a bit to not convey  
the same impression I got.  Maybe something like "Replace config's  
lowercase() function with a public one".

--Kyle
