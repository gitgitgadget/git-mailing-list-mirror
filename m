From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using test-lib.sh under GPLv3?
Date: Tue, 16 Feb 2010 12:54:19 -0800
Message-ID: <7vaav8hpfo.fsf@alter.siamese.dyndns.org>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
 <87hbpwpoko.fsf@yoom.home.cworth.org>
 <5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com>
 <201002081614.24284.sojkam1@fel.cvut.cz>
 <871vgr78lr.fsf@yoom.home.cworth.org> <87iqa2y0gz.fsf@steelpick.localdomain>
 <87r5oqe7mi.fsf@yoom.home.cworth.org> <871vgmki4f.fsf@steelpick.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, notmuch@notmuchmail.org,
	git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:54:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhURN-0002kH-5d
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 21:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277Ab0BPUyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 15:54:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242Ab0BPUyb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 15:54:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3246B9AC6E;
	Tue, 16 Feb 2010 15:54:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dvqQ7+2oxytvVMsfvFj9Orrvims=; b=RpoD5N
	Rwxwr3zpaeXxsYy+M1lPntTLvkeGzpgOWq5OVkIDM+S47PbCiCvYkmIfXV3HzsJJ
	HkVTkoosNHDBnwY4/GBre+iXIUbh/RO9T1CCINkAlxgYlLFK8l57eLtXkjAPmNbS
	0KVfjYxZLXoUAG2fvWu8B2qMWtk6VR/87bAyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ylu2MarljZdYp2B/RPnWm6JfT2Ro3E8t
	uMpb5xdoymCEfLAIGJBatNHYmReK2FMkIbzdDNDuZ10NvQzwt7IMQ7eySuLwiuLc
	nD51Z7uPhQn1l/HeCPUNZqgLxCg8+yT6YyrZ3Fy3uyOsakswY4AtwUBxxL/50yxb
	8bTxf0dMVGU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E41069AC62;
	Tue, 16 Feb 2010 15:54:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA2B99AC5E; Tue, 16 Feb
 2010 15:54:20 -0500 (EST)
In-Reply-To: <871vgmki4f.fsf@steelpick.localdomain> (Michal Sojka's message
 of "Mon\, 15 Feb 2010 09\:39\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 77AAC9EE-1B3D-11DF-B803-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140156>

Michal Sojka <sojkam1@fel.cvut.cz> writes:

> ... You are mentioned
> as a copyright holder in test-lib.sh and t0000-basic.sh so I'd like to
> ask you: Would you mind using parts of these files under GPLv3?

I don't mind for the parts I wrote, which is the basic infrastructure
(output redirection, skipping certain tests, expecting failure, etc).
My blessing would be enough to relicense it if you are are going to take
the file from some old version like 04ece59 (GIT_SKIP_TESTS: allow users
to omit tests that are known to break, 2006-12-28) and base your work on
it, but otherwise it would not be nearly sufficient.

Other people worked on polishing it over time and they all hold copyright
on their parts.  Notable parts that are not mine and that are not git
specific are:

 - color output support is mostly by Pierre Habouzit <madcoder@debian.org>
 - valgrind support: Johannes Schindelin <johannes.schindelin@gmx.de>
 - conditional test: Johannes Sixt <j6t@kdbg.org>
 - summarizing the results: Sverre Rabbelier <srabbelier@gmail.com>
