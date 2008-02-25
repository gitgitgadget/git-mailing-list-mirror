From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long
 format
Date: Sun, 24 Feb 2008 19:08:08 -0800
Message-ID: <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
 <20080225023634.GK8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 04:08:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTTi3-0003bj-W5
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 04:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbYBYDIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 22:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbYBYDIV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 22:08:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbYBYDIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 22:08:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C84DA15A1;
	Sun, 24 Feb 2008 22:08:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E35A015A0; Sun, 24 Feb 2008 22:08:12 -0500 (EST)
In-Reply-To: <20080225023634.GK8410@spearce.org> (Shawn O. Pearce's message
 of "Sun, 24 Feb 2008 21:36:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74985>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> +		else
>> +			printf("%s-0-g%s\n", n->path,
>> +				find_unique_abbrev(cmit->object.sha1, abbrev));
>
> Is this really that useful?  Where is having the tag and the commit
> SHA-1 both useful?

I had the same question.  The only place that I find this could
be useful is when you tag, build and install, and then find
glitches before pushing the results out and rewind, rebuild and
re-tag.  I unfortunately have this issue almost all the time.

But even then, I would probably not rely on this patch.
