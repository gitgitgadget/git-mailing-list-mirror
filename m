From: Charles Bailey <charles@hashpling.org>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 11:39:52 +0000
Message-ID: <20080223113952.GA4936@hashpling.org>
References: <200802221837.37680.chase.venters@clientec.com> <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr> <20080223014445.GK27894@ZenIV.linux.org.uk> <7vfxvk4f07.fsf@gitster.siamese.dyndns.org> <20080223020913.GL27894@ZenIV.linux.org.uk> <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com> <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 12:40:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSskH-0000in-07
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 12:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbYBWLkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 06:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbYBWLkG
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 06:40:06 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:33746 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYBWLkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 06:40:03 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1JSsjY-0003tZ-Kv; Sat, 23 Feb 2008 11:40:00 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1NBdqhL005315;
	Sat, 23 Feb 2008 11:39:52 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1NBdqMQ005314;
	Sat, 23 Feb 2008 11:39:52 GMT
Content-Disposition: inline
In-Reply-To: <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: c6107c82179c7df9e1d0d7527b182b78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74816>

On Sat, Feb 23, 2008 at 03:47:07AM +0100, J.C. Pizarro wrote:
> 
> Yesterday, i had git cloned git://foo.com/bar.git   ( 777 MiB )
>  Today, i've git cloned git://foo.com/bar.git   ( 779 MiB )
> 
>  Both repos are different binaries , and i used 777 MiB + 779 MiB = 1556 MiB
>  of bandwidth in two days. It's much!
> 
>  Why don't we implement "binary delta between old git repo and recent git repo"
>  with "SHA1 built git repo verifier"?
> 
>  Suppose the size cost of this binary delta is e.g. around 52 MiB instead of
>  2 MiB due to numerous mismatching of binary parts, then the bandwidth
>  in two days will be 777 MiB + 52 MiB = 829 MiB instead of 1556 MiB.
> 
>  Unfortunately, this "binary delta of repos" is not implemented yet :|

It sounds like what concerns you is the bandwith to git://foo.bar. If
you are cloning the first repository to somewhere were the first
clone is accessible and bandwidth between the clones is not an issue,
then you should be able to use the --reference parameter to git clone
to just fetch the missing ~2 MiB from foo.bar.

A "binary delta of repos" should just be an 'incremental' pack file
and the git protocol should support generating an appropriate one. I'm
not quite sure what "not implemented yet" feature you are looking for.
