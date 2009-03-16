From: Steven Tweed <orthochronous@gmail.com>
Subject: Re: Generalised bisection
Date: Mon, 16 Mar 2009 10:29:12 +0000
Message-ID: <d9c1caea0903160329v3c1a1600m9913eafa00cc2f37@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
	 <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
	 <efe2b6d70903130549m63ae9bdeg1cd3f24a43b3e66f@mail.gmail.com>
	 <d9c1caea0903130819u770686b1w867f074ffef8fabf@mail.gmail.com>
	 <efe2b6d70903151216q4a8881e5t797cf5d3bebc5697@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Tapsell <johnflux@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 11:30:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjA5n-0006Sr-HG
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 11:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbZCPK3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 06:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZCPK3R
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 06:29:17 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:49111 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbZCPK3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 06:29:15 -0400
Received: by bwz23 with SMTP id 23so885985bwz.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QgAN9qXAN3Hzyw5xhtTNI0FcpRhnDVm5Y/xGXdcsNw4=;
        b=gaIe/POeG2h8RWlr8j5uEnvvI8uTzJ0VNGM0Py9Pk1HuKIiazSOgSG5byoUv+h1w1w
         glwX5UnE1XbhUiumn6xiG/YUvwVgDhkbtkHKboj+qD4qU9mhK8sqgSwxJZD0e/5wIg95
         bDItfk/tBb8D3slza2nR+YYBXaxtI/CsFcVck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wF1OzsWeFOtXExAsiLsIMsHBBliOfzcCr/KqfMwr3/NpCUBpr5J3XIPeJ4B901XLw4
         LG38XN+XI3b7v0dLJWOufUuEkIOIHNlFlMpyGx9vg5c8QroAziZ0ieuEIOxqVM20CzYn
         NLMTQHE4nk8foYVSOVtRng+6NGPIswA1S88NY=
Received: by 10.223.126.1 with SMTP id a1mr3108035fas.52.1237199352785; Mon, 
	16 Mar 2009 03:29:12 -0700 (PDT)
In-Reply-To: <efe2b6d70903151216q4a8881e5t797cf5d3bebc5697@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113316>

On Sun, Mar 15, 2009 at 7:16 PM, Ealdwulf Wuffinga
<ealdwulf@googlemail.com> wrote:
> On Fri, Mar 13, 2009 at 3:19 PM, Steven Tweed <orthochronous@gmail.com> wrote:
> It is not obvious how to perform this algorithm incrementally, because
> of the need to
> marginalise out the fault rate. As I understand it, marginalisation
> has to be done after you
> have incorporated all your information into the model, which means we
> can't use the
> usual bayesian updating.

I had a look over the weekend, and got a bit sidetracked on one of
your assumptions. You seem to be assuming that the bug is such that
observing a single positive observation of the symptom at a position i
in the linear history _does not_ completely rule out that the guilty
commit occurs after that point. I would have thought the generally
more applicable assumption is that, given that generally you don't
have a bug ridden system where more than one bug causes the same
symptom _within the history of interest_, that a single observation of
the symptom does totally rule out the bug after that point (whilst
intermittency clearly not having observed the bug before that point
doesn't completely rule out the guilty commit being earlier, although
it should increase the liklihood estimate of the bug being later).

I wonder what your thoughts are on this? (I started formulating a
model over the weekend, but work is a bit hectic so I may not get to
write it up in LaTeX very quickly.)
