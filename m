From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2011, #01; Sun, 3)
Date: Mon, 04 Apr 2011 08:09:21 -0700
Message-ID: <7vlizq9hpa.fsf@alter.siamese.dyndns.org>
References: <7v62quc464.fsf@alter.siamese.dyndns.org>
 <4D99A023.1090102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 17:09:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6lPM-0001ux-G7
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 17:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab1DDPJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 11:09:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab1DDPJa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 11:09:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5AA974CD2;
	Mon,  4 Apr 2011 11:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T1qdgm7Ut70LyRbTWjUX9S2yycI=; b=MM8lXe
	qe3cQF6WoSWSP3OqY9PJA6DOv3P78I8soB7YoSnmtxTqnyXk9DIWDL4mDUPXWJcd
	is04nFx6NS0LDaT6DVgRRJ6xJ48TsQVqQjOGo76Nu4kh1fcUUVh8cO+3jwN2KX0z
	rabk0xWdQB9wXVtNUrjkcL4qzuU+TCEz5hLys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nG7POay6o14Dl3mkmAWEfAT7CBdKsMyU
	DTtz2Qmx7HonWPjRlNN6rjM1RAjG9zWXbs9e5Ue7WmagjDlooa6rxOkeA17fpTG/
	HFWK59gm9YWoaDagcVu7b5UNlbgSbmjTCwR0XA+di+W5ioG7c3WnofX+9ItZXWJd
	bm4XrajQ0xs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3783C4CD1;
	Mon,  4 Apr 2011 11:11:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 363654CCE; Mon,  4 Apr 2011
 11:11:14 -0400 (EDT)
In-Reply-To: <4D99A023.1090102@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 04 Apr 2011 12:40:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA98604C-5ECD-11E0-82C1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170816>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> [New Topics]
>> * jc/rev-list-options-fix (2011-04-01) 1 commit
>>   (merged to 'next' on 2011-04-03 at 91f19de)
>>  + "log --cherry-pick" documentation regression fix
>> 
>> We should merge this before -rc1, but there might be other similar
>> breakages in the text flow due to the same f98fd43 (git-log.txt,
>> rev-list-options.txt: put option blocks in proper order, 2011-03-08).
>
> I rechecked and didn't find any other mis-references. Some commit
> limiting options mention commit formatters like "--pretty", but I deem
> that to be okay without an explicit "see below".

Thanks.

>> * mg/doc-revisions-txt (2011-04-01) 3 commits
>>  - revisions.txt: language improvements
>>  - revisions.txt: structure with a labelled list
>>  - revisions.txt: consistent use of quotes
>> 
>> Most parts looked reasonable except for some nits.
>
> Should I resubmit or have you squashed that in already?

I don't think I squashed anything in to this series.

>> * mg/show-without-prune (2011-04-01) 1 commit
>>  - builtin/show: do not prune by pathspec
>>  (this branch uses mg/reflog-with-options.)
>> 
>> I wanted to like this, but it still feels like too much magic.
>
> ...with a little less magic suggested now (act on single no-walk rev only).

An alternative might be to give an advice message only when a single
no-walk rev with given with a single pathspec and we didn't produce any
output.

>> * mg/sha1-path-advise (2011-03-31) 2 commits
>>  - sha1_name: Suggest commit:./file for path in subdir
>>  - t1506: factor out test for "Did you mean..."
>
> Should I resubmit with "commit:./file" only, or is that too late anyways?

The topic is too late for 1.7.5 either way, and I am starting to like your
"aka" better than before.  I am tempted to merge this to "next" only to
give it wider exposure now, so that other people know what we are talking
about when we have to decide what to do after 1.7.5.
