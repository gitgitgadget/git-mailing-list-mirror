From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 22/45] archive: convert to use parse_pathspec
Date: Sat, 16 Mar 2013 23:22:29 -0700
Message-ID: <7vboaisfyy.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-23-git-send-email-pclouds@gmail.com>
 <7vfvzwv96b.fsf@alter.siamese.dyndns.org>
 <CACsJy8DUb5j0of=cuQje5cRWLwyi-MiH-d-RsyBiPOjaD1Tntg@mail.gmail.com>
 <7vehfetycj.fsf@alter.siamese.dyndns.org>
 <CACsJy8A3NaA=faQoGhCDWNB7CKHQ2WF_5T0tf9z7mGTYFdreEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 07:23:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6zj-0004BW-C6
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 07:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3CQGWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 02:22:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab3CQGWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 02:22:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49164A901;
	Sun, 17 Mar 2013 02:22:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U5S5F/ICxbTlbo276mLEC7Vj1B8=; b=X7kFw/
	TyBTErN0W8IwJuGZotSHVwKIdPUYu3s+Xsi7WeLUgOyH8IhQBegdiIazyGL2ycbA
	XPPWgxlDMY/vOoclbUK3T1vrqrDvlOXdtAzJZ1HUVFYrL/FXPCSsQd2UkekM7R6v
	X+/b5op9BICJ+PNnYPqQymH/eakrE4nl7SFws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GODhN2P8EZOMAuWe16UYwiPG73JYh/Xg
	B8xzc9Mk1w8Of3oIei6ZqWjFVWwvunffWYCKhyniT983dD2H3F7HA99/mff9rGhD
	TCWHNfbc4wARbVPqq4BzDP01yl5CVJ7L7y7+GX+NvtGV16hLlHHzONVOporBZZVL
	ZWApzV0fY6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D6E5A900;
	Sun, 17 Mar 2013 02:22:31 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2ADDA8FE; Sun, 17 Mar 2013
 02:22:30 -0400 (EDT)
In-Reply-To: <CACsJy8A3NaA=faQoGhCDWNB7CKHQ2WF_5T0tf9z7mGTYFdreEg@mail.gmail.com> (Duy
 Nguyen's message of "Sun, 17 Mar 2013 12:31:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C1EEC6E-8ECB-11E2-9286-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218342>

Duy Nguyen <pclouds@gmail.com> writes:

> No, the literal strings are reparsed in path_exists() before being fed
> to read_tree_recursive.

Yuck.  OK.  Thanks.
