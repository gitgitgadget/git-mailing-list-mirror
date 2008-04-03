From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: merge conflict diff
Date: Thu, 03 Apr 2008 18:48:22 +0200
Message-ID: <vpqk5jeubop.fsf@bauges.imag.fr>
References: <b9fd99020804030713n3c1a2602t847e8a132f8ccd06@mail.gmail.com>
	<20080403142649.GA16699@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Ramer <jdramer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 18:50:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhSe1-00015k-1J
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 18:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbYDCQtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 12:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbYDCQtr
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 12:49:47 -0400
Received: from imag.imag.fr ([129.88.30.1]:58549 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbYDCQtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 12:49:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m33GmSRS022025
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 3 Apr 2008 18:48:28 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JhSbu-0006lP-Cz; Thu, 03 Apr 2008 18:48:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JhSbu-00018D-AZ; Thu, 03 Apr 2008 18:48:22 +0200
In-Reply-To: <20080403142649.GA16699@coredump.intra.peff.net> (Jeff King's message of "Thu\, 3 Apr 2008 10\:26\:49 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 03 Apr 2008 18:48:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78761>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 03, 2008 at 08:13:04AM -0600, Jeremy Ramer wrote:
>
>> I am trying to figure out how to quickly diff two source files that
>> led to a merge conflict.  When a conflict occurs the command
>> [...]
>> So far I am thinking of
>> # git checkout-index --stage=2 --temp foo
>> # git checkout-index --stage=3 --temp foo
>> # git diff .merge_x1 .merge_x2
>
> The special ref syntax :<n>:file refers to the blob in stage <n> of the
> index. So you can see them with:
>
>   git show :2:foo
>   git show :3:foo
>
> Or diff them with:
>
>   git diff :2:foo :3:foo

See also

git diff --ours
git diff --theirs
git diff --base

and man git-diff-files (BTW, it's a pity not to find this in man
git-diff).

-- 
Matthieu
