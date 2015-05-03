From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] git help: group common commands by theme
Date: Sat, 02 May 2015 19:23:40 -0700
Message-ID: <xmqqk2wqwg9f.fsf@gitster.dls.corp.google.com>
References: <554405D5.9080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 04:23:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YojZM-0004Un-8S
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 04:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbbECCXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2015 22:23:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750966AbbECCXn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 May 2015 22:23:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 855374EA75;
	Sat,  2 May 2015 22:23:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FdiJc9IJpKvT
	N0Jm2QfEMgxqpZw=; b=jo8eDzJSnFD7Gxpc1ANAHF10dMQjsvZ46DFpLsmtxd8e
	cBQTGNVD+nlrSNhoW0R+DZCjndTVCBJXzHpfCq9O6PWL1CNdNXvpnaAEjRDreP41
	H+YBOxBEy0MPKmJBlwElnPi9bCJWs7K5eCHa8ub/0FiFzMe0/t6apSxjUk6OV5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uYABP1
	zFVfrQS/UTnC1YgF642PryDZNlEj088s7wr6ker3n4Z4DoRMlExJtTuy+GHdOQmO
	G70D7l6HxUqhsR3706m2X5CIkRpa47kGbjhk+TfxXhLkirpfxXj5JyMpvxtngxbv
	dl0xFVVjxQS5UknLYV0iAEmApbOM6mPl28NyY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DF1B4EA74;
	Sat,  2 May 2015 22:23:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC2DA4EA72;
	Sat,  2 May 2015 22:23:41 -0400 (EDT)
In-Reply-To: <554405D5.9080702@gmail.com> (=?utf-8?Q?=22S=C3=A9bastien?=
 Guimmara"'s message of
	"Sat, 02 May 2015 01:01:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6A7B61C8-F13B-11E4-8434-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268251>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

> Finally, list_common_cmds_help() prints those common commands by
> groups, skipping a line between each group:
>
> [...]
>
> The most commonly used git commands are:
>    clone      Clone a repository into a new directory
>    init       Create an empty Git repository or reinitialize an exist=
ing one
>
>    log        Show commit logs
>    show       Show various types of objects
>    status     Show the working tree status
>
>    add        Add file contents to the index
>    mv         Move or rename a file, a directory, or a symlink
>    reset      Reset current HEAD to the specified state
>    rm         Remove files from the working tree and from the index
>
>    fetch      Download objects and refs from another repository
>    pull       Fetch from and integrate with another repository or a l=
ocal branch
>    push       Update remote refs along with associated objects
>
>    commit     Record changes to the repository
>    diff       Show changes between commits, commit and working tree, =
etc
>    rebase     Forward-port local commits to the updated upstream head
>    tag        Create, list, delete or verify a tag object signed with=
 GPG

What is the target audience?  Are they expected to be familiar
enough with Git that they can guess what the above grouping is based
on without a group header?

I consider myself experienced enough with Git but cannot explain or
justify the placement of "diff" in the above list myself, for
example.  I'd say

 * starting a working area (clone, init)
 * examining the history and state (log, show, status, diff)
 * working on the current change (add, checkout, reset)
 * growing, marking and tweaking your history (commit, tag, rebase)
 * working with others (fetch, pull, push)

might be a more sensible presentation order (and classification).
