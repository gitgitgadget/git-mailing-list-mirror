From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH v3] submodule: Improve documentation of update subcommand
Date: Mon, 23 Feb 2015 14:31:23 +0100
Message-ID: <87egpgdaac.fsf@steelpick.2x.cz>
References: <87d255zt0j.fsf@steelpick.2x.cz> <1424371972-13393-1-git-send-email-sojkam1@fel.cvut.cz> <xmqqlhjsxira.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 14:31:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPt6h-0000zV-2B
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 14:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbbBWNb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 08:31:27 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:46814 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbBWNb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 08:31:26 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 183233CFF1A;
	Mon, 23 Feb 2015 14:31:25 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id ohCuNOyB48pv; Mon, 23 Feb 2015 14:31:23 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 6671F3CFEF1;
	Mon, 23 Feb 2015 14:31:23 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1YPt6Z-0002jO-2Q; Mon, 23 Feb 2015 14:31:23 +0100
In-Reply-To: <xmqqlhjsxira.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.19+54~g0747f5c (http://notmuchmail.org) Emacs/24.4.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264256>

On Sat, Feb 21 2015, Junio C Hamano wrote:
> Michal Sojka <sojkam1@fel.cvut.cz> writes:
>>  update::
>> +	Update the registered submodules to match what the superproject
>> +	expects by cloning missing submodules and updating the working
>> +	tree of the submodules. The "updating" can be done in several
>> +	ways depending on command line options and the value of
>> +	`submodule.<name>.update` in .git/config:
>
> No quoting around .git/config?

There is not quoting in the rest of the file as well.

> Actually, it is probably better not to spell out that path. "... and
> the value of the `...` configuration variable" would be better.

Yes, I changed it to this. See the followup mail.

>>  	When running add, allow adding an otherwise ignored submodule path.
>>  	When running deinit the submodule work trees will be removed even if
>>  	they contain local changes.
>> -	When running update, throw away local changes in submodules when
>> -	switching to a different commit; and always run a checkout operation
>> -	in the submodule, even if the commit listed in the index of the
>> -	containing repository matches the commit checked out in the submodule.
>> +	When running update and the checkout method is used, throw away
>> +	local changes in submodules when switching to a different
>> +	commit; and always run a checkout operation in the submodule,
>> +	even if the commit listed in the index of the containing
>> +	repository matches the commit checked out in the submodule.
>
> This makes a reader wonder what --force would do when --merge or
> --rebase is given from the command line (or specifiedy in the
> configuration).  The original (unfortunately) did not have that
> problem because it did not single out the --checkout mode.

I changed that to "(only effective with the checkout method)".

> The use of the phrase "the checkout method" is iffy, as nobody
> defines what it is (I just said "--checkout mode" to mean the same
> thing, but I do not think anybody defines it).  See below.

I defined it in gitmodules.txt as you suggest as well as in the
description of update command in git-submodule.txt.

Thanks.
-Michal
