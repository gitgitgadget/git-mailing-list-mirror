From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/4] basic priority queue implementation
Date: Fri, 20 May 2011 10:13:10 -0300
Message-ID: <BANLkTinojbxq=y3f-GPJsL7OH2OAJfW6zw@mail.gmail.com>
References: <20110519212349.GA28589@sigill.intra.peff.net>
	<20110519212448.GB29584@sigill.intra.peff.net>
	<BANLkTikLSwWanxUksf3Ezx7uhaTR4mMiWw@mail.gmail.com>
	<20110520073821.GA3663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 20 15:13:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNPW3-0006aF-PD
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 15:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066Ab1ETNNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 09:13:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37546 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab1ETNNL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 09:13:11 -0400
Received: by ywe9 with SMTP id 9so1112431ywe.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nQYT5ts7kJjKIfOeQLTqN+6gWFnfC1SVEIix9BhCgs4=;
        b=uwUnmaThhDLe9hawQzx05g+BgUEdJLrA6lify3au0cKHD9xv3vDi6sKoexK9X0r1F0
         uTbhaOh56NR/eNCx/SgCL1l3nM5GaMimonYC9fuhHLxlxjk8OZ6LR5HY2mT0/IlnUijJ
         xw3Iag6gQdXBRiAQqvx8TyYDuk6J6c0QfxWQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GWX5Dw9Cl+sVYsYNotB6qLx7gz0/+PMymMHHXzRcfHsBFEphj627KtulezvM84uFwb
         f8ky4cdTjLEmsSsaTmBWp1W2Y/+3QF5cTggRn9NvBVhJtIjTWiHtrSA7bvmQn/pQnojP
         If46p4flFatbIWvRFCK+54+M5vCmt040MoXH8=
Received: by 10.151.130.2 with SMTP id h2mr420022ybn.171.1305897190145; Fri,
 20 May 2011 06:13:10 -0700 (PDT)
Received: by 10.151.82.7 with HTTP; Fri, 20 May 2011 06:13:10 -0700 (PDT)
In-Reply-To: <20110520073821.GA3663@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174059>

On Fri, May 20, 2011 at 4:38 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 19, 2011 at 09:47:38PM -0300, Thiago Farina wrote:
>
>> > +void queue_insert(struct queue *pq, void *item);
>> I'd rename this to queue_append as we add |item| to the end of the
>> array (like you did for sha1_array_append), opposed of inserting it at
>> some position/index.
>
> It's definitely not an append. The data structure is a priority queue,
> so the element is inserted within the heap at the proper position
> according to the comparison function (notice that we stick at the end,
> but then heapify_up).
>
OK, sorry. I didn't read the heapify_up part :(

> Speaking of naming, though, the real problem is that this data structure
> should be called "pqueue" or something similar to indicate that it is
> not a simple FIFO. Unfortunately, the short-and-sweet "pqueue" is taken
> by openssl, which pollutes all over the global namespace.
>
Hum, yeah when I read the commit message I though about the name of
the structure, but I didn't want to bother you with that. Probably you
have considered the option of naming it 'priority_queue' too. Haven't
you chose priority_queue, because you consider the name longer than
necessary?

> -Peff
>
> PS If you don't mind, please try to trim your quoted text a bit. Finding
> your 3-line paragraph amid 200 lines of quoted text was a little
> challenging. :)
>
OK. ;)
