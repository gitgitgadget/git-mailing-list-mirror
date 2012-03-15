From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/difftool: add deltawalker to list of valid
 diff tools
Date: Thu, 15 Mar 2012 13:56:22 -0700
Message-ID: <7v3999k2h5.fsf@alter.siamese.dyndns.org>
References: <1331828906-5943-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 22:07:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8HtF-0005Qe-Sf
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 22:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626Ab2COVG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 17:06:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161562Ab2COU4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 16:56:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E5DE79AA;
	Thu, 15 Mar 2012 16:56:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w84fwwV0AMkAfn3WljcdP5OUtOw=; b=CVYIJT
	Fd4QKGc8Yd9EtHeQCjx72laEJwgmiQTbFz8CHYzCuc0V/5rgcNFcssKvfH/HrHgs
	h7fh5ymcLs13gX1MqinbwRQMJfz4cDEe+tLO/P6FlFyueeNd4pI6NDokRKseampR
	d/vZD7YwneLBsyAio62+eCzTQKfJc/fjpBr28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J4w0hInderQzcDqVzQeq2o5RxhXrvBd/
	E39o+1GORmlI9uEPo5XYSixBS1lUKuuWQwqTBxUz05RJ4ZrKNaHImOFXqW29XNzM
	dACAV0OoHBXX/wdR/KrTZ3UGQbBS7fVIzGH+mTKuT7jdrsDO6jTUN1N/xamupBL9
	tqgLSMBeiq0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5515479A9;
	Thu, 15 Mar 2012 16:56:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E02F379A8; Thu, 15 Mar 2012
 16:56:23 -0400 (EDT)
In-Reply-To: <1331828906-5943-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Thu, 15 Mar 2012 12:28:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 532282E8-6EE1-11E1-A71E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193226>

Tim Henigan <tim.henigan@gmail.com> writes:

> The list of valid tools seems prone to error. Right now, there is nothing
> that tells people to update this documentation when new config files are
> added to 'mergetools'.  Should I add a README to 'mergetools' with
> instructions to update this file?  Or would it be better to replace the
> list in the help string with a more general statement like "<tool> must
> match one of the files located in $(git --exec-path)/mergetools"?

I would prefer to rip most of them out from this list in the
documentation, and refer people to ask the installed version of "git
difftool" to list them.  After bc7a96a (mergetool--lib: Refactor tools
into separate files, 2011-08-18), that should be the most sensible option.
I.e.

	--tool=<tool>::
		Use the diff tool specified by <tool>.  Valid diff tools
                include emerge, kompare, meld, and vimdiff; for complete
                list, run 'git difftool --tool-help'

or something.
