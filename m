From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Add --patchdepth parameter to git-am.sh
Date: Wed, 7 Feb 2007 09:59:11 +0000
Message-ID: <200702070959.12819.andyparkins@gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <200702051924.39205.andyparkins@gmail.com> <7vfy9ibcdx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 10:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjaH-0007yi-9Y
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 10:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbXBGJ7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 04:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbXBGJ7U
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 04:59:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:36839 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161121AbXBGJ7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 04:59:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so137244uga
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 01:59:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VHgkTz8npgLJIFL5J+ItZxMjIuHSPSBCKYNZc2ByKqbtbaP9lnaBKg0F0t6k8QG9Kn0nlHLH67cxhX1iS77jh0NIXjWmdfcS5xKOeilxOAEou2PS2NaOEIAPca0WOPuGzUbZAquFOevK7WNcUj+P+PoAwReTNwkjD0WjaQD7kOY=
Received: by 10.67.103.7 with SMTP id f7mr10235052ugm.1170842357816;
        Wed, 07 Feb 2007 01:59:17 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id e34sm896386ugd.2007.02.07.01.59.14;
        Wed, 07 Feb 2007 01:59:14 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vfy9ibcdx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38905>

On Wednesday 2007 February 07 08:27, Junio C Hamano wrote:

> I do not understand this remark, as applypatch does not have -p
> either.  If we were to do this, I agree with others that this

Oh.  That /would/ make it confusing.  I didn't realise they both didn't have 
it (I thought I had used it at some point in the past, my swiss cheese 
memory).  In that case, the patch is a lot more relevant.

> should simply be called -p (we do not have name crash with
> existing options, do we?).

I have no problem with it being "-p"; I just don't like to take valuable 
single letter namespace unilaterally.

> After seeing that a patch does not apply because the patch was
> generated at the wrong level, it would be very natural to use
> "git apply -p0 --index .dotest/patch" and then continue with
> "git am --resolved".  So obviously, -p to git-apply is very
> useful, but -p given to "am" means all of the patches in your
> mailbox has uniformly wrong patch depth.  I wonder how common
> would that be in practice.

I added it because I had need for it; I managed to manufacture a whole series 
of patches at the wrong patch level.  It had been hard work to make them, so 
I didn't feel like making them all again just to change the depth.

> But other than that "how useful would that be in practice?"
> This is wrong if you do not use any $patchdepth.

Guilty.  As I said, I added it for my own use; so didn't mind too much about 
weird output.  If I resent it would be to drop my modifications to the 
message (it's redundant anyway - surely you know what you specified on the 
command line?), so feel free to just remove that hunk.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
