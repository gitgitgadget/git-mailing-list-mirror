From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Sun, 13 Apr 2008 23:54:41 -0700
Message-ID: <7v63ulapu6.fsf@gitster.siamese.dyndns.org>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de>
 <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de>
 <7vskxsneau.fsf@gitster.siamese.dyndns.org>
 <20080412101110.GD31356@alea.gnuu.de> <20080413035648.GY10274@spearce.org>
 <20080413165011.GB3179@alea.gnuu.de> <20080414062425.GB20979@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 14 08:55:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIbQ-0005d5-D4
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 08:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbYDNGyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 02:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbYDNGyy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 02:54:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbYDNGyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 02:54:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BA793732;
	Mon, 14 Apr 2008 02:54:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B0A25372F; Mon, 14 Apr 2008 02:54:45 -0400 (EDT)
In-Reply-To: <20080414062425.GB20979@spearce.org> (Shawn O. Pearce's message
 of "Mon, 14 Apr 2008 02:24:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79468>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> Except of this, I prefer to use the colon to be much closer to the syntax
>> of fast-import.
>
> Me too, but it looks like in a human edited "TODO" script we may want
> to be more friendly and allow named marks.  Though I'm not sure that is
> really all that useful.  If you are merging something because it used to
> be merged before the rebase I doubt we'd generate a meaningful mark name
> when the TODO script is initially formatted.

I'd say a small integer is the only thing we would need.  The TODO insn
sequence would be machine generated then manually tweaked, not the other
way around.

Regarding colon vs pound, I would say that the 'mark' insn can just say
"2" to set the second mark, and then store it in refs/marks/2; the
commands that refer to the commit later can use the usual "refs/marks/2"
or "marks/2" syntax without colon nor pound nor any other special syntax
that way.
