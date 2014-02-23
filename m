From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 3/8] merge-recursive: -Xindex-only to leave worktree unchanged
Date: Sun, 23 Feb 2014 12:57:15 +0100
Message-ID: <87vbw6qbxg.fsf@thomasrast.ch>
References: <cover.1393059605.git.tr@thomasrast.ch>
	<2e56b258bca6cf83c322da4be85c42c7b54f6a3e.1393059605.git.tr@thomasrast.ch>
	<CAPig+cSWhbunMtQ8=sXqwR7Ps+c0DY2SqVKpu_draaieSJrEPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 23 12:57:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHXgh-0005qm-Lq
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 12:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbaBWL51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 06:57:27 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:36667 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbaBWL50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 06:57:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id CFB654D6564;
	Sun, 23 Feb 2014 12:57:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id s9dcVXlMr-EF; Sun, 23 Feb 2014 12:57:14 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (9-226.197-178.cust.bluewin.ch [178.197.226.9])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 870AA4D64BD;
	Sun, 23 Feb 2014 12:57:14 +0100 (CET)
In-Reply-To: <CAPig+cSWhbunMtQ8=sXqwR7Ps+c0DY2SqVKpu_draaieSJrEPA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 23 Feb 2014 04:07:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242542>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Feb 22, 2014 at 4:17 AM, Thomas Rast <tr@thomasrast.ch> wrote:
>> Using the new no_worktree flag from the previous commit, we can teach
>> merge-recursive to leave the worktree untouched.  Expose this with a
>> new strategy option so that scripts can use it.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
>> index fb6e593..2934e99 100644
>> --- a/Documentation/merge-strategies.txt
>> +++ b/Documentation/merge-strategies.txt
>> @@ -92,6 +92,10 @@ subtree[=<path>];;
>>         is prefixed (or stripped from the beginning) to make the shape of
>>         two trees to match.
>>
>> +index-only;;
>
> s/;;/::/

I think ;; is actually correct: this continues the sub-list of options
to the recursive strategy.  The :: level lists the available strategies.

>> +       Write the merge result only to the index; do not touch the
>> +       worktree.
>> +
>>  octopus::
>>         This resolves cases with more than two heads, but refuses to do
>>         a complex merge that needs manual resolution.  It is
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Thomas Rast
tr@thomasrast.ch
