From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show-branch --topics and merge commits
Date: Sun, 17 Jul 2011 19:21:01 -0700
Message-ID: <7v8vrwl46q.fsf@alter.siamese.dyndns.org>
References: <CA+6x0LWXz-SpnZjdiV3UKJzUz3+0LiMOsbZHTn2gJ+v6bPGndA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Shal <marfey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 04:22:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QidTs-0003kA-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 04:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab1GRCVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 22:21:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756378Ab1GRCVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 22:21:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A1714C0C;
	Sun, 17 Jul 2011 22:21:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eZRzQSNC+X7WE3eiQsiF7/lZv4Q=; b=lHr9p6
	IKMxWv8vxK1qVjN5NHMKAzC/6wokj+iTHb+tfQS0MLCKMleA+S/+3+ZbmhWrPKzv
	ytmUZHUMWU8Q/fz6Xy5WBxPMq9Ktd2V1C03RTHqXPBKMp+UXYRk8ZuesjqAG/sB3
	fCY9nCmXmuCIevsd4e3zoiit3/2knOSTMpCTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dM5o0FNGdNUdI3hiJxXPgoxmrGAyagbl
	oVaH6ieKa9DsLxhpw8LnVDyBnZfj0LtPdjHGWkjsu/Dj2aCpJu3ZUuRlB1CBDrjy
	9ZFQMZ84B+bN3hKrOhsBjSf6Eufuu0dwAZpcHBPEor7NO9Qjkr2kX0DNDlrtxu4V
	7aRoljQiT08=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0977C4C0B;
	Sun, 17 Jul 2011 22:21:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 663534C09; Sun, 17 Jul 2011
 22:21:03 -0400 (EDT)
In-Reply-To: <CA+6x0LWXz-SpnZjdiV3UKJzUz3+0LiMOsbZHTn2gJ+v6bPGndA@mail.gmail.com> (Mike
 Shal's message of "Sun, 17 Jul 2011 19:56:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95DADA42-B0E4-11E0-8456-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177330>

Mike Shal <marfey@gmail.com> writes:

> So rev-list shows my merge commit and the 'new' commit, but
> show-branch --topics doesn't show 'new'. Is this the expected
> behavior?

Yes, show-branch was specifically written for people with strict sense of
project hygiene who do not merge into their topic from upstream (which
would turn the branch from "place to hold commits on this topic" into
"place to hold commits on this topic and unrelated random changes made in
upstream").
