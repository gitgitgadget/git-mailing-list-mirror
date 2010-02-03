From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using "git log" to find the files patched at the same time as a
 named  file
Date: Wed, 03 Feb 2010 12:52:04 -0800
Message-ID: <7vk4uughzf.fsf@alter.siamese.dyndns.org>
References: <218b69371002031238y6a377b06x76b8f8e87ea0ee46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zack Brown <zacharyb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmCu-0001ea-US
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866Ab0BCUwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:52:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791Ab0BCUwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:52:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9912996A81;
	Wed,  3 Feb 2010 15:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CG2WJn0oXZg+dGcLr/yTd+232OE=; b=f3qUP/
	QD/RZk4DmsN4Hd73/tzqL3apzpTxE9cehMUgimTqhqoM28HlydClNRlU053FniBo
	iMhNLIgPRU9m6iDKWbDQnib9sg6kIKkKptzUR30yk1Chas0mESV5RnP4P+bT56eG
	GJLT8L11ggUM9mHsGaNIWAjZ3/2QWq0c3XuTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H9ctXN45U9b6oxg+/CkeaCT9uCX68ZHu
	RcZhFv21WsITjROv7mv5cgiocQXd2ULt6yn1Vfxj9fSuCtEvcbWWl/tKfYF3GeLD
	fSMdurrHE/hX28MZc/xyjdl4dUwuuiRY9T+AvplDMUC1dI4TRVMZRw7R44KI4W3w
	QkbvOdYNo/Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7172196A7D;
	Wed,  3 Feb 2010 15:52:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B59B796A7C; Wed,  3 Feb
 2010 15:52:05 -0500 (EST)
In-Reply-To: <218b69371002031238y6a377b06x76b8f8e87ea0ee46@mail.gmail.com>
 (Zack Brown's message of "Wed\, 3 Feb 2010 15\:38\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE55B5A4-1105-11DF-9239-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138894>

Zack Brown <zacharyb@gmail.com> writes:

> If I have a filename I'm interested in, and I want to find other files
> that have been modified in the same commits that modified the file I'm
> interested in, how could I do that with git?

Like this?

$ git log --full-diff --name-status v1.6.0..master -- Makefile

to ask "Which files have changed in the commit that touch Makefile since
v1.6.0 up to the tip of the master?"
