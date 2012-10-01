From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Mon, 1 Oct 2012 12:16:34 +0700
Message-ID: <CACsJy8CQaOw9aUJDAoG+gg_n0=A-62KdwYukf-MbgXwCigr8xA@mail.gmail.com>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
 <CACsJy8APNsDrTH+hUxgcB=MY0eECCGktm6P1feEEpz2427OQqg@mail.gmail.com>
 <CAJo=hJtweVTOUT84U1=ONnjQXz5Rt_sDYD2BjUP9tOQ4HDj6Kg@mail.gmail.com>
 <CACsJy8BY2DFhgqdwQdm58+rCuwDj8-7xtqUV9S5cbErU36+zPQ@mail.gmail.com> <CAJo=hJsGptu8c04XQh0xLmMhz+mxYKAOQfhbjaNK887dY-jAMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 07:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIYNy-0006iF-GJ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 07:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904Ab2JAFRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 01:17:07 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45312 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab2JAFRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 01:17:06 -0400
Received: by ieak13 with SMTP id k13so11287447iea.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 22:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AABe12CLRA+vXwlqH5VeEhj69b5SLJeztP41TGLo7uw=;
        b=FJ1fL1pb8Gw1ziJIzyeu4QHUGWYXtkJMqpUVigNmJZpqGic7tM+/oFwQ+d0/O1I41b
         Y7gwEyQKY4YhQWssmyflaO/B0w1L7gYciYa45bfD5+6woimAy5Dtf7n7xv2XG69piVS1
         uZNLMKnfbXKvl32l8PNx/uOmFLeUjkBvfvolGVhm5xOJEiUZ26TZkOK9NUl8PWOPkqvW
         JO/9Q+yrq7znmPg7BpZHmkKdwFSvh1Di6uDPNITnWuKEZ45BVzeJKaJhyCnwtQTNX+LL
         aH6gZXRTKVOHC7kle3KIeNR5TkkSM34S7fQWQM+Hfj/m0OdsHuttrAfb7YvvI8DKpv8G
         zpzg==
Received: by 10.50.207.33 with SMTP id lt1mr4682035igc.40.1349068625117; Sun,
 30 Sep 2012 22:17:05 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Sun, 30 Sep 2012 22:16:34 -0700 (PDT)
In-Reply-To: <CAJo=hJsGptu8c04XQh0xLmMhz+mxYKAOQfhbjaNK887dY-jAMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206714>

On Mon, Oct 1, 2012 at 9:27 AM, Shawn Pearce <spearce@spearce.org> wrote:
> Git has enough magic switches. It doesn't need yet another magic
> switch that one group of users needs to set, and another can safely
> ignore because their project's usage just happens to align with Linus
> Torvald's current world view.

I see it as tuning, not switching.  It's like setting the number of
commits where bitmaps are taken. We can see the commit cache as a
table, where columns are commit properties. We have a column for date,
one for the first parent. Users can choose to have a third column for
the second parent, or another one for root tree sha-1. The
implementation could be made generic to support caching any <n>
sha1-columns.
-- 
Duy
