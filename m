From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-shell needs $(COMPAT_OBJS)
Date: Sun, 20 Jul 2008 15:15:38 -0700
Message-ID: <7vzloc2odx.fsf@gitster.siamese.dyndns.org>
References: <200807202111.48332.johannes.sixt@telecom.at>
 <200807202334.36506.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:17:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhD8-00029S-5t
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060AbYGTWPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbYGTWPp
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:15:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018AbYGTWPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:15:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 346253786E;
	Sun, 20 Jul 2008 18:15:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9BA453786A; Sun, 20 Jul 2008 18:15:40 -0400 (EDT)
In-Reply-To: <200807202334.36506.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Sun, 20 Jul 2008 23:34:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64D12A16-56A9-11DD-96E4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89245>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Sonntag, 20. Juli 2008, Johannes Sixt wrote:
>> -git-shell$X: compat/strlcpy.o abspath.o ctype.o exec_cmd.o quote.o
>> strbuf.o usage.o wrapper.o shell.o
>> +git-shell$X: abspath.o ctype.o 
>> exec_cmd.o quote.o strbuf.o usage.o wrapper.o shell.o $(COMPAT_OBJS)
>
> Unfortunately, that's only half the deal. If we compile with NO_PREAD=1, this 
> needs read_in_full(),...

Well, if compat/* implementations use anything outside compat/ left and
right, then all bets are off.

Why do we care about the size of git-shell so much in the first place
anyway to begin with?
