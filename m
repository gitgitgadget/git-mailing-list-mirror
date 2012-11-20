From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Tue, 20 Nov 2012 11:52:46 -0800
Message-ID: <7vhaokrr01.fsf@alter.siamese.dyndns.org>
References: <20121117153007.GB7695@book.hvoigt.net>
 <20121117192026.GI22234@odin.tremily.us>
 <7vd2z9t7y2.fsf@alter.siamese.dyndns.org>
 <20121120011628.GD321@odin.tremily.us>
 <7v1ufou92h.fsf@alter.siamese.dyndns.org>
 <20121120121912.GC7096@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Nov 20 20:53:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TatsV-0003v9-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 20:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab2KTTwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 14:52:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434Ab2KTTws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 14:52:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 586149745;
	Tue, 20 Nov 2012 14:52:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C509Kw3TXHVlXEWz/f6rchppnq0=; b=rHaTz5
	7ru6SAF2ZnDB4wLCgy6S8uQERMm2zbrA2IcVI6oB94WgnvLwLThZqI96PNS3z2Gp
	5eZ9b7GXhnslOKs+IdUfSfaahzL/WVryzW/9RS2ccaMRQQtu5O9ISW5NUnsMYcZK
	nrU3RN/e0Kf9QtZ10dGrultYnzZrBT28EfEJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q8G+8GAxlbFEfMlIXlHJLlNr3hJswn2/
	e4cl4c8aO5aD7im+bWHc6s8v1K5AGpgBVCOkyYuHUnbbW1YJYS+63r7C0dgVmbgb
	uFIGBADcwMo+qtB08qlD8YpQIu3JnOuIEEbB/tb0JTXN+RfI9vszMvYtdNFalil8
	1bPbPfSDN6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 439509744;
	Tue, 20 Nov 2012 14:52:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A64559743; Tue, 20 Nov 2012
 14:52:47 -0500 (EST)
In-Reply-To: <20121120121912.GC7096@odin.tremily.us> (W. Trevor King's
 message of "Tue, 20 Nov 2012 07:19:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBC5F7EA-334B-11E2-942C-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210107>

"W. Trevor King" <wking@tremily.us> writes:

> The superproject gitlink should only be updated after
>
>   $ git submodule update --pull
>
> A plain
>
>   $ git submodule update
>
> would still checkout the previously-recorded SHA, not the new upstream
> tip.

Hrm, doesn't it make the "float at the tip of a branch" mode
useless, though?
