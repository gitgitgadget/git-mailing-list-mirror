From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: git stash create and git stash store added to git stash usage synopsys
Date: Wed, 14 Jan 2015 09:43:29 -0800
Message-ID: <xmqqy4p59s1q.fsf@gitster.dls.corp.google.com>
References: <1421171646-12113-1-git-send-email-kuleshovmail@gmail.com>
	<20150114031137.GA12605@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Scott Schmit <i.grok@comcast.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:43:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRyk-0002e3-V4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440AbbANRnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:43:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754417AbbANRnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:43:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA68D2BC38;
	Wed, 14 Jan 2015 12:43:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ELqPgM0c6jgu2Dn0bLuO2KLAlUo=; b=P3lvA6
	mLZc+WbzO9dk2Vlq1Va90G2aYi45QuFFQkfm3hPGnG9ivPKmvoMiPOdcNl+527dK
	aClplGajYuEo1Q0YaEnoZAOS5KUXLgmvAXhprv54+x3H/Kwq1WYTHJbcz5tWGyF4
	7LQVE2mPQHjJFaeGo7oHcxRqlpoA/Zfka3IbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gp14j0PVank5yJ50C+By3q4W48Lc8zt+
	z951dgMMWVLvn6usXqFBpJgj5g7C3NJjPLRDt7Ru2+shuF22yC/hhupD+/oMD0vA
	4hmaXAoosBOnOwmtnc0vTpgLnZbfNfvIso8Tn5+uQlIyV+N1HgKxnORbEB7ftp9u
	9QmnfAr8OOQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D215F2BC36;
	Wed, 14 Jan 2015 12:43:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 519CF2BC32;
	Wed, 14 Jan 2015 12:43:30 -0500 (EST)
In-Reply-To: <20150114031137.GA12605@odin.ulthar.us> (Scott Schmit's message
	of "Tue, 13 Jan 2015 22:11:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA48B338-9C14-11E4-8981-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262401>

Scott Schmit <i.grok@comcast.net> writes:

[administrivia: please refrain from using Mail-follow-up-to]

> On Tue, Jan 13, 2015 at 11:54:06PM +0600, Alexander Kuleshov wrote:
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>>  git-stash.sh | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 6846b18..6e30380 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -9,7 +9,9 @@ USAGE="list [<options>]
>>     or: $dashless branch <branchname> [<stash>]
>>     or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
>>  		       [-u|--include-untracked] [-a|--all] [<message>]]
>> -   or: $dashless clear"
>> +   or: $dashless clear
>> +   or: $dashless create [<message>]
>> +   or: $dashless store [-m|--message <message>] [-q|--quiet] <commit>"
>>  
>>  SUBDIRECTORY_OK=Yes
>>  OPTIONS_SPEC=
>
> Considering the man page says create & store are intended for scripts
> and "probably not the command you want to use", why would we want it in
> the synopsis?

With the understanding that these are only for scripters, I think we
can agree that we do want to describe them in the manual pages, and
we do not want them in the completion.

I feel "git stash -h" output is on the borderline, and can be argued
both ways:

 - When you script and are not clear how a command you wanted to use
   in your script is to be used, it wouldn't be a crime to ask the
   short "git stash -h" form (instead of the full manual page "git
   stash --help") to remind how the command line ought to be
   spelled.

 - When you are not interested in script at all, from the command
   line you may want to be reminded how to spell the subcommand with
   "git stash -h" form.  Having "store" listed, which will never be
   what you want in this scenario, will be confusing.  You want to
   see "save".

So, I dunno.
