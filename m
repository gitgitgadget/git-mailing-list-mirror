From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Mon, 1 Jul 2013 12:13:25 -0700
Message-ID: <CAJo=hJv=rb2S1DqERQ9GJRQkix=Z5pG2jEyghVDcCHPSF7AKDA@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com> <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
 <7vtxkl28m7.fsf@alter.siamese.dyndns.org> <CAFFjANRqZ0U5tGhgjACUtquyVKCyuHiS3CC2Xxwo0J1UJVrf=g@mail.gmail.com>
 <CAJo=hJtJoizQUubriTPvs2bsjvw+N82MCPvw263fUB8vv8_VVA@mail.gmail.com>
 <CAFFjANSr2QRLE8DSPP2zZ_baEZUqR8dzkPzMwqyEqgFX=8cnog@mail.gmail.com>
 <20130627024521.GA6936@sigill.intra.peff.net> <CAJo=hJvOq=CATrDeYAwi+jgkPpqjywWhuKeC1TVYeCXr6NVM6w@mail.gmail.com>
 <CAFFbUKKm89n0HG6xUhYMLs_yjRJ8n0jFtOEEN=vXxJfWKLx5FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Colby Ranger <cranger@google.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 21:13:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtjXq-0002JA-Mp
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 21:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab3GATNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 15:13:46 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55273 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab3GATNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 15:13:46 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so9059111iec.8
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YoX0YBBcBJE/CBNVDrd4W3UnBJPunJB36KGbpC9xnvs=;
        b=amkmHr9lcNLWxxphwxe20yqnu7f2iSrG3bXvmnBF1daqhBCHQseue1nYNZz5UL2CLO
         mAmJ+NYXwA3Xwr+Np/mrv9XGjUjomTzzup9MlJEMRX4KpVzxtHZG22SDYLzSmjJ+nWrL
         mQayEKmFWfPzEU2pZ5ewqntIsE60lNAUUbNME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=YoX0YBBcBJE/CBNVDrd4W3UnBJPunJB36KGbpC9xnvs=;
        b=YJT8pWGPRgulTVyhvgb5+CVg9FN4j1Y3iCrA5GC1KzU+pyPt8s4Yocx1WTNZzJwV22
         o00D0xlLWodPyWIN2QpQiPYTLBhBYoNP4OcfqhyqI/jH6/hOG2XkTpJq67NvZuyLE84i
         OW5teFS275MRWr8TeKhVpRUYL3MpkQujCozfetBMkkilfOHZ+sxLDN9Hn+4FUkzLqjtK
         j2/b4jMx93uFXbxFDqj6szgYVWokBEUrOMDpEjs96YW96ho9Qb4SMtYIQ4VwghVdZbLu
         aBJIihUONWdQGWzg29UZ5xATyBPYq0Qj1dOPyZWj8M+iAgyWwhVqo+YSY4nGfbwDErPy
         q4WQ==
X-Received: by 10.50.119.74 with SMTP id ks10mr14138658igb.59.1372706025559;
 Mon, 01 Jul 2013 12:13:45 -0700 (PDT)
Received: by 10.64.143.200 with HTTP; Mon, 1 Jul 2013 12:13:25 -0700 (PDT)
In-Reply-To: <CAFFbUKKm89n0HG6xUhYMLs_yjRJ8n0jFtOEEN=vXxJfWKLx5FA@mail.gmail.com>
X-Gm-Message-State: ALoCoQlUeoW6daxrJzEE1boAtjKewHjoEHnWdyw0f+RsGuRzvyCp1FVYzIlj89R2HKtsKapuj/ul
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229322>

On Mon, Jul 1, 2013 at 11:47 AM, Colby Ranger <cranger@google.com> wrote:
>> But I think we are comparing
>> apples to steaks here, Vincent is (rightfully) concerned about process
>> startup performance, whereas our timings were assuming the process was
>> already running.
>>
>
> I did some timing on loading the reverse index for the kernel and it
> is pretty slow (~1200ms). I just submitted a fix to do a bucket sort
> and reduced that to ~450ms, which is still slow but much better:
> https://eclipse.googlesource.com/jgit/jgit/+/6cc532a43cf28403cb623d3df8600a2542a40a43%5E%21/

A reverse index that is hot in RAM would obviously load in about 0ms.
But a cold load of a reverse index that uses only 4 bytes per object
(as Colby did here) for 3.1M objects could take ~590ms to read from
disk, assuming spinning media moving 20 MiB/s. If 8 byte offsets were
also stored this could be more like 1700ms.

Numbers obviously get better if the spinning media can transfer at 40
MiB/s, now its more like 295ms for 4 bytes/object and 885ms for 12
bytes/object.

I think its still reasonable to compute the reverse index on the fly.
But JGit certainly does have the benefit of reusing it across requests
by relying on process memory based caches. C Git needs to rely on the
kernel buffer cache, which requires this data be written out to a file
to be shared.
