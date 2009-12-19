From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is
 required
Date: Fri, 18 Dec 2009 20:43:52 -0800
Message-ID: <7veimrmv3r.fsf@alter.siamese.dyndns.org>
References: <4B274BDE.8000504@viscovery.net>
 <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com>
 <7veimsvz8a.fsf@alter.siamese.dyndns.org>
 <200912182304.27656.j.sixt@viscovery.net>
 <m3d42cc4i8.fsf@localhost.localdomain>
 <7vr5qrsv4g.fsf@alter.siamese.dyndns.org>
 <20091219122509.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 05:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLrAv-00049E-TK
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 05:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbZLSEoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 23:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZLSEoL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 23:44:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbZLSEoK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 23:44:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A089A8713;
	Fri, 18 Dec 2009 23:44:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aE9fPbG0m+AKWvYWP7lBg3qMqN0=; b=r0hGOr
	x/CJsa+NhIAUWRw09IZtciu2spEGeM2mPDjj69m8mWyLU6JnoRzW3TXipbcxlRgl
	UpaKPHpgATXyufEjlMLrA9LfUU38WyvG8TERjMrCNJ2CJea+K5vhuNIqsVCRpNjz
	XQzCG2lJ+KUDvvD42t8me3unOwBXtLIgBrsAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BdwmaxS/r1SbvOfQ1NkvnmMq3cNKICN9
	caZDo1t9EjSSNQe7eYS8BtGk9N/tClt64ivXEWe5BTRcfQbx7EfZ43hobClMlEDb
	/ZVlCZrRbz3pQn1gKs73a4zNinBj/2IwPA4gP9SJ4k/l8U+prpxq7hSfOrLKwlUG
	Yd4B+1J8JdE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1DF1DA8708;
	Fri, 18 Dec 2009 23:44:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5F226A8704; Fri, 18 Dec 2009
 23:43:54 -0500 (EST)
In-Reply-To: <20091219122509.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Sat\, 19 Dec 2009 12\:25\:09 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20991880-EC59-11DE-954F-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135461>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> Come back with a proof that there has never existed any script that uses
>> "read-tree" without arguments to purge the index, and I'd immediately
>> accept and apply the patch to retroactively forbid what the implementation
>> has allowed users to do for a long time.
>
> For what it's worth, I compiled the very first version of git
>
>  commit e83c5163316f89bfbde7d9ab23ca2e25604af290
>  Author: Linus Torvalds <torvalds@ppc970.osdl.org>
>  Date:   Thu Apr 7 15:13:13 2005 -0700
>
>      Initial revision of "git", the information manager from hell
>
> and its read-tree fails with 
>
>   read-tree: read-tree <key>
>
> Is it a proof enough?

Ok, that initial one was "read a single tree to populate the index".

I consider it a fundamentally different program from "read-tree" as we
know now, which was introduced by d99082e (Make "read-tree" merge the
trees it reads by giving them consecutive states., 2005-04-15).  Ever
since that "multi-stage" version, read-tree was "starting from an empty
index, read these trees into stages #1, #2, ..."  And even that version
called the program "read-tree", not "git read-tree".  IOW, "git read-tree"
never had that "no tree is an error" restriction during its entire life.

Having said all that, I don't care that deeply either way myself.

As read-tree is a very basic and low-level Porcelain, if somebody were
using it to empty the index in an existing script, this change would
appear as a regression and hopefully will be caught eventually, and
updating such a script can be made reasonably easy if we want to be
helpful (the error message can suggest running "rm $GIT_DIR/index", for
example).
