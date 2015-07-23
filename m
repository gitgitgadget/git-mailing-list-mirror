From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Config variables and scripting // was Re: [RFC/PATCH] log: add
 log.firstparent option
Date: Thu, 23 Jul 2015 11:53:37 +0200
Message-ID: <55B0B9A1.7060609@drmicha.warpmail.net>
References: <20150723012343.GA21000@peff.net>
 <20150723044007.GA3651@gmail.com> <20150723051445.GA24029@peff.net>
 <20150723054816.GA1917@peff.net>
 <CA+P7+xrNiK168rXX3SwwmQFPR6i4iA0nhFdfHKL7wqwtwvnEPA@mail.gmail.com>
 <20150723065310.GA7542@peff.net>
 <CA+P7+xrX5q_abQYZ-LkzAjvEKmZ+-ykJBS-DwOaLJ6d62-CHPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 11:53:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIDCJ-0003Ob-3E
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 11:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbbGWJxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 05:53:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40646 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860AbbGWJxk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2015 05:53:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9AF1520B41
	for <git@vger.kernel.org>; Thu, 23 Jul 2015 05:53:39 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 23 Jul 2015 05:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=kejC7u8bPTweeZKbv/RjEgpbIcQ=; b=afgN4e
	GkI1qqA7+XICpEydCtUgUO4HicmfWs0LwPk1/8eHdW2yMua163mSejTxtpvQIfGN
	rfB30SDD59HInsEvt6F7XamKYHteejX0I7iMFsYLgiNZNjDucqXUF35KroTjY+zS
	e+jhSXmKkm1wM4pbvYUNXNH+0bxY4PrAaDEus=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=kejC7u8bPTweeZK
	bv/RjEgpbIcQ=; b=P9WhIr51CjZh9kFSdsFUJFsso5Vy46KdEMWvnLUDLTG+R8b
	XO5I2ps8TL97ZUQ5Rqxh0b4ii8bvlbyz9i6bbmmeFUCA/lG4eNQdRaGZmRHxJddP
	wthtDqG5EPMVghJoa6IbX3GSKErYoPkYq/QjgLcVOg76a6qHRUKWr7wy7uFw=
X-Sasl-enc: 2cTD1SYe4ScYP/ki6Ds0IqOdTbPDEwEhFPtjfQtIFNsJ 1437645219
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DAEB2C00014;
	Thu, 23 Jul 2015 05:53:38 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CA+P7+xrX5q_abQYZ-LkzAjvEKmZ+-ykJBS-DwOaLJ6d62-CHPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274492>

Jacob Keller venit, vidit, dixit 23.07.2015 08:55:
> On Wed, Jul 22, 2015 at 11:53 PM, Jeff King <peff@peff.net> wrote:
>> "man git" already has such a list (which is generated from the
>> annotations in command-list.txt). But I agree that it would probably be
>> helpful to point people directly from "git log" to "git rev-list" and
>> vice versa.
>>
>> -Peff
> 
> That's good. I just know that I've had many a co-worker complain
> because the man page felt too technical because they accidentally
> found their way into a plumbing section. If I heard a specific case of
> confusion again in the future I'll try to work up a patch for it.
> 
> Regards,
> Jake
> 

That reminds me of my attempt to add those "categories" to the man pages
of each command (rather than just to that of "git") so that users know
where they landed. It died off, though: I preferred just specifying the
category (maybe with a long form), others including the whole
explanation of the category (which I thought would be too much text; we
have the glossary for that).

Would something like that help? Maybe "category" plus optionally pointer
to a related command in the "other" category.

Michael
