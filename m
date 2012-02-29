From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filtering out mode-change-only changes
Date: Tue, 28 Feb 2012 19:40:12 -0800
Message-ID: <7vmx82wbmr.fsf@alter.siamese.dyndns.org>
References: <jik2le$2lb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 04:40:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2aOx-0007GS-GC
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 04:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030752Ab2B2DkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 22:40:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030724Ab2B2DkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 22:40:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648066967;
	Tue, 28 Feb 2012 22:40:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OIViHsXySP/A4zcn4+bV3BjS9z4=; b=HoUpjf
	8W5vX2gH4uWBgJDik3cUZ8CUYGT9XTv7Bc3boZqbaYx03AyUGbJvMHxAJtZww7uj
	SlLOSJUjQL9/maAb35CvtCfrzC++gbSNZZ4rWICAMnJMKn2eYZbQBMFnmL8D5OPw
	KN5nZgrmsmrxQUIP7+clHnZY6J574LRXDw0Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WrLn2i0gvmKAadWKQtu2AJQ76oPPUZAV
	49llMQzRAycOEnycxJ8MU1yeCt9id/3dAUv5RNQqTML6pM3lmhKAjPwcqdq083HF
	NVvJnD42VyvbzLsbhJWIpEcwl8lBWQpauKF2wBVPjpFkiZzQW291efenYZb68rEU
	HiTpPov2nAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BD826966;
	Tue, 28 Feb 2012 22:40:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDD6E6965; Tue, 28 Feb 2012
 22:40:16 -0500 (EST)
In-Reply-To: <jik2le$2lb$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Tue, 28 Feb 2012 20:31:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18834B88-6287-11E1-9529-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191806>

"Neal Kreitzinger" <neal@rsss.com> writes:

> What is the best way to filter out the "mode change only" entries from a 
> "name-status diff result" listing of changed files?
>
> Reason-for-this:
> get a list of files whose content changed and feed that list into a 
> gui-diff-tool for visual review of "merge" (rebase) results.

Later I have some words on this.

> ... I'd like to see if there is some way that git 
> already-does-this-for-you, or if someone already has a script that does 
> this.

I do not know about random scripts people write, but there is nothing
built-in.

But *if* the _real_ reason you want to do this is because you do not want
to see unnecessary mode changes caused by your filesystem that screws up
file modes for whatever breakage, perhaps setting core.filemode to false
so that mode changes made to the working tree files by your mode breaking
filesystem might be the real solution.

Of course I do not know if that is the real reason you are asking for that
or not.
