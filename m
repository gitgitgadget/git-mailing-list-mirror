From: Junio C Hamano <gitster@pobox.com>
Subject: Re:
Date: Thu, 07 May 2009 13:43:06 -0700
Message-ID: <7v63gcejad.fsf@alter.siamese.dyndns.org>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>
	<81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>
	<D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>
	<alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>
	<A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
	<alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>
	<alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 07 22:43:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2ARC-0005Jr-SL
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 22:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763418AbZEGUnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 16:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763415AbZEGUnI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 16:43:08 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:59247 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763408AbZEGUnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 16:43:06 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090507204306.FJPB20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Thu, 7 May 2009 16:43:06 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id okj61b00A4aMwMQ04kj6Fx; Thu, 07 May 2009 16:43:06 -0400
X-Authority-Analysis: v=1.0 c=1 a=Z4Rwk6OoAAAA:8 a=Ed_7w-9nfZCDohHt5w4A:9
 a=pcc2Xqnx_9WVeZPvKwsA:7 a=4hUIM4JXIz71X05untkbOyTIeAAA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> (Linus Torvalds's message of "Thu\, 7 May 2009 13\:20\:28 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118521>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 7 May 2009, Linus Torvalds wrote:
>>
>> The patch is TOTALLY UNTESTED. It also worries me that 'git checkout' 
>> seems to do _two_ 'lstat()' calls per file. I didn't look any more 
>> closely, but there may be other issues here.
>
> Hmm. The second pass comes from 
>
> 	show_local_changes(&new->commit->object);
>
> (this is the "git checkout" without actual filenames), and is suppressed 
> if we ask for a quiet checkout. But it's sad how it re-loads the index. I 
> wonder where the CE_VALID bit got dropped.

I do not think you mean CE_VALID; CE_UPTODATE isn't it?
