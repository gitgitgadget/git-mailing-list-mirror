From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/2] Rename suffixcmp() to ends_with() and invert
 its result
Date: Thu, 21 Nov 2013 08:32:08 +0100 (CET)
Message-ID: <20131121.083208.893400033155439223.chriscool@tuxfamily.org>
References: <20131119.220438.1634671089949485179.chriscool@tuxfamily.org>
	<CALWbr2yG7XOhuZa9bf6sXRV=m49dTPNyPZ9JUU2-_2G8ZJsCTg@mail.gmail.com>
	<xmqq4n7881s7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: apelisse@gmail.com, jrnieder@gmail.com, git@vger.kernel.org,
	apenwarr@gmail.com, Johannes.Schindelin@gmx.de, peff@peff.net,
	max@quendi.de, ae@op5.se
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 21 08:32:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjOke-0002Bc-2P
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 08:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913Ab3KUHcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 02:32:32 -0500
Received: from [194.158.98.15] ([194.158.98.15]:57875 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750821Ab3KUHcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 02:32:31 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id ACE8B36;
	Thu, 21 Nov 2013 08:32:08 +0100 (CET)
In-Reply-To: <xmqq4n7881s7.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238112>

From: Junio C Hamano <gitster@pobox.com>
>
> Antoine Pelisse <apelisse@gmail.com> writes:
> 
>> I'm not exactly sure I understand the point of not squashing all those
>> patches together ?
>> It's not like one is going without the others, or that the commit
>> message provides some new information (except for the name of the
>> file, but that is not very relevant either). The downside is that it's
>> _many_ messages to bypass when reading mails from small-screen devices
>> :-)
> 
> The only plausible reason I could think of is to avoid clashing with
> topics in-flight, but then the approach to produce per-file patch is
> not perfect for that purpose, either, when more than one topic in
> flight touch the same file at different places.
> 
> I'd say probably the best organization would be something like:
> 
>  * A set of clean-up patches to normalize oddball usages of existing
>    functions (e.g. normalize 'prefixcmp(a,b) != 0' in some file(s)
>    to 'prefixcmp(a,b)');
> 
>  * A single patch to introduce the new function(s), to be applied on
>    top of 1.8.5;
> 
>  * A large patch to convert all uses of prefixcmp to starts_with and
>    suffixcmp to ends_with in the 1.8.5 codebase;
> 
>  * A patch for each topic in flight to convert newly introduced
>    prefixcmp/suffixcmp to starts_with/ends_with, to be applied after
>    the topic graduates to 'master' after 1.8.5; and then finally
> 
>  * A separate patch to remove prefixcmp and suffixcmp, to be applied
>    after _all_ in-flight topic has graduated to 'master'.

Ok, I will wait for 1.8.5 and then send a patch series like what you
suggest.

Thanks,
Christian.
