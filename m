From: Junio C Hamano <gitster@pobox.com>
Subject: Re: standarize mtime when git checkout
Date: Mon, 08 Jul 2013 15:03:05 -0700
Message-ID: <7vobacyajq.fsf@alter.siamese.dyndns.org>
References: <7D0754FFADBD2D4785C1D233C497C47B209AF2BC@SJEXCHMB06.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Rick Liu" <rickliu@broadcom.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 00:03:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwJWb-0002Xd-WF
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 00:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab3GHWDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 18:03:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809Ab3GHWDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 18:03:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7CFD2F166;
	Mon,  8 Jul 2013 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/wWfew4Mpkf4jsc3lp3Yaqf9BLU=; b=VFrzdx
	9GY2ZyK+nVlz2UH0lKnPcaNoi2s0eL7q6IlYa5fTPpE9V8dJPQHJ3Ga/43IeGMeI
	Bh1X9cSxK+5V7bsxYiKGPOn2tDSsASob0wvWvmysG3AXoahs6zgcq/z0J4Ktbxda
	BZH3WgG1kOshUeJldnHERd4xQeRv6e7iB/auw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rwV8qQ5rEzYTfW1c6av8p+PsCRvoV3lq
	/sNhvN05Fz3MNsYcep2Mv8xoAWCR+OKJ9wHKYX4yitDj+jX+1UBfhHn2Ni2/FGgv
	y9HAYk3UD0vHN2L+yaxhf0vHHdf1bDXS7snK2PavRh24sex1eGeZT9ckEaZAochd
	Qs5nH1HTD5w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC8582F165;
	Mon,  8 Jul 2013 22:03:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FF2F2F163;
	Mon,  8 Jul 2013 22:03:07 +0000 (UTC)
In-Reply-To: <7D0754FFADBD2D4785C1D233C497C47B209AF2BC@SJEXCHMB06.corp.ad.broadcom.com>
	(Rick Liu's message of "Mon, 8 Jul 2013 21:39:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B8DEA48-E81A-11E2-BAF9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229898>

"Rick Liu" <rickliu@broadcom.com> writes:

> Can we use GIT's commit time as the mtime for all of files/folders when we do "git checkout"?

No.  That will screw up common practice of build based on file
timestamps (e.g. make).

You may be interested in "git archive $commit" which will set the file
timestamps that of the commit object.
