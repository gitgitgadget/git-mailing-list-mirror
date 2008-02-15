From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git filter-branch failed to suppress a file with an
 accentuated letter in the filename
Date: Fri, 15 Feb 2008 14:21:07 -0800
Message-ID: <7vwsp5g8to.fsf@gitster.siamese.dyndns.org>
References: <87bq6iw42w.dlv@maison.homelinux.org>
 <7vd4qygld8.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802151811240.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 23:22:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ8wW-0000Ux-H0
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 23:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbYBOWVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 17:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755495AbYBOWVa
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 17:21:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462AbYBOWV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 17:21:29 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DC11B4C;
	Fri, 15 Feb 2008 17:21:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 679391B42; Fri, 15 Feb 2008 17:21:20 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802151811240.30505@racer.site> (Johannes
 Schindelin's message of "Fri, 15 Feb 2008 18:12:57 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73990>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I have to wonder in what century filter-branch was written ;-)
>> 
>> Shouldn't those two lines be:
>> 
>> 	git diff-index -r --name-only $commit |
>>         git update-index --add --replace --remove --stdin
>> 
>> these days, without any of the cut and cruft?
>
> Maybe even using "-z" in both cases?
>
> Having said that, I do not understand why the old code did not work.  Will 
> have a look later today.

The reason mine does not have to use -z is because both end
knows how to C-quote paths under non-z mode.

Now you mention it, it certainly is a bit puzzling why the old
one did not work.
