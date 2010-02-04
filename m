From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Thu, 04 Feb 2010 08:33:09 -0800
Message-ID: <7vpr4lhsfu.fsf@alter.siamese.dyndns.org>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1265300338-25021-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 17:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4eG-0002Em-Qz
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758344Ab0BDQd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:33:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758340Ab0BDQdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:33:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8140796931;
	Thu,  4 Feb 2010 11:33:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=CsIV8cq1bCiA43X7xMGUr06yYew=; b=jiDw/xhvuIHOv3zEEqk3aSP
	Px3FyGqOobPv/HigC4AwhdCV9rT/KhR+y3PAHFUOf+j5w3gSCYU8KapELCXrEeT4
	AaqT6GDIngLiFOG5jQ/M8woGKEo1ruz6xIo6RuQ+dDI8xgu6gX0RMZaoFFWOnX/a
	L+3jN7n36/hnR/ISACdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IleygDgaIsZeNv0Jr7LGdVWcsR1KZw0GsbM8qx7XtpL9N48oc
	KFTAx3Utz8v8kX0HK0tDZT3Cv1DhOyZfuMQQ/nySm+nb8gELhZZvBVbJeSMZu2fn
	e54O7jl0DUG1Ky1B0e39iQNnl5VZlEkGmfshQOCNvAgIxqT4WD2dQmdH8c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F9F99692D;
	Thu,  4 Feb 2010 11:33:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A8EB96928; Thu,  4 Feb
 2010 11:33:12 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0002D468-11AB-11DF-B018-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138976>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> +		my %notes = () ;
> +		foreach my $note_ref (@note_refs) {
> +			my $obj = "$note_ref:$co{'id'}";

I think this look-up is wrong (meaning: will stop working anytime in the
future, and needs to be rewritten).

Other parts of this patch looked Ok from a cursory reading, though.
