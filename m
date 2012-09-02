From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] For each exclude pattern, store information about
 where it came from
Date: Sun, 02 Sep 2012 12:02:02 -0700
Message-ID: <7vipbwgnnv.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-7-git-send-email-git@adamspiers.org>
 <997D30474124498FBFBA89C2E20F7773@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Adam Spiers" <git@adamspiers.org>,
	"git list" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	=?utf-8?Q?Nguy=3Fn_Th=C3=A1i_Ng=3Fc_Duy?= <pclouds@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:44:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2N-00008J-NL
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab2IBUol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754Ab2IBUoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBD71831E;
	Sun,  2 Sep 2012 16:44:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=WP8d8dDvKCz1FNa9tMVslZbRrbc=; b=NkX6qsxvBQebSx8d/S6q
	ZiACrOjLSsMNzglGLWk0CUmiGErWNE6uUgh+Aq4bKnLNM/pF7pvVI8iY4VWLySNY
	23dswQx9U8cA2QKHB+U2O1xcGN1mbU6jn6zzUIWyZ6lXSVmtpf05L57jr15r/o0b
	m2nWrUdpwMWuowN/jm9cEIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZdmKIhkeXid8z8gVZKV/Bux2la/5bhxmylwNG/kb43UWxl
	pkhVehXdI4rpTTnfDMZBJ2eFrCBu2mlK1lTzJgQ7Jpo8ot4Iv/KWix5N9uYoPi9H
	w/BrWwMGZWEBNsErZsEDTfDtJHlN6ullBlCiZ4hYhtF6i/bYqLusL3a2heuWE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D90BF831C;
	Sun,  2 Sep 2012 16:44:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 510B98319; Sun,  2 Sep 2012
 16:44:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 029CD924-F53F-11E1-B82A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204670>

"Philip Oakley" <philipoakley@iee.org> writes:

> Is there a way to identify the config core.excludesfile if present?
> i.e. that it is from that config variable, rather than directory
> traversal.

If the code handles $GIT_DIR/info/exclude then that configuration
would also be handled the same way, no?
