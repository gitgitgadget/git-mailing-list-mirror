From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] git-svn: don't confuse editors with an apostrophe
Date: Fri, 29 Apr 2011 14:47:03 -0700
Message-ID: <7v4o5gwx0o.fsf@alter.siamese.dyndns.org>
References: <1304077214-1707-1-git-send-email-cmn@elego.de>
 <7viptxxbr7.fsf@alter.siamese.dyndns.org>
 <20110429205130.GA2727@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:47:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFvWy-0000WM-HB
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 23:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088Ab1D2VrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 17:47:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab1D2VrO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 17:47:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E20E5170;
	Fri, 29 Apr 2011 17:49:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Kf3oQ6RhdjnN
	ewCT2+QEeDynjVQ=; b=hxOQPbmXLEY+82szwp8B+bJd+xam79a6dT1QOa052viH
	JSj1TXXrHm8hGZ5YqDySLlZDYS+sZ1e//E8LxiKEsWrINecB3wZZCbccOAaYhkID
	LAf3nkEMAbE1eyI147nnQlc/pWpgyTN7NSX+kjdaE6u4GixlWCeqJQxY6OGjJbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QAN0y9
	S21j48NHboMIJi93PV47mCBEkayBvRdeb44WGnxSg52ZfuuLHOxqRNQgSk+eJTOn
	W7buAFE5XKll675O2bKKrFXindhR1WWmCiq38rn/oxZvV+6tktKYwgKiK9PIf54Q
	g1eyb/UOfxJtLNUJk/9BWIAT3Nf86Vc3riHek=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFBA8516F;
	Fri, 29 Apr 2011 17:49:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E14A6516E; Fri, 29 Apr 2011
 17:49:07 -0400 (EDT)
In-Reply-To: <20110429205130.GA2727@bee.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 29 Apr 2011 22:51:33
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84CBF8E4-72AA-11E0-92A4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172496>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> It's not the output of the tool, it's the perl script. It uses the ca=
t
> << EOF trick/method so ...

Ahhhhh (a lightbulb dimly lits, and then explodes).

As it is generally a bad practice to cater to those who edit this file =
by
changing the output that is served to the end user, _unless_ the update=
d
output clearly gives a better experience to the end user [*1*], it neve=
r
occurred to me that that is what you are doing in this patch.

Yes, the message should be made clearer.

Thanks for an explanation.

[Footnote]

*1* In other words, updating the output to help users is fine.  And if
such a change unconfuses your editor, that would be a nice side effect.
Doing things the other way around is simply the tail wagging the dog.
