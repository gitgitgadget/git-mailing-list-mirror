From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Wed, 21 Nov 2012 10:14:24 -0800
Message-ID: <7vmwya3h0x.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:14:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFkt-0004Kn-5d
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761Ab2KUTO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732Ab2KUTOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C618E9630;
	Wed, 21 Nov 2012 14:14:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=FkLRBsqAb5m/EYKd6bRlFN9AEjs=; b=jj12zJa/ZucPJopr3jmh
	ADpt3h6j0pWrNL7hsbKUvnJhAFsvQvN9AjWWQM7zM6mKE66LHAUTygTPNLnhiVle
	/a/jl/d7FTKehItCinUTTHBZh4tB1uKNh1riddOSNWK8CRqS6SP08YoCWi+BrZjX
	wnanKT2HGkkgpD7PG7Q0soM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ucDVTTt6vVbeZHNtTTMpNU3ZZX2tTghIU9+9bJnM62XR87
	5g3vdB5KMZvJuRfb49Wqfp8MaGpsqtG+ivad6Crtb1QSt1Aza6R3FGCpRlfB2tKg
	UwGHgCZsll0yKzmahuHB4c1dhR8XzUXZCttGGpsq8xAMOcjEIDApkzxlT/54s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1197962F;
	Wed, 21 Nov 2012 14:14:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25D3B962D; Wed, 21 Nov 2012
 14:14:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A92CA7BA-340F-11E2-A09F-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210153>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> They have been marked as UNINTERESTING for a reason, lets respect that.
> ...
> The current behavior is most certainly not what we want. After this
> patch, nothing gets exported, because nothing was selected (everything
> is UNINTERESTING).

The old behaviour was an incorrect "workaround" that has been
superseded by your 14/15 "make sure updated refs get updated", no?
Mentioning that would help people realize that this patch would not
cause regression on them, I would think.
