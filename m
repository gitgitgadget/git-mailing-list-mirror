From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: make match_refs() copy src ref before
 assigning to peer_ref
Date: Mon, 23 Feb 2009 22:17:44 -0800
Message-ID: <7vfxi4mk8n.fsf@gitster.siamese.dyndns.org>
References: <7vzlgcmsan.fsf@gitster.siamese.dyndns.org>
 <1235448334-36310-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 07:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbqee-0002l5-Sq
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZBXGRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbZBXGRw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:17:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZBXGRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:17:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E7FC9C230;
	Tue, 24 Feb 2009 01:17:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0EB109C22E; Tue,
 24 Feb 2009 01:17:45 -0500 (EST)
In-Reply-To: <1235448334-36310-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 23 Feb 2009 23:05:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DC40ECFC-023A-11DE-911E-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111219>

Jay Soffian <jaysoffian@gmail.com> writes:

> This issue has gone undetected as the existing callers of match_heads()
> call it only once and then terminate, w/o ever bothering to free the src
> or dst lists.

Thanks.

It sounds more like existing function and usage was alright but your new
caller made it into an issue.

So I'd queue this as the first patch in the 13-patch series, dropping 10/13?
What should happen to 11/13?
