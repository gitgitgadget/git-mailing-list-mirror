From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] technical-docs: document tree-walking API
Date: Wed, 29 Jul 2009 01:25:05 -0700
Message-ID: <7vtz0vyjz2.fsf@alter.siamese.dyndns.org>
References: <1248844995-13769-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4TY-0006nd-Tx
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbZG2IZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbZG2IZN
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:25:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbZG2IZL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 04:25:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB00C151CC;
	Wed, 29 Jul 2009 04:25:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0F2E151CB; Wed, 29 Jul 2009
 04:25:07 -0400 (EDT)
In-Reply-To: <1248844995-13769-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Tue\, 28 Jul 2009 22\:23\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54EE95AC-7C19-11DE-8D9F-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124321>

Stephen Boyd <bebarino@gmail.com> writes:

> Some things to get you started:
>
>       - the traversal callback mask parameter
> 	- a better general usage description at the top
> 	- add an authors section?

Thanks.

> diff --git a/Documentation/technical/api-tree-walking.txt b/Documentation/technical/api-tree-walking.txt
> index e3ddf91..baa382d 100644

> +* `mask` has its nth bit set if the nth tree's entry is valid. (or different?)

nth bit is set when something exists in that tree at the path (entry[nth]
could be either a file (regular or symlink) or a directory).

> +* `dirmask` has its nth bit set if the nth tree's entry is a directory.

Correct.

> +* `entry` is an array of size `n` where the nth entry is from the nth tree.
> +
> +* `info` maintains the state of the traversal.
> +
> ++
> +Returning a negative value will terminate the traversal. Otherwise the
> +return value is treated as an update mask. If the nth bit is set the nth tree
> +will be updated and if the bit is not set the nth tree entry will be the
> +same in the next callback invocation.

Correct.
