From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unable to get "pretty" URL aliases working
Date: Tue, 12 Jan 2010 22:55:41 -0800
Message-ID: <7vockytrwy.fsf@alter.siamese.dyndns.org>
References: <4B4ABDB5.9000203@uq.edu.au>
 <7v7hrpvzqa.fsf@alter.siamese.dyndns.org> <4B4BB2DC.4090203@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Nielsen <adam.nielsen@uq.edu.au>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:56:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx93-0000oO-Lm
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab0AMGzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754919Ab0AMGzu
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:55:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab0AMGzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:55:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ED0C9000C;
	Wed, 13 Jan 2010 01:55:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/n+lydiVacMCL6yYg/ZUzVb9uoY=; b=K5d1u4UzYKOCfb3rn+xoyVH
	B8HUOtWP4bmRe/6eqZ2kN6OMESGVPxaRCnETNnIcOpDv+ZJLblOihN7yUuqvFcEc
	E3PyVH17HuEN8L4ALPFSnhKcKeylJRyqKP/WuPv6+DmEioo4TytNvYHEMj4M9OhI
	dTnCzuLa2exWLVhVUklY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=w4gvu5/ntPjz+mJxjQfwKt6y9wWXSn1fL01+okXKTHG+Lija0
	Z2oocBBTUVDLN0hVbwX0ajOsi9DtfDrZxuZYmz8+GzgVUAlsNJi2+l8bzE2zM5bm
	dssfoVsr+CD3Wox4tznYcO1GvXFFvutWGTor3Bdaea3rFrPgX+wWZoK+Yk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EE4090009;
	Wed, 13 Jan 2010 01:55:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2AD290006; Wed, 13 Jan
 2010 01:55:42 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC299B16-0010-11DF-9B93-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136775>

Adam Nielsen <adam.nielsen@uq.edu.au> writes:

> What actually happens when you use the ssh:// style connection?

Be it ssh://host/full/path or host:/full/path or host:path/in/home, you
log in as whatver ssh identifies you as to the server, and start a
server-side git process over there.

With ssh://host/path notation, there is no way to specify any relative
path (i.e. "/path" part begins at root) so it will mean the same thing for
everybody (unless you are getting chrooted or something), while host:path
notation allows relative path which will be taken relative as where you
are, i.e. home directory of the user on the server.
