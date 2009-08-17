From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "make quick-install-man" broke recently
Date: Mon, 17 Aug 2009 01:02:25 -0700
Message-ID: <7veira27hq.fsf@alter.siamese.dyndns.org>
References: <86my5z8cjd.fsf@blue.stonehenge.com>
 <7vy6pj449g.fsf@alter.siamese.dyndns.org>
 <86iqgn8brv.fsf@blue.stonehenge.com>
 <7vd46v3tp1.fsf@alter.siamese.dyndns.org>
 <8c9a060908162258ua50e34ah53c1ada9dbcd4aa0@mail.gmail.com>
 <7vhbw72ap3.fsf@alter.siamese.dyndns.org> <4A890E09.9010507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:02:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McxBA-0007C0-5L
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215AbZHQICp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757208AbZHQICp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:02:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189AbZHQICo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 04:02:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEC1A2C45D;
	Mon, 17 Aug 2009 04:02:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 967402C459; Mon, 17 Aug 2009
 04:02:32 -0400 (EDT)
In-Reply-To: <4A890E09.9010507@viscovery.net> (Johannes Sixt's message of
 "Mon\, 17 Aug 2009 10\:00\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5864DFEE-8B04-11DE-97E5-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126137>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> check_path(): allow symlinked directories to checkout-index --prefix
>
>> +test_expect_success 'checkout-index -f twice with --prefix' '
>
> Please add SYMLINKS prerequisite before you publish this test case.
>
>> +	mkdir -p tar/get &&
>> +	ln -s tar/get there &&
>> +	echo first &&
>> +	git checkout-index -a -f --prefix=there/ &&
>> +	echo second &&
>> +	git checkout-index -a -f --prefix=there/
>> +'

Heh, I am not sure if the fix is the best approach to begin with yet ;-)
