From: Junio C Hamano <gitster@pobox.com>
Subject: Re: format-patch: numbered patches from a patch list?
Date: Tue, 21 Jul 2009 19:43:57 -0700
Message-ID: <7vtz15wi6q.fsf@alter.siamese.dyndns.org>
References: <auto-000020035874@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tfogal@sci.utah.edu
X-From: git-owner@vger.kernel.org Wed Jul 22 04:44:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTRoR-00087I-LE
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 04:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbZGVCoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 22:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbZGVCoD
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 22:44:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZGVCoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 22:44:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7737BDCB6;
	Tue, 21 Jul 2009 22:44:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 723B9DCB5; Tue, 21 Jul 2009
 22:43:59 -0400 (EDT)
In-Reply-To: <auto-000020035874@sci.utah.edu> (tom fogal's message of "Tue\,
 21 Jul 2009 20\:25\:52 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83EAC6BA-7669-11DE-8F2D-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123734>

tom fogal <tfogal@alumni.unh.edu> writes:

> I have a need to generate a numbered sequence of patches from a sparse
> sprinkling of patches on a branch.  Is there a way to accomplish this?
>
> Basically I want to say, `for the patches at the heads of these sha1s,
> give me a numbered sequence.'  Currently I take the list of shas that I
> want, throw them in a file, and loop over each entry:
>
>   for sha in $(cat patches) ; do git format-patch -o a/ ${sha}^..${sha} ; done

You can pass --start-number to these invocations of format-patch; maintain
the parameter to give as an argument to the option inside your loop.
