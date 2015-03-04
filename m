From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Wed, 4 Mar 2015 19:05:08 +0700
Message-ID: <CACsJy8B=MN412dZYYc=NwpXHVz=Pxv+8wWMT7JNurVgqKrWn8A@mail.gmail.com>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com> <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com> <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
 <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
 <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <xmqqioekawmb.fsf@gitster.dls.corp.google.com> <20150302092136.GA30278@lanh>
 <20150303103351.GA4922@lanh> <xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
 <CACsJy8B_r_0nP9NyKFBnr9bXgwjx8dJkSVkHbZw+Mxin_YpZZw@mail.gmail.com> <CAJo=hJtgda4ATtPeLWbhgDPiTm9h-gzBkpknxsOdRddueUgTbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 13:05:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT83h-0007Rd-2X
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 13:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933143AbbCDMFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 07:05:40 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34071 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932803AbbCDMFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 07:05:39 -0500
Received: by iecvy18 with SMTP id vy18so2447396iec.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 04:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CD0QV6XGBPUmgk/+74Bos4jXHL0bV9XUEZuoXJ00QZw=;
        b=giFgOFrIZRqBPaFWswICRuGHRvhWYcpHNoR7Qezj9neInTsUau3+gEpwuez1IwOnCb
         F3Tf/Vf5RfZlwv8HE6K1a/wzaLeldwmN/5dccaDq3Ef8DABwN1Q9/cwE3a1y0AEcH3An
         +MngsxRMmwfrival/MSlsMCx6jJ8RaByUni1L/IdnYlSYJnyU1uWmiVm+wfqLB6hhyew
         onoZ6mbGZyXNZ1Q91uMw+z2Se8E8SpZ4RJRKnAClXmJPY1ZPl1bE3hVQqVJbUu+hSKWk
         tIa2rMWTRn/aPdZU8OoDGR3+uthoPuu4pDUpC6ZqLZxu3/92g77Tz9yb1Ei6ooc/KK/T
         eh3Q==
X-Received: by 10.107.35.140 with SMTP id j134mr10459862ioj.11.1425470738234;
 Wed, 04 Mar 2015 04:05:38 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 4 Mar 2015 04:05:08 -0800 (PST)
In-Reply-To: <CAJo=hJtgda4ATtPeLWbhgDPiTm9h-gzBkpknxsOdRddueUgTbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264757>

On Wed, Mar 4, 2015 at 11:27 AM, Shawn Pearce <spearce@spearce.org> wrote:
> Let me go on a different tangent a bit from the current protocol.
>
> http://www.grpc.io/ was recently released and is built on the HTTP/2
> standard. It uses protobuf as a proven extensibility mechanism.
> Including a full C based grpc stack just to speak the Git wire
> protocol is quite likely overkill, but I think the embedding of a
> proven extensible format inside of a bi-directional framed streaming
> system like HTTP/2 offers some good guidance.

I'll take this as "learn from grpc, not just reuse grpc"

> Network protocol parsing is hard. Especially in languages like C where
> buffer overflows are possible. Or where a client could trivially DoS a
> server by sending a packet of size uint_max and the server naively
> trying to malloc() that buffer. Defining the network protocol in an
> IDL like protobuf 3 and being machine generated from stable well
> maintained code has its advantages.

I'm still studying the spec, so I can't comment if using IDL/protobuf3
is a good idea yet.

But I think at least we can avoid DoS by changing the pkt-line (again)
a bit: the length 0xffff means that actual length is 0xfffe and the
next pkt-line is part of this pkt-line. Higher level (upload-pack or
fetch-pack, for example) must set an upper limit for packet_read() so
it won't try to concatenate pkt-lines forever.
-- 
Duy
