From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Wed, 27 Aug 2014 21:52:45 +0200
Message-ID: <CAPuZ2NFzHjUSfi1H0RFvOuWdRptwxv-gsUOAJv0Uh5BFLWmnRA@mail.gmail.com>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
	<1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
	<20140825194430.GI30953@peff.net>
	<CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
	<CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
	<20140826122008.GC29180@peff.net>
	<xmqqmwarjiq7.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NGTQoKnSfeN2zte5=fqswN5PcfAULdFy9WnGWPtc2Zskg@mail.gmail.com>
	<xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:52:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMjH2-0002Gn-95
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935467AbaH0Tws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:52:48 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62658 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbaH0Twr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:52:47 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so1112551pad.36
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CK9gaDYU9eWdZ6QQTMcRT9Saqyj75UTlqRZOQhSpwDc=;
        b=HuC+wmtbNxVYPEcjJ6X8p8uZHuOmjw8eIPNQYTfP+wIbOYLCoyGv8uMyyMtjjIfi/0
         UxP90VC9oQccGGpwPZxIBScOR++p4X++9Lr2aEqjN+tszMS6wSZjYKnnO3yNpyar78cC
         UhRvnwunTYyN4P/DQBZ0Dhn1t0KeViyFudRGuZ9GaqcbxmPRCM/ifSpEx4Iaxplw1U9u
         Qy1OMXYdwZO/WEE1/woEdxV/uo8rCa11XfNqmHUnhwiS+otsoS4aZtgvBFuWNv5dzHcI
         FZRKZ5wdjNedgAUP3GiNwtqfk65db8DLV3d8g6TzUqwaydGIMQolCTPX1TJXHBb+i/+M
         zRZg==
X-Received: by 10.70.95.34 with SMTP id dh2mr15157304pdb.119.1409169165862;
 Wed, 27 Aug 2014 12:52:45 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Wed, 27 Aug 2014 12:52:45 -0700 (PDT)
In-Reply-To: <xmqqy4ubi1ty.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256037>

On Tue, Aug 26, 2014 at 7:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Does the current codebase choke with such entries in the index file,
> like you saw in your index file with both stage #0 and stage #1
> entries?

Not sure, I couldn't reproduce an scenario with an index with multiple
entries in the same stage for the same path.
