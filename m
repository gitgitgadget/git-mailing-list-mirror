From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 14/14] Add git-check-ignore sub-command
Date: Wed, 26 Sep 2012 07:49:25 +0200
Message-ID: <50629765.2060107@viscovery.net>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org> <1348170383-15751-1-git-send-email-git@adamspiers.org> <1348170383-15751-15-git-send-email-git@adamspiers.org> <505BFED7.5030203@viscovery.net> <7vk3vhvg5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 07:49:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGkVD-0005JA-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 07:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab2IZFte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 01:49:34 -0400
Received: from so.liwest.at ([212.33.55.24]:22069 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab2IZFtd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 01:49:33 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TGkUw-0000bk-BB; Wed, 26 Sep 2012 07:49:26 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CE3731660F;
	Wed, 26 Sep 2012 07:49:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vk3vhvg5b.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206395>

Am 9/26/2012 1:25, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Am 9/20/2012 21:46, schrieb Adam Spiers:
>>>  test_expect_success 'general options plus command' '
>>> -	test_completion "git --version check" "checkout " &&
>>> -	test_completion "git --paginate check" "checkout " &&
>>> -	test_completion "git --git-dir=foo check" "checkout " &&
>>> -	test_completion "git --bare check" "checkout " &&
>>> +	test_completion "git --version checko" "checkout " &&
>>> +	test_completion "git --paginate checko" "checkout " &&
>>> +	test_completion "git --git-dir=foo checko" "checkout " &&
>>> +	test_completion "git --bare checko" "checkout " &&
>>> ...
>>
>> I find this worrysome. Is check-ignore, being a debugging aid, so
>> important that it must be autocompleted?
> 
> The shell function __git_list_porcelain_commands in contrib/completion/
> starts from "git help -a" and filters plumbing commands and helpers
> via a blacklist.  At least, check-ignore needs to be added there.
> 
> These days, we do not add random subcommands willy-nilly (I still
> doubt if check-ignore needs to be a separate debugging command, or a
> new mode of operation of ls-files or something), so the approach to
> use a blacklist makes more sense.  "help -a" is designed to show
> whatever the users throw in their ~/bin (assuming that is on $PATH)
> under git-whatever name, and we _do_ want to complete "git wh<TAB>"
> to that custom command, so a whitelist-based solution is unwieldy to
> construct.

We already have 'git check-attr', but it is obviously not among the
autocompleted commands, otherwise the above test would not have passed.
IMO, 'git check-ignore' falls into the same category as 'git check-attr'
with regard to completion.

-- Hannes
