From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths scanning
Date: Wed, 05 Feb 2014 11:42:41 -0800
Message-ID: <xmqq61ot4a8e.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
	<xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
	<xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
	<20140204163400.GA20436@tugrik.mns.mnsspb.ru>
	<xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
	<20140205165119.GA18558@tugrik.mns.mnsspb.ru>
	<xmqqfvnx5umg.fsf@gitster.dls.corp.google.com>
	<20140205191427.GA3923@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Wed Feb 05 20:42:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB8N8-0005ku-2t
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 20:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbaBETmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 14:42:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbaBETmq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 14:42:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C3C669066;
	Wed,  5 Feb 2014 14:42:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WS2GUF8yZIubhHYpX13g31ixhk8=; b=eM4U0s
	IkMtqY5vNzQDFHhUUCM1Vg3wgJCPU+WPWDdyOsWOiccBZzbYhjlrv9aCWWvCuFZ9
	pMaRc0YVE7MyDKhK7+vsz1gzDOH/IySWrvJk32XhTsf1EahwfcrclhhprO9zmCpY
	rIlwBMg6mICI99owIKMWA9p4Z2K1d7ygweP+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8LEEJHBi2F7P93KkUgLmC9tR6soULo9
	MJTbUMSHdWNKfBYru2tZIrphWeluxJfGfDpkCGB+ttpuoen/QXEK0U1nFL1G4Xs0
	mgyu1Hx2+KcDynzmL9503Zt3FSHgRh3IYEqOpTacx9JoSQpteVRwVHeOwLocvaDF
	/dFANv8U1tA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54F5A69065;
	Wed,  5 Feb 2014 14:42:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E6EF69064;
	Wed,  5 Feb 2014 14:42:44 -0500 (EST)
In-Reply-To: <20140205191427.GA3923@mini.zxlink> (Kirill Smelkov's message of
	"Wed, 5 Feb 2014 23:14:27 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AEE648FC-8E9D-11E3-AC37-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241647>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> I agree object data should be immutable for good. The only thing I'm talking
> about here is mode, which is parsed from a tree buffer and is stored in
> separate field:

Ah, I do not see any problem in that case, then.

Thanks.
