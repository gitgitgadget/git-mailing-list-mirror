From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Thu, 16 Jun 2011 11:42:17 -0700
Message-ID: <7vpqmdhb3q.fsf@alter.siamese.dyndns.org>
References: <20110616003800.GC20355@sigill.intra.peff.net>
 <7v39jai94h.fsf@alter.siamese.dyndns.org>
 <20110616065146.GA30672@sigill.intra.peff.net>
 <20110616075621.GA12413@arachsys.com>
 <20110616174653.GD6584@sigill.intra.peff.net>
 <7vtybphcym.fsf@alter.siamese.dyndns.org>
 <20110616182149.GB12689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>,
	Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:42:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXHWM-0001K0-CG
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab1FPSmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 14:42:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1FPSmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 14:42:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B1BE6027;
	Thu, 16 Jun 2011 14:44:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t+fMjiHpFRRuEnj12cMB5FQQTBQ=; b=na8yEw
	n0HxOJeu8iAqr2dRMdmsWRmJoGAucXlA8VUg33F37n/6onhiy1lfliwWXuC8i2MF
	9ypzXu5x/l6u6PRpPP+yaS0o1gQ5FP0o2jxJl/xcL1DN65WC3kAEP53oWfqoZDgB
	8khMYUbJ8Bq0rYOOM8SpRF7apGSIAfNAbU6Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trkwsCLgDXu/Mgh5QUrHvxd+IlwDRgp8
	bE5kVU1e1MZe6IElFW+hNennYvnJzEPg8gCeWQXaRY76iHQ1cA5CbMpQqDdflk0Q
	xxWt3GTz02mHW3sXkgCu6tGw5RGIdyibq9GVrFGSMZclCrtanH/k3n/HGF81N8zW
	Noc22nCj6f8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 611D76026;
	Thu, 16 Jun 2011 14:44:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C28C66025; Thu, 16 Jun 2011
 14:44:29 -0400 (EDT)
In-Reply-To: <20110616182149.GB12689@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 16 Jun 2011 14:21:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB2D578A-9848-11E0-BCCD-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175915>

Jeff King <peff@github.com> writes:

> Also, since it's easy via the external helper route, should there be any
> other builtin formats? Bzip2? It's not that big a deal for a big hosting
> site like kernel.org to stick it in their configuration, but I wonder if
> normal users would find it useful.

I know k.org statically prepares *.bz2 for any *.gz in /pub/software/
hierarchy, but isn't bzip2 significantly more expensive (like taking ten
times as much memory or four times as much CPI time to squeeze the last
extra 15% out), making it unsuitable for one-shot online use?
