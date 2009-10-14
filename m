From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Tue, 13 Oct 2009 22:07:40 -0700
Message-ID: <7v4oq2mulf.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxw8w-00038c-JN
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbZJNFIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbZJNFIz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:08:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbZJNFIy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:08:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74CA876564;
	Wed, 14 Oct 2009 01:07:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Y/BJ5c/vf5OXponcOdu6MICqVM=; b=jkkPha
	7sOWA3zzN028P250CPwqfWjAWyMaZaJ0sNomzh+UZpKLq81ToyshwY3P7/1yMy8p
	mpn8+TnLDa7AWZM2SMduotyEZLWmUI/mGEzlOuW3kTFuXh2ucw8H8yJ0YBjwFcxE
	8GUa4SYDWOX809HvRsPuODpGrq0WtSxIw7zIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ei/RvnGT9FIo3wH98CgzZOTFel+W07TM
	eMU02x3uotB3BzmUuZ9DwhmN4woTEsQwBNuxnrg/nX4bwE+YBLEX/VQqwcElMcwl
	aqnGBAaX4UKxTYo5RAJsLU8SXeYoAOLyW5YJO6/gGTd3Km8HSXUOpnlbbDMq1Tl4
	m4tXjGey3B0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 581A276562;
	Wed, 14 Oct 2009 01:07:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 480C976560; Wed, 14 Oct 2009
 01:07:41 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> (Daniel
 Barkalow's message of "Wed\, 14 Oct 2009 00\:44\:34 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 823AD6AE-B87F-11DE-A976-A730BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130248>

Daniel Barkalow <barkalow@iabervon.org> writes:

> When detaching HEAD (or "browsing history"), the user has specified
> the commit with some "extended SHA1" which is not a local
> branch....

I do not have enough mental bandwidth to think about (1) if this
information is a good thing to have, shown in your transcript, or (2) if
the name of the branch _before_ getting into the detached state may be
more interesting information tonight.

But I have one question regarding the implementation.  Why do you need a
new file in $GIT_DIR for this?  Wouldn't what is in the logs/HEAD be
enough, and if not why not?
