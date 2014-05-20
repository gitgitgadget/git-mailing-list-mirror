From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] t6006-*.sh: Fix truncation tests
Date: Tue, 20 May 2014 16:01:22 +0100
Message-ID: <537B6E42.8040308@ramsay1.demon.co.uk>
References: <537B5E8C.3070803@ramsay1.demon.co.uk> <20140520141936.GA30187@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 17:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmlXr-00040v-7s
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 17:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbaETPBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 11:01:31 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:47598 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751947AbaETPBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 11:01:30 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 4CD52AC408F;
	Tue, 20 May 2014 16:01:33 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 16528AC4071;
	Tue, 20 May 2014 16:01:33 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Tue, 20 May 2014 16:01:28 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140520141936.GA30187@ashu.dyn1.rarus.ru>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249690>

On 20/05/14 15:19, Alexey Shumkin wrote:
> On Tue, May 20, 2014 at 02:54:20PM +0100, Ramsay Jones wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> Hi Alexey,
>>
>> If you need to re-roll your 'as/pretty-truncate' branch, could
>> you please squash the relevant parts of this patch into the
>> corresponding patches of your patch series. (ie this is a patch
>> against the head of the current pu branch ...).
>>
>> Without this patch I get:
>>
>>   $ ./t6006-rev-list-format.sh
>>   ok 1 - setup
>>   ok 2 - format percent
>>   ok 3 - format hash
>>   ok 4 - format tree
>>   ok 5 - format parents
>>   ok 6 - format author
>>   ok 7 - format committer
>>   ok 8 - format encoding
>>   ok 9 - format subject
>>   ./t6006-rev-list-format.sh: 152: ./t6006-rev-list-format.sh: Syntax error: "(" unexpected
>>   FATAL: Unexpected exit with code 2
>>   $ 
> Ooops, my fault.
>>
>> (if you have bash as /bin/sh you get different but related errors).
>> The additional quoting suppresses the 'command redirection' errors, etc...
> It's strange but I do have Bash as /bin/sh and unfortunately I have no
> this error

Hmm, I see this:

  $ bash t6006-rev-list-format.sh -i
  ok 1 - setup
  ok 2 - format percent
  ok 3 - format hash
  ok 4 - format tree
  ok 5 - format parents
  ok 6 - format author
  ok 7 - format committer
  ok 8 - format encoding
  ok 9 - format subject
  t6006-rev-list-format.sh: line 152: 20,trunc: command not found
  not ok 10 - format subject-truncated
  #	
  #			git rev-list --pretty=format:'%/dev/fd/63%s' master >output.subject-truncated &&
  #			test_cmp expect.subject-truncated output.subject-truncated
  #		
  $ 

(Since I'm on Linux Mint, my /bin/sh is dash, which produces the output in my previous mail).

ATB,
Ramsay Jones
