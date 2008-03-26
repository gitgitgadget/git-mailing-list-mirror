From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in .gitignore handling
Date: Wed, 26 Mar 2008 13:49:14 -0700
Message-ID: <7vd4phcit1.fsf@gitster.siamese.dyndns.org>
References: <47EAABB6.30803@thorn.ws>
 <alpine.LFD.1.00.0803261324380.2775@woody.linux-foundation.org>
 <47EAB3AD.5070507@thorn.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JecZa-0003Ok-Dd
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 21:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053AbYCZUt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 16:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757133AbYCZUt3
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 16:49:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757053AbYCZUt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 16:49:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A13DF101C;
	Wed, 26 Mar 2008 16:49:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CF3B6101B; Wed, 26 Mar 2008 16:49:16 -0400 (EDT)
In-Reply-To: <47EAB3AD.5070507@thorn.ws> (Tommy Thorn's message of "Wed, 26
 Mar 2008 13:35:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78311>

Tommy Thorn <tommy-git@thorn.ws> writes:

> Linus Torvalds wrote:
>> On Wed, 26 Mar 2008, Tommy Thorn wrote:
> ...
>> Use "/foo" and it should be ok.
>>
>> Basically, a path with a slash in it is considered absolute, but if
>> the slash is at the end it will only match a directory. A slash at
>> the *beginning* will match the root of the git repository, though.
>
> D'oh, of course that works. I double check the documentation and it
> actually isn't obvious that that is allowed, so I propose this patch.
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index e847b3b..941a8a4 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -57,6 +57,9 @@ Patterns have the following format:
>    included again.  If a negated pattern matches, this will
>    override lower precedence patterns sources.
>
> + - If the pattern begins with a slash '/', the pattern will only
> +   match in the current directory.
> +

Did you fully read the existing description and Linus's resopnse?

The above is just a special case of a pattern that contains a slash '/'
(iow, that falls into "Otherwise" rule that follows "If the pattern does
not contain a slash '/'").


 
