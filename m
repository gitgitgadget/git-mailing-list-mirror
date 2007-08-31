From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk from subdirectory
Date: Thu, 30 Aug 2007 22:32:47 -0700
Message-ID: <7vir6w46bk.fsf@gitster.siamese.dyndns.org>
References: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708302200160.25853@woody.linux-foundation.org>
	<7vsl6046gn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 07:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQz7o-000868-Gq
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 07:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530AbXHaFcx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 01:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbXHaFcw
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 01:32:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523AbXHaFcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 01:32:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F6C912A46B;
	Fri, 31 Aug 2007 01:33:11 -0400 (EDT)
In-Reply-To: <7vsl6046gn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 30 Aug 2007 22:29:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57115>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> I realize that the "--" behaviour of git log was intentional, but seeing 
>> what it results in I think the intention was good, but stupid.
>
> I haven't finished analysis yet, but I was reaching the same
> conclusion.
>
> v1.2.0 used to limit "git rev-list" to the current working
> directory, v1.3.0 and newer does not.  But they do when "--" is
> given.  This makes it impossible to do:
>
> 	cd Documentation
> 	echo >master
> 	git rev-list master
>         ... get "ambiguous -- which do you mean?  rev, or
> 	... limited to path?" error message
>         git rev-list master --
>         ... I do mean unlimited and dig from 'master'

FWIW bisect points at your commit ae563542bf10fa8c33abd2a354e4b28aca4264d7
(First cut at libifying revlist generation) ;-).
