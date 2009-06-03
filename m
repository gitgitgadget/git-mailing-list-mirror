From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 03 Jun 2009 10:11:21 -0700
Message-ID: <7vtz2x9r9i.fsf@alter.siamese.dyndns.org>
References: <200905122329.15379.jnareb@gmail.com>
	<200906030250.01413.jnareb@gmail.com>
	<20090603012940.GA3355@spearce.org>
	<200906031121.38616.jnareb@gmail.com>
	<20090603144837.GE3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:11:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBtzu-0001tr-MQ
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 19:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbZFCRLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 13:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756017AbZFCRLU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 13:11:20 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56213 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950AbZFCRLU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 13:11:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603171122.PIWQ17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jun 2009 13:11:22 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id zVBM1b00J4aMwMQ04VBMYi; Wed, 03 Jun 2009 13:11:21 -0400
X-Authority-Analysis: v=1.0 c=1 a=1cH15jnNZHcA:10 a=8-WIN01VSTQA:10
 a=oAYF_C9AAAAA:8 a=r6bvT2I3uIyuchMjFUUA:9 a=x5mB9auNXSZQBqZDlX0Q8giYSmsA:4
 a=R0wQ3QzoQ0IA:10 a=x02sdpDNYZUe_bCT:21 a=gg4kHApd8tKSqw2q:21
X-CM-Score: 0.00
In-Reply-To: <20090603144837.GE3355@spearce.org> (Shawn O. Pearce's message of "Wed\, 3 Jun 2009 07\:48\:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120622>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I think there's something like that in DIRC too, but that change
> (to introduce the current DIRC format) may predate my involvement
> with Git, so my memory isn't very good there.

The index_extension part where the cache-tree is stored is another
example.  The length of the index is known from the mmap, the file
checksum is defined to appear at the end of the file, and the number of
entries are recorded in the file header, so there was a hole after that
many index entries I could add new section.

>> P.S. By the way, is pkt-line format original invention, or was it 
>> 'borrowed' from some other standard or protocol?
>
> No clue.  I find it f'king odd that the length is in hex.  There
> isn't much value to the protocol being human readable.  The PACK
> part of the stream sure as hell ain't.  You aren't going to type
> out a sequence of "have" lines against the remote, like you could
> with say an HTTP GET.  *shrug*

The text-ness made it easier to debug while I was developing the sideband
support.  I literally typed the pkt-line from the terminal ;-).
