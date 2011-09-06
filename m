From: Junio C Hamano <gitster@pobox.com>
Subject: Re: question about interactive.singlekey
Date: Tue, 06 Sep 2011 14:28:27 -0700
Message-ID: <7vsjo9743o.fsf@alter.siamese.dyndns.org>
References: <20110906205011.GC1747@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>
To: Valentin Haenel <valentin@fsfe.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 23:28:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R13C7-00066s-BE
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 23:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab1IFV2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 17:28:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64042 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab1IFV23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 17:28:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 549A15B45;
	Tue,  6 Sep 2011 17:28:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oGPxWJhQ2vMZCdUsQwT65XmTo2w=; b=klgGs1
	bQgXw+rKfuKVLs57u9e+/0zZ1rBYoCR1Hqa0MLkKTJER0PJGycRXnweizu0a3wOh
	42Yjk4CYQ3JCRuE3pIVdrNlRH3XYZoLvB9QPRQ7WZFM0wMrdkv+tQd5+ZLxuL1xb
	4nitKJcn1Sy0MJa8lSY6QL1l0wkFvTFPaOg/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uWvxW29nXi/z2bsX6opxyXOSaJz8n97i
	KulNq2bEar6h8kPwlqtHYlN8ucsboOmaKeYDmF0J8hWp/ZLX78f76KtCKPnwdUPS
	Sz85KfQIgsYa2Zc9oNKZ2l8xiYsnq79mrsh+8eZUN7zH0yrh7P0N/s3iz7jGsbd9
	Kvfizjv40AU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BD795B44;
	Tue,  6 Sep 2011 17:28:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFA685B43; Tue,  6 Sep 2011
 17:28:28 -0400 (EDT)
In-Reply-To: <20110906205011.GC1747@kudu.in-berlin.de> (Valentin Haenel's
 message of "Tue, 6 Sep 2011 22:50:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2995747E-D8CF-11E0-8DC7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180838>

Valentin Haenel <valentin@fsfe.org> writes:

> i have recently installed debian on my laptop. I discovered that the
> 'interactive.singlekey' setting does not seem to work. On my desktop,
> which has been debian for a while it does work. These are both debian
> stable and have the exact same version of git v1.7.2.5, but
> perhaps slightly different packages of other software installed. Does
> the 'interactive.singlekey' setting perhaps need additional libraries
> which were forgotten in the debian package dependencies?

I see this:

        eval {
                require Term::ReadKey;
                Term::ReadKey->import;
                $use_readkey = 1;

so perhaps...

    $ apt-cache search term.*readkey
    libterm-readkey-perl - A perl module for simple terminal control
