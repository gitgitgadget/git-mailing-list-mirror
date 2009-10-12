From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git: add --no-replace-objects option to disable
 replacing
Date: Mon, 12 Oct 2009 16:42:19 -0700
Message-ID: <7vmy3w5gdg.fsf@alter.siamese.dyndns.org>
References: <20091012203033.8939.43473.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:43:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxUY9-0007dA-RJ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 01:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbZJLXnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 19:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbZJLXnR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 19:43:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932468AbZJLXnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 19:43:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 14E1F75815;
	Mon, 12 Oct 2009 19:42:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=s2g9zz3zw4lq5MybrFzxn1bJl7g=; b=wB/30j0L1KXz6dwNQnbssHp
	cRJ4QmZNHATfemmpRuQxidIwVDcyiC+sN5S6VWIQfRyHZXc5Zqecz0FGQn3Skg3B
	eaPYPPUfAF02P+Gbv8SI5Sq9hytagchNfRqUgqXfuFpmoWlbJc2pKBst9bXEepTZ
	RwFk/aWbXW/wxWL5X9PY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KV/C/99mM7iFWDps7ajDTur8a184+P/yy/5cCEsu00d54+JUi
	l9AyqOT4JqaOboczRi5xcY1U3eWn7COJVvDmAOZSoTqjsThQRXws/mZCDyD5Kja6
	eceooc9DNotZ9REF9mB25ii2Wg7eUJ3tC2iHAt/XHzM+STUMSD0sLNHfPg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B742975814;
	Mon, 12 Oct 2009 19:42:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D537C75813; Mon, 12 Oct 2009
 19:42:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E7065880-B788-11DE-A62E-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130097>

Thanks.

I understand that the replace mechanism is lazily initialized so it would
be Ok to flip this variable as long as it is done before anybody makes the
first call to read_sha1_file().  I am guessing the assignment the patch
adds is early enough but I didn't audit the code.
