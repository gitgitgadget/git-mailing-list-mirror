From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 20 Jul 2008 11:27:56 -0700
Message-ID: <7vd4l88l77.fsf@gitster.siamese.dyndns.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <7v63r38r4r.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
 <7vabge30dh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness>
 <20080720130407.GF10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 20:29:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKdeg-00019M-NV
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbYGTS2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbYGTS2J
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:28:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYGTS2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:28:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6852C34602;
	Sun, 20 Jul 2008 14:28:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0A28B345ED; Sun, 20 Jul 2008 14:27:58 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 978E47EC-5689-11DD-83FE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89208>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Third, it would be nice to allow passing extra parameter(s) to the
> backends, but I do not know what concept is the best here. The
> strategy1=foo,stategy2=bar limits the input to a single string. Is that
> enough? Given that recursive=theirs was considered harmful, we don't
> have too much examples;...

I personally think -sstrategy=string1,string2,... is simply a bad taste.

Why force yourself to parse things by having the users to concatenate
something that the user could give us separated?  If you care about the
order and association between strategy and their options, you can always
do:

	-s strategy1 -X option-1-for-strategy-1 -X option-2-for-strategy-1 \
	-s strategy2 -X option-1-for-strategy-2 ...
