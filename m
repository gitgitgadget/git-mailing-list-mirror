From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 12:10:30 -0800
Message-ID: <7vska01qrt.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:10:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXgt5-0005TE-J9
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351Ab0ATUKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336Ab0ATUKj
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:10:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0ATUKi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 15:10:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4052B925F6;
	Wed, 20 Jan 2010 15:10:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b1wgVTJDck0YpEfwkJ79DPZmk1g=; b=Y9oGC8
	Yh8y/jjteEF6QL3QATRIB7CYQ4JD/8Md2Ht34JV4w8KEWbcMOC4zNU2mskDKTvD7
	eYU1bfefTWNkyxhs/8scypYw9pnx2B0c9Ke6j3xcmGEwChnmTlgZFz1r5ET7kCdD
	GhKzpU/9WqOt8Z6yT8N7J6kCo7u2ZrttkMeOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YOxETL+cszvHk+Yg+cbNkEjg8AD70P1P
	UFFNr1bX2jaSKVCrs8pJ8XuQBDlbB11E8tNzTV+QkopDz4Fz6AHlxot0W8tmoYSI
	F0HSJ04hCCRM4n5ywKgnKpNZvTdRDVi8AAHZ7OdRItRaQgxU67GEejsjHRg6vaX9
	llCL93vhbSg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18BD5925F0;
	Wed, 20 Jan 2010 15:10:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C284925EE; Wed, 20 Jan
 2010 15:10:32 -0500 (EST)
In-Reply-To: <20100120195626.GA6641@gnu.kitenet.net> (Joey Hess's message of
 "Wed\, 20 Jan 2010 14\:56\:26 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE691BFC-05FF-11DF-84F9-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137567>

Joey Hess <joey@kitenet.net> writes:

> Do you think it makes sense for even git log --format=format:%s to be
> porcelain and potentially change when new features are used?

If the series changed the meaning of "%s" format to mean "the subject of
the commit and notes information", with or without documenting it, then it
is just a bug we would like to fix.

But I cannot reproduce such a bug.  In my tree locally:

    $ git notes show a97a74
    Origin of commit notes feature was at
    a97a74).
    $ git show -s --pretty=short a97a74
    commit a97a74686d70a318cd802003498054cc1e8b0ae2
    Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>

        Introduce commit notes

    Notes:
        Origin of commit notes feature was at
        a97a74).
    $ git show -s --pretty=format:%s a97a74
    Introduce commit notes

Puzzled...
