From: Junio C Hamano <gitster@pobox.com>
Subject: Re: MERGE_RR droppings
Date: Mon, 25 Jun 2012 22:30:32 -0700
Message-ID: <7vtxxyd4hz.fsf@alter.siamese.dyndns.org>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
 <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com>
 <7v8vfk2pby.fsf@alter.siamese.dyndns.org>
 <7vwr2vfc1c.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7Hj4f-Gww4j89kppR8g1vzmhmydsFnG0ecjzL5WrRP4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 07:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjOMJ-0001bb-SD
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 07:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756333Ab2FZFag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 01:30:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab2FZFaf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 01:30:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4D955998;
	Tue, 26 Jun 2012 01:30:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cg/j2DGzhUj8jJo8yBOQUyTk8Hs=; b=WFH1sY
	XolHo1MFW/0qU3FRGveZnRfnNty5WNvSahttCS7cbwZhgODi7djyGnFwQMCoNVBV
	jhrx99nTWqSiMdWuMt+uS19A+C9TjSO2FPbe0niCZ2tPm53QuwlZLfBkc9T5v1JV
	ie6zUMBo1YXB0VYSNo5V1QESczfjREULO1UI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OvOhKTI2ESNaji/BROvFWblLf8HG67m/
	z8cEZ43TzfKrY+c+7JnhidZ+D7CgTJXvQw9Eigqc/LPsuUOg+4EwtKD55A8RV3hy
	bc/rruYt0BJhkgj9SNeR7oExj5Ym1wijtJWUrAt9lBWu/GwCoBqx+WqrA+okLzCF
	Y848nWtIK08=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B0365997;
	Tue, 26 Jun 2012 01:30:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2694B5995; Tue, 26 Jun 2012
 01:30:34 -0400 (EDT)
In-Reply-To: <CAJDDKr7Hj4f-Gww4j89kppR8g1vzmhmydsFnG0ecjzL5WrRP4g@mail.gmail.com> (David
 Aguilar's message of "Mon, 25 Jun 2012 21:31:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D71F624-BF50-11E1-B240-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200631>

David Aguilar <davvid@gmail.com> writes:

>> Perhaps mergetool should consider a missing MERGE_RR and an empty
>> one the same way?
>
> Would that test look (roughly) like this?
>
>     if test -f "$GIT_DIR/MERGE_RR" && test -n "$(cat "$GIT_DIR/MERGE_RR")"

Hrm, would "test -s $that_file" be simpler?


>     then
> 	files=$(git rerere remaining)
>     else
> 	files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
>     fi
>     ...
>
> If so I'll throw together a patch.
