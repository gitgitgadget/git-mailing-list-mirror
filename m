From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git rebase --interactive commits order
Date: Fri, 13 May 2011 19:51:12 +0200
Message-ID: <20110513175112.GA14079@vidovic>
References: <BANLkTimX2tupqV464+Re8u06TT+qRmqPuw@mail.gmail.com>
 <BANLkTi=PyBfMxCbWNfJEXEP6-MphdeE+_Q@mail.gmail.com>
 <m2d3jr1mev.fsf@Spindle.sehlabs.com>
 <BANLkTim1e=+yoyxd1AAThVYMZ_X3nfz=7Q@mail.gmail.com>
 <BANLkTinRcigdQv2GJN6L+nF3X2+F-5Lf5w@mail.gmail.com>
 <7vwrhygmrp.fsf@alter.siamese.dyndns.org>
 <BANLkTikV_TSEE1cgr=EOhuD0f8KP2vh-tA@mail.gmail.com>
 <7v39klgng7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Peterson <richard@rcpeterson.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 19:51:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKwWM-0002pW-8L
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 19:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab1EMRvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 13:51:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57113 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1EMRvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 13:51:20 -0400
Received: by wya21 with SMTP id 21so2086322wya.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n24pV175rUJuUJgFso+Ijbql6wmVCPl0zkL72i7z+dM=;
        b=tItQ/2bXRb7rNIw5Ta3204W56k+sBN4M7JsetKkSYfzv6WCSobLjm8CJNshDS1WeJe
         ZkrgKDyxHEzrCrZWtIvVCFROoNOGG7NogRqMXyAZfR5a31TRR3yCKH5bQmvDUrsP+qeN
         iB48fgZRSJ0xuKU7EUZzV23eujf5VF0+Ve7Co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B7mv8LD/N9ltZZXMz/5F7QLv//YaCDoRN7LnNcCt1CY9VOq2ZQS75uYq+oV2o4UdeE
         ltBvQeTufQHPldI1AAqwIEzn372cMRfK0kebkc5FBv7bPxHfb7LJ/baVvNzqUSN3kC7U
         UnhXXFBl6xW+36tr34WoErpGwwDR6xYhcdiDA=
Received: by 10.227.60.131 with SMTP id p3mr1723676wbh.80.1305309078818;
        Fri, 13 May 2011 10:51:18 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id y29sm1532443wbd.38.2011.05.13.10.51.15
        (version=SSLv3 cipher=OTHER);
        Fri, 13 May 2011 10:51:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v39klgng7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173555>

The 11/05/11, Junio C Hamano wrote:
> Richard Peterson <richard@rcpeterson.com> writes:
> 
> > On Tue, May 10, 2011 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Devils lie in the details.  For example, should squash/fixup come before
> >> or after the squashed commit when --reverse is in effect, and why?
> >>
> >> Should "rebase --reverse --continue" work after it gets interrupted, if
> >> not why not?
> >
> > Yes, it should work,...
> 
> Of course, if you start with --reverse, it is clear and obvious that
> 'continue' should continue with the reversed instruction sheet, and it
> probabaly should take --reverse as a no-op when given with --continue.
> The original question should have been written more carefully to avoid
> soliciting the response that addresses that uninteresting case.

I don't understand. Why not just _display_ the commit in reverse order?

Then, from the user POV commands like squash, fixup, etc would apply in
reverse order too (from up to down); keeping the mental model for "apply
against ancestor".

-- 
Nicolas Sebrecht
