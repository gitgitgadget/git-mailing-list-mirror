From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH-w 101/105] t6300 (for-each-ref): modernize style
Date: Thu, 1 Mar 2012 07:48:08 -0800
Message-ID: <20120301154808.GG2572@tgrennan-laptop>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-7-git-send-email-tmgrennan@gmail.com>
 <7v62epqd9a.fsf@alter.siamese.dyndns.org>
 <20120301032053.GD2572@tgrennan-laptop>
 <7vty29ovcd.fsf@alter.siamese.dyndns.org>
 <20120301051010.GE2572@tgrennan-laptop>
 <87ty28n244.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 16:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S38FE-0005Lk-5X
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 16:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966351Ab2CAPs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 10:48:27 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47932 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965030Ab2CAPsO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 10:48:14 -0500
Received: by vbbff1 with SMTP id ff1so563439vbb.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 07:48:13 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.36.176 as permitted sender) client-ip=10.52.36.176;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.36.176 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.36.176])
        by 10.52.36.176 with SMTP id r16mr8677410vdj.84.1330616893954 (num_hops = 1);
        Thu, 01 Mar 2012 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QvUZyie6XLdl0ic+kVC+QXYKYz9J4wkQoXVJDj+oxBw=;
        b=v4YLHsx6DUE3dZUrGK3sY28rHLWlXmpLIhpVl1jW5kHE+QbSkrYAtsxny49o1Akdcs
         GbIprRnj1IXu3+RNpzR3IQX9NfYvQz2t7iShPIeuhLvq4IEVMKdDPFJNDmbUI0Fnwszu
         reQeK1Wdu8uEl2cbcmB0eYPztpQOXFOwBBhGY=
Received: by 10.52.36.176 with SMTP id r16mr7313033vdj.84.1330616893907;
        Thu, 01 Mar 2012 07:48:13 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id he3sm3666296vdb.2.2012.03.01.07.48.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Mar 2012 07:48:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87ty28n244.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191938>

On Thu, Mar 01, 2012 at 09:42:51AM +0100, Thomas Rast wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>> On Wed, Feb 29, 2012 at 07:26:10PM -0800, Junio C Hamano wrote:
>>>Tom Grennan <tmgrennan@gmail.com> writes:
>>>
>> Like I said, I think there is currently a debug distraction with verbose
>> mode.  However, rather than hiding expected failures and diverting other
>> output as I had, perhaps we should dup stderr to stdout in verbose mode
>> so error messages show up near the logged invocation when piped through
>> a pager (i.e. mimic "|&").  With this, one can quickly scan past the
>> noise to focus on the broken cases.
>
>If you have trouble finding the broken case, you can run with -v -i.
>
>I also think you are making an argument for a different feature (which
>does not rob us of having all the debug output): test-lib.sh could
>perhaps redirect the test output to a file, and dump the file to stdout
>only if the test failed.  Perhaps --verbose-failing or something like
>that.
>
>Otherwise, your proposal is restricting us to having only an "easily
>scannable" amount of output per test, perhaps 5-15 lines.  Which I
>personally think is an insane restriction for something that was
>intended for debugging in the first place.

Oh, I hadn't tried -i with -v. This does mimic "|&".
	(cd t && ./t5512-ls-remote.sh -v -i) | less
	(cd t && ./t5512-ls-remote.sh -v) |& less

So, please ignore my suggestion.

Thanks,
TomG
