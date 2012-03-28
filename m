From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash-completion now loads completions dynamically, so __git_ps1
 is not defined when you open a shell
Date: Wed, 28 Mar 2012 15:17:13 -0700
Message-ID: <7v1uoctlp2.fsf@alter.siamese.dyndns.org>
References: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kerrick Staley <mail@kerrickstaley.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD1BC-0000H3-7R
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 00:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820Ab2C1WRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 18:17:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758112Ab2C1WRP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 18:17:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1B3479BF;
	Wed, 28 Mar 2012 18:17:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fHAkibuVm3Z+8mNh0U5tS4W2qXM=; b=gJOhVT
	kdulCtTDb4rGbwk+epBQ28yeARvJB2nb4KzL07pL5uFQ6zFucmhmEmsGeZJ6QVoH
	bTZ8xiXuQfn3oZ11CNQ+oaIBucxGp91Fl7BOobIE3GDjcg4LRHOf5kjiPeJr2UqI
	ULhbf8DkoQ8VHFbyUcBdGiiarBLqcqMiMYCAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FEmwT8FZnBBgASfvE7MCrRDeShGyyRE9
	nkt+GoxDEk7CBRRF4fHqrDOWBWxbuJifPcFtEXM5cNvd2wj2yCNNK2Lu6OLcKerm
	SHfTVNvRBefUfSKDixVvu9WJ1zmnqOApGi2cdOnjhqnb3AXkU5VFNTZrUEp0n1Zb
	usckgO4hQXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E98A379BE;
	Wed, 28 Mar 2012 18:17:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E62979BD; Wed, 28 Mar 2012
 18:17:14 -0400 (EDT)
In-Reply-To: <CANaWP3wu3260uFNzCLJ=YSG1BWFr=ge_6CmMGrG6zLThvFnjcQ@mail.gmail.com> (Kerrick
 Staley's message of "Wed, 28 Mar 2012 15:27:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5AFFBB4-7923-11E1-9226-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194210>

Kerrick Staley <mail@kerrickstaley.com> writes:

> The __git_ps1 function is defined in same script that defines Git's
> tab completions (contrib/completion/git-completion.bash). Since
> bash-completion loads completions on-the-fly in newer versions, the
> __git_ps1 function isn't immediately available in a new shell. How
> should this be handled? Should users just source git-completion.bash
> before they redefine $PS1?

Sorry, I don't quite get it.  "newer verions" of what?

To me, completion scripts have always been to be dot-sourced early, making
sure inclusion happen before PS1 is used.  Did we change anything recently
to break it????
