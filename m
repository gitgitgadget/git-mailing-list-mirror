From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 12:32:57 -0700
Message-ID: <7vwrwykhee.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
 <20100326124650.GA12215@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:33:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFHM-0002zg-TL
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0CZTdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:33:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab0CZTdG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:33:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7AD7A52E9;
	Fri, 26 Mar 2010 15:33:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8bdeYSCrtYbTOyjBoZIwxUyLJ0Y=; b=yitxw0y7UiODwpNfiF0yFSg
	XwgYQTsaKIT2VWhg+iqg+hLEZBbr27EDk4/nrjctpTXPZ5zMxAJudIuGI5V1Uea5
	gABS6AwMbL2J3BdHisD1dK8HbvMiN6NgTG4OfrbfQVmgUQl08P3S+/K5x3kZldZC
	YKu58ErqY33ph6n61QJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=C8HR/DIwvNijD2namDCBmeZywxyd7d9poZPQkpZvNkpIl86bN
	YOIAo+3cVWSXeB9ORwoRPNjDSkfCy/XW3cLGpbzyDxZeeJoeUfKOMFGBOICbLljA
	QHL/Qx/LDFVg3upKNEjkYrbCJxou20bbl7ZcLDvczx3rWdlc+IC27CAdW0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FC26A52E7;
	Fri, 26 Mar 2010 15:33:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82003A52E0; Fri, 26 Mar
 2010 15:32:58 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64782D96-390E-11DF-9B51-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143272>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 26, 2010 at 11:48:41AM +0100, Johannes Schindelin wrote:
>
>> This supports opening the results of a 'git grep' directly in a pager 
>> (where the pager can be 'vi', too).
>
> This is not an argument against your patch, but you may be interested in
> an alternate method:
>
>   git grep -n $pattern >grep.out
>   vim -q grep.out
>
> The advantage is that the editor understands the output as a "quickfix"
> list and lets you cycle through the hits (just like you might with
> compiler errors). The disadvantage is that quickfix is a vim extension,
> so "less" and stock "vi" can't do this (I imagine emacs has a similar
> feature). It's also obviously a little more typing, but you can hide it
> inside an alias quite easily.

"M-x grep-find" mode is designed for this, and I often run "git grep -n"
in that mode..  The output is dumped into a sbuffer that is used as a
"quickfix list" to bring in files with hits and jump around.
