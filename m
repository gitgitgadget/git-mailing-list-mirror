From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add definitions for global variables to shell.c
Date: Tue, 19 Aug 2008 18:06:24 -0700
Message-ID: <7vzln8trzj.fsf@gitster.siamese.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org>
 <7vy72tkfu0.fsf@gitster.siamese.dyndns.org>
 <20080819072650.GE11842@schiele.dyndns.org>
 <7vpro5fnke.fsf@gitster.siamese.dyndns.org> <48AA8931.1030009@viscovery.net>
 <20080819091830.GG11842@schiele.dyndns.org>
 <7vbpzoy53d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 03:07:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVcAo-0003y8-Lz
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 03:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbYHTBGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 21:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbYHTBGc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 21:06:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbYHTBGb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 21:06:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 42FC853732;
	Tue, 19 Aug 2008 21:06:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 86D125372F; Tue, 19 Aug 2008 21:06:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3989CB7A-6E54-11DD-BC2A-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92947>

Junio C Hamano <gitster@pobox.com> writes:

> Robert Schiele <rschiele@gmail.com> writes:
>
>> On Tue, Aug 19, 2008 at 10:49:53AM +0200, Johannes Sixt wrote:
>>
>>> Why not just revert 5b8e6f85f (shrink git-shell)? It was a nice try. If it
>>> had not proved as a maintainance burden, it would have had merits. But who
>>> these days cares whether git-shell takes 300K or 30K in the light of that
>>> it goes out of the way anyway by execing some other process at the first
>>> opportunity?
>>
>> Sounds reasonable to me.  Doing this in a clean way would require more
>> restructuring in the code.  So far this change started a chain of changes
>> where each change tried to solve one issue and caused a more severe one.
>>
>> Though it would not only be 5b8e6f85 to be reverted but also 78568448 that
>> tried to fix up problems that 5b8e6f85 caused.
>
> I have no issue with that.  Some people also mumbled about auditability,
> which I did not find particularly convincing.

The result would look like this two-patch series.

 [1/2] shell: do not play duplicated definition games to shrink the executable
 [2/2] Build-in "git-shell"
