From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: write test results to
 test-results/<basename>-<pid>
Date: Fri, 13 Mar 2009 10:20:36 -0700
Message-ID: <7viqmdgx0b.fsf@gitster.siamese.dyndns.org>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
 <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <alturin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 18:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiB5R-0001xa-3Z
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 18:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946AbZCMRUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 13:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757706AbZCMRUp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 13:20:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548AbZCMRUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 13:20:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8059DA1751;
	Fri, 13 Mar 2009 13:20:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 39A0DA1750; Fri,
 13 Mar 2009 13:20:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Fri, 13 Mar 2009 17:36:13 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 47DFF7F8-0FF3-11DE-B628-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113212>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 13 Mar 2009, Johannes Schindelin wrote:
>
>> The earlier code meant to attempt to strip everything except the test
>> number, but only stripped the part starting with the last dash.
>> 
>> However, there is no reason why we should not use the whole basename.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> 
>> 	Even if this is not strictly necessary after Hannes' test cleanup, 
>> 	it would still be nice.
>
> Just to clarify: it fixes the issue that these two tests share the same 
> file in test-results/: t5521-pull-options.sh  t5521-pull-symlink.sh
>
> As a consequence, one's results overwrite the other one's.

Are you saying that your "fix" will break things if we did not have
renames from j6t?

What bug/problem/issue does this patch fix?

I never look into test-results/ subdirectory myself (I'll let the
summarizing code do that for me) and the full names never bothered me.

Actually I've always thought it was a very nice touch by you to make sure
results will not be mixed up even when we have more than 10 tests in the
same category and some tests need to share their numbers, and and your
"meant to ... strip everything" above gave me "Huh?"
