From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 21:50:03 -0700
Message-ID: <7v1w6g8s1w.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
 <m33aqxzknl.fsf@localhost.localdomain>
 <402c10cd0803112124i2726c32m75b9353d902df320@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 05:51:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZIvr-00084Q-1i
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 05:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbYCLEuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 00:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbYCLEuU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 00:50:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYCLEuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 00:50:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 05CAF335F;
	Wed, 12 Mar 2008 00:50:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0E4EE335B; Wed, 12 Mar 2008 00:50:11 -0400 (EDT)
In-Reply-To: <402c10cd0803112124i2726c32m75b9353d902df320@mail.gmail.com>
 (Sverre Hvammen Johansen's message of "Tue, 11 Mar 2008 20:24:02 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76923>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> On Tue, Mar 11, 2008 at 1:15 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>  > +never::
>>  > +     Generate a merge commit even if the merge resolved
>>  > +     as a fast-forward.
>>
>>  This is equivalent of current '--no-ff'; nevertheless I think that it
>>  would be better to name this strategy 'commit' or 'merge', as in
>>  --ff=merge, or --ff=commit.
>
> If there is consensus to change this I will.

I do not think Jakub's suggestion makes much sense.  If --ff stands for
"fast forward", then --ff=merge could be explained (very unnaturally) as
"(in a) fast forward (situation, create a) merge", which might make some
sense as an incomplete sentence, but I cannot explain "commit" like that
even with a broken sentence.

Using "fast forward" as a verb ("instead of creating a needless merge,
just move the head"), then the mode of operations your patch proposes can
be described much clearer.  "Never fast forward, always create an
artificial merge if needed", "Only fast forward is allowed, never advance
this head by creating a true merge", etc.

So I think the wording is fine.  What's more necessary in the documention
is how and why these restrictions are useful in what situations, workflows
and management policies.
