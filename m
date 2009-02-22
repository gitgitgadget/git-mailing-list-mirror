From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Sun, 22 Feb 2009 08:49:13 -0800
Message-ID: <7v63j22z92.fsf@gitster.siamese.dyndns.org>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com>
 <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <git@storm-olsen.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:51:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHXf-0004pu-QC
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 17:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbZBVQt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 11:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZBVQt0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 11:49:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbZBVQtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 11:49:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CA639CAD3;
	Sun, 22 Feb 2009 11:49:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E6C079CAD2; Sun,
 22 Feb 2009 11:49:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C29A8168-0100-11DE-8151-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111017>

Marius Storm-Olsen <marius@trolltech.com> writes:

>> For doing any usual work of growing history, you would work inside
>> a repository with an work tree.  The only occasion you would *go*
>> to a bare repository would be to tweak, futz with and fix one that
>> is used as a distribution point, isn't it?  You usually update such
>> a repository by pushing into it, so your being there would be a
>> result of very conscious act of chdir'ing into it yourself, and you
>> wouldn't be spending too much time in there anyway.
>>
>> There may be a different workflow where you would stay in a bare
>> repository for an extended period of time and you would benefit
>> from such a reminder like this patch adds, but I do not think of
>> one.
>>
>> Care to enlighten?
>
> Right, I have quite a few repos on my machine which are just bare, as I
> use them gather branches and push out
> again. (http://repo.or.cz/w/git/platforms.git is one of them) However,
> it's probably just me, since I could just as easily put them in a proper
> directory structure to indicate their bareness.

Ah, so "gather branches and push out again" would look something like
this?

    $ cd /pub/some/where/platforms.git
    $ git fetch platform1 ;# perhaps with master:one/master mapping
    $ git fetch platform2 ;# perhaps with master:two/master
    $ git push public

Then it is very understandable that you would spend time inside a bare
repository.  I do not understand the need for GIT_DIR! thing even less,
but since we have that there already, I do not see a reason not to add
this to the queue.
