From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how do I review gitk release notes
Date: Wed, 22 Feb 2012 17:13:27 -0800
Message-ID: <7vpqd673ns.fsf@alter.siamese.dyndns.org>
References: <ji42ab$71s$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 02:13:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0NFY-0007By-U8
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 02:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab2BWBNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 20:13:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818Ab2BWBNa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 20:13:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A97D56B02;
	Wed, 22 Feb 2012 20:13:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VZKzkUByB/Sk7D07AsTMx/pLg7c=; b=QkMdL8
	TJHFWue4lH7quHzgg/p5Atr4l6mPQb8EqJ63uB3gd88IyrevCa6zfoTohyA120OD
	xE+3FbHDVCA5y64rXAfLXiaJTbrduHAqVLlS6csmfo36bV8fFxJNXpPo9bmQ5Wui
	m5K8iEzwoAAOsJpTxQqbiKww2qn5Zq6eIZu2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WIYKvTaoHHsyj93AXySrNr7yty0TmXN7
	NrDoItTc5pSCJaw+3TkUCylPaOhUrVIrWjNP1AoMZOkziMyBJ2KFXbGuON8paA7p
	BRiTWekfX1cSgqnmrY5JMFkCP1PZm843JQYcerVNsPr+8/i5zF4vtaEZpe+zuSEK
	XCglz0L5w4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0C616B01;
	Wed, 22 Feb 2012 20:13:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37DB26B00; Wed, 22 Feb 2012
 20:13:29 -0500 (EST)
In-Reply-To: <ji42ab$71s$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Wed, 22 Feb 2012 18:47:08 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 983FA626-5DBB-11E1-8B91-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191320>

"Neal Kreitzinger" <neal@rsss.com> writes:

> What is the best way to get the corresponding gitk release notes for git 
> releases (so I can see the detailed gitk release notes behind the git 
> release note "various gitk enhancements and fixes")?

Unfortunately, the best way I can think of is that you write it yourself
by looking at the log; I do not think there is any selarate release notes
written by anybody.

$ git log -1 --oneline --first-parent master -- gitk-git

will show that 09bb4eb (Merge git://ozlabs.org/~paulus/gitk, 2011-12-16)
was the last merge, so

$ git log -p 09bb4eb^2
$ git shortlog 09bb4eb^2

would be the "raw" data source to study.
