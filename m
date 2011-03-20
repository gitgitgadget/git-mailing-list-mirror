From: Junio C Hamano <gitster@pobox.com>
Subject: Re: dependable submodules
Date: Sat, 19 Mar 2011 21:27:58 -0700
Message-ID: <7vd3lmv2k1.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Daniel <daniel@netwalk.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 05:28:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1AFd-000436-Lj
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 05:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146Ab1CTE2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 00:28:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1CTE2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 00:28:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E52331E1;
	Sun, 20 Mar 2011 00:29:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ddFOtFBPVOD5HwNMMRthfN6KcjE=; b=mvjc0L
	ADHzfR6EtvEJ0Cf3aj/wCNsR4eqvx3t6GlFuxAnh42IGqOnbslLs91eXBJwC1MHQ
	hEZiFQ/zYCsSiH9hu/3ueXOaCoZ639p77fta84gIwZnvp/IsfFDVmvrB74RW52UZ
	KZS3STnAUfN6MQnNC3nWlDrgO81YygdAHtQzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KHwHWo2yTzEiC10eA9Uyy4E0xfBu1Owt
	K5VZbYZDtFUC2XTm7WAm1KqE/ZhWsUJvIvoXedpVC5MgnmbC+NqYLZGgkHFhaPDF
	CcKSAs34eKd/72TFJhHZNLVHHGIcnRqmcjv3dzLmioBck2/R0V81HyovdKfA1Ijd
	vKlv45Xhoz8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EED4A31E0;
	Sun, 20 Mar 2011 00:29:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC1D731DF; Sun, 20 Mar 2011
 00:29:37 -0400 (EDT)
In-Reply-To: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>
 (daniel@netwalk.org's message of "Sat, 19 Mar 2011 17:53:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC3FDE92-52AA-11E0-A8EF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169485>

Daniel <daniel@netwalk.org> writes:

> IOW, I may have
>
>     myrepo/somefile.txt
>     myrepo/another_project/.git/...
>     myrepo/another_project/another_project_file.txt
>
> and I'd like to, when I clone repo, to be able to get all files from
> repo independently of the remote repo's existence.

Cloned repositories from your repository can say where they get from
"another_project" embedded in it in .git/config of the clone of the
superproject. The supermodule may have .gitmodules that points at github
or whereever your original upstream repository resided, but that is
supposed to be used to only give you the default.

When "another_project" you borrowed really dies and becomes useless for
anybody, you may update its entry in .gitmodules of the superproject to
point at the public repository that inherited that submodule project.
The project might be simply abandoned, in which case you end up being
that inheritor.
