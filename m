From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possibly-spurious 'not uptodate. Cannot merge'
Date: Sun, 14 Dec 2008 17:27:55 -0800
Message-ID: <7vy6yiz0pw.fsf@gitster.siamese.dyndns.org>
References: <874p16puuq.fsf@hades.wkstn.nix> <gi4adq$cr1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 02:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC2Gu-0002zL-Ip
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 02:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbYLOB2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 20:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbYLOB2B
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 20:28:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbYLOB2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 20:28:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B19F87B40;
	Sun, 14 Dec 2008 20:27:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9D29087B3F; Sun,
 14 Dec 2008 20:27:56 -0500 (EST)
In-Reply-To: <gi4adq$cr1$1@ger.gmane.org> (Sitaram Chamarty's message of
 "Mon, 15 Dec 2008 01:03:54 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9BA2509E-CA47-11DD-9EBA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103124>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> On 2008-12-14, Nix <nix@esperi.org.uk> wrote:
>> In this situation, 'git diff' reports no changes at all, but 'git reset
>> --hard' gets the tree back into a state where merging succeeds, as does
>> 'git update-index --refresh'.
>
> Wasn't there some situation in which merely running 'git
> status' would have a similar effect?  I seem to recall
> reading that somewhere but now I can't find any mention of
> it in 'git help status'.

It would, but this is a pure bug in the re-implementation of git-merge
that was introduced soon after v1.5.6.  The users shouldn't be required to
run refresh to work this around.
