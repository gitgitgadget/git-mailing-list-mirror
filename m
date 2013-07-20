From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Add the GIT_SENTINEL macro
Date: Sat, 20 Jul 2013 20:13:10 +0100
Message-ID: <51EAE146.2070309@ramsay1.demon.co.uk>
References: <51E849C4.7020305@ramsay1.demon.co.uk> <7vr4evz0oc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 21 15:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0tLd-0002yH-Qm
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 15:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab3GUNGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 09:06:46 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:47377 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755206Ab3GUNGp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 09:06:45 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id D9890A647A2;
	Sun, 21 Jul 2013 14:06:44 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 36F92A6462F;
	Sun, 21 Jul 2013 14:06:44 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sun, 21 Jul 2013 14:06:43 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vr4evz0oc.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230932>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> The sentinel function attribute is not understood by versions of
>> the gcc compiler prior to v4.0. At present, for earlier versions
>> of gcc, the build issues 108 warnings related to the unknown
>> attribute. In order to suppress the warnings, we conditionally
>> define the GIT_SENTINEL macro to provide the sentinel attribute
>> for gcc v4.0 and newer.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> This was built on the next branch
> 
> It seems to apply well on the tip of jk/gcc-function-attributes.
> 
> 
>  - This macro is not about "git" at all, so I'll edit the patch to
>    call it GCC_ATTR_SENTINEL before applying.
> 
>  - Also I'll drop the (0) at the end.
> 
> Thanks.

Yes, GCC_ATTR_SENTINEL is a better name, but I like LAST_ARG_MUST_BE_NULL
even more! The final commit 9fe3edc4 ("Add the LAST_ARG_MUST_BE_NULL macro",
18-07-2013) is much better than my patch and works beautifully.

Thanks Junio, Jeff and Jonathan!

ATB,
Ramsay Jones
