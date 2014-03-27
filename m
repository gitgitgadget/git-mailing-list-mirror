From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be sha1 based
Date: Thu, 27 Mar 2014 11:48:11 -0700
Message-ID: <xmqq1txneavo.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
	<xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
	<20140325092215.GB3777@mini.zxlink>
	<xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>
	<20140326195201.GB16002@mini.zxlink>
	<xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>
	<20140327142438.GE17333@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Thu Mar 27 19:48:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFLh-0002cK-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200AbaC0SsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:48:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56006 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757193AbaC0SsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 14:48:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8091B751B3;
	Thu, 27 Mar 2014 14:48:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hXhPukiz13AWS8HrM65eTsewF8s=; b=e8ZixZ
	+hCTJBzwFTtnpq1qwueK86Ngc+YF9ipl5CN9zIzTJiWxflxXkLiXionMpWEb2fLi
	EhpEpK6zdRHi8JGHWxT4hozEORU+Yt0ow3tKmH487p/PUxpcBZd9jf1spFwrURfr
	rkYJa84VMuOyUH6aqwjUvLOpxqJG47tc4DcRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Le8q1Tsq4jbmqBc0TqwbLc7Tvuc0Nz9L
	PhvwN4fx4ZBDnNnRcjSHAIHQm6YkECy6sbudxD1SgSDNq9A/AGALZbAFtoP/P7Kf
	6W2ug381EmVdlcbWO1JUyT2cJixk0TXKfDWB2/Ob0ix3UDO3Mk3veLgdH5wcqiga
	a2NMPsn5wIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AA9C751B2;
	Thu, 27 Mar 2014 14:48:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE77D751AF;
	Thu, 27 Mar 2014 14:48:13 -0400 (EDT)
In-Reply-To: <20140327142438.GE17333@mini.zxlink> (Kirill Smelkov's message of
	"Thu, 27 Mar 2014 18:24:38 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 59F6B330-B5E0-11E3-A840-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245306>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> (please keep author email)
> ---- 8< ----
> From: Kirill Smelkov <kirr@mns.spb.ru>
> Date: Mon, 24 Feb 2014 20:21:46 +0400
> Subject: [PATCH v3a] tree-diff: rework diff_tree interface to be sha1 based

"git am -c" will discard everything above the scissors and then
start parsing the in-body headers from there, so the above From:
will be used.

But you have a few entries in .mailmap; do you want to update them
as well?

By the way, in general I do not appreciate people lying on the Date:
with an in-body header in their patches, either in the original or
in rerolls.

Thanks.
