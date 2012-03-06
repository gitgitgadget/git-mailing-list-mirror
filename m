From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 12:37:23 -0800
Message-ID: <7vzkbtqxdo.fsf@alter.siamese.dyndns.org>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
 <jj5ih2$f0m$1@dough.gmane.org> <7vsjhlsetn.fsf@alter.siamese.dyndns.org>
 <CAC0z1F-Eg2DOLvd3aA5XCoEJjj1jC=VWVkTA+uc24=18h3pN7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jerome Yanga <jerome.yanga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 21:37:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S518X-000845-6E
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 21:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030988Ab2CFUh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 15:37:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030895Ab2CFUh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 15:37:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04259717C;
	Tue,  6 Mar 2012 15:37:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OgKYBS+U4Xo6tFzHodBwfxvnubE=; b=yUBA3z
	zySdtzX9erBAN2SzGmcMfabE0W5ASlhNJFS/Yz9A9Rx0ErFl4c5F+HdwDAwoHQgJ
	7MlHnfpEvSPRGaok531zGMelr5Zzl8MO+W7mpYFHmC3CjmJ5ejEukM/CPL7cQLLF
	L67xQmzNmmGwysXu+NNg4fZUEiN70BwbJyixo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HcvuUENIphVpqPKyJPyKRiizrtyJGsQs
	vjXGWnDPqI04oQEo/prb+8HigWhCY6TnOqNf/1KQ1QZbUWb/pjpIS+EckY7aPRwM
	xgKwGsKnzJ01GttLVykaqm9hFQLCu8+x9WfC/su7NqEr154e4uuz0Pqrd73igurT
	wIVGBCCLQfE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0A89717B;
	Tue,  6 Mar 2012 15:37:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 822517177; Tue,  6 Mar 2012
 15:37:24 -0500 (EST)
In-Reply-To: <CAC0z1F-Eg2DOLvd3aA5XCoEJjj1jC=VWVkTA+uc24=18h3pN7g@mail.gmail.com> (Jerome
 Yanga's message of "Tue, 6 Mar 2012 11:49:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E4A5412-67CC-11E1-8365-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192388>

Jerome Yanga <jerome.yanga@gmail.com> writes:

[jc: kicking the thread back to the list; I do not give free
consultation in private, but I do not mind answering questions in
public to help wider audience.]

> Thank you for the prompt response.
>
> The projects in the Apache DocumentRoot are bare repositories.  I
> think this is what allowed me to push at least this is how I
> understood it from the URL I had quoted in my last message.
>
> If I understood what you had said about push being the opposite of
> fetch, then it is understandable that the files on the working
> directory did not get updated and that it only shows in the Gitweb
> interface.
>
> So how do I make the changes go in the working tree?

By arranging a "checkout" to happen when you want to.  One common
way people seem to do this is to have "git reset --hard HEAD" in
post update hook when the push came to the current branch, assuming
that nobody but the update in response to "push" is expected to
touch the working tree of the receiving repository.
