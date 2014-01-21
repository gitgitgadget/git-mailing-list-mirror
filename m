From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_WORK_TREE and GIT_DIR with git clone
Date: Tue, 21 Jan 2014 12:23:41 -0800
Message-ID: <xmqq4n4xulrm.fsf@gitster.dls.corp.google.com>
References: <CAKJdRamFDDWRZDHBCe7GrXg0OWhLfBPq_ofsvowaW9d8VOGTMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cosmin Apreutesei <cosmin.apreutesei@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 21:23:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5hrW-0004BZ-68
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 21:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbaAUUXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 15:23:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbaAUUXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 15:23:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB83863A66;
	Tue, 21 Jan 2014 15:23:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CHHo1nFcFoabe0sJCRdPShDcrxE=; b=IjZCEb
	OZytGoB9SZzd4RSVXUHjg6vj9V+0mJgkCAqTEpObbUIy8A09iizyl0Lzl/S8AJZd
	2QBHenTMPBJvJdZQTmbZEF6JnvFWQ6lC94+7Jmw7rkXK7TDAp8ESG9bLDSLMf5E/
	748wKQ++cktMJ2IUYjC4VAnA/hMaDl+Flz928=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nBcvemHcudw9NFGhmQ6t/+n6NqpBjBOd
	xih6sr6Ccy+CEmM4sgIATg4yf8sezqQAFGV2aUaNKYOatIx8DV8zhZhKpoWnePjI
	Tm0FIv+yWmSlI5Zmcp8McWvrkYSd1a+joCkXuk/ZTwJ+Ysiv3kFp+fvwnok492mi
	XWHlVaQBdSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D18A863A65;
	Tue, 21 Jan 2014 15:23:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2C1263A63;
	Tue, 21 Jan 2014 15:23:43 -0500 (EST)
In-Reply-To: <CAKJdRamFDDWRZDHBCe7GrXg0OWhLfBPq_ofsvowaW9d8VOGTMA@mail.gmail.com>
	(Cosmin Apreutesei's message of "Mon, 20 Jan 2014 17:59:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EC8BEE2A-82D9-11E3-93DB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240773>

Cosmin Apreutesei <cosmin.apreutesei@gmail.com> writes:

> I would like to be able to tell my users that they can simply do:
>
> git clone --git-dir=_/git/module1/.git module1-url
> git clone --git-dir=_/git/module2/.git module2-url
>
> which will overlay the files from both modules into the current
> directory, which from git's perspective is the work-tree for both
> modules.

Would there be a sensible semantics in the resulting working tree?
Which repository would a new file in such a combined working tree
belong to?
