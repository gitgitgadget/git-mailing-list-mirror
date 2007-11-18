From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Solaris portability
Date: Sun, 18 Nov 2007 09:46:47 -0800
Message-ID: <7vmytbwins.fsf@gitster.siamese.dyndns.org>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
	<1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
	<Pine.LNX.4.64.0711152253430.4090@bianca.dialin.t-online.de>
	<7v640340kp.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711161954510.7139@bianca.dialin.t-online.de>
	<7vtznlww0t.fsf_-_@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711181302360.3945@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn O Pearce <spearce@spearce.org>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Dennis Stosberg <dennis@stosberg.net>
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Sun Nov 18 18:47:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItoEm-00017x-U8
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 18:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXKRRq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 12:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXKRRq6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 12:46:58 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56791 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbXKRRq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 12:46:57 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B50372EF;
	Sun, 18 Nov 2007 12:47:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 24E5E9718E;
	Sun, 18 Nov 2007 12:47:11 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711181302360.3945@bianca.dialin.t-online.de>
	(Guido Ostkamp's message of "Sun, 18 Nov 2007 13:08:20 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65377>

Guido Ostkamp <git@ostkamp.fastmail.fm> writes:

> On Fri, 16 Nov 2007, Junio C Hamano wrote:
>> This makes me wonder if treating it just like strcasestr() might be
>> simpler.  Could folks with access to Solaris boxes of different
>> vintages please see if the attached patch makes sense?
>
> I think the patch makes sense as neither Solaris 8, 9 nor 10 supports
> mkdtemp().
>
>> Can we also unify UNSETENV, SETENV, C99_FORMAT and STRTOUMAX, by the
>> way?
>
> No.
>
> I've just checked on our Solaris Sparc systems, and found that the
> C-library provides unsetenv(), setenv() and strtoumax() beginning with
> Solaris 10; also the 'man sprintf' page mentions the 'z' and 't'
> specifiers for printf (which is what is behind C99_FORMAT) only
> beginning with Solaris 10.
>
> So workarounds are needed for all 4 cases for Solaris 8 and 9 but not 10.

Thank you very much for detailed information.
