From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: diff weirdness (bug?)
Date: Mon, 17 Feb 2014 11:20:10 +0100
Message-ID: <87r472ujl1.fsf@thomasrast.ch>
References: <52FE6C64.4060700@gmail.com>
	<xmqq8utdihqx.fsf@gitster.dls.corp.google.com>
	<53014A43.6080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dario Bertini <berdario@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 17 11:20:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFLJK-0006zz-E4
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 11:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbaBQKUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Feb 2014 05:20:15 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:51939 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaBQKUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Feb 2014 05:20:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 972094D6594;
	Mon, 17 Feb 2014 11:20:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aQZQX_GfAB95; Mon, 17 Feb 2014 11:20:10 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (80-219-153-229.dclient.hispeed.ch [80.219.153.229])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B202D4D64BD;
	Mon, 17 Feb 2014 11:20:10 +0100 (CET)
In-Reply-To: <53014A43.6080505@gmail.com> (Dario Bertini's message of "Mon, 17
	Feb 2014 00:31:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242250>

Dario Bertini <berdario@gmail.com> writes:

> On 02/14/2014 09:03 PM, Junio C Hamano wrote:
>> This is a combined diff, and yaml-related lines are added relative
>> to your _other_ branch you are merging (notice these + are indented
>> by one place).  Relative to what you had at the tip of your branch
>> before you started this operation that ended up conflicted, the
>> half-merged result removes if/else that sets DIST_MODULE_PATH and
>> replaces it with a single line (their +/- are on the first column,
>> signifying that these are differences relative to the first parent,
>> i.e. your state before you started the operation).
>> 
>>> if we remove these 3 lines, we'll get this diff:
>> 
>> With that understanding, I think the output after removing these
>> three lines is perfectlyh understandable and correct.  You are
>> looking at the three lines that used to exist in the version you
>> started from, that were missing from the other side.  If you remoe
>> them, it will show as removal from _your_ version (notice these -
>> that shows what _you_ did manually are on the first column, saying
>> that that is relative to _your_ version).
>> 
>
> Thank you, I was completely unaware of combined diffs. Still: I can't
> see how this would explain the empty diff when deleting 4 lines instead
> of 3.

With a --cc diff (which it is: it says 'diff --cc' in the file headers)
git doesn't show the combined diff for hunks that fully agree with one
side.

So if you (even manually) resolve the merge so that it fully matches one
side, that will not show up in a --cc diff.

-- 
Thomas Rast
tr@thomasrast.ch
