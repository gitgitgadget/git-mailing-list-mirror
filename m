From: Jim Meyering <jim@meyering.net>
Subject: Re: git-diff: must --exit-code work with --ignore* options?
Date: Sat, 23 May 2009 09:26:25 +0200
Message-ID: <878wkoe0v2.fsf@meyering.net>
References: <87k549dyne.fsf@meyering.net>
	<7vvdnt869j.fsf@alter.siamese.dyndns.org>
	<87eiuhdnw9.fsf@meyering.net>
	<7v7i087twu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 09:26:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7ld3-00088g-9b
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 09:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbZEWH0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 03:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbZEWH0f
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 03:26:35 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58718 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbZEWH0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 03:26:34 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 451949400E1
	for <git@vger.kernel.org>; Sat, 23 May 2009 09:26:28 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 60FA6940048
	for <git@vger.kernel.org>; Sat, 23 May 2009 09:26:26 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 018EB2A2CA; Sat, 23 May 2009 09:26:25 +0200 (CEST)
In-Reply-To: <7v7i087twu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 May 2009 13:40:49 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119757>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>> Junio C Hamano wrote:
>>> Jim Meyering <jim@meyering.net> writes:
>>>>
>>>>     # do this in an empty directory
>>>>     $ git init -q; echo>k; git add .; git commit -q -m. .; echo \ >k
>>>>     $ git diff --ignore-space-at-eol --quiet || echo bad
>>>>     bad
>>>
>>> I am slightly torn about this, in that I can picture myself saying that
>>> this is unintuitive on some different days, but not today ;-)
>>
>> Thanks for the quick reply.  Here's why I noticed:
>> ...
>
> It seems that today is already "some different day" ;-) We could do
> something like this patch.
>
> While in the longer term I think it may make the world a better place by
> being more consistent with what users expect, I am not sure at what
> revision boundary we should introduce such a semantic change.
>
> -- >8 --
> Subject: [PATCH] diff --quiet: special case "ignore whitespace" options
> ...

Wow.  And now a patch.  Service with style ;-)

> We could always declare this a bug and apply the "fix" at any time.  It's
> all perception ;-).

The declare-it-a-bug option sounds sensible, since I doubt anyone
even noticed, much less relied on, the changing behavior.

Thank you!
