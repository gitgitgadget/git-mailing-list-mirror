From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] fast-import: handle empty paths better
Date: Mon, 01 Jul 2013 14:57:32 -0700
Message-ID: <7v7ghaapzy.fsf@alter.siamese.dyndns.org>
References: <cover.1371999369.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dave Abrahams <dave@boostpro.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:13:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmLC-0005bA-CO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab3GAWMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:12:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755682Ab3GAWMv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:12:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 955532D37E;
	Mon,  1 Jul 2013 22:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=3lh3p7yMS7PmpAOJLtD3NVrJAbw=; b=WQ2KaI+HA6riY8RJN9MI
	yv4P8ecq+XjZyDq2/GJpPwploZ+J0HlcaY14MQLq0TI6vjFwrB1KQLupPKVwysK5
	kXYKvNeEZ6CgP/lbsPVyw4eYFbD1RHrjLdgcp02oXwzSnveLB64mHKRu+sWwwoAP
	3/F/OWmtIzUK6H07e+KeVYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=yU4t18qqgzk0so38RLWauVgsT4E6YwdFT4Hq/cltrYhHe0
	eceYD520FCSXt6yS40VtNgQx7MwfzfL80YqxczMbgOEDIwM8D4AoUdITp/vCmMjU
	a3/d+4283sa8DBJ3g+aClf+7tf0oV/FH+2wXIJpIQZmdulpVhsA+LvnCh9hkQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B2D2D37D;
	Mon,  1 Jul 2013 22:12:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 049132D37B;
	Mon,  1 Jul 2013 22:12:50 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EA5CE02-E29B-11E2-99D2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229336>

John Keeping <john@keeping.me.uk> writes:

> This series addressed Dave Abraham's recent bug report [1] about using
> fast-import's "ls" command with an empty path.  I also found a couple of
> other places that do not handle the empty path when it can reasonably be
> interpreted as meaning the root tree object, which are also fixed here.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/228586
>
> John Keeping (4):
>   t9300: document fast-import empty path issues
>   fast-import: set valid mode on root tree in "ls"
>   fast-import: allow ls or filecopy of the root tree
>   fast-import: allow moving the root tree
>
>  fast-import.c          | 58 ++++++++++++++++++++++++++++----------------
>  t/t9300-fast-import.sh | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+), 20 deletions(-)

Ping?  Reviews, please?

No need to hurry, but just to make sure this didn't disappear from
everybody's radar.

Thanks.
