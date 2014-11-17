From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Mon, 17 Nov 2014 08:43:59 -0800
Message-ID: <xmqq389hzsj4.fsf@gitster.dls.corp.google.com>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu>
	<CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com>
	<5469C40B.4080601@alum.mit.edu>
	<xmqqbno5zvdm.fsf@gitster.dls.corp.google.com>
	<546A1FFC.60605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 17 17:44:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqPPM-0003tx-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 17:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbaKQQoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 11:44:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751283AbaKQQoC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 11:44:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 445E61DCC4;
	Mon, 17 Nov 2014 11:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x9HvjIi/ID1Ok7YIwzvvLn6Q0Kc=; b=b9h73y
	A2LP2Fo3MoKW+7G9CU8sHJqUQnXpG5qH7aHztwCAcJVOzJtOiajGCjgGH8tvcCWh
	2nzE9jrT3wNadDThS9y02GcETY+ZcLxL8nzOQc7alNpxuSvGZFo4h3I0FIyD0nvK
	TvPMjI4BAx6zydoT8mWovv5Av5OIcs1Kyg1H4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yNikazkgM3FkHi50Qgn4fH5YqAdomF7s
	Kv0cedGDMTdeppKJsNfzKVGAoBKHpTdwWmr0K1nSMULG6OfXEQRZ77MBDrZ6Zedh
	GGZD1uChwxXd5nuVMNb0Bx6cFWxokfrCV9trxMxbu+KV8YnJ0/N0/ahXFAlJ9Au6
	YW/SV4uxtAA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BFED1DCC3;
	Mon, 17 Nov 2014 11:44:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B4D41DCC1;
	Mon, 17 Nov 2014 11:44:02 -0500 (EST)
In-Reply-To: <546A1FFC.60605@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 17 Nov 2014 17:19:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EFDB8C8A-6E78-11E4-970A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think the logic should be
>
> 	if test_have_prereq POSIXPERM && test -x "$1/config"
>
> , right?

Yeah ;-)
