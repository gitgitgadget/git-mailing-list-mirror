From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Another core.safecrlf behavor with git diff/git status
Date: Mon, 24 Jun 2013 09:55:41 -0700
Message-ID: <7v7ghjbg8i.fsf@alter.siamese.dyndns.org>
References: <866f886ef5e48ba22eec0f67203666bb@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:55:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrA3Q-0004K0-Td
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab3FXQzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:55:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948Ab3FXQzo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:55:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77BA52A880;
	Mon, 24 Jun 2013 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c6gRYOXIShHfwMsfEAPq6U/KYBg=; b=u9Z5Cm
	IPzXHnzYHdQVT6NK9sUJ5VC/IEqc0Zc5MQ1vzcv6A2DxAXGSfVsYeGEEoQuk73MU
	BCL611g7gdXx1uT5MwtX+O/4QDnf4l5J/7NI8Lw0ww5i+qbxWUn1GyioYf13qSUY
	OV8YEzyVRywikXCRBbF9hZIExsn/jgZye5FbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vh/PkrQSmnaht7z7rDEHlxhydzoSo8f8
	ECcX4qcPkb0KwlB4HAtJM9LVKKl1LR3zJuRS7Tn4IfDTrZL+mNNK2m0qOzo07e88
	jmdzO07kMomTTKNzIQNCCoypcrA45J4rfFDkLLAJsSsM2w0yeSDh305afj9EaOME
	gV5Z54915KM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CF062A87F;
	Mon, 24 Jun 2013 16:55:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E19D52A87C;
	Mon, 24 Jun 2013 16:55:42 +0000 (UTC)
In-Reply-To: <866f886ef5e48ba22eec0f67203666bb@meuh.org> (Yann Droneaud's
	message of "Mon, 24 Jun 2013 18:37:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8212E22-DCEE-11E2-9BB7-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228872>

Yann Droneaud <ydroneaud@opteya.com> writes:

> - Why git diff does not always report the CRLF/LF mismatch ?

Most likely because you are telling safecrlf not to error out but
just warn, and then you are not fixing the cause of the warning?  So
diff would say "Ok, you must know what you are doing, so I trust
what is in the index", perhaps?

> - Why git status does not report about the CRLF/LF mismatch before
> updating the index:

My suspicion is the same as "diff".
