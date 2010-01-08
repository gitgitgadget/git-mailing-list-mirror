From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ssh username environment variable
Date: Fri, 08 Jan 2010 12:34:43 -0800
Message-ID: <7vskag9vz0.fsf@alter.siamese.dyndns.org>
References: <a038bef51001081224l33164526y51e5ca064b82b73a@mail.gmail.com>
 <20100108202958.GL32155@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 21:35:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLY6-0003KD-0Z
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab0AHUfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 15:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300Ab0AHUfD
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:35:03 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab0AHUfA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 15:35:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69A5F8F759;
	Fri,  8 Jan 2010 15:34:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J8bNXKdZ1Uq+bBnXqCZ1T+H8G60=; b=Ov1Odz
	DXJ89N3bJJbeEOgcxqy0tZjePzWD46V2MreCJknesqtH3cJOOQPrkgDoQ/fHQIq/
	uQK/coaLxtlVurR36wM9UI84hvw3KGHdp35qYNLdwzpkLRpzf0pOV47vQ9cJ4++r
	carkVCg/54TFvU3nIDehleBJHhuASybqMInfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TLe2JToGARfPILXcQj7xyy8+aU0oNVmm
	f3F2zAIGNJPQC05Ar+SZP1m5uk+KVKNu5OAqKMow8ivAVOZQhMjbSD6voRAESSxV
	UzGArbK5EHezdbco/R7PM9CZyXIuA5S9kACEtBl6IjPsOuWMRvX4OM/Wrn0TpaVL
	td3zJyBMSSQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 386D68F758;
	Fri,  8 Jan 2010 15:34:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 746248F752; Fri,  8 Jan
 2010 15:34:45 -0500 (EST)
In-Reply-To: <20100108202958.GL32155@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 8 Jan 2010 12\:29\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 442FC1DA-FC95-11DE-88AF-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136473>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Chris Packham <judge.packham@gmail.com> wrote:
>> Just wondering if there is an environment variable I can use to tell
>> git or ssh what user name to use for the ssh transport?
>
> No.  But you can hack around it:
>
>   cat >$HOME/bin/git-ssh
>   #!/bin/sh
>   ssh -l $GIT_SSH_USER "$@"
>   ^D
>
>   GIT_SSH=$HOME/bin/git-ssh GIT_SSH_USER=myname git clone ...

I thought the standard answer was "use $HOME/.ssh/config", to set User
by keying on the remote hostname to which you are going.
