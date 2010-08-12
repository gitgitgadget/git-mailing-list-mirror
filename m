From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] SVN dump parser
Date: Thu, 12 Aug 2010 10:22:58 -0700
Message-ID: <7vbp97u4nh.fsf@alter.siamese.dyndns.org>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino> <20100809215719.GA4203@burratino>
 <20100809225500.GD4429@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:23:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjbUv-0001HU-08
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab0HLRXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 13:23:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0HLRXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 13:23:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4F3DCDA2E;
	Thu, 12 Aug 2010 13:23:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sJAO+EvJirxu9g2C8NfMyPpLOsw=; b=TB2Jl9cTev/Zlbs0ZCuENp7
	No0mSjtkdalYsrlNeAqjX09SZxgLvbEMpy8izAdauup9cRLr2555qdDj4QXQb2dA
	0K9qOYHQUZp4bQmHqiyJ5vZsXy2mZc04m+ZWJSTi19MlHBvKSx3ghTXxWhJQoXZ5
	q797cQVS5ohNsUPAk8KU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=AObdnUT2JJ2c2QRJu1WpnzHb2NJCeT09irqApDsltPmFR/Keh
	5mloE5fTZ+MDytuRvGfMu4rGGfel6+qUnsyD5OTiQKGkyn6sy8EoVyOAVc532Ubu
	VB7Zj7mZgbw4qNB5t64EFgli3pXQA+w7cIVg7249Koc2um94xlTSWKH2V8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 550F1CDA2C;
	Thu, 12 Aug 2010 13:23:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66959CDA2A; Thu, 12 Aug
 2010 13:22:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44905CAC-A636-11DF-81D3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153391>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> new file mode 100644
> index 0000000..630eeb5
> --- /dev/null
> +++ b/vcs-svn/svndump.c
> @@ -0,0 +1,302 @@
> ...
> +static char* log_copy(uint32_t length, char *log)

Style: static char *log_copy(...)
