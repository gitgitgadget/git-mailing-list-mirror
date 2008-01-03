From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stitching together private svn repo and public git repo
Date: Thu, 03 Jan 2008 09:24:31 -0800
Message-ID: <7vd4sistyo.fsf@gitster.siamese.dyndns.org>
References: <C3A2A4FD.1089D%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>,
	Dmitry Potapov <dpotapov@gmail.com>, <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 18:25:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAToe-0005VX-Q5
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 18:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYACRYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 12:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbYACRYp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 12:24:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYACRYo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 12:24:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B6F345FF;
	Thu,  3 Jan 2008 12:24:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F7B45F8;
	Thu,  3 Jan 2008 12:24:38 -0500 (EST)
In-Reply-To: <C3A2A4FD.1089D%jefferis@gmail.com> (Gregory Jefferis's message
	of "Thu, 03 Jan 2008 14:43:09 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69528>

I suspect your message was linewrapped by your MUA and ...

Gregory Jefferis <jefferis@gmail.com> writes:

> ...
> # set up the grafts
> cat > .git/info/grafts <<EOF
> # connect r2 of git-svn to v1.86 of nm-ucl
> # r1 (which was an identical initial import) will now be detached (and
> forgotten)
> 52b1933421ef524811407fa4c240da58ceec5749
> eca3db14fcf25744fdf585456f03599a9db2af96
> #
> # Make fake merge with Neuromatic v1.91b
> # svn-manualmerge1 svn-manualmerge1~1 public-v1.91b
> 120282ee5275027312dde386c8995218f361cf35
> 0962cb27f7ad92f44def04630e8e6a22b86e0699
> 6735057f53dd57248c7ec23f6ae9f22085d98fba
> EOF
>
> # running git-status seems to stop git thinking that the working dir is
> dirty
> git-status
> ...

... your grafts file look as if you are marking five commits as
root commits, which is not what you wanted ;-).

The reason I mention this is because I think with a bit more
polishing and some background description your message is a good
material to add to Documentation/howto/.
