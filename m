From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Mon, 05 Nov 2012 14:39:28 +0100
Message-ID: <5097C190.80406@drmicha.warpmail.net>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 14:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVMu0-0003Cg-4h
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 14:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2KENjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 08:39:31 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40910 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751042Ab2KENja (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 08:39:30 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1CDAA209FE;
	Mon,  5 Nov 2012 08:39:30 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 05 Nov 2012 08:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=rJ6vfS2qmoxZVlEBcWObhN
	NtNNs=; b=NRXBUbkGP0bcSRkRKJwvR90EFWRNqOFbuywqfp616CUJgH06hyAT0f
	eiVQF1QIhTRrSs6Z6HXBdUHvtvHsQOZqwP7jQusvr85x0ugzENESKsiTpq4mJG7V
	HbN9+ECDWWMNlc5LDFcf5OgLzJkYrWe/w0d2oIHt96C+NGLvBM07o=
X-Sasl-enc: npgiE4Loyc/jcp9dmpEaeatjceaeopt8zsGHSczxSzoZ 1352122769
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9509A482655;
	Mon,  5 Nov 2012 08:39:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209058>

Eric Miao venit, vidit, dixit 05.11.2012 03:26:
> Hi All,
> 
> Does anyone know if git has sort of support for a series of patches, i.e.
> a patchset or changeset? So whenever we know the SHA1 id of a single
> patch/commit, we know the patchset it belongs to. This is normal when
> we do big changes and split that into smaller pieces and doing only one
> simple thing in a single commit.
> 
> This will be especially useful when tracking and cherry-picking changes,
> i.e. monitoring on the changes of some specific files, and if a specific
> patch is interesting, we may want to apply the whole changeset, not only
> that specific one.

First of all, if you know the sha1 of a commit, then all its ancestors
are determined by that. If you want to describe a set of patches, say
based on rev1 and leading up to rev2, then the expression

rev2 ^rev1

describes that set uniquely. Often you can do without ^rev1, e.g. if you
know that all patch series are developed bases on origin/master, then
specifying rev2 is enough as "git rev-list rev2 ^origin/master" will
give you all commits in the series (unless they have been integrated,
i.e. merged).

Or are you thinking about patches "independent" of a base?

Cheers,
Michael
