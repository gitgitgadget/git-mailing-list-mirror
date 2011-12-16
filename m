From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 11:38:35 -0800
Message-ID: <7vaa6si9xg.fsf@alter.siamese.dyndns.org>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <A8E08CC616E248EC8F9000DD86F228E0@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, <git@vger.kernel.org>,
	"Brandon Casey" <drafnel@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:38:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbdcB-0000Fg-3c
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab1LPTij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:38:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab1LPTii (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:38:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB34C7822;
	Fri, 16 Dec 2011 14:38:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8BTXYNwBljNypuwaShbxyrXE2uE=; b=bbqEn8
	TY7GNQxWRMYxw2SLiTvOvIqlfCMzV6dewXdS6+ln5Hji+on+QNuVCUGsIMgJAg7Z
	QLauwPpxsxvGBW5NnUwTz9gzB2ubWdwn7uesmcaof/I9RAxpxH63iMAhbsAPsTdM
	9krgnpgjTLAXuk0advcHaF3o8pj1zGZeXj62U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IXNsfMJU+qKbJQbInkmNk57JuOCZ9p6x
	IObC0dfRjZeqs7hPqyHXHlA7Nu/g7Q2dkttjosLb3R7QQOtTmxlpv1p/DtJZb7Sy
	BE8qJxDN7PVJMFEC7MSWJ/lS84Fce41WwXik5cfFYD7arKcb6/BdSAV6qrFsTMgM
	3tvJarUGT3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C40F77821;
	Fri, 16 Dec 2011 14:38:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03B61781F; Fri, 16 Dec 2011
 14:38:36 -0500 (EST)
In-Reply-To: <A8E08CC616E248EC8F9000DD86F228E0@PhilipOakley> (Philip Oakley's
 message of "Fri, 16 Dec 2011 19:26:00 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C443162-281D-11E1-A18B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187309>

"Philip Oakley" <philipoakley@iee.org> writes:

Administrivia: do not quote the whole message if you are only responding
to one small detail; cull the part you are not responding to. Thanks.

>> + "*.m diff=objc",
>
> There is a conflict here with the Matlab community which also uses "*.m"
> files for its scripts and code.  They fit the "It's not that hard to do,
> but it's an extra step that the user might not even know is an option."
> rationale.
> ...
>
> If the objc.m is used as a default it must be overidable easily, and
> listed in the appropriate documentation to mitigate the "might not
> even know" risk.

Even if we did so, I suspect that projects around Matlab would have to say
"Give attributes *.m diff=matlab" in their README files anyway, so if we
accept that, it wouldn't be too much additional trouble for the same
README files to also say "Specify diff.matlab.xfuncname to this pattern"
as well.  So in a sense, it might help reducing the confusion if we 
dropped the built-in Matlab pattern rule we recently added.
