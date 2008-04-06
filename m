From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update, and clear up the pack format documentation a bit
Date: Sat, 05 Apr 2008 23:16:35 -0700
Message-ID: <7vve2vse2k.fsf@gitster.siamese.dyndns.org>
References: <20080405180759.GA29710@bohr.gbar.dtu.dk>
 <20080406045132.GA10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 06 08:17:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiOCF-0004lW-DK
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 08:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYDFGQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 02:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYDFGQq
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 02:16:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbYDFGQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 02:16:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FED4720F;
	Sun,  6 Apr 2008 02:16:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 60BCA720E; Sun,  6 Apr 2008 02:16:37 -0400 (EDT)
In-Reply-To: <20080406045132.GA10274@spearce.org> (Shawn O. Pearce's message
 of "Sun, 6 Apr 2008 00:51:32 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78887>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Peter Eriksen <s022018@student.dtu.dk> wrote:
> ...
>> +     (for object type ofs_delta)
>> +     n-byte offset (n*7-bit as above, but with size0 being 7 bit)     
>> +     compressed delta data
>> +
>
> That is not correct.  The ofs_delta is encoded as an n-byte offset
> that is subtracted from the current object's first byte (the byte
> holding the type/representation field and first 4 bits of length).

Right.  Saying just "n-byte offset" can be mistaken as the offset from the
beginning of the file, and making it clear that it is relative is good.

> The n-byte encoding for an ofs_delta is different then the one
> used for the length.  We add 1 for each byte where the MSB is 1.
> We also store the data in big-endian form (the most significant
> byte is first and the least significant byte is last).

Ah, I forgot about that one.
