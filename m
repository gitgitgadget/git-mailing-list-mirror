From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] racy-git.txt: explain nsec problem in more detail
Date: Fri, 09 Oct 2009 17:56:53 -0700
Message-ID: <7vmy40f4mi.fsf@alter.siamese.dyndns.org>
References: <20091009101400.GA16549@progeny.tock>
 <20091009102554.GI16558@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLc-0005GI-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934540AbZJJA5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933867AbZJJA5o
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:57:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759153AbZJJA5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:57:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB56071E3D;
	Fri,  9 Oct 2009 20:56:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AAN47nCVKuohklBELmFHorlk+u0=; b=MLiaEYLspKMjJ8d0ioJp7tK
	VACKIkfhFZWKSeJwH3ZJPKccEAe0zdWvzKNk7wc8pTQ+YaYdh9xftm0GZydqSnSS
	wHA4/EcZRvYhIaeHIF3pIwEYKCyDj3Nx/NApGbrSAWI8wxRaopU9RsbbTqqoNFEJ
	bOQrKoMb0X4VNGWaP2po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RY7Lg/tiHx6By/WsQ95fuhVjOsRBysa91fwhKCge901t+3aG1
	aB1EtcXmihOnkfGx0hPwYySfmUzb0311puP0sxUPGlux+U22+seiRr7T/ebnBFUq
	1Fr60s93JjLDVq4CO2VCuvBLGgStlrUKKWgZQoIbJvTHObR1oEl17gv3HE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF8FC71E3A;
	Fri,  9 Oct 2009 20:56:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CEE1871E39; Fri,  9 Oct 2009
 20:56:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF898054-B537-11DE-B55A-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129858>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Am I understanding the problem here correctly?

I think so ;-).
