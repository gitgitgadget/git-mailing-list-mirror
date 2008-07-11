From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 15:18:54 -0700
Message-ID: <7vzloohxo1.fsf@gitster.siamese.dyndns.org>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>
 <alpine.DEB.1.00.0807111649290.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQyC-0008WD-M4
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924AbYGKWTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756884AbYGKWTF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:19:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740AbYGKWTE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:19:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B45622738B;
	Fri, 11 Jul 2008 18:19:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA28E27387; Fri, 11 Jul 2008 18:18:56 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807111649290.8950@racer> (Johannes
 Schindelin's message of "Fri, 11 Jul 2008 16:51:03 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D706534-4F97-11DD-B644-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88192>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 11 Jul 2008, Denis Bueno wrote:
>
>> I'm trying to use git archive to create a kind of "release" tarball of
>> my source.  I've got a patch (a commit) that I'd like to apply to the
>> tree before I call git archive on HEAD.  Currently my command is:
>> 
>>     git archive --format=tar --prefix=pfx/ HEAD | gzip > prj.tgz
>> 
>> If I were to actually modify my tree & history, I'd change the command to:
>> 
>>     git cherry-pick 97a1235ce674f7cf4df3129cd0ab1ae0793db392
>>     git archive --format=tar --prefix=pfx/ HEAD | gzip > prj.tgz
>>     git reset --hard HEAD^
>> 
>> But I'd rather not modify my history, if it's possible.  (This will
>> create a bunch of dangling commit objects over time, no?)
>
> $ git cherry-pick -n <bla>
> $ git archive --format=tar --prefix=pfx/ $(git write-tree) | gzip > prj.tgz
> $ git reset

That will create a bunch of dangling tree objects over time, yes.
