From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/git-checkout.txt: document 70c9ac2
 behavior
Date: Sun, 16 Dec 2012 23:21:32 -0800
Message-ID: <7vd2y9nnyb.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-3-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:21:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkV1M-0005By-UE
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155Ab2LQHVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:21:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab2LQHVf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:21:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B5189594;
	Mon, 17 Dec 2012 02:21:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lSFjfiag1+5dJENKhZ3s3pIGAyQ=; b=CqETQq
	qiUz1fkAKVq/JFwxEBMuMJVxv48YRP7QPOhhxObU1aKpUGQl7gpHnfk+fVg+ScFY
	5ZGrsKab0RWoQ95H0Y0BF0V60udq3sP63sQQMwuoADLPdGtqdSUVd78VynNvrwj4
	GF5mjK6L30G85c9FuaizhGXacaW0uiIWbJJEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayBrJqGO2gbawKE1vTe01x87gIlXBhmZ
	VjmUaU5n/gQBNE19LxHubvfqqaxPR89mCrp80lYxkshXxC/WIpHD1ZEo0b4GS3zj
	C4MdRhW9IxpgjvmR+FyZk5kzlFG5sD8hT/O1CKi1es3OqQBsAPbHKwquLFQEy0nH
	Qf31ULy6NVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 085BE9593;
	Mon, 17 Dec 2012 02:21:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 642C69591; Mon, 17 Dec 2012
 02:21:34 -0500 (EST)
In-Reply-To: <1355726702-27974-3-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Mon, 17 Dec 2012 00:45:02 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6323EE1C-481A-11E2-AEF9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211646>

Chris Rorvick <chris@rorvick.com> writes:

> Document the behavior implemented in 70c9ac2 (DWIM "git checkout
> frotz" to "git checkout -b frotz origin/frotz").
>
> Signed-off-by: Chris Rorvick <chris@rorvick.com>
> ---
>  Documentation/git-checkout.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index a47555c..db89cf7 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -25,6 +25,14 @@ branch.
>  
>  	Update the index, working tree, and HEAD to reflect the
>  	specified branch.
> ++
> +If <branch> is not found but there does exist a tracking branch in
> +exactly one remote (call it <remote>) with a matching name, treat as
> +equivalent to
> ++
> +------------
> +$ git checkout -b <branch> --track <remote>/<branch>
> +------------
>  
>  'git checkout' -b|-B <new_branch> [<start point>]::

Thanks; does it format well (I didn't check)?
