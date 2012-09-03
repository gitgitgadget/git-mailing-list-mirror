From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] Support for setitimer() on platforms lacking it
Date: Mon, 03 Sep 2012 20:15:55 +0200
Message-ID: <5044F3DB.9060908@kdbg.org>
References: <003301cd81e4$cd68daa0$683a8fe0$@schmitz-digital.de> <7vr4qqzsbe.fsf@alter.siamese.dyndns.org> <002201cd86ce$285841b0$7908c510$@schmitz-digital.de> <7vfw74s3oy.fsf@alter.siamese.dyndns.org> <003d01cd8827$34e90180$9ebb0480$@schmitz-digital.de> <7vpq64f935.fsf@alter.siamese.dyndns.org> <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 20:16:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8bBy-0005bD-5j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 20:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab2ICSQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 14:16:03 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:61894 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753483Ab2ICSQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 14:16:00 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7A1BC130057;
	Mon,  3 Sep 2012 20:15:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4427B19F3BE;
	Mon,  3 Sep 2012 20:15:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <000d01cd89b6$d5ba6c30$812f4490$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204703>

Am 03.09.2012 11:31, schrieb Joachim Schmitz:
> 
> Hmm, I see that there the errors are handled differently, like this:
> 
>         if (ovalue != NULL)
>                 return errno = EINVAL,
>                         error("setitimer param 3 != NULL not implemented");
> 
> Should this be done in my setitimer() too? Or rather be left to the caller?
> I tend to the later.

The error message is really just a reminder that the implementation is
not complete. Writing it here has the advantage that it is much more
accurate than a generic "invalid argument" or "operation not supported"
error that the caller would be able to write.

-- Hannes
