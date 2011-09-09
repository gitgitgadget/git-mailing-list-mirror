From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our
 Documentation/
Date: Fri, 09 Sep 2011 13:50:15 -0700
Message-ID: <7vehzptp88.fsf@alter.siamese.dyndns.org>
References: <4E6A23DB.1040606@drmicha.warpmail.net>
 <7v4o0lvcq3.fsf@alter.siamese.dyndns.org>
 <20110909190547.GF28480@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 22:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R281p-00070q-P9
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 22:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933788Ab1IIUuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 16:50:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933750Ab1IIUuT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 16:50:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D19EB5FC3;
	Fri,  9 Sep 2011 16:50:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sNdquTYs3Bhw9NJAXaOtIOpbZjs=; b=WCDBDv
	Qn2z3103Afdj5r10DF4KyFaBbnS/hFyURU7y4thgj4Ec9ZGc3HUNTa+ej5DRQLlE
	nLsxAAB/QQoDug/Gb5kKXrSknDT7A4W+7QVGu1oI1O8fOsxjoiFEgXhz5gW8p0uh
	s4TP+EXiV0KWhY/fD6aINmbmdlgUB+xeqWls0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K1XY0uPD0vyaEVlCp33YhKlZm5UpKjS0
	OwKJU3EjPZjpvUfa9m810NRFuq6GoCqlS4RRnuNipjiVtNYwWEiSN/K3Fxh+DAww
	Vlv3z9FS4SH7JVhKabyw3Y/TcwK4cFy05yVUeo71m/RE39EdXZ7R7HBC2BuTxi7q
	SmOcRfMjggQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C86605FC2;
	Fri,  9 Sep 2011 16:50:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6801F5FBF; Fri,  9 Sep 2011
 16:50:17 -0400 (EDT)
In-Reply-To: <20110909190547.GF28480@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 9 Sep 2011 15:05:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53072BE2-DB25-11E0-A06C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181124>

Jeff King <peff@peff.net> writes:

> How frequently do you build the html branch? I always assumed it was
> once in a while (every push?), not for every commit.

I don't ;-)

Every time "master" is updated to the official distribution point, i.e.,
kernel.org (which currently is down). A post-update hook runs there,
fetches the "master" branch commit into a separate repository, rebuilds
the documentation, updates "html" and "man" branches and pushes the
results back to that distribution point repository.

The mirrors will pick the result up after all that happens (or they may
lag but they will eventually catch up).
