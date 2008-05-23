From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH] Make git add -n and git -u -n output consistent
Date: Fri, 23 May 2008 10:14:48 +0200
Message-ID: <48367CF8.8040307@isy.liu.se>
References: <4835E1AE.6030201@isy.liu.se> <1211493582-13400-1-git-send-email-hendeby@isy.liu.se> <7vabihtyxw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: vmiklos@frugalware.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 10:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzSRE-0001LZ-8x
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 10:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbYEWIOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 04:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754606AbYEWIOx
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 04:14:53 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:64158 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbYEWIOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 04:14:51 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id E2B9125A44;
	Fri, 23 May 2008 10:14:49 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 28136-09; Thu,  8 May 2008 07:37:09 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 421F025A42;
	Fri, 23 May 2008 10:14:49 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7vabihtyxw.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82690>

On 05/23/2008 06:40 AM, Junio C Hamano wrote:
> Gustaf Hendeby <hendeby@isy.liu.se> writes:
> 
>> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
>> ---
>>
>> This would be one way to go to get a more coherent behavior or the -n
>> switch to git add.  It would also unify the implementation somewhat.
>> I'd suggest amending this to your patch, or would the output be likely
>> to be used by scrips?  In that case I'd vote for changing the output
>> of git add -n -u,
> 
> The commit log message should describe what kind of consistency you are
> talking about to people who are not familiar with the topic.

Point taken, I will try to do better next time.

> 
> Output format from "git add -n $path" lists path to blobs that are going
> to be added on a single line, separated with SP.  On the other hand, the
> suggested "git add -u -n" shows one path per line, like "add '<file>'\n".
> Of course, these two are inconsistent.
> 
> Plain "git add -n" can afford to only say names of paths, as all it does
> is to add (update).  However, "git add -u" needs to be able to express
> "remove" somehow.  So if we need to have them formatted the same way, we
> need to unify with the "git add -n -u" format.  Incidentally, this is
> consistent with how 'update-index' says it.
> 
> I do not think we need to worry about people who wrote script around
> output from "git add -n".  Output from Porcelain commands is a fair game
> for improvements.

Thanks for the explaination.

/Gustaf
