From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting
 options
Date: Tue, 11 Sep 2012 09:22:34 -0700
Message-ID: <7vsjaoil6d.fsf@alter.siamese.dyndns.org>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:22:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBTEc-0006w4-BF
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab2IKQWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 12:22:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab2IKQWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 12:22:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 428917162;
	Tue, 11 Sep 2012 12:22:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zLAF+Rf0q2kuqtTG+3i4EFGtAnQ=; b=bDc54M
	IB3N6jwdMYM/EAY/+4fG3j4jAS5OdsqNzNhEeUSbt2Ybjm6LrcUA6/iShHn0JA+y
	APZgwqiLmCXkeu/B3NAx80N9444HO4T5/42xvnG0N29kpdzBQLSZM9oG8lwX/ekt
	QEnLRM0TLuJaG/65TLXrmsD+13Jyq3bqQF26Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YoueRpy6llVcm33xLQhEMfSjo+JwdMpo
	zz0S5KQdE4zId3SKAD7J7PPtIRFWF7W2bG97/3aUICfaIMR1fN8io7UqxMgjOhji
	lWQpbuu9i1xI27O6MBX7Nk6z+QbbYqxXl5TdzhfiI1bvppzvk85s6snefw824w5O
	y8CLWtCHmwI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3D637161;
	Tue, 11 Sep 2012 12:22:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C733715E; Tue, 11 Sep 2012
 12:22:35 -0400 (EDT)
In-Reply-To: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 11 Sep 2012 16:45:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5B75F9C-FC2C-11E1-9211-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205246>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The current behavior is probably as useful as it is confusing. In any
> case it is going to stay. So, document it.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I would have written a test but don't really know where to stick it in.
> rev-list has many small tests where it doesn't fit.

"git log" would be the more natural place, I would say.

>
>  Documentation/rev-list-options.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 5436eba..9c13df3 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -6,6 +6,12 @@ special notations explained in the description, additional commit
>  limiting may be applied. Note that they are applied before commit
>  ordering and formatting options, such as '--reverse'.
>  
> +All occurrences of the same option are ORed: '--grep=foo --grep=bar'
> +limits to commits which match at least one of these conditions.

How would this interact with "--all-match"?
