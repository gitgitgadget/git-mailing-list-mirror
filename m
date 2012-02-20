From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Mon, 20 Feb 2012 15:41:35 -0800
Message-ID: <7v4nuljcnk.fsf@alter.siamese.dyndns.org>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Feb 21 00:41:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzcrX-0001BG-NL
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 00:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab2BTXlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 18:41:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851Ab2BTXli convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 18:41:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDF636A13;
	Mon, 20 Feb 2012 18:41:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=D2klwCh4Ggzt
	uAwAMlYzCTc1bzs=; b=vledkd525/D15NQCSvc1Wpsr7HREafPOn+lJJypEZDN3
	mtUVv+k7DGJ14UKdIqsSAFxQ1P9btJMF19XsrMPrrnx7g1GA4zPba3n8n1Oh0DjB
	M2BzU8kUm349Y5R+oaBOkShsKKOuwL/QVGWgu+iMctJ92jUUEVvP3AmzWw4W5nE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NjY6Z8
	poUgKN/XehiOSPYnJXog6uCDJb7Ch65iOKgGu3SDfecxIfy0jl/5NrZ2Gcy2KU3Z
	qMSao8GDgO34X9smyjMHnkZ6MaVlaAVTXNWEerJ7KdKi5M3jkesSBo9HGYx4BOXW
	KWjkL+vFsKkdg6ZjAkfhDvv+iDhb3GBHryUUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C3D6A12;
	Mon, 20 Feb 2012 18:41:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62B0B6A11; Mon, 20 Feb 2012
 18:41:37 -0500 (EST)
In-Reply-To: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Mon, 20 Feb 2012
 22:57:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E1E8AF6-5C1C-11E1-BB66-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191126>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> JC:
>> Perhaps the maximum for garph_width should be raised to something li=
ke
>> "min(80, stat_width) - name_width"?
> I think that a graph like
> a | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> b |    1 -
> is not very readable. I like the consistency forced by the 40-column =
limit.
> But I guess that this is very subjective.

The above makes it very obvious that there is a huge amount of change m=
ade
to 'a' and a bit of deletion to 'b', compared to a mini-graph that is
truncated to half the screen width.

Besides, the above is what you would get without your patch on 80-colum=
n
terminal, no?
