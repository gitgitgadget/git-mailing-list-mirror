From: Junio C Hamano <gitster@pobox.com>
Subject: Re: splitting a commit that adds new files
Date: Sun, 02 Feb 2014 10:15:07 -0800
Message-ID: <xmqqzjm9fkk4.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 19:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA1Zg-0002Mn-QI
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 19:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbaBBSPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 13:15:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbaBBSPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 13:15:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F64866C39;
	Sun,  2 Feb 2014 13:15:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qPe8lArpK4CVYfYg+YgTB1bhv8I=; b=xPF2EM
	r1e/gkyQeC8UFQ7POgxCLwUzCu3uC8yBIttoFV9TR3yCB5ee5LGMzxtVjOa1Wg7/
	E8GeIYdb9upXBTfno7RPvhSiQZLqQaSgg1rzAk0P296y4b4ulRhDfbvujUGFRDcG
	pK+W+mQK/eSUlxqYgBpIlTszd7LLnYJCALQhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BqCDjcTM7e3kFy8E/Ot0D3KtbCSVocx5
	RvPXIdXzj3XbfAjQEWLEdgoXGxWyFXGRHJe8lRgEkzlQ/eyPKTNCG0p2OnqbUDJt
	sP/wXBAjuVkfnmFWnaIw3m4mtcWV1ebK7U8NrXo1n6kgWieCoP2v8VyzRgQ14GIZ
	AdpjVRbUxdg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4384666C38;
	Sun,  2 Feb 2014 13:15:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0FAD66C32;
	Sun,  2 Feb 2014 13:15:09 -0500 (EST)
In-Reply-To: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 1 Feb 2014 17:48:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3995198-8C35-11E3-AEF5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241381>

Duy Nguyen <pclouds@gmail.com> writes:

> I usually start splitting a commit with "reset @^" then "add -p" back.
> The problem is "reset @^" does not keep track of new files added in
> HEAD, so I often end up forgetting to add new files back (with "add
> -p"). I'm thinking of making "reset" to do "add -N" automatically for
> me so I won't miss changes in "add -p". But maybe people already know
> how to deal with this case without adding more code?

Is "reset -p" what you are looking for?  I do not use that myself,
though.
