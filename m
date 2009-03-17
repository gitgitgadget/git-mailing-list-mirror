From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH 2/2] make the ST_{C,M}TIME_NSEC macros more function like
Date: Tue, 17 Mar 2009 18:38:59 +0100
Organization: private
Message-ID: <86bps0t5fw.fsf@broadpark.no>
References: <cover.1237115791.git.barvik@broadpark.no>
 <cover.1237115791.git.barvik@broadpark.no>
 <0681248ac5c9cedf5f42adeeae89966a89e6d42a.1237115791.git.barvik@broadpark.no>
 <7v4oxu7dyn.fsf@gitster.siamese.dyndns.org> <86tz5u1m7i.fsf@broadpark.no>
 <7vhc1ux7nx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 18:40:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjdHS-000503-NX
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 18:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbZCQRjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 13:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755897AbZCQRjF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 13:39:05 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:52519 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594AbZCQRjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 13:39:03 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGN00AQUVP0UR00@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 17 Mar 2009 18:39:00 +0100 (CET)
Received: from localhost ([80.202.166.137]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGN009B4VOZOK20@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 17 Mar 2009 18:39:00 +0100 (CET)
In-reply-to: <7vhc1ux7nx.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113510>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>>     [...] in C or Pascal, calling a function with a large structure as
>>     an argument will cause the entire structure to be copied,
>>     potentially causing serious performance degradation, and mutations
>>     to the structure are invisible to the caller. [...]
>>
>>   So in my eyes it make more sense to be consistent and take the address
>>   of all struct like objects (&st in this case) for all arguments to
>>   "function-like" things.
>
> Notice the "mutations to the structure are invisible to the caller" part.
> The call site of st_ctime_nsec(st) can be sure that st won't be modified,
> without checking the definition of the function.
>
> Which is actually a nice property.  When st_ctime_nsec(st) is implemented as
> a macro, you _could_ write it in such a way to mutate what is in st, but
> the implementation does not do so, and will be unlikely to in the future,
> so I think writing it as if it is a function that receives a structure by
> value will help readers of the calling code.
>
> And the readability is what we should optimize for when picking from two
> ways to write it, and when the generated code is the same.

  OK, I guess we can dropp this patch!  :-)

  -- kjetil
