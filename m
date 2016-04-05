From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] correct blame for files commited with CRLF
Date: Tue, 05 Apr 2016 14:12:34 -0700
Message-ID: <xmqqegaj220t.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459884234-13026-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Apr 05 23:13:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anYHY-0007Vt-MS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 23:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760121AbcDEVMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 17:12:38 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759764AbcDEVMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 17:12:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28B1A53706;
	Tue,  5 Apr 2016 17:12:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kkUdK/2j+xfaDS1NMu+J7HycDiw=; b=CO2vB0
	5pAsd5otEx34w8N7JybZSA2/tSC4Bzxx7PWtffggZRAVLEtJUnGdaLjwLF2W+KTQ
	wFLRkuzIwlkxqyyMr+CQuJnKKU8vjkPeXLk+u4/3o0mW1/kzJns/pPcr2iPHemLT
	WXzYY5bP7EL4W5TvqwKK7clmmVUsyzMjqu9RU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ChlJr7+OYFUFYciICA4yVkYFY/92lYQZ
	JrGhrEdlKN6HGfW3K6vNG5HSoMOcmsXJSYiEzF2LuvzYB7zsNdjZpUpRULb3sz/2
	LNdHqAThna8f37Zbgsj/3N4gDU4kaGuwmQlGLD5ymOyFeJ38F/b+z5jw4TmnDkZa
	n3ZWjKnbmjU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2064953705;
	Tue,  5 Apr 2016 17:12:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 802D553704;
	Tue,  5 Apr 2016 17:12:35 -0400 (EDT)
In-Reply-To: <1459884234-13026-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Tue, 5 Apr 2016 21:23:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E7385D8-FB73-11E5-A10D-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290812>

tboegi@web.de writes:

> +	git config core.autocrlf true &&
> +	mv crlfinrepo tmp &&
> +	git checkout crlfinrepo &&
> +	rm tmp &&

Why not just "rm -f crlfinrepo" and "git checkout crlfinrepo"?

> +	git blame crlfinrepo >actual &&
> +	grep "A U Thor" actual
> +'
> +
>  test_done
