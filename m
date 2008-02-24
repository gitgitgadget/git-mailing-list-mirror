From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 16:03:44 -0800
Message-ID: <7vfxvjxlsv.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
 <200802232113.40100.johannes.sixt@telecom.at>
 <7v63wf2yzt.fsf@gitster.siamese.dyndns.org>
 <200802232209.41428.johannes.sixt@telecom.at>
 <20080223211536.GA13280@coredump.intra.peff.net>
 <7vmypr1gmh.fsf@gitster.siamese.dyndns.org>
 <20080223223933.GA13683@coredump.intra.peff.net>
 <7vve4fz3y1.fsf@gitster.siamese.dyndns.org>
 <20080223224938.GA14231@coredump.intra.peff.net>
 <7vir0fz3ip.fsf@gitster.siamese.dyndns.org>
 <20080223231253.GA14320@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4MN-0004Yh-C2
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 01:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbYBXAEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 19:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754855AbYBXAEA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 19:04:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbYBXAEA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 19:04:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C3AE18F4;
	Sat, 23 Feb 2008 19:03:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 80D6918F1; Sat, 23 Feb 2008 19:03:51 -0500 (EST)
In-Reply-To: <20080223231253.GA14320@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 23 Feb 2008 18:12:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74896>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 23, 2008 at 02:55:42PM -0800, Junio C Hamano wrote:
>
>> I think the basic goal should be to come up with a way to make
>> sure that "cd t/ && make" and "cd t/ && sh -x tXXXX-name.sh"
>> would get an environment as close as possible to what happens
>> when you run "make test" at the toplevel.
>
> I was thinking of something like this:
> ...
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 83889c4..3c4e21f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -342,6 +342,8 @@ if ! test -x ../test-chmtime; then
>  	exit 1
>  fi
>  
> +. ../GIT-BUILD-OPTIONS

Sounds sane to me.
