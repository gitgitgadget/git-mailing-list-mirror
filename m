From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: a submodule-like facility that tracks branches rather than 
 commits
Date: Sun, 02 May 2010 09:00:24 -0700
Message-ID: <7veihuuwdj.fsf@alter.siamese.dyndns.org>
References: <w2n2cfc40321005020402gdc210b79v2652afa849cf7a60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 18:00:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8baw-0005Gf-30
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 18:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655Ab0EBQAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 12:00:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139Ab0EBQAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 12:00:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27606B0AD6;
	Sun,  2 May 2010 12:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tABWO4Cf2t79REGlCEkDCL/pDcA=; b=XvWViJ
	l/i37aCkAvMMNVZU9WIawuD0KEii9PfSh1THidEmdqGbwneT1XGfmWSwT3IDL89i
	JyZl79gk31u1vV5J729+PySww8Vg5g9jN18WHX90vWnlUMTB948dq25rteZ37Raz
	Xq5p42u2yWGoMqUeZX7oDjr3pNZ0VG+Xaugjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fXVjlY+bahk9do1cmYXQaR6RYCwhg1ZK
	P73Go14yEiuQy9TeaCe7B3huMfenipxhR1bbhXuZaS8ACFce0OLyR2UjWb3DG8jQ
	rvMQqFDx5i3C7zCSlB+9qgbrJ+MdL3rZrBhab8uja3eHRXIDkAJe2Gv4odbWryaw
	KBKQHvXOFW8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03238B0AD5;
	Sun,  2 May 2010 12:00:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5635AB0AD4; Sun,  2 May
 2010 12:00:26 -0400 (EDT)
In-Reply-To: <w2n2cfc40321005020402gdc210b79v2652afa849cf7a60@mail.gmail.com>
 (Jon Seymour's message of "Sun\, 2 May 2010 21\:02\:58 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D438A504-5603-11DF-B29E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146188>

Jon Seymour <jon.seymour@gmail.com> writes:

> Has consideration ever been given to a submodule-like facility where
> the configuration information maintained in the supermodule for the
> submodule is not a gitlink but is instead the name of a branch (or
> generally, a symbolic reference within the nested submodule).

I think this comes up from time to time, and there was an even a slightly
more concrete suggestion to us 0{40} in the tree object to denote such an
entry.

But once people realize that there is no single canonical authoritative
repository whose branch heads point at the same commits for everybody in a
distributed environment, the line of thought to touch gitlink entries gets
retracted or discarded as a misguided idea.

I however don't think it would hurt to enrich .gitmodules with not just
the repository information but with branch information to help clones
decide which commit (other than what is recorded in the tree of the
superproject's commit) on the named remote tracking branch to try out with
the superproject's commit.
