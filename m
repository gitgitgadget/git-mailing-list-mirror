From: David Lang <david.lang@digitalinsight.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 15:46:26 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0702121544550.6630@qynat.qvtvafvgr.pbz>
References: <45CFA30C.6030202@verizon.net> 
 <20070212042425.GB18010@thunk.org><Pine.LNX.4.64.0702120839490.8424@woody.l
 inux-foundation.org><7vps8f6l81.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.63
 .0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 01:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGl70-0008NN-1l
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 01:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbXBMABb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 19:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbXBMABb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 19:01:31 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:61775 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1030558AbXBMABa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 19:01:30 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 12 Feb 2007 16:01:30 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 12 Feb 2007 16:01:09 -0800
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39463>

On Mon, 12 Feb 2007, Junio C Hamano wrote:

>> Hi,
>>
>> On Mon, 12 Feb 2007, Junio C Hamano wrote:
>>
>>> I agree that we can assume editors can grok files with LF end-of-line
>>> just fine and we would not need to do the reverse conversion on checkout
>>> paths (e.g. "read-tree -u", "checkout-index").
>>
>> In that case, a simple pre-commit hook would suffice.
>>
>> No, the problem mentioned by Mark was a very real one: you _cannot_ rely
>> on Windows' editors not to fsck up with line endings. The worst case is if
>> the file contains _some_ CRLF and _some _LF_. Almost always I had the
>> problem that it now converted _all_ LFs to CRLFs. Even those which already
>> were converted.
>>
>> So, if we are to support text mode, it is not one-way. If we do one-way,
>> we really do _not_ support text mode, but pre-commit conversion to LF
>> style text. And in this case, core git does not need _any_ change.
>
> Well I disagree in two counts.
>
> - I do not see how you propose to solve some CRLF and some LF
>   case with both-ways conversion.

the expectation is that the some-of-each situation is unlikly to happen if you 
convert all the time.

and if you do end up with a mixed ending file, the next time you check it in 
from a windows box it should clean it up.

David Lang
