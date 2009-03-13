From: Steven Tweed <orthochronous@gmail.com>
Subject: Re: Generalised bisection
Date: Fri, 13 Mar 2009 15:19:38 +0000
Message-ID: <d9c1caea0903130819u770686b1w867f074ffef8fabf@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
	 <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
	 <efe2b6d70903130549m63ae9bdeg1cd3f24a43b3e66f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Tapsell <johnflux@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 16:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li9H8-0001wj-Bm
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 16:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbZCMPYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 11:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbZCMPYn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 11:24:43 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:38787 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbZCMPYm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 11:24:42 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2009 11:24:41 EDT
Received: by bwz23 with SMTP id 23so161381bwz.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=knA1Hs8+eWjVd0QAZqHEdrRQQgz+1pCInj99Vbi+a6M=;
        b=vhbYAoHMY+5PE4Y4WBd1HksmB2/5B9oLAKQC9CYvAn24RQWsqedirhMl1rhnJGDLYj
         ijZ4oPaxEo9YkHgKiu5+8beH0luepaXPGKL8WxLH++oIoo8Ior9nnKgWEdSrf0Y6bzn1
         h2KhDlo5TldRpgmZVmuBB5y1PL+J4olrjVq8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P0nxUNZ6/bmoNXV8Gj1LqiyshgXWBLxvTvySsA7f0cxFnLRZ0Rz2GaDh+jvvnuKjI2
         Ag7JkNuXuRlln8xpIQI0sgxzlXVcViu+P4M/yzBllSQzzrNN0z9Y0VQGkpjUUkgOjeMN
         yG3n8y0Kddhi3iyMe7RibGGnBeKyIu8NavO6s=
Received: by 10.204.55.199 with SMTP id v7mr430556bkg.141.1236957578978; Fri, 
	13 Mar 2009 08:19:38 -0700 (PDT)
In-Reply-To: <efe2b6d70903130549m63ae9bdeg1cd3f24a43b3e66f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113196>

On Fri, Mar 13, 2009 at 12:49 PM, Ealdwulf Wuffinga
<ealdwulf@googlemail.com> wrote:
> On Thu, Mar 12, 2009 at 6:02 PM, Steven Tweed <orthochronous@gmail.com> wrote:
>> I haven't even looked at the source code so a description of the
>> mathematical algorithm would help, but I'll just point out that
>> underflow (in the case of working with probabilities) and overflow
>> (when working with their negated logarithms) is inherent in most
>> multi-step Bayesian algorithms. The only solution is to rescale things
>> as you go so that things stay in a "computable" range. (You're almost
>> never interested in absolute probabilities anyway but rather relative
>> probabilities or, in extreme cases, just the biggest probability, so
>> rescaling isn't losing any useful information.)
>
> Are you sure you aren't thinking of when you are using fixed point? I
> was under the impression
> that Bayesian algorithms usually worked okay in floating point.

Underflow when using probabilities and lack of precision (rather than
overflow) when using negated logarithms are well known problems in the
kind of probabilistic object tracking, inference in graphical networks
and object identification processes I work with (in computer vision).
I there may well be other areas of Bayesian decision theory where this
doesn't happen, and indeed a _very_ quick scan through your document
suggests that you're adding to tallying information on each timestep
and recalcuating the entire model from those tallys, which is one of
the few cases where you can't really do rescaling. I'll try and have a
more detailled read over the weekend.

> One issue in BBChop which should be easy to fix, is that I use a dumb
> way of calculating Beta functions. These
> are ratios of factorials, so the subexpressions get stupidly big very
> quickly. But I don't think that is the only problem.

Yes, "Numerical Recipes" seems to suggest that computing with
log-factorials and exponentiating works reasonably, although I've
never tried it and NR does occasionally get things completely wrong...
