From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 11:38:21 -0700
Message-ID: <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 09 20:38:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUk7w-0000kq-KP
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 20:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab1FISik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 14:38:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab1FISij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 14:38:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A9CC55F5;
	Thu,  9 Jun 2011 14:40:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ByR2dXKiuHcqktWHHEaFLM0FoNg=; b=iOsJYc
	XHiGp/4psaJIBlh4R0HbXgdYEdr8HZp/P2zfl6HPcYcp4vhCTxottXDTYNO6Ywq+
	sjyzMlehoSdIVdHHcpkKCToNMvW8jiUHbTvn6F+hZW845x20Ay9XN32YZd//mN1P
	sddAwck9vmNnbUwO6MK6xoDqlg0JzKwoJODf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z77W2SJsLunVqc96nzMPTOAb3g7CLP+t
	4snkMUWqzpTiZ2aZVt2BYJynB3ZrJq/fK/9plcDcWqnIXGCr6gFjxI1ZxMRos4oy
	ZqIIXHpEcbUsa6lPDu+sRcY0fJnEX5Y1sGv0HD5DHeBXrCbZKPJ0ojfUUnXne0Im
	J4ieB+CKtxk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DE7855F3;
	Thu,  9 Jun 2011 14:40:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 40DBC55F2; Thu,  9 Jun 2011
 14:40:32 -0400 (EDT)
In-Reply-To: <4DF10ADA.5070206@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 09 Jun 2011 20:03:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9E2CDFA-92C7-11E0-804E-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175566>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Wouldn't the four trees described above contain information equivalent
> to the contents of the index?

In the same sense that you can re-create the state in the index by running
the merge again between HEAD and MERGE_HEAD, yes, they probably do, but is
that a useful question to ask?

I think this mega-thread served its purpose. It started to explore "will
it make it easier to understand and explain if we use these tokens to name
trees that do not exist in reality?" which is a worthy thing to do.  The
conclusion appears to be "well we do not even know what exactly these
tokens mean in certain situations." but at least people tried, and along
the way a few new people seem to have become more aware of the index, so
overall we didn't lose that much.
