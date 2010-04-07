From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 07 Apr 2010 10:23:38 -0700
Message-ID: <7vzl1fch2d.fsf@alter.siamese.dyndns.org>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
 <7vsk77e20r.fsf@alter.siamese.dyndns.org>
 <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 19:24:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzYz3-00017U-DO
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 19:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111Ab0DGRYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 13:24:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758063Ab0DGRYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 13:24:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D31E9A8FF3;
	Wed,  7 Apr 2010 13:23:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=gnthrt3apZAyhfhY5OSmJP0kddM=; b=C200e7
	0m/l7eR5FJygtvwOqtJcHDNjcbzWzJup6BexovCy3g2Oo72k3ZZfJXvcgeWEQkh5
	LVgxNdkQ8bwMQmNwkJaWFnzdGz6B0Cs4yzwDjO4ARQFyjgIkTeDRofe58DxGoA8a
	wuQkXCEqQax2DJksE+tqpkUVOFPQ2XKmUWoko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TrECc58ZeokOcLWV/iw7db/v4olQEHKD
	KvCOhRhdQL+kd5NHqvf9ohEtBfcybSMAykpGMBUKSEOXqAvs3SuCG86jNNRid7Zm
	8LfPG6i6pLLkvqocajdPggAXS6lRYfHv5WNFpg6C8LPqfzaiypMyWlu/JlZ/Szsx
	BIrN91vXnLY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43BB9A8FEE;
	Wed,  7 Apr 2010 13:23:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E734FA8FE9; Wed,  7 Apr
 2010 13:23:39 -0400 (EDT)
In-Reply-To: <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed\, 7 Apr 2010 22\:20\:52 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54E2428A-426A-11DF-A89F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144253>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Can someone tell me what I'm doing wrong? Earlier, Junio also had a
> problem with one of my patches being corrupt. I used git-imap-send and
> the GMail web interface to fill out the "to", "cc" and some comments.

In the above procedure, up to imap-send, everything would be fine, but I
heard GMail web interface still wraps lines before sending the result out.

Gmail section in Documentation/SubmittingPatches says:

  GMail does not appear to have any way to turn off line wrapping in the web
  interface, so this will mangle any emails that you send.  You can however
  use any IMAP email client to connect to the google imap server, and forward
  the emails through that.  Just make sure to disable line wrapping in that
  email client.  Alternatively, use "git send-email" instead.

This is a tangent, but I think this can still be further improved.  What
it says is not incorrect per-se, but the "can however" gives a false hope
to people who have been burned by the web interface.  The fact it lists
are:

 - GMail web interface will wrap lines and corrupt patches, no matter what
   you do;

 - With imap-send, you can stuff messages to your outbox at GMail, and
   using IMAP client that does _not_ corrupt messages, you can send things
   out.

Combined together, these mean that you lose even if you preprare your
outbox with imap-send if you send out the end result from their web
interface.

At the minimum, we could add a parenthesized comment like this.

  the emails through that.  Just make sure to disable line wrapping in
  that email client (again, there is no way to tell GMail web interface to
  do so).
