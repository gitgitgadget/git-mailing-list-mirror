From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 08/19] rebase -i: Root commits are replayed with an unnecessary option
Date: Fri, 18 Jul 2014 09:52:12 -0700
Message-ID: <xmqq7g3aobib.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<606af9e165c447b59076046a4d84aecf8b4cd2b0.1404323078.git.bafain@gmail.com>
	<xmqqzjgj7a88.fsf@gitster.dls.corp.google.com>
	<53C8E5E8.4090509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 18:52:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8BOT-0001PR-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 18:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965651AbaGRQwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 12:52:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57435 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756232AbaGRQwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 12:52:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B88D27C90;
	Fri, 18 Jul 2014 12:52:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UI4fRq9zva3GwajwsgSmgLIP6uk=; b=WCAWUi
	zN4y8N+ZpzsdXrT1hgGgRYzNjLzoeEduMhx9XV1ae3I7hycTqe7kv9tw3mQg6hnb
	isILFuEQ6UyYRkRD5CbzF7Wmsaq5rYxCRA+7FCvpKqFdAY7kTnseDPw/dNFQKL5h
	PqKgY74jVMMpypBIgaLwji9ozhVmdEwZOCSoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w3ldURA6qoSpxbjZPBK7mT1YFwm+8LiD
	qE0WrFwxWPCiqLOD7lYj8dBPjiNgAWgi47fC8wiX3aCNcx6sUN9ngSDMP6DGWwIS
	a3NI5/BQgz+uQDd1TaA+RjEhPMiOPr5qSdKzc2nIOyfzeNh14NTh09nZLDL/eEVn
	5EjqEbDj+8I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FE9227C8F;
	Fri, 18 Jul 2014 12:52:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91A8627C81;
	Fri, 18 Jul 2014 12:52:14 -0400 (EDT)
In-Reply-To: <53C8E5E8.4090509@gmail.com> (Fabian Ruch's message of "Fri, 18
	Jul 2014 11:16:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DEA5C04E-0E9B-11E4-84F8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253826>

Fabian Ruch <bafain@gmail.com> writes:

> It makes the next patch easier to understand because the finalising
> command line "git commit --allow-empty --amend --no-post-rewrite -n
> --no-edit" seems to be simply moved to the end of do_pick. Substituting
> --no-edit for -C there would make that log message overly long ...

And the reason why the same "-C $1" is not used and "--no-edit" is used
in the final version that is moved to the end of do_pick is...?
