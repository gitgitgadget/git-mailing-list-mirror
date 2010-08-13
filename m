From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 7/9] stash: teach git stash show to always tolerate
 stash-like arguments.
Date: Thu, 12 Aug 2010 17:49:44 -0700
Message-ID: <7vwrrvmj4n.fsf@alter.siamese.dyndns.org>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
 <1281398688-21008-8-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 02:50:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjiTE-00053o-VZ
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 02:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761248Ab0HMAtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 20:49:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761245Ab0HMAtz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 20:49:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BFA7CD617;
	Thu, 12 Aug 2010 20:49:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=7vq5iLIzQUGtAMz4QrpSp5lIeQY=; b=PzPzQhz4snt4ROg01F3m03h
	GqO3bJS6YVtdLwNFObNLhmAm8Y0SrDhaWjhFeeYCi2BSTcyCuAALeAVoMkGTSRqi
	cGNQ04ExV45fAVMzYkyhf0g+t7ErBF+W9KbzaiAlQPFlqD58JWN2r7VMgeaFWZ9N
	6QBs7kqxqb02fr2C07n0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=oeJNtdAy8NW9eKDbeG7BiOC2ywCsDuxNK5ZI8NXyXbSEVi1/w
	tUS/kXUgSUXEvgS3dtfmWsH1QqqPFIStHy+cr/GB9jWKcv1ad/mTppTwoUHjpm0q
	dKsEVgspUgPifM3GXQc4N8AsnFmr3ANHzO0/3pqHjwQvbzQo+bIFMzLvNk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E4CFCD614;
	Thu, 12 Aug 2010 20:49:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDB1BCD612; Thu, 12 Aug
 2010 20:49:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD6B1526-A674-11DF-A427-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153445>

Jon Seymour <jon.seymour@gmail.com> writes:

> +	revs=$(git rev-parse --revs-only "$@")

You probably want to also give --no-flags to avoid  "show stash --parents"
grabbing --parents into $revs variable here.
