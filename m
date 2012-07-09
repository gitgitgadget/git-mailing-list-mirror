From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow edit of empty message with commit --amend
Date: Mon, 09 Jul 2012 12:43:54 -0700
Message-ID: <7vliisk9dx.fsf@alter.siamese.dyndns.org>
References: <20120709142437.GQ13885@arachsys.com>
 <7v7guclucl.fsf@alter.siamese.dyndns.org>
 <20120709181754.GE23859@arachsys.com> <20120709185326.GF23859@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 21:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoJsI-00027O-U6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 21:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab2GITn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 15:43:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260Ab2GITn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 15:43:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE8AB8017;
	Mon,  9 Jul 2012 15:43:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bGn2oxKzD0n5m0BZUezUSVdlrY=; b=t/JqsV
	J3JWdZ8om8qYZSmwAqMzk8xhbUpsILSU7ThJ0uh9FM1LcGBoJEQ0JFUcGj8XrV3e
	QWllC3x1WBrZ18/qzsUMc7l7RRimo5rL4PTFL3Zdbz/oNX46qSxFjuTwkRM1o3fT
	0PmlfIgvGWVI1qDr2yIdl4tLAGgO20K3dUORY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lo0ER69Ap6Yugrn5qzFHXwApMXLX3qch
	lSOOv3FiXv7xarEuUTUomX5ZkQlz4fd9mvljmBiJCrFvZvZHPQvob097mJ0Ia3Cp
	igObiizo9rwNF+B/WZdP5ai3bCiQjE2T8KmB5DYyohg6bnLxreaz5wBl8LfNcxbJ
	uv9cdZkJNpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB8D38015;
	Mon,  9 Jul 2012 15:43:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 377508014; Mon,  9 Jul 2012
 15:43:56 -0400 (EDT)
In-Reply-To: <20120709185326.GF23859@arachsys.com> (Chris Webb's message of
 "Mon, 9 Jul 2012 19:53:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BA06AA6-C9FE-11E1-853F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201221>

Chris Webb <chris@arachsys.com> writes:

> If git commit --amend is used on a commit with an empty message, it fails
> unless -m is given, whether or not --allow-empty-message is specified.
>
> Instead, allow it to proceed to the editor with an empty commit message.
> Unless --allow-empty-message is in force, it will still abort later if an
> empty message is saved from the editor. (This check was already necessary
> to prevent a non-empty commit message being edited to an empty one.)
>
> Add a test for --amend --edit of an empty commit message which fails
> without this fix, as it's a rare case that won't get frequently tested
> otherwise.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>

Thanks.
