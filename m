From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never,
 and only
Date: Sat, 22 Mar 2008 12:49:52 -0700
Message-ID: <7vbq56ilnj.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
 <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
 <7vskym310l.fsf@gitster.siamese.dyndns.org>
 <402c10cd0803192347q7b4a3fb0s35737f361d53a86a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 20:50:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd9k0-00053g-DK
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbYCVTuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbYCVTuP
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:50:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbYCVTuN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:50:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 568A51501;
	Sat, 22 Mar 2008 15:50:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A3EC71318; Sat, 22 Mar 2008 15:50:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77844>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> On Wed, Mar 19, 2008 at 12:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > ...
>>  This might be easier to review if split into two parts.  Code suffling to
>>  do --ff/--no-ff => ff={allow,never} and documentation updates to improve
>>  the description of these two options in the first patch, and addition of
>>  "only" to code and the updated docuemntation in the second.
>
> What I would like to do is to split it in three like this:
>
> 1. Head reduction
>
> 2. --ff/--no-ff => ff={allow,never} and documentation updates.
>
> 3. --ff=only
>
> If you would like me to do this please tell me.

Yeah, making head reduction into its own separate patch would make things
clearer, I guess.

But if you are going to do that, then the order should be 2/1/3 from the
above list.  In a series of patches, restructuring without changing
semantics should come first to make existing logic cleaner and later
enhancements on top of it easier to follow.  Then you build new features
and enhancements on top of that solidified base.

Because "head reduction" changes the semantics (making it better or worse
does not matter --- "changes" is what matters), it should come after #2
above, I think.
