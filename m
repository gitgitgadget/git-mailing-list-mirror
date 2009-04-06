From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 05 Apr 2009 22:17:26 -0700
Message-ID: <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <200904052358.53028.markus.heidelberg@web.de>
 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
 <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
 <20090406032457.GA14758@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 07:19:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqhEl-0002gJ-Ek
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 07:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbZDFFRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 01:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbZDFFRj
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 01:17:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267AbZDFFRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 01:17:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 38D66CAD7;
	Mon,  6 Apr 2009 01:17:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3EEB4CACE; Mon, 
 6 Apr 2009 01:17:28 -0400 (EDT)
In-Reply-To: <20090406032457.GA14758@gmail.com> (David Aguilar's message of
 "Sun, 5 Apr 2009 20:24:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C5BFB8C-226A-11DE-926D-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115764>

David Aguilar <davvid@gmail.com> writes:

> On  0, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Heya,
>> 
>> On Mon, Apr 6, 2009 at 01:17, Markus Heidelberg
>> <markus.heidelberg@web.de> wrote:
>> > Felipe Contreras, 06.04.2009:
>> >> But actually, "git diff --cached" is a
>> >> different action; you can't do "git diff --cached HEAD^.." for
>> >> example.
>> >
>> > And I neither could I do "git stage diff HEAD^.."
>> 
>> I rest my case ;). That's the whole point Felipe is trying to make here.
>> $ git diff --cached
>> $ git diff HEAD^..
>> 
>> That's two different modes of operation with the only difference being
>> a switch ('--cached'), which changes what is, and what is not valid
>> after that.
>> 
>> Whereas with
>> $ git stage diff
>> 
>> There is no confusion that 'HEAD^..' is not a valid argument, as there
>> is no command in 'git stage diff' to which it _is_ a valid argument.
>
> Hello
>
> Here's an interesting email from a while back:
>
> http://kerneltrap.org/mailarchive/git/2008/10/29/3857134
>
> The above mentions the following suggestion:
>
>     git diff STAGE WORKTREE   (like "git diff" today)
>     git diff HEAD WORKTREE    (like "git diff HEAD" today)
>     git diff WORKTREE HEAD    (like "git diff -R HEAD" today)
>     git diff HEAD STAGE       (like "git diff --cached" today)
>     git diff commit STAGE     (like "git diff --cached commit" today)
>
>
> From a consistency and usability perspective, the above
> example seems very appealing because:
>
> a) it does not introduce any new commands, and
>
> b) it is consistent with the way git-diff's command-line
>    interface works today.
>
> All we'd have to do is teach git-diff to special-case
> 'STAGE' and 'WORKTREE'.  Now, whether we'd want to do
> that is a completely different discussion, but I figured I'd
> throw the old thread out there.

How would you express operations the current --index option does in such a
scheme?  Yet another WORKTREEANDTHEINDEX token?
