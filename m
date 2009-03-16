From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] New config push.default to decide default behavior
 for push
Date: Sun, 15 Mar 2009 21:55:23 -0700
Message-ID: <7viqmayslg.fsf@gitster.siamese.dyndns.org>
References: <20090311220144.GA6782@pvv.org>
 <7vwsavlg6q.fsf@gitster.siamese.dyndns.org> <20090312115433.GA2848@pvv.org>
 <7viqmbakmt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 05:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj4sp-0001FN-2J
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 05:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbZCPEze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 00:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbZCPEze
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 00:55:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbZCPEzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 00:55:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6342DA278E;
	Mon, 16 Mar 2009 00:55:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 578A3A2789; Mon,
 16 Mar 2009 00:55:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD35D042-11E6-11DE-94F7-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113310>

Junio C Hamano <gitster@pobox.com> writes:

> Finn Arne Gangstad <finnag@pvv.org> writes:
>
>> Something like this amended into the last commit? I can amend it on top
>> of the last one and resend if that is better.
>
> Thanks.
>
> I looked at these two patches after squashing them into one, and I think
> it makes sense as the final shape of a two patch series.

I seem to have forgotten to say what the two pieces in the series should
look like here.  What I meant was a split along these lines:

 (1) introduce the configuration variable, so that people who do not like
     the current default can get a different default, but do not warn;

 (2) start warning to notify the users of possible different settings and
     forcing them to choose now, before we switch the default.

As some people still seem to object to the change of default (and that
includes 20-30% of myself), we may end up deciding not to switch the
default after all, but even in that case, applying the first half would
benefit people who would want different behaviour.

If we were to decide not to switch the default, applying (2) would force
people who want the current default to set the configuration only to
squelch the message, which is an annoying inconvenience.

But since then I thought about this a bit more, and I am inclined to
change my mind.  Having (2) will allow people who wish there were a way to
have a different default to discover that there is already an easy way to
do so.  The tradeoff between "a slight inconvenience to traditionalist" vs
"helping people to discover the feature designed for them, without which
they would be badly burned" does not look too bad to me.
