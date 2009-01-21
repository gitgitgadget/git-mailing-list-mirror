From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unmerged flag at git diff-index
Date: Tue, 20 Jan 2009 18:40:35 -0800
Message-ID: <7vbpu1js9o.fsf@gitster.siamese.dyndns.org>
References: <1976ea660901201813r7b03525ax39fd0e1ecfb1700e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 03:42:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPT2c-0001Cs-DW
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 03:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbZAUCkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 21:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbZAUCkl
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 21:40:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZAUCkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 21:40:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 21C2092A38;
	Tue, 20 Jan 2009 21:40:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 507A792A37; Tue,
 20 Jan 2009 21:40:37 -0500 (EST)
In-Reply-To: <1976ea660901201813r7b03525ax39fd0e1ecfb1700e@mail.gmail.com>
 (Frank Li's message of "Wed, 21 Jan 2009 10:13:30 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E4238A6A-E764-11DD-B948-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106559>

Frank Li <lznuaa@gmail.com> writes:

> There are conflict when I call git merge
> git ls-files -u
> 100644 54d05e1c40c686027b611b702e014284e9ab9a31 1       a.c
> 100644 a8a1b77c0d92f33491a0a69a8645f02ececb1eb6 2       a.c
> 100644 642ba972b2234f63048abcca544b3926f94e04ee 3       a.c
>
> but when use git diff-index HEAD
> :100644 100644 a8a1b77c0d92f33491a0a69a8645f02ececb1eb6 0000000000000000000000
> 0000000000000000 M      a.c
>
> a.c flag is M: Modification of the contents or mode of a file.

That is correct.

By asking "git diff-index HEAD", you are asking to compare the work tree
contents through the index against HEAD commit.  The work tree path by
definition cannot be "unmerged" as there is no stages in the work tree.

"git diff-index --cached HEAD" would compare the index against the HEAD
commit, and would say it is unmerged.
