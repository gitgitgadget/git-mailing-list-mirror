From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Tue, 08 Nov 2011 19:36:53 -0800
Message-ID: <7vobwmvuei.fsf@alter.siamese.dyndns.org>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
 <7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
 <CAMP44s0vsQ5sfx8arrRDo+-g9Zff_MmCz5t+yghwCMx_pL4Xzg@mail.gmail.com>
 <7vvcquy05c.fsf@alter.siamese.dyndns.org>
 <CAMP44s0bm+bydNnMWPHpz8B8wMf6XN9LTiiCD-nrYSHGAV5c5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 04:41:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNz26-0000Op-BX
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 04:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab1KIDg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 22:36:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab1KIDg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 22:36:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 284AC6A41;
	Tue,  8 Nov 2011 22:36:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2dDF/dHN+sHcL+1SN4FIjfOWZ3Y=; b=ByCMp0
	dE64rLAKIzLZqLQyAcfSJtROoSmh+73ZO+pSraTlY6o7Tv5jWgQJ4hoQ58Jb5KXM
	1rvJdgXVSVdS2jszEg3kI2N9NyILi+djkNlbGV/l7UJbSpGy2sCrdywK4iN9Z3+0
	LRSKFIpa8IPoM8T/GTyDEn3XHiAZ93lcm2a5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IHISGzCCGFZhTuGOkSmnF7Gwg8DxV8i9
	JPu5U1UsTpwh/TAThvO2SOffJnpTzX1cxKk18srFh4lY+EPvhNyClFlmmDK+B2x3
	G309rMjAHcuFjUvIocZDv7xuzWf0iVvTLN83E83Rs8bmsqhv7BlhAq/qU4qIGToC
	K5JCIwPyF/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DC546A3F;
	Tue,  8 Nov 2011 22:36:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A04956A3E; Tue,  8 Nov 2011
 22:36:54 -0500 (EST)
In-Reply-To: <CAMP44s0bm+bydNnMWPHpz8B8wMf6XN9LTiiCD-nrYSHGAV5c5Q@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 8 Nov 2011 19:59:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11B21ECA-0A84-11E1-A26F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185143>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Perhaps these 'git remote' commands should be removed in 1.8 then.

It is true that it was a long-term goal to deprecate many parts of the
"git remote" script that started as a hack to scratch itches "git fetch"
in the older days did not directly scratch for people, e.g. fetching from
multiple remotes in one go.

I do not think 1.7.X series to 1.8 is a big enough jump to remove
duplicated features, though.
