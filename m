From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/10] nd/clone-detached
Date: Sat, 14 Jan 2012 18:34:23 -0800
Message-ID: <7vk44twv68.fsf@alter.siamese.dyndns.org>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
 <1326439322-15648-1-git-send-email-pclouds@gmail.com>
 <7vvcofxtv8.fsf@alter.siamese.dyndns.org>
 <CACsJy8DggQdM1aoeL+u=3Wz+5f7hi4eG=6MHXPCJZ6pOmhQJ_w@mail.gmail.com>
 <7vhazyyduw.fsf@alter.siamese.dyndns.org> <20120114074036.GA27256@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 15 03:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmFvT-0000JD-9A
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 03:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab2AOCe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 21:34:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50744 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab2AOCe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 21:34:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C141D72DA;
	Sat, 14 Jan 2012 21:34:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2b+E2Fk+IiaBWRqVhLzcKTxbGLI=; b=MH2fDX
	BYZwaZbdTUIBBASid/GgNv/Cxg2cgz2ZV7VeIGawjdfrV9x5gSnxA3OpVqB7DHQ+
	qtLXcT8vq2jFi3OSa09QLB+SWZArOHS7YCvNDK2wtAlf7bezzH1hQ9HcnUSOcOzF
	/dEKCq6D/M0FU78Yq7Zfnzs7HAd+wXle5FsRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kt6+a43gtukRKZchdD5rAYqOYGVBUdnS
	JOea4RwIvXVwGU197C7pMNDTIaBZj5NjWeSqCkW4RyHfDMJlPVCOtkPih5pataa/
	7T/8vzrJORX84XSxW2rB+sChB0RGDYK5yFXGqQKQschnGUQ7eorepJqfXuiESzFe
	p8R4Dz+dxvk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B896F72D9;
	Sat, 14 Jan 2012 21:34:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EF8F72D7; Sat, 14 Jan 2012
 21:34:25 -0500 (EST)
In-Reply-To: <20120114074036.GA27256@do> (Nguyen Thai Ngoc Duy's message of
 "Sat, 14 Jan 2012 14:40:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70989104-3F21-11E1-A5DA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188587>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> Hmm, 'pu' seems to fail its selftest with this merge present, though.
>
> The commit "refuse to clone if --branch points to bogus ref" from this
> series changes clone's behavior that t5500.31, which is added in
> nd/clone-single-branch, relies on.

Ahh, of course.

> Another cleaner approach is to combine the two clone series into
> one.

I think "--single-branch" is much more relevant compared to cloning from a
repository with some funkiness like detached HEAD which is more about a
theoretical fun exercise, so let's rebuild this on top of the other one.

Thanks.
