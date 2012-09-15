From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Sat, 15 Sep 2012 10:08:45 -0700
Message-ID: <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCvsD-0006oX-LO
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 19:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab2IORIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 13:08:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906Ab2IORIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 13:08:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFC698C04;
	Sat, 15 Sep 2012 13:08:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6BnBxFVm19un4MDTeeorL6xK8XQ=; b=WzkUMx
	PVbhmdWBp7dxigFueEhfoFPI71i+T1NFe0lCw3Wfl3pIRM463Fd1y2aO5RSXE2S2
	NXDuzET0PnfdUHYZFuc9yK1DnqpTrj4gwoNbjM/uLXn6FWXQqLyOEDEg462Ov0MK
	ED680ZTqrlmasUHBZsgX26kEOOQTmvKJ+zRHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U7JroV2kl7TclK2KLpr8RSHRcT0pJqz6
	0s+2MRlDf4n6fup91u+h/2V20tYPWkW16S5pCEz/i8UA0W/cpOjoCXF8n+3rNVgM
	ZK6DvUzDpMCT5VmjWY/H95aUOtGjfo3AEpy6xX/l3vO8yggTL10zmeKsw96ZbiOy
	UZqzUCS+2rc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB2008C03;
	Sat, 15 Sep 2012 13:08:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E4468C01; Sat, 15 Sep 2012
 13:08:47 -0400 (EDT)
In-Reply-To: <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley> (Philip Oakley's
 message of "Sat, 15 Sep 2012 15:27:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 032C9A28-FF58-11E1-A4C7-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205563>

"Philip Oakley" <philipoakley@iee.org> writes:

> "Typically it will be placed in a MUA’s drafts folder, edited to add
> timely commentary that should not go in the changelog after the three
> dashes, and then sent as a message whose body, in our example, starts
> with "arch/arm config files were…". On the receiving end, readers can
> save interesting patches in a UNIX mailbox and apply them with
> git-am(1)."
>
> hides a multitude of implicit knowledge steps. Is there an extended
> description of what that would mean from a platform independent
> viewpoint? e.g. if the patches are separte files and an mbox is one
> consolidated file, how to get from one to the other so that 'it' can be
> sent by 'git send-mail'.

If you plan to use "git send-email" to send the final results out,
you should consider "git send-email" as your "MUA" in the quoted
paragraph.  And that will be very platform independent viewpoint to
see things from.

"git format-patch -o my-series/ --cover-letter ..."  would treat
"my-series/" directory as "MUA's drafts folder" and prepares the
messages you would want to send out, and you can proof-read and edit
the files in there before telling your "MUA" to send them out, with
"git send-email ... my-series/*.patch" or something.

> I'm also missing an understanding of the preparation stage where one
> tries to tidy up the various commit messages becaue they weren't
> explicit, specfic nor concise enough,...

Many people usually do "rebase -i" until perfection and then a
single final invocation of "format-patch".  Of course, the "final"
can and should further be proof-read and it is fine to do typofixes
in the format-patch output files without going back to the commits
before sending them out.

> ...so I suspect that there is an
> implicit `git format-patch` <-> `git am` loop of sharpening the mbox
> patches before submission to the list that I'm missing. Has this 
> described somewhere?
