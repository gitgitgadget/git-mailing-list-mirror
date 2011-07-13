From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2011, #01; Wed, 6)
Date: Wed, 13 Jul 2011 15:12:35 -0700
Message-ID: <7vd3hd6d9o.fsf@alter.siamese.dyndns.org>
References: <7vpqlmhoi0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 00:12:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh7ff-00064c-1c
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 00:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab1GMWMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 18:12:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1GMWMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 18:12:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 836D15198;
	Wed, 13 Jul 2011 18:12:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CQgDf721TpABNfRaxcO1XQcNg1w=; b=byUQUF
	91BKjxhmOwG67NgR3pFzvgyZUG/Xo0YHAEznhxCeSnJL+4SMZllCjrvtydlquZBp
	ALKZOBVd8Yz8i/iZB/PHSATmYFSta3dRzvjo0M8Wb9opxRzSCDMHq+XubUXUZ8HZ
	1aP5kTbwbeCoR/rLDWPy9xlIBxxsvJT7kv1K0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hicDZBmLBscgKJhY66TYfaQdI7PNXbfm
	2ixPI2U/BTGZp7I+ULJIdBh69eBiP/lJTb257dIM+yFd3Whz6YX2q31Z5AekSuBb
	+7/i5br3RIdtGJKCbWXn8UgnqzNQojQ3N/YloKzj9b0fIEYnWtOyZ1MszZJ6WaWM
	SeX5DoGY8UA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C0665197;
	Wed, 13 Jul 2011 18:12:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BF39E5196; Wed, 13 Jul 2011
 18:12:36 -0400 (EDT)
In-Reply-To: <7vpqlmhoi0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Jul 2011 18:24:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37276DDE-AD9D-11E0-B7EC-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177088>

Junio C Hamano <gitster@pobox.com> writes:

> * jk/clone-detached (2011-06-07) 4 commits
>  - clone: always fetch remote HEAD
>  - make copy_ref globally available
>  - consider only branches in guess_remote_head
>  - t: add tests for cloning remotes with detached HEAD
>
> Somewhat involved bugfix.
> Will merge to "next".

What is it in this series that causes t5800 to fail when merged to next, i.e.

$ sh t5800-remote-helpers.sh -i -v

expecting success: 
        git clone "testgit::${PWD}/server" localclone &&
        test_cmp public/file localclone/file

Cloning into localclone...
fatal: Got feature command 'relative-marks' after data command
fast-import: dumping crash report to /srv/project/git/git.git/t/trash
directory.t5800-remote-helpers/localclone/.git/fast_import_crash_16957
error: refs/remotes/origin/master does not point to a valid object!
error: Trying to write ref refs/heads/master with nonexistent object
0000000000000000000000000000000000000000
fatal: Cannot update the ref 'HEAD'.
not ok - 2 cloning from local repo
#
#               git clone "testgit::${PWD}/server" localclone &&
#               test_cmp public/file localclone/file
#

Stumped...
