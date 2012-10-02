From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unstaging during a merge conflict
Date: Tue, 02 Oct 2012 10:24:12 -0700
Message-ID: <7v4nmcaitf.fsf@alter.siamese.dyndns.org>
References: <CAHUDv6qM37nua2uB6TDOmf1a5L_TUFz=0q=v5W=9MrpEmWoShg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McClellan <mcclellan.mj@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:24:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ6Cq-0001Ov-9D
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 19:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab2JBRYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 13:24:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966Ab2JBRYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 13:24:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8C2981EF;
	Tue,  2 Oct 2012 13:24:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BajUXezJj48gYT5KVtxwou1ztcQ=; b=nCR0Sy
	Jtob9e7OduQPj9wSFpP0knZxIN9HKrQ/LiDxM+XRaG2aGe6qUva/KTyEb47ErJL2
	sv8GUQbAmD4ny8W0e7PyRjd/GAKBdRHasmiq4bTbffCcaMdmmEeS6NSaMk8E8Nqz
	S+UqNrCLmVRJH1SARioavXgx4MU3KCP3D6rVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OCgVmiwyUeoO/4uLIt/fDP2GyxvPNa1P
	AIb5QSQ4G1B00qDNcWoYZjmQ6aK3XA4Cdv69041dXQiwTCRXQaSM4dqBpuDUzkK3
	GdPXSUGilIWYWG5PZSdK61YYSZvuRhw4N8psNQcDcO0oCSgHcbIMWIxILbb9jHIr
	vrpNVU2oJVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A523981EE;
	Tue,  2 Oct 2012 13:24:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21D6581EC; Tue,  2 Oct 2012
 13:24:14 -0400 (EDT)
In-Reply-To: <CAHUDv6qM37nua2uB6TDOmf1a5L_TUFz=0q=v5W=9MrpEmWoShg@mail.gmail.com> (Matt
 McClellan's message of "Mon, 1 Oct 2012 20:13:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC9F6620-0CB5-11E2-87E5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206824>

Matt McClellan <mcclellan.mj@gmail.com> writes:

> I've done this using git add --interactive then reverting a files
> changes, though the actual crime was done using egit staging tool.  It
> seems the command line won't let you unstage changes but gui tools and
> interactive tools seem to allow it.

I think you could do "git reset [--mixed]" from the command line to
induce the same mistake.  It may be that it is much less likely for
people to do this from the command line because the command name is
"reset" that is spelled in red ;-) than some GUI programs without a
careful UI to mark potentially dangerous operations as such, like we
do in the CLI.
