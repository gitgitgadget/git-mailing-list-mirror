From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: determine the list of header files using a
 glob
Date: Fri, 27 Nov 2009 10:28:44 -0800
Message-ID: <7v1vjjom8z.fsf@alter.siamese.dyndns.org>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 19:29:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE5Z3-0006Lx-BJ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 19:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbZK0S2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 13:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbZK0S2r
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 13:28:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbZK0S2r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 13:28:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB4F3833A9;
	Fri, 27 Nov 2009 13:28:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VfMjrObkBPMbS4kKA2Sb6vetVUA=; b=dkvUv/FbNo+R8fBbvBGq4AG
	m2jOAZ9fjCQOxfs+tHHdFCfLTlTdxBfFFZuO5cyHLFMxaIsjDcwRfN4We7j9goN8
	1SAZfs3apOVYgGvTZiNM0ZWGYu0jnGpetg2e1T+8qfL8z1mVEsb8HyfVzbWpOihK
	A+3Ve4wgGzT3CNmIABOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=YXJmKGApwVoQh25H0yjwhVqBM47iGoN04Dkb+t3BhVm05Scc9
	Tc9WHFv4zYNQc3jJzXY/EDha38z8Fr2Hy3toNgTeI0kBXdu6+m7V1Z+TGtinjj17
	V23VxOTW9aUz+cZ33wGDXi/zCZDr018XuHcsEbFgrIAHFIOdq8rfa7huQU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93580833A8;
	Fri, 27 Nov 2009 13:28:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D210A833A7; Fri, 27 Nov
 2009 13:28:45 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4ED28BA-DB82-11DE-AEC4-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133917>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Sidestep the issue by computing the list using $(wildcard).
>
> Funny; I thought that not all header files are library header files, i.e. 
> not all header changes should trigger a full new build of libgit.a.
>
> Am I wrong?

You are right.
