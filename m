From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Quickly searching for a note
Date: Tue, 25 Sep 2012 09:19:53 -0700
Message-ID: <7vlifyvzva.fsf@alter.siamese.dyndns.org>
References: <7vy5k370n7.fsf@alter.siamese.dyndns.org>
 <505CB21E.4040607@workspacewhiz.com>
 <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
 <505CCD2A.8020003@workspacewhiz.com> <505CD2FA.80200@kdbg.org>
 <505CD7D0.2000505@workspacewhiz.com>
 <20120921233723.GA29433@sigill.intra.peff.net>
 <7v7grn3pfo.fsf@alter.siamese.dyndns.org>
 <505DE30B.2000805@drmicha.warpmail.net>
 <7vk3vl3ixv.fsf@alter.siamese.dyndns.org>
 <20120925003855.GB19586@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 18:20:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGXrl-0007rp-HM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 18:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758353Ab2IYQT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 12:19:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47422 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758350Ab2IYQT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 12:19:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10A7990F8;
	Tue, 25 Sep 2012 12:19:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AR+rwHwswwLKyL9o2+kfgTWGw+I=; b=ULUCJ2
	k2lSq/TUsfTnyz89erDJq1HskA/EQztBMI1TVUJVQG0qtvjl+KF/olyv1nilyMGu
	19Jy3KF2CNKEDsMfgKmLlEk+Eoxs1jasjLBw1pW1P+XxWSFCtStEXm58xhYgsvvw
	8zHm+4/sTiVI1otRLjQ6DJmU32O1XJ3Yf8IIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Meg7kE4LuKBNii7IrAxtM8BJN+asXN4p
	sT/k3q3EINpTv6B8k/BrTucDeoGmMpGw4JuH6f5v+22MVa+3nDwyHVfTUJPbXAKt
	0vrcgGFSCC2O/LGl2qiI4fP9SJxpYgiWQV3qCz97TABYKYYgdmxCzNqaaWBHKNpm
	sjZyp1RH2pI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1A3B90F7;
	Tue, 25 Sep 2012 12:19:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55B3190F4; Tue, 25 Sep 2012
 12:19:55 -0400 (EDT)
In-Reply-To: <20120925003855.GB19586@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 24 Sep 2012 20:38:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7B73326-072C-11E2-9FDC-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206364>

Jeff King <peff@peff.net> writes:

> Agreed. I just posted a patch series that gives you --pretty lua
> support, though I haven't convinced myself it's all that exciting yet. I
> think it would be nicer for grepping, where the conditionals read more
> like regular code. Something like:
>
>   git log --lua-filter='
>     return
>       author().name.match("Junio") &&
>       note("p4").match("1234567")
>   '
>
> reads OK to me.

Yeah, except for "me and p4???" ;-)
