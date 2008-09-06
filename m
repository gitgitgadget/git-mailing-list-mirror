From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? - Unexpected lock file error
Date: Fri, 05 Sep 2008 17:09:32 -0700
Message-ID: <7vtzcut9s3.fsf@gitster.siamese.dyndns.org>
References: <279b37b20809051622q6b3ab37tec3f1726c71952e4@mail.gmail.com>
 <7v63paupd8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 02:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KblOG-0005jF-99
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 02:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYIFAJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 20:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYIFAJp
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 20:09:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYIFAJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 20:09:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F5745D25F;
	Fri,  5 Sep 2008 20:09:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 587645D25E; Fri,  5 Sep 2008 20:09:38 -0400 (EDT)
In-Reply-To: <7v63paupd8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 05 Sep 2008 16:47:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1ABF104A-7BA8-11DD-AD37-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95052>

Junio C Hamano <gitster@pobox.com> writes:

> "Eric Raible" <raible@gmail.com> writes:
>
>> If 'empty' has any commits then the merge happens as expected.
>
> I think it is a bug in the git-merge rewritten in C, in "Already
> uptodate!" codepath.

Try reverting 18668f5 (builtin-merge: avoid run_command_v_opt() for
recursive and subtree, 2008-08-28).  That patch seems to be seriously
broken.
