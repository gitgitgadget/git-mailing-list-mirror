From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Pull gitweb If-Modified-Since handling out into its own
 function and use for snapshots.
Date: Tue, 20 Mar 2012 16:07:07 -0700
Message-ID: <7vvcly50tg.fsf@alter.siamese.dyndns.org>
References: <20120320014853.GA21052@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 21 00:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA89A-0001S8-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 00:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759372Ab2CTXHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 19:07:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab2CTXHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 19:07:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 425E27739;
	Tue, 20 Mar 2012 19:07:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=SiGIu++IjWrGBcoShEj22RlSHNE=; b=KKQy1bTY3aQrNR4o3Eo4
	JuZBT3jScbGL849nZoqSbavQeXS+32RgsVzCHG5z61Jy0lYUZVwIeX5k2qUXIEXt
	/QVjcrMeXxfT7BEj0orIj/4ZCCUl7TkHu7cNk+4G1dhH2qABrtxjtiUZyjdHoIcI
	WXDXwvXpr06Wn/wkioIWQio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=a8GAhn5XyitB8OYm7bKPbgJk0VsUITPaalDwTalh9xCMgH
	MAdwgLGZkUnUQneCMpI56shW8E57XiKOfhvUMNAaipn8YtZD67+iw8fI+x5rl1ur
	Ntb0wE6vdFem3NDdxB9zcXwtXpHx5e0FpHaZODAc1RZ9la4krpy22ddzo6v9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A5BE7737;
	Tue, 20 Mar 2012 19:07:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A37A7733; Tue, 20 Mar 2012
 19:07:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B035DA2-72E1-11E1-A95D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193547>

"W. Trevor King" <wking@drexel.edu> writes:

> My If-Modified-Since patch seems to have fallen through the cracks
> here.  Is that because nobody is interested, or did I mess up
> something in the submission?

Probably "just fell through the cracks"; if somebody found what it wants
to do very interesting but the implementation or submission lacking, you
would have heard loud noises.
