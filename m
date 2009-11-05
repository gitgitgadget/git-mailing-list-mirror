From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git 
 directory
Date: Wed, 04 Nov 2009 16:04:28 -0800
Message-ID: <7vd43xg7lf.fsf@alter.siamese.dyndns.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
 <1257364098-1685-12-git-send-email-srabbelier@gmail.com>
 <alpine.LNX.2.00.0911041621400.14365@iabervon.org>
 <fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 01:05:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5pqd-0002ol-Eu
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 01:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbZKEAEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 19:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbZKEAEh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 19:04:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZKEAEg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 19:04:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79111738A0;
	Wed,  4 Nov 2009 19:04:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=OOn6d/DhkTAvsjLR9GkjQzoxVZk=; b=tqVuxl
	CEUOmK/6ffoLwxc6tYZ8C0LMdYhQO+sk7Yyx18y5OAlFgg06XUJydOlPwEVtveM2
	tkGqS1lTpy3Qgs1MeyLspw7KEdHjUUbK+2GahyXcrQM1YC9lfy0Ogq648ai3Ku6P
	fztnOSRKjXREnyw1NYpABugtfYHJDAfLdKmJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bn0B8UK/L5RnjTwgTd9/9jlUFSofcIwf
	iDEbA97ZuSil/D1lzSYiY2vQx6SrxTUKn4IBT9RS0//QPKhoEXIiIfJN/LXxpDCj
	mLfpStqmwHIVENBO9Jhp6WOEiTKcjgon8ptXxZ5j1/dN2pwdtu4qELsx/TmUBBZa
	7xliByM5J1Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 323A07389D;
	Wed,  4 Nov 2009 19:04:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38E9F73899; Wed,  4 Nov
 2009 19:04:30 -0500 (EST)
In-Reply-To: <fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 4 Nov 2009 23\:06\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CDC24C94-C99E-11DE-9C98-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132178>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> In any case, I think it would be good to have
>> something like that, but I think maybe we should tell it where it can put
>> its status files, rather than telling it where the .git dir is.
>
> Yes, that would probably be a good idea, .git/info/remote-<vcs>/<alias> perhaps?

What do you mean by <alias> here?  Is it the <alias> in

	[remote "alias"]
                url = hg::http://some.where/repo/sito/ry.hg

IOW, can a user ever use the foreign interface directly from the command
line, without ever defining such entries in .git/config, perhaps using
"git remote"?
