From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Teaching rerere about existing merges
Date: Tue, 09 Apr 2013 09:01:23 -0700
Message-ID: <7vd2u3u20c.fsf@alter.siamese.dyndns.org>
References: <504282025.1400346.1365517106800.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Tue Apr 09 18:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPazE-0005cN-V6
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 18:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937022Ab3DIQB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 12:01:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936360Ab3DIQB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 12:01:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 579EE14FAE;
	Tue,  9 Apr 2013 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ScGLPO42bEJk9yrfLVCAgBOLyzo=; b=CKdWao
	RD9SnCoYbZA5//+IZpb2A8EF85Y1LLeHdeHi66klzRv7zHsODkHa6uQtR5YHn9v1
	EfiMbbHfTx/PFgk2nghblqx1tq/fTfNQr5SVz6Ck5YPy/Bepl+go5JC0tfcwIZWP
	jzXRTh022aUOrTtRkIrt3kR1TfH109IOrTDFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0vxR1y4sMoZ5TJx9P9/AUfL0e5PIi7g
	R6Fhq75rvAPNLtehOSNDWNiNlwhVu6BO3bMSfBzWIq3sQQsH55LdWNx0tOwA7w6y
	FSjCSYxjsfOW9l83kz3thW073OZpbWWWMwy8dQEgrmFgEI8C2JTR+7Z+FoJiUSmp
	ToQvwgei4B4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F37A14FAC;
	Tue,  9 Apr 2013 16:01:26 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8916914FA9; Tue,  9 Apr
 2013 16:01:25 +0000 (UTC)
In-Reply-To: <504282025.1400346.1365517106800.JavaMail.root@openwide.fr>
 (Jeremy Rosen's message of "Tue, 9 Apr 2013 16:18:26 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB3183F4-A12E-11E2-90EE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220580>

Jeremy Rosen <jeremy.rosen@openwide.fr> writes:

> is there a way to "teach" rerere about existing merge commits, or do I 
> have to re-solve all the existing merge manually once ?

There is a tool that does the "re-solve manually" for you.

$ git ls-files | grep rerere-train
contrib/rerere-train.sh

It uses your working tree to do its work, so you should first commit
or stash whatever you are in the middle of doing before using it.
