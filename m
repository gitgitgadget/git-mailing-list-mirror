From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add "first parent" to gitglossary
Date: Sun, 18 Mar 2012 11:56:41 -0700
Message-ID: <7vehspd9g6.fsf@alter.siamese.dyndns.org>
References: <1331966864-31687-1-git-send-email-nkreitzinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, bfields@fieldses.org,
	phil.hord@gmail.com
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 19:57:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9LI6-00026a-EG
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 19:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab2CRS4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 14:56:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753838Ab2CRS4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 14:56:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E43D77B9;
	Sun, 18 Mar 2012 14:56:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnREgiZ5eDg33WL4CFwJkPMttkU=; b=dMH+qD
	pnGHaTsO3fT3QvvKSq/BX1vLoUuUZ+xW2IoqyudSdlQWXSc+K9GFEoySCK759SOJ
	psuRM4VC41+9a0unfXZMRO1ikHu8twNGANrCQgZF1585gjB1lMc37b/fRIdOWiBi
	6Lvav5Og8WOfiF82kP5suolC5fnEx9+Q0PQPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XmTRIMNBBUvHq8WTo/Q4p/eaEk5uWG6d
	fmhaJMKjKodrAiGKrZ6AMDLdUPdUtpmaoh8VnjovpMlp0nBtHJxW9q1SN5OXIuQR
	hBKAI0pXT8w+p/KH4dzPj4/nHdAqdXUtBeDw2DrPvq0sYP8TafD7wg/ktwagMXsC
	OhJHbrRIz4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 630B077B8;
	Sun, 18 Mar 2012 14:56:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8C7277B6; Sun, 18 Mar 2012
 14:56:42 -0400 (EDT)
In-Reply-To: <1331966864-31687-1-git-send-email-nkreitzinger@gmail.com> (Neal
 Kreitzinger's message of "Sat, 17 Mar 2012 01:47:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A2FA5A4-712C-11E1-8335-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193388>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> Add "first parent" to "gitglossary" reference manual page.  Use the
> definition provided by Junio Hamano in a git newsgroup post[1].
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/192523

As the message was written specifically for you, taking what *you* seem to
already know, and more importantly what *you* seem to be misunderstanding,
into account, I do not think it is suitable for general documentation
without rewording.

Also, as Jonathan already pointed out, singling out "first parent" and
placing it in the glossary is a very odd thing to do.

Also see

  http://thread.gmane.org/gmane.comp.version-control.git/192427/focus=192534


Three entries "parent", "child" and "ancestry" might want to have an
explanation in the glossary to give new people the prerequisite, though.

child::
parent::
ancestry::
	Git represents a specific state of the project in its history with
	a commit object, which points at zero or more other commit objects
	as its "parents". When commit A points at commit B as its parent,
	we say "A is a child of B" and "B is a parent of A".
+
Parents of a commit is an ordered set, and because a commit object is
immutable, the parents of a commit do not change once it is created.
On the other hand, a new commit can be created, pointing at any other
commit as its parent, so children of a commit is not a mutable set,
and there is no inherent order among children.
