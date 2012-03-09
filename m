From: Phil Hord <hordp@cisco.com>
Subject: Re: rerere.autoupdate that wouldn't
Date: Fri, 09 Mar 2012 17:51:54 -0500
Message-ID: <4F5A898A.2060701@cisco.com>
References: <4F5A8580.1010807@cisco.com> <7vd38l4cl5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68fI-0004QH-LN
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150Ab2CIWv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:51:56 -0500
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:21848 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756909Ab2CIWvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=921; q=dns/txt;
  s=iport; t=1331333515; x=1332543115;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=kXzvrMrB64UWgpBqTlsUn/PSljW/annvmC4Y4E4isSU=;
  b=IVc+HtGbzRt06GivV9STWtFgDejlS6P3hLi3Kkk0Oonsm3vIXTde566w
   8mNZiNXGuPZ/CXN/cFZsmuAjqQtCQ2mYL44t1yw2D9f7VtIwyCL27eQEk
   CqjHXoxQHKTc1HqPxtGjgaVhTrs2pjF3/DmItQI+jXuwfaTYdk6ZMBWns
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApYFAO+IWk+tJXG8/2dsb2JhbABDgwmyKoEHggsBAQQSAWUBEAshFg8JAwIBAgFFBg0BBQIBAR6HaJwNAZ50kHgEiFOMdoVmijaDAQ
X-IronPort-AV: E=Sophos;i="4.73,560,1325462400"; 
   d="scan'208";a="65262349"
Received: from rcdn-core2-1.cisco.com ([173.37.113.188])
  by rcdn-iport-1.cisco.com with ESMTP; 09 Mar 2012 22:51:55 +0000
Received: from [10.117.80.109] (rtp-hordp-89112.cisco.com [10.117.80.109])
	by rcdn-core2-1.cisco.com (8.14.3/8.14.3) with ESMTP id q29MpsEq032718;
	Fri, 9 Mar 2012 22:51:54 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vd38l4cl5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.5
X-TagToolbar-Keys: D20120309175154097
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192752>

Writ Junio C Hamano <gitster@pobox.com>,
> Phil Hord <hordp@cisco.com> writes:
> 
>> Is this what is supposed to happen?  Should I look into adding
>> 'rerere.autoContinue=true'?
> 
> "Yes", and "Perhaps, but there may be a better alternative".
> 
> Whatever rerere did, "git merge", "git am", and friends should
> report the fact that the result is not just a trivial conflict-free
> merge, so that the user can take an appropriate action.  Otherwise
> you will be robbing the last chance to eyeball the result from
> people who have been using rerere.autoupdate=true and doing so
> before committing.
> 
> And a better alternative to make "rerere.autoupdate" stronger may be
> to make the variable tri-valued, instead of adding a new variable
> that does not make any sense when rerere.autoupdate is not set.

Any preference on the third option-name?

I think  'False || True || Continue'

Phil
