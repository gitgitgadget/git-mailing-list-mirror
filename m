From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: fix quoting TRIED revs when "bad" commit is also
 "skip"ped
Date: Fri, 27 Feb 2009 14:34:33 -0800
Message-ID: <7vmyc7ik5i.fsf@gitster.siamese.dyndns.org>
References: <20090226082918.6adbc565.chriscool@tuxfamily.org>
 <200902270730.56998.chriscool@tuxfamily.org>
 <7v3ae0mfob.fsf@gitster.siamese.dyndns.org>
 <200902272205.10501.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 23:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdBJS-0001po-8N
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 23:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758182AbZB0Wem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 17:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757636AbZB0Wem
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 17:34:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbZB0Wel (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 17:34:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B0A139C0CB;
	Fri, 27 Feb 2009 17:34:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AB7DF9C0C9; Fri,
 27 Feb 2009 17:34:35 -0500 (EST)
In-Reply-To: <200902272205.10501.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 27 Feb 2009 22:05:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1572FB8-051E-11DE-B21D-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111723>

Christian Couder <chriscool@tuxfamily.org> writes:

> So you should perhaps squash the following hunk to the patch:
> ...
> as this will string the commands together when there are no skipped commits 
> too.

Ok, good eyes.

Even though this part is directly from rev-list --bisect-vars and is much
less likely to be malformed than the list of commands filter_skipped
function produces, I agree it is a good discipline to protect it from the
breakage the same way.

Thanks.
