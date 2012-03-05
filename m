From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Allow Overriding GIT_BUILD_DIR
Date: Mon, 05 Mar 2012 12:08:11 -0800
Message-ID: <7vaa3u24lw.fsf@alter.siamese.dyndns.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
 <7vaa3v4kwo.fsf@alter.siamese.dyndns.org>
 <nng399m3om6.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: greened@obbligato.org, git@vger.kernel.org
To: dag@cray.com (David A. Greene)
X-From: git-owner@vger.kernel.org Mon Mar 05 21:08:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4eCl-000569-Rz
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 21:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642Ab2CEUIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 15:08:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757633Ab2CEUIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 15:08:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59F516BAF;
	Mon,  5 Mar 2012 15:08:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1tJ1x8+Ti/gQlt3h0i4Gady5Q3Q=; b=dXW2eu
	lLL2nsxkwogwKkEaCOtC59HGKlrieHZTCe1/8gsmhzQ/AaYG94jqC/tJaPUeKZkl
	7innUo1cni/Zo5uIFRPFeHlqtkNz8t9A3k1ItJK7FiSaORhZjceF6mu36Il4ftI3
	fBhURXw2+D84bo/o870fl8ivdtar68zITvvwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mtaiP9YSTd2U1zuAW369CrN9sgx8G6wP
	BUVP8gKNsb/1AFVYi8Q9U5OuZQM/0flQ8RpyQBHvplWE0vfGTVWTiISl6oHrPIRv
	JTyoSw0YkXEIYDXELeIY/Qf2RPrtccWLIzc1GFp+d2S62Irb1EADA3V89Bfsxz+H
	2obzpciPX9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 506676BAE;
	Mon,  5 Mar 2012 15:08:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C20156BA7; Mon,  5 Mar 2012
 15:08:12 -0500 (EST)
In-Reply-To: <nng399m3om6.fsf@transit.us.cray.com> (David A. Greene's message
 of "Mon, 05 Mar 2012 12:10:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFC28A70-66FE-11E1-B3B7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192269>

dag@cray.com (David A. Greene) writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Both of your changes seem to have broken indentation to use 8-SP at
>> the beginning of some (but not all) lines instead 1-HT.  I'll queue
>> a fixed up version and push the result out in 'pu' later, so please
>> double check to make sure I didn't screw up.
>
> Right.  This is because you flagged an indentation issue with the
> previous version of the patch.  I think what happened is that the
> previous version included the 1-HT (what is HT - half-tab?) spacing but
> it "looked funny" with the additional "+" from the diff line.

No, with your earlier patch, all the existing lines used horizontal
tabs for indenting, and the line you added used runs of spaces.
When such a hunk is shown in diff output, "+" will make it obvious
that only the new line you added is wrong (because the initial "+"
and " " is absorbed in the first horizontal tab for Tab-indented
lines) and that is how I noticed and pointed out "a funny
indentation" to you.
