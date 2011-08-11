From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Move git-dir for submodules
Date: Thu, 11 Aug 2011 16:34:53 -0700
Message-ID: <7vy5yzo736.fsf@alter.siamese.dyndns.org>
References: <1312831022-12868-1-git-send-email-iveqy@iveqy.com>
 <1312831022-12868-3-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 01:35:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QremC-0002dm-BI
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 01:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab1HKXe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 19:34:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60457 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627Ab1HKXez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 19:34:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 585A047A4;
	Thu, 11 Aug 2011 19:34:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DvSLWrZo0tx2LIMBIByjgAXbCZ8=; b=SEO0OtxK2dXrV3Mx1oKS
	0M7t9elU5dUfTWPPP5ea/liGEamrjVLPQ1KLBL56m2+u/JfVGl/AS3LbZDmwbuI5
	WcpoTuZOa7FQfwC/o1t2TLSlwgZTCC3u6okCAfSZvdcx86EU6EPhChfbUc/yfvi2
	YnDDYgEtJxlmuOoqTW8k1Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PbJhsqU0g41TCoevDYCaQvVByt1wAFtbdKTeZPcE/u0lbl
	kB++/IM5qai6TmmVtdjp2DKRFpnTrRbqovSnLhcVBNX5xz+fnTQ35QgkZdvP88Xg
	UrgDJxKu4Psw+lO27zBAdxE14US7Mn17P1OcF62cF+S9fNF+1C44UXBXseZLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 507E6479E;
	Thu, 11 Aug 2011 19:34:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBBE04799; Thu, 11 Aug 2011
 19:34:54 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 847B37C8-C472-11E0-8654-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179154>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
> the superproject. This is a step towards being able to delete submodule
> directories without loosing the information from their .git directory
> as that is now stored outside the submodules work tree.
>
> This is done relying on the already existent .git-file functionality.
> When adding or updating a submodule whose git directory is found under
> $GIT_DIR/modules/[name_of_submodule], don't clone it again but simply
> point the .git-file to it and remove the now stale index file from it.

And the index is populated to match the correct commit how?

> Tests that rely on .git being a directory have been fixed.

Thanks.

How would this interact with submodule repositories that are already
initialized in-place?
