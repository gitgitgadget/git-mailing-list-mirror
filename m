From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 02 Mar 2009 09:08:12 -0800
Message-ID: <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 18:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeBeH-0004nm-7c
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 18:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbZCBRIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 12:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbZCBRIU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 12:08:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbZCBRIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 12:08:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B8FE20DD;
	Mon,  2 Mar 2009 12:08:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C573020DC; Mon, 
 2 Mar 2009 12:08:14 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0903011820590.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 1 Mar 2009 18:42:34 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B941CEE4-074C-11DE-91FE-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111949>

Daniel Barkalow <barkalow@iabervon.org> writes:

> My use case is actually, more precisely:
>
> some/constant/stuff/$PROJ-$NUMBER/junk/my-proj
>
> Where $NUMBER is the version number, and $PROJ is usually, but not quite 
> always "my-proj"; the exception being that it might be effectively a 
> superproject. So I'd like to have:
>
>  fetch = some/constant/stuff/my-proj-*/junk/my-proj:refs/remotes/origin/*

... and expect "some/constant/stuff/my-proj-2.5/junk/my-proj" to be mapped
to "refs/remotes/origin/2.5"?  I think it does not look too bad.

> But I can live with remote branches like "my-proj-2.4" instead of "2.4".
>
> I think it would make sense, and limit typo damage, to say that the * can 
> only expand to something with a '/' in it if the star has a slash or the 
> end of the string on each side.

I do not understand what you mean by "* can only expand to something with
a '/' in it if ..." part.  None of the examples in your message have a
case where the asterisk matches across directory boundaries, and I thought
you would simply say "* does not match /" and be done with that.

What scenario do you have in mind that wants to match a slash with an
asterisk?
