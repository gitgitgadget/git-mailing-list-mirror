From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] commit.c - provide commit-type to the hooks/pre-commit
 script
Date: Mon, 07 Jun 2010 08:26:53 +0200
Message-ID: <4C0C912D.9080404@viscovery.net>
References: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com> <20100606221037.GE6993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 07 08:27:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLVnc-00061F-4a
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 08:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab0FGG06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 02:26:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58313 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752125Ab0FGG05 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 02:26:57 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OLVnS-0006Jt-L9; Mon, 07 Jun 2010 08:26:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 45B471660F;
	Mon,  7 Jun 2010 08:26:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100606221037.GE6993@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148576>

Am 6/7/2010 0:10, schrieb Jeff King:
> On Sat, Jun 05, 2010 at 01:39:50PM -0400, Mark Levedahl wrote:
> 
>> -	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
>> +	if (!no_verify && run_hook(index_file, "pre-commit", amend ? "amend" : "normal", NULL))
>> [...]
>> -	against=HEAD
>> +	if test "$1" = "amend"
>> +	then
>> +		against=HEAD~1
>> +	else
>> +		against=HEAD
>> +	fi
> 
> Is there a reason to use the magic "amend" and "normal" words, if
> scripts are just going to end up changing them back into HEAD~1 and HEAD
> anyway?

pre-commit might act differently when a commit is amended, the most likely
reason I can think of is to always allow to amend. When you have only a
SHA1, you can get that information only with an additional process.

-- Hannes
