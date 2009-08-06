From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging to and from non-current branches.
Date: Thu, 06 Aug 2009 11:43:16 -0700
Message-ID: <7vprb8lr5n.fsf@alter.siamese.dyndns.org>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com>
 <alpine.LNX.2.00.0908042236240.2147@iabervon.org>
 <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
 <81b0412b0908051428g40b7678ewc549f079abbd03ee@mail.gmail.com>
 <C766A4F9-C12B-4F94-8B24-9BD3665B70E8@mgreg.com>
 <alpine.LNX.2.00.0908061320030.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "lists\@mgreg.com" <lists@mgreg.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:43:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ7w7-0005Cs-Sr
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 20:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZHFSn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 14:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753339AbZHFSn1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 14:43:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbZHFSn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 14:43:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9BC71F1F9;
	Thu,  6 Aug 2009 14:43:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 501281F1F4; Thu,  6 Aug 2009
 14:43:19 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0908061320030.2147@iabervon.org> (Daniel
 Barkalow's message of "Thu\, 6 Aug 2009 13\:41\:58 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 069DC7AA-82B9-11DE-B11E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125104>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> As I said, I understand what is being said, but in IMHO it would seem that a
>> merge of that nature would be immediately desirable.  Think of it more as a
>> local "push".
>
> You mean like "git push . dev:master"? That does work in the case where a 
> content merge is not required (although not otherwise).

Just to clarify.

It works _only_ when the push is a fast forward, i.e. where a merge is not
required.

That is different from working in a case "where a content merge is not
required".

The word "content merge" is often used in contrast to "tree level merge",
meaning the latter can be finished by flipping stages inside the index by
the three-way read-tree (--aggressive) while the former needs to call out
to "merge-one-file".

But the push will be rejected if you need _any_ kind of merge.
