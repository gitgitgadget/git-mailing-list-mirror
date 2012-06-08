From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] git-rebase.txt: "--onto" option updated
Date: Fri, 08 Jun 2012 12:52:32 -0700
Message-ID: <7v8vfxd1j3.fsf@alter.siamese.dyndns.org>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vipf1d96k.fsf@alter.siamese.dyndns.org>
 <20120608210630.Horde.joXbQHwdC4BP0k02QgDFpMA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 21:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd5Ec-0003C2-Gk
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 21:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934146Ab2FHTwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 15:52:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933436Ab2FHTwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 15:52:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 103B684C8;
	Fri,  8 Jun 2012 15:52:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=imywvymjM90xU+OHRuA79MZmPt8=; b=QN2qDs
	bHO7GVIIXhB5h9HqpaPAOSivy9B3PDgi6lodJEW7K3nq5AKEVu+a1AIt1eQf17ld
	nk9uqxKLAZF/KxRRct2AXMxTaJjD9UWJjlIiiHi5xj0aXdx8zD9UnOxtuXd0zxV8
	UROPl6+izxeMvP1QBqx5KP94hP+fdRjdW+cFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L+Gi/IlVdoA1zj1NQppthjk2uxUm5FKE
	gaaMb37spJXj4o9CB2JC4oOTOnSeBhF1W6oZqxZJ5Spp7FXoCCQWoK0eiskmuQzn
	u360eHgggHL1704RA1waZHx/zq1HAWUu5MG96H6oQutHqM6Ji3ow4ix2GXDohv+T
	K5jQ7/4K+ac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0615A84C7;
	Fri,  8 Jun 2012 15:52:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8663D84C6; Fri,  8 Jun 2012
 15:52:33 -0400 (EDT)
In-Reply-To: <20120608210630.Horde.joXbQHwdC4BP0k02QgDFpMA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Fri, 08 Jun 2012 21:06:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D2F7ADC-B1A3-11E1-9675-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199523>

konglu@minatec.inpg.fr writes:

> That's what I thought, but it appeared to me that the description
>
> --onto <newbase>::
>          Starting point at which to create the new commits.
>          If the --onto option is not specified, the starting
>          point is <upstream>.  May be any valid commit, and
> 	not just an existing branch name.
>
> only focus on the parameter <newbase>.

Talking about <newbase> is equivalent to talking about --onto isn't
it?  What the command does is described far above upfront in the
manual page; the description of options is the place to explain what
details are affected by giving (or not giving) the option in the
behaviour that was explained earlier.
