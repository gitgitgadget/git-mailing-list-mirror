From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge format documented?
Date: Mon, 23 Mar 2009 00:52:28 -0700
Message-ID: <7viqm08ymb.fsf@gitster.siamese.dyndns.org>
References: <200903230419.50000.agruen@suse.de>
 <7vtz5k99tr.fsf@gitster.siamese.dyndns.org>
 <200903230818.20044.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 08:54:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llez0-0001mK-VP
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 08:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbZCWHwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 03:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZCWHwg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 03:52:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbZCWHwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 03:52:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 696C2A456C;
	Mon, 23 Mar 2009 03:52:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7242AA456B; Mon,
 23 Mar 2009 03:52:30 -0400 (EDT)
In-Reply-To: <200903230818.20044.agruen@suse.de> (Andreas Gruenbacher's
 message of "Mon, 23 Mar 2009 08:18:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9152604A-177F-11DE-892E-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114250>

Andreas Gruenbacher <agruen@suse.de> writes:

> On Monday, 23 March 2009 4:50:24 Junio C Hamano wrote:
>> Andreas Gruenbacher <agruen@suse.de> writes:
>> > is the format that git normally uses for indicating merge conflicts in
>> > files (the <<< === >>> markers) documented somewhere?  How exactly does
>> > it differ from the diff3 format (<<< ||| === >>>)?  Diff3's -m mode seems
>> > to come close to what git does, except that git doesn't produce the |||
>> > section:
>>
>> It is an imitation of output from "merge" program of RCS suite Paul you
>> know maintains ;-)
>
> So it's the same format except that diff3's ||| section isn't shown. I was 
> wondering if there are any additional tricks.

No additional tricks.

As far as I can remember, the format was not really chosen, but simply
fell out as a natural consequence of using "merge" rather than "diff3" as
a merge backend (we originally used to invoke "merge" from RCS suite
instead of performing file-level merges ourselves), but we could say we
chose "merge" over "diff3 -m" because the output format should be more
familiar than the diff3-m format with |||, especially to anybody who came
from subversion or CVS background.
