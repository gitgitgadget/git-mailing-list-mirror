From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git interactive rebase 'consume' command
Date: Sun, 20 Jan 2013 11:05:38 -0800
Message-ID: <7vk3r7llod.fsf@alter.siamese.dyndns.org>
References: <kdgtir$apt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:06:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx0DS-0007ZE-Rg
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 20:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab3ATTFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 14:05:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352Ab3ATTFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 14:05:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D87DBAB1C;
	Sun, 20 Jan 2013 14:05:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Pz+DM2kxwpYrAeUxd9ydlD4EeA=; b=ZdfTB0
	9r2IZxULLwysLSVsK5DXitTCPYhZCaIp2LKGuuiHfOPFzXElixErq30rMpu/V817
	nKv6i6JZfTueum+t/K/E26AEu2/SZS0BxQaF+lmteBwjxtqeNJU6feigF/ksLVtG
	HPdyne2+Q9P8xseXf2uxM7PlzRA6G7o12M2RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GS5pC7ZNJNp6tcd+/6Ijslk0Dz4VnlDZ
	fXjA3ECXlTl4b32WOjiBq//9OiKPVqEbUcRRK+NeSfCJYal/NF2+odHr/1qHnMxB
	EVYvIclSuRBvldSG4uR4uUasgwyVRCBeXIp6dgTgOyCqtFVho2vBKTsjTr1uGwyu
	dbAVM//Hr5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDA3CAB1B;
	Sun, 20 Jan 2013 14:05:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3138FAB15; Sun, 20 Jan 2013
 14:05:40 -0500 (EST)
In-Reply-To: <kdgtir$apt$1@ger.gmane.org> (Stephen Kelly's message of "Sun,
 20 Jan 2013 15:05:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61A39986-6334-11E2-A7B9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214035>

Stephen Kelly <steveire@gmail.com> writes:

> Hi there,
>
> I find the fixup command during an interactive rebase useful.
>
> Sometimes when cleaning up a branch, I end up in a situation like this:
>
>  pick 07bc3c9 Good commit.
>  pick 1313a5e Commit to fixup into c2f62a3.
>  pick c2f62a3 Another commit.
>
>
> So, I have to reorder the commits, and change 1313a5e to 'f'. An alternative 
> would be to squash 's' c2f62a3 into 1313a5e and clean up the commit message. 
> The problem with that is it ends up with the wrong author time information.
>
> So, I usually reorder and then fixup, but that can also be problematic if I 
> get a conflict during the re-order (which is quite likely).
>
> I would prefer to be able to mark a commit as 'should be consumed', so that:
>
>  pick 07bc3c9 Good commit.
>  consume 1313a5e Commit to fixup into c2f62a3.
>  pick c2f62a3 Another commit.
>
> will result in 
>
>  pick 07bc3c9 Good commit.
>  pick 62a3c2f Another commit.
>
> directly.
>
> Any thoughts on that? 

Sorry, but I do not understand what you are trying to solve.

How can 1313a5e, which fixes misakes made in c2f62a3, come before
that commit in the first place?
