From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 17:28:53 -0700
Message-ID: <7vd3ekxkca.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
 <7vty7xttxh.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
 <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
 <20110928222542.GA18120@sigill.intra.peff.net>
 <20110928230958.GJ19250@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Joseph Parmelee <jparmele@wildbear.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	"Olsen\, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 29 02:29:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R94Uq-0007H6-5Y
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 02:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab1I2A26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 20:28:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35453 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab1I2A25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 20:28:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 089C05812;
	Wed, 28 Sep 2011 20:28:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xm3b/yVTWQ11Y50eCIzzRdaa+zc=; b=aCthwG
	yLVKtlD22UfpeH/RcWLK0qSf9g1errGMOsGz6Kn8OxtegBDRlpiwplNYd3tnb8Mp
	Fy3ERSi86yRdMDw3CX5efStwCQYMvpgHEBCD+++0e8w08UFnyAeo4gnbF/OrdrLz
	id9vQAauWrcRI2yxpjI/ho447Vo6qzBr3FbGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T6TJejqn7XBOZhromcOUQ0Fddu87pePu
	aVKyUfeWzYwzFhf8beqUStMsEI63o+bbfS2xFVECxwu/+HQ9FHRSpYFGjlEt0obx
	S/13yQtspgIPJPgLaa83G6+p/0I9ByUb1OyVTQM3psgSc2VyEVH8q0mNw3VgRSn+
	ZuTop8VBI0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 009D35810;
	Wed, 28 Sep 2011 20:28:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8124F580F; Wed, 28 Sep 2011
 20:28:56 -0400 (EDT)
In-Reply-To: <20110928230958.GJ19250@thunk.org> (Ted Ts'o's message of "Wed,
 28 Sep 2011 19:09:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 047DCA64-EA32-11E0-AA41-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182376>

Ted Ts'o <tytso@mit.edu> writes:

> On Wed, Sep 28, 2011 at 06:25:43PM -0400, Jeff King wrote:
>> [1] This is a minor nit, and probably not worth breaking away from the
>> way the rest of the world does it, but it is somewhat silly to sign the
>> compressed data. I couldn't care less about the exact bytes in the
>> compressed version; what I care about is the actual tar file. The
>> compression is just a transport.
>
> The worry I have is that many users don't check the GPG checksum files
> as it is.  If they have to decompress the file, and then run gpg to
> check the checksum, they might never get around to doing it.
>
> That being said, I'm not sure I have a good solution.  One is to ship
> the file without using detached signatures, and ship a foo.tar.gz.gpg
> file, and force them to use GPG to unwrap the file before it can be
> unpacked.  But users would yell and scream if we did that...

I suspect that letting GPG do the compression and shipping foo.tar.gpg
would work just fine as well, and it is somewhat a tempting response to a
_demand_ to sign materials we distribute. Of course, a nicer response to a
_request_ would be to give a detached signature ;-)

I understand that the automated GPG signature k.org used to use on the
master machine was primarily to protect the copies that the mirrors serve
from getting tampered after they leave the master machine. Do you happen
to know what the new policy will be? Will the developers who distribute
their snapshot tarballs from the site be GPG signing them themselves
before uploading? That would improve the situation (I suspect that there
were some people who misunderstood that these GPG signature were to
protect against break-in at the master machine), but at the same time, it
may create the chicken-and-egg bootstrapping problem if public keys of too
many people need to be published securely.
