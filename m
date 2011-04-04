From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Documentation: Add diff.<driver>.* to config
Date: Mon, 04 Apr 2011 10:24:38 -0700
Message-ID: <7v1v1i9bft.fsf@alter.siamese.dyndns.org>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1301840722-24344-1-git-send-email-artagnon@gmail.com>
 <1301840722-24344-3-git-send-email-artagnon@gmail.com>
 <4D998736.2080901@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 19:25:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6nWN-0006sT-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 19:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab1DDRYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 13:24:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab1DDRYx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 13:24:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7416C4284;
	Mon,  4 Apr 2011 13:26:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZAuGk4xZb69Pd9hoMH/WcEY/2Mg=; b=MoI1Tz
	C8wRdgJqGTO4hcMOOH1Yv/SE4Lb+SI3IQJBgHQ5Ji/M3ymiV52TKcYiEh1yL6rEf
	MCYKsfkpqSMnBAaut/LSOTTKHcrwjkebpmllqQl++sCCbITqAerNkU3i5G9YMyeF
	lY1JrTNnCbK5AXWxQgDz0IpyFn8dc9IAELA6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/FdsdLuS27JjI2qQu6KPe37j6SkCrai
	VblwylC+NYG/sq6yolagRhKtSEbaOILGepvUAvEwFc3zF7B7jnXVrQBHwX0fFu2h
	6WZ95iOA6ZBMDS5LGwNLiREQDtwNTx3+BW/rlNemTrsgz4DArnNUyzhfx0f4kpqd
	5iMbX7g7QTw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D87C74279;
	Mon,  4 Apr 2011 13:26:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 49A254278; Mon,  4 Apr 2011
 13:26:31 -0400 (EDT)
In-Reply-To: <4D998736.2080901@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 04 Apr 2011 10:54:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B24AF71C-5EE0-11E0-94A3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170827>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> ...
>> +diff.<driver>.xfuncname::
>> +	Defines the regular expression that the custom diff driver
>> +	should use to recognize the hunk header.  A built-in pattern
>> +	may also be used.  See linkgit:gitattributes[5] for details.
>
> The regular...

I agree with your "Defines..." comment.

>> +diff.<driver>.binary::
>> +	Set this option to true to make the custom diff driver treat
>> +	files as binary.  See linkgit:gitattributes[5] for details.
>
> This has nothing to do with the diff driver's operation. It is about how
> git treats the result (the output from the diff driver):

In general, the use of "diff.<driver>.foo" is consistent with the current
terminology, which is coming from the description of <driver> in the
gitattributes documentation:

   `diff`
   ^^^^^^

   The attribute `diff` affects how 'git' generates diffs for particular
   files. It can tell git whether to generate a textual patch for the path
   or to treat the path as a binary file.  It can also affect...

   Set::
   ...
   String::

           Diff is shown using the specified diff driver.  Each driver may
           specify one or more options, as described in the following
           section. The options for the diff driver "foo" are defined
           by the configuration variables in the "diff.foo" section of the
           git config file.

When the 'diff' attribute was invented, its string value was meant to say
more than "do generate diff for this path" (set) vs "don't generate diff
for this path" (unset) by saying what _kind_ of file it is and switch the
backend driver to generate diff based on that _kind_.  We could call this
"kind" a file-type, but that is a bit too broad a word; we are not talking
about regular file vs symbolic link or executable vs non-executable.  This
is about letting us determine the type of the _content_ more explicitly
than the case where the attribute is Unspecified and we inspect the
content to determine the type.  Perhaps we could have called this
content-type but again that word has other established meaning.

In any case, as you point out, the description itself is not quite right
from the end-user's point of view, even though it is correct at the
implementation level.

This diff.<driver>.binary variable is a somewhat ugly workaround for
content types that want to be treated as if they are binary while "diff"
(usually you would say "-diff" in gitattributes file for such a path)
works, but still want non-diff users (e.g. "cat-file --textconv") of the
textconv filter to still apply the specified text conversion.  In order to
specify what text conversion to apply, you would need a content-type to do
so, but once you specify a content-type, "diff" will not treat them as
binary anymore, so you tell the "diff" machinery by setting this variable.

At the implementation level, you are telling the <driver>, which is
defined as an array of operations indexed by content-types, to respond to
requests to "diff" by producing "binary files differ", so in that sense,
it is telling "the custom diff driver" to "treat files as binary".

>> +diff.<driver>.textconv::
>> +	Defines the command that the custom diff driver should call to
>> +	generate the text-converted version of a binary file.  The
>> +	result of the conversion is used to generate a human-readable
>> +	diff.  See linkgit:gitattributes[5] for details.
>
> No, please! You don't need a custom diff driver for textconv.

Correct.  Probably we should abolish "custom" from the above description.
Also "binary" is unnecessary in "version of a binary file" above, as it is
perfectly sensible to run ps2ascii for a text postscript file.

>> +diff.<driver>.wordregex::
>> +	Defines the regular expression that the custom diff driver
>> +	should use to split words in a line.  See
>> +	linkgit:gitattributes[5] for details.
>> +
>> +diff.<driver>.cachetextconv::
>> +	Set this option to true to make the custom diff driver cache
>> +	the text conversion outputs.  See linkgit:gitattributes[5] for
>> +	details.
>
> Again, both are independent of a custom diff driver.

Just drop "custom".

> ... Maybe even <driver>
> is misleading here, I dunno.

Perhaps.  See the "file-type" and "content-type" discussion above.
