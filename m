From: SungHyun Nam <namsh@posdata.co.kr>
Subject: Re: Re* git-remote SEGV on t5505 test.
Date: Fri, 18 Jul 2008 18:07:49 +0900
Message-ID: <48805D65.1060704@posdata.co.kr>
References: <g5osl6$4g3$1@ger.gmane.org> <7vsku7es3n.fsf@gitster.siamese.dyndns.org> <48802DCD.2090704@posdata.co.kr> <7vsku7d8ak.fsf_-_@gitster.siamese.dyndns.org> <7vk5fjd7x5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 11:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJlxl-0005sz-Ft
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbYGRJIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbYGRJH7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:07:59 -0400
Received: from main.gmane.org ([80.91.229.2]:52696 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572AbYGRJH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:07:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJlwQ-0003Mt-9u
	for git@vger.kernel.org; Fri, 18 Jul 2008 09:07:55 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 09:07:54 +0000
Received: from namsh by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 09:07:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vk5fjd7x5.fsf@gitster.siamese.dyndns.org>
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89013>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> SungHyun Nam <namsh@posdata.co.kr> writes:
>>
>>>     Is it possible that we can use 'SHELL_PATH' here?
>> It is not just possible but we really should.  There are other test
>> scripts that use hardcoded /bin/sh, but by setting SHELL_PATH the user is
>> already telling us that what the vendor has in /bin/sh isn't adequately
>> POSIX enough, and we really should try to honor that.
>>
>> "git grep -n /bin/sh t/t*sh | grep -v ':1:#!'" would tell you which ones
>> are suspect.
> 
> SungHyun, I did not test this patch myself (all my shells grok $() command
> substitutions), so I won't be committing this until/unless I see a "tested
> on system X and works fine".

I tested it on Solaris and works fine. ^^

$ uname -sro
SunOS 5.9 Solaris

$ SHELL_PATH=/bin/bash bash ./t9001-send-email.sh
*   ok 1: prepare reference tree
*   ok 2: Setup helper tool
*   ok 3: Extract patches
*   ok 4: Send patches
*   ok 5: Verify commandline
*   ok 6: Show all headers
*   ok 7: reject long lines
*   ok 8: no patch was sent
*   ok 9: allow long lines with --no-validate
*   ok 10: Invalid In-Reply-To
*   ok 11: Valid In-Reply-To when prompting
*   ok 12: setup fake editor
*   ok 13: --compose works
*   ok 14: first message is compose text
*   ok 15: second message is patch
*   ok 16: sendemail.cc set
*   ok 17: sendemail.cc unset
*   ok 18: --compose adds MIME for utf8 body
*   ok 19: --compose respects user mime type
*   ok 20: --compose adds MIME for utf8 subject
* passed all 20 test(s)
