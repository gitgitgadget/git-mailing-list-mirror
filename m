From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 14:56:45 +0200
Message-ID: <5060588D.3080202@drmicha.warpmail.net>
References: <5060097F.9050203@drmicha.warpmail.net> <CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com> <50601274.80506@drmicha.warpmail.net> <CACsJy8ChOd-684V8Dsbwf2nOsW8UMnYn_vo5MAZ6ixyq_QvMkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 14:57:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG8De-0003Wz-WE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 14:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab2IXM4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 08:56:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58111 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753844Ab2IXM4r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 08:56:47 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C845A209C7;
	Mon, 24 Sep 2012 08:56:46 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 24 Sep 2012 08:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4XD0z2btaV3j4gyne9PHaV
	qQP8Q=; b=p9O9xMljVXGhMcJxRjk6zGSA8Z77pfpnm6gNGvFUbg67aGr693Z0dY
	NeLVd1sBIK3fIWwHLKq1TC6c1WlpfUPc2vCM6sreP39G9TUK7818Kz3xMpXKPyNu
	JS6MV4AfBYMPAg7yro3mFHQMRuUMsYUgvNa2CAMgnW37Z8LEy8Mbs=
X-Sasl-enc: fhc2ZbN2Fp3kQrpz6pN5tve+fzvj1epYy4MQNkI2AVlB 1348491406
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4C1D64827CE;
	Mon, 24 Sep 2012 08:56:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <CACsJy8ChOd-684V8Dsbwf2nOsW8UMnYn_vo5MAZ6ixyq_QvMkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206264>

Nguyen Thai Ngoc Duy venit, vidit, dixit 24.09.2012 11:53:
> On Mon, Sep 24, 2012 at 2:57 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> It might be difficult to implement, but I'm sorry I can't follow the
>> argumentation above at all; it's not based on what we do in other places
>> and other cases.
> 
> My point is, what's so special about --git-dir? what about
> --work-tree, or "commit -F path"? It's hard to draw a line there.

Sure those should follow, especially work-tree.

> Config files are a special case, because git is the only one that
> reads the file. "~" expansion depends on shell setting. If users turn
> it off, they may be surprised that "~foo" is turned to /home/foo while
> they really mean "~foo". Warning is the only sensible thing we could
> do.

But that argument applies to config files in exactly the same way as it
applies to command line arguments. Git is the only one reading them. So
why not leave it up to Git to decide about expansion?

On the other hand: If Git expanding arguments is surprising, why is it
unsurprising if Git expands config values?

You know the implementation, so there are no surprises for you. But once
in a while we can pretend to design Git for those who just use it.

Michael
