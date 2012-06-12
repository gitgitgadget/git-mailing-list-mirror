From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv4] Read (but not write) from XDG configuration, XDG attributes
 and XDG ignore files
Date: Tue, 12 Jun 2012 18:32:06 +0100
Message-ID: <4FD77D16.3060108@ramsay1.demon.co.uk>
References: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> <4FCCF63B.8070609@ramsay1.demon.co.uk> <7v62b6udg1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: nguyenhu@ensibm.imag.fr, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:11:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVYi-0002GL-SX
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 20:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab2FLSLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 14:11:12 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:46386 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752252Ab2FLSLK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 14:11:10 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SeVYa-0005li-pa; Tue, 12 Jun 2012 18:11:09 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v62b6udg1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199824>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Subject: [PATCH] path.c: Fix a static buffer overwrite bug by avoiding mkpath()
>>
>> In order to fix the bug, we introduce a new variation of the mkpath()
>> function, mkpathdup(), which avoids the use of the internal static
>> buffers.
> 
> Shouldn't we aim a bit higher to also avoid the use of bounded
> buffer?  Instead of returning bad_path, retry with lengthened buffer
> until we succeed, or something.
> 
> Better yet, internally use strbuf_vaddf().

Sorry for the late reply, I've been away ...

Yes, I wasn't aiming too high. In fact I was only aiming for "I spent the
last 20 minutes fixing up your patch so that it doesn't tickle the bug
on cygwin, and it looks like this..." :-P

While away, I did rewrite mkpathdup() to address your concerns (although I
didn't use strbuf_vaddf()).

However, I see that Nguyen has not been idle and, with help from others, has
fixed up the patch and re-rolled the series (v7 I think). I haven't fetched
that mail yet, but it looked good and should not tickle the cygwin bug. I will
test it soon.

ATB,
Ramsay Jones
