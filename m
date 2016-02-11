From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Thu, 11 Feb 2016 16:44:41 +0100
Message-ID: <56BCAC69.8030909@drmicha.warpmail.net>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
 <xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
 <xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
 <56BB4BDF.3010407@drmicha.warpmail.net>
 <xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Dickson Wong <dicksonwong@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 16:44:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTtQK-00050M-0U
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 16:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbcBKPor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 10:44:47 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33683 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751435AbcBKPoq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 10:44:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 00A03208A2
	for <git@vger.kernel.org>; Thu, 11 Feb 2016 10:44:45 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 11 Feb 2016 10:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=N6wkT9Ami56c9LPviVtj/LEJr/I=; b=YjdYjz
	SCV6UZm//c+zXKJyWFnEnkRAOiCHqU6UlXnMD4y0lSPBbpY0qjVmcYezx34GzWxb
	+UYoKAm26cyT7el24Y6y64c/8i/6pa/lef2Tduw/d+lidu1FYklNHhVv4PsIvwR1
	l/APHLtAqdVIDCJ3Arh7VNeqop25UwHpsa9jw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=N6wkT9Ami56c9LP
	viVtj/LEJr/I=; b=gJU5KdGbopm4nfonV1IFEGe24VwSi+Omh2k1DeuWRD9p6XY
	GTg0tV2/3UMFF23mIt6h0p7uokyF17JVoV7lXx2AydbpBmp64++9ksJtOIOdIHYE
	WkiF0etCgQU4EWVYTVmg6DO+JmcLKs9cYt5Se7ckRDPDMMWaTn+jm3/BfW7c=
X-Sasl-enc: SHqol63BeJD+k1eVrZhdpj6V3zir691lt2SZ8051lUEl 1455205484
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 50A84C0001A;
	Thu, 11 Feb 2016 10:44:43 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285981>

Junio C Hamano venit, vidit, dixit 10.02.2016 18:45:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> Second call for help.  Any comments on this from anybody other than
>>> the author that I missed to support this change?
>>
>> OK, applied it (on top of next), looks sane and improves the situation
>> for the majority of people who read left to right, then top down and
>> assign buffers 1 2 3 4 "mentally" to local base remote merge windows
>> based on that. Their expectation is met now. Thanks!
> 
> Thanks.
> 
> Does this mean that I should warn in the release notes that some
> existing users might get their expectation broken but we are going
> ahead anyway because we think most people read left to right and
> then top down?  I am OK with saying that--I just wanted to make sure
> we know that it is what we are doing.

I would claim that anyone who notices the difference in buffer numbering
would be positively surprised.

>> (Also, the other vim variants don't need a corresponding change.)
> 
> A stupid question while I am here.  What are these different
> variants?  When reviewing this patch for the first time I tried to
> find where they are documented, but didn't spot anything.
> 
> I can see from the code that vimdiff2 variant does not do anything
> special when it is doing a 3-way merge,

It is "vimdiff" without the base window.

> but vimdiff3 variant does
> behave differently when it has $BASE.  It does not need a change
> like this because it already arranges and numbers the windows
> sensibly (in other words, we can label this patch as aligning the
> behaviour of vimdiff to that of vimdiff3)?

git log mergetools/vimdiff3
commit 7c147b77d34f072c40b912fafba499727921fa6e
Author: Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun Apr 20 19:24:20 2014 -0500

    mergetools: add vimdiff3 mode

    It's similar to the default, except that the other windows are hidden.
    This ensures that removed/added colors are still visible on the main
    merge window, but the other windows not visible.

    Specially useful with merge.conflictstyle=diff3.


I have to say I'm still not sure what it is about (even after trying it
out, even with the conflictstyle config)).

In any case, the buffer numbering is not the same (it is local remote
base merge) but it doesn't matter in this case because only one window
is displayed, so there is no visual association.

Michael
