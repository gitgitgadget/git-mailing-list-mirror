From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git checkout -b: unparent the new branch with -o
Date: Tue, 16 Mar 2010 22:23:10 -0700
Message-ID: <7v4okfiksh.fsf@alter.siamese.dyndns.org>
References: <1268763584-14164-1-git-send-email-erick.mattos@gmail.com>
 <7v634v27vf.fsf@alter.siamese.dyndns.org>
 <55bacdd31003161810w1c824570lee1b7d5759568bc1@mail.gmail.com>
 <20100317041307.GA26641@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 06:23:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrlj3-0004Bi-J5
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 06:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab0CQFXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 01:23:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab0CQFXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 01:23:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 027D9A29CC;
	Wed, 17 Mar 2010 01:23:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=wwCGjO48c6rL9zNXZwKtd6GBytg=; b=RriozpMf1MMp8JYabzGaEO3
	P99xphP6WtxIqM5PlQOkIYluubzoRt0Sdow0Y9MA6fzm1K6814VmeuWHLaCGW518
	k8S8k0B8UbOM0fO2OvJWgsiLFjBOsB2Z30OvagVja7MW67FK/ZUfoWaxVb45Je5A
	IyiR0IX1YBORGfWPRSxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kkHm/5dytoRl9d9ivR6HEiuo9KPP+r0DN2TZEJdjL5FzPJjpp
	nRcj/ZkSXXhZPoUssprc0swdLuuKrRGKGv9ppcOTzvYgOjizYOBF8ATN7HbhggKx
	DW97yANHssOpDo5RpmVbQKgBO0GZR8v1voSMVHaa6rlD5RvLz5s+4YRaCQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C223DA29CB;
	Wed, 17 Mar 2010 01:23:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B33FA29CA; Wed, 17 Mar
 2010 01:23:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 310B9424-3185-11DF-A197-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142365>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio was discussing the case B.

Well, not really.  Even as an ingredient, "nuke index, leaving files in
the work tree around" is the most difficult-to-use mode of operation.
Either "try to run 'git rm -f .' from the toplevel and only if it succeeds
point HEAD to an unborn branch" (aka "remove both"), or "point HEAD to an
unborn branch without doing anything else" (aka "keep both") would be an
ingredient that is far easier to use.
