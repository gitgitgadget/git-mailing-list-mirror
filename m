From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git branch --merged and git branch --verbose do not combine
Date: Mon, 15 Sep 2014 11:06:23 -0700
Message-ID: <xmqq38bs92sg.fsf@gitster.dls.corp.google.com>
References: <87fvfutza3.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:06:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTafX-0001Nb-77
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbaIOSG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 14:06:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64800 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbaIOSG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 14:06:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 297123AD76;
	Mon, 15 Sep 2014 14:06:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5YLRkTEogBHNizgJj4KXrYq3DcQ=; b=askpK7
	frMXaL9lGPSyAZHgknKmex0n1CScuaC0l2YmsqNcG0VhF4W3Mhl0dPNAyejDGfQx
	lkMhFPkhJ6uX2oH+F2eHQ3Vy2ASwIawYqF6vL/VmUfoRZ//f7Jm4CAOAA9EbtzrE
	xWaVrWZGFACVbcwQ+2HfS6eINAO8MifHVTxIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rmTMVPGTtzKLxCG8Kt6uWtz00sYrkW9v
	a9/jXzaPgJxWgNtnQ1BeXMipwV2nqvdz9wFxgGO5RmmLBRRChEMHauFP3IwQavp5
	7dvYEzIB1URpdEeqaL4gs3CKFgyJlzM3q/l8JtmshKGc0FfpNm3y5srN7QohI3QE
	hILysFApzGY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FC3B3AD75;
	Mon, 15 Sep 2014 14:06:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 96AC53AD74;
	Mon, 15 Sep 2014 14:06:25 -0400 (EDT)
In-Reply-To: <87fvfutza3.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sun, 14 Sep 2014 09:52:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 02084C92-3D03-11E4-B255-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257061>

David Kastrup <dak@gnu.org> writes:

> dak@lola:/usr/local/tmp/lilypond$ ../git/git branch --merged --verbose
> fatal: malformed object name --verbose

Only at the very end of the command line if you omit something that
is required, Git helps by defaulting the missing rev to HEAD.  You
can be a bit more explicit in the middle, i.e. instead of asking
"Which are branches that already has been merged in --verbose?", you
can ask "branch --merged HEAD --verbose", meaning "What are branhes
that already has been merged in HEAD, please give me a verbose
answer?" perhaps?
