From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 04 Mar 2008 03:12:48 -0800
Message-ID: <7vk5ki91zj.fsf@gitster.siamese.dyndns.org>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca>
 <alpine.LSU.1.00.0803041044120.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Bremner <bremner@unb.ca>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org, 469250@bugs.debian.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWV5f-0004z3-Jf
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYCDLNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbYCDLNJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:13:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbYCDLNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:13:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D9B542571;
	Tue,  4 Mar 2008 06:13:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 321372570; Tue,  4 Mar 2008 06:12:59 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803041044120.22527@racer.site> (Johannes
 Schindelin's message of "Tue, 4 Mar 2008 10:45:12 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76063>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 4 Mar 2008, David Bremner wrote:
>
>> It looks like line 435 of builtin-commit.c disables stdin for hooks 
>> (with the disclaimer that I first looked at the git source ten minutes 
>> ago).
>> 
>> 	   hook.no_stdin = 1
>> 
>> I'm not sure if this was by design, but just so you know, this breaks 
>> people's hooks.  In particular the default metastore pre-commit hook no 
>> longer works.  I didn't find anything relevant in the docs [1].
>
> Pardon my ignorance, but what business has metastore reading stdin?  There 
> should be nothing coming in, so the change you mentioned should be 
> correct, and your hook relies on something it should not rely on.

It is not metastore.  It is an interactive hook that reads from the user
who is sitting on the terminal and invoked the git-commit program.
