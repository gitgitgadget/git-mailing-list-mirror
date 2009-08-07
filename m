From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] Re: mailinfo: allow individual e-mail files as input
Date: Thu, 06 Aug 2009 21:05:26 -0500
Message-ID: <4Frzb2o8m7o4sjOhlZiN-mXQHUAsXYeImlNxZ8ANJZ5I3_S_JjSsoA@cipher.nrlssc.navy.mil>
References: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil> <20090807015238.GF12924@vidovic> <20090807015628.GG12924@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 04:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZEq2-0002jW-O7
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 04:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204AbZHGCFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 22:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756149AbZHGCFh
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 22:05:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53266 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852AbZHGCFh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 22:05:37 -0400
Received: by mail.nrlssc.navy.mil id n7725SNt017287; Thu, 6 Aug 2009 21:05:28 -0500
In-Reply-To: <20090807015628.GG12924@vidovic>
X-OriginalArrivalTime: 07 Aug 2009 02:05:27.0162 (UTC) FILETIME=[883E85A0:01CA1703]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125161>

Nicolas Sebrecht wrote:
> The 07/08/09, Nicolas Sebrecht wrote:
>> The 06/08/09, Brandon Casey wrote:
>>
>>> diff --git a/git-am.sh b/git-am.sh
>>> index d64d997..49f2be4 100755
>>> --- a/git-am.sh
>>> +++ b/git-am.sh
>> <...>
>>
>>> +			{
>>> +				echo "$l1"
>>> +				echo "$l2"
>>> +				echo "$l3"
>>> +				cat
>> UUOC, I guess.
>>
>>> +			} | sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
>>                                                    ^^
> 
> Owned by the tabulation, sorry.
> 
> Do we still need the "$1"?

Whoops, I missed that "$1" argument to sed.  That means the v2 followup
patch is unnecessary since the sed is operating on a file argument
and _not_ stdin.  I think it's a little strange like that though...

   {
      sed "$1"
   } < "$1"

-brandon
