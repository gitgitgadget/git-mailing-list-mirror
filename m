From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/15] user-manual: Give 'git push -f' as an
 alternative to +master
Date: Sun, 10 Feb 2013 15:19:33 -0800
Message-ID: <7vbobrrc3e.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <f0f8b77a3487be30ee4c492899fe73af05e20413.1360508415.git.wking@tremily.us>
 <7vsj53sub1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4gBq-0006Qg-WE
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 00:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab3BJXTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 18:19:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab3BJXTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 18:19:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 677E9C2D9;
	Sun, 10 Feb 2013 18:19:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EYGgm6u8qWadnRGN5xBNK07pRU8=; b=HTlTam
	lLDJhzBi+t1VKXu8PWkcCylejnwqOlCgOPkn7kSC6j+QUJytlr4qNmpddjOyhCS7
	NbW8aj/HyifjH57GYTVI6ByaGCO9XFPpsbecpOc6zF9zIWzBMHYtjAVf2rXUoyE/
	8eMVjspIjuUujahIsdVtPtwLZLw7XadgG4440=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ALv1s54pW4N4RQQO12ZjvCIgl8Pdw5GF
	zOytoF3wcIcjNKHtoX0ZXXtQKFMzB+sH5vGcfunhJw2vv0tDla0rIESztCm9R3wb
	D8mjbNbxveUjbqe03W63myUP+qnEvHGHv9oHVWAmF2zm5heuyTpRRQBuUdNWjyo3
	1aRQUi8l+oM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FE68C2D3;
	Sun, 10 Feb 2013 18:19:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 864DBC2D1; Sun, 10 Feb 2013
 18:19:35 -0500 (EST)
In-Reply-To: <7vsj53sub1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 10 Feb 2013 14:00:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5549FF54-73D8-11E2-88A6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215969>

Junio C Hamano <gitster@pobox.com> writes:

>> +Note the addition of the `+` sign.  Alternatively, you can use the
>> +`-f` flag to force the remote update, as in:
>> +
>> +-------------------------------------------------
>> +$ git push -f ssh://yourserver.com/~you/proj.git master
>> +-------------------------------------------------
>> +
>
> I didn't check the surrounding examples but would it make it a bit
> too advanced to make the example flow push out more than one
> branches here (perhaps he is also updating the 'maint' branch)?
> Then use of "--force" can be explained as "Instead of adding + to
> each and every refs to be pushed, you can use a single -f to force
> everything."

Now I have.  This is after a "git push" failed, saying that 'master'
does not fast forward, and attempting to push the 'master' out
forcibly.  There is little risk the user would get confused and say
"push -f $there master some-other-branch" in the context of this
flow.

So I think the patch is good, but others may have comments, so I'll
let the patch floating on the list for now.
