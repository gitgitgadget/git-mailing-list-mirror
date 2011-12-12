From: Junio C Hamano <gitster@pobox.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Mon, 12 Dec 2011 00:28:57 -0800
Message-ID: <7vhb165h0d.fsf@alter.siamese.dyndns.org>
References: <jbvj5o$skt$1@dough.gmane.org>
 <1kc4qnw.1xgi3yf14oaw7gM%lists@haller-berlin.de>
 <hbf.20111211x512@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lists@haller-berlin.de (Stefan Haller),
	gelonida@gmail.com (Gelonida N), git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:30:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1HW-0004ht-68
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab1LLIad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:30:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948Ab1LLIa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:30:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1C9728BE;
	Mon, 12 Dec 2011 03:30:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=IUdSRpt+A3nVaxfrOY4EPzTVwCQ=; b=OPf+k5svmxkEoHc0T/Vu
	N2b4C92sUn+n28+k+pJdFv0hhC9rm+ZQ4EqxO9OLnsi/Wrf37NYux0ZKG3HT8iRR
	eopep48WRK/6iRXLJMrPNi2u28pOrqwvJ8pNCMZJcFNBxYCiAXVtNNK9vbW5f5Vj
	wdN3YM/gamJEVBrfJOSdX04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Uh9Es92/2Bz6z1Bb0undXPROOFOznsqYSBYRX9JNPlbEv2
	Ixc4HBKqgnqbZ9kHxX+PrTkPm0EFN5uNKtovGVuFUDtXH7zyy+V0xE9zp/wNOPl2
	Eq6K6VHZLIgGoLhOdYu42Em6Sy1iLykQHc9mnv5TSBgfwwDM1/K41JZlSbaiM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D81BE28BD;
	Mon, 12 Dec 2011 03:30:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F0D228A0; Mon, 12 Dec 2011
 03:30:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B5F96F4-249B-11E1-AB13-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186896>

Hallvard B Furuseth <h.b.furuseth@usit.uio.no> writes:

> Local branches can track each other.  So the script needs to toposort
> the branches, or to loop until either nothing was done or an error
> happened.  (The latter to prevent an eternal loop on error.)

If you have branches A that forked from B that in turn forked from C, and
if after updating C you want to and can successfully update both B and A
by fast-forwarding, that would only mean that neither A nor B had their
own change since they were forked from their upstream, regardless of local
or remote.

What use do these empty branches have in the first place?
