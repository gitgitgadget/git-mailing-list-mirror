From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Make old sha1 optional with git update-ref -d
Date: Mon, 02 Jun 2008 22:51:33 -0700
Message-ID: <7vk5h73w2i.fsf@gitster.siamese.dyndns.org>
References: <20080602233244.26087.51827.stgit@yoghurt>
 <20080602233453.26087.52259.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 07:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3PSF-0006eG-Rd
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 07:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbYFCFvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 01:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYFCFvs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 01:51:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbYFCFvr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 01:51:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6411B37EA;
	Tue,  3 Jun 2008 01:51:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0A2137E9; Tue,  3 Jun 2008 01:51:43 -0400 (EDT)
In-Reply-To: <20080602233453.26087.52259.stgit@yoghurt> (Karl =?utf-8?Q?Ha?=
 =?utf-8?Q?sselstr=C3=B6m's?= message of "Tue, 03 Jun 2008 01:34:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26BB4074-3131-11DD-A667-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83619>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> Giving the old sha1 is already optional when changing a ref, and it's
> quite handy when running update-ref manually. So make it optional for
> deleting a ref too.
>
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

"Handy" is not a very good reason when talking about plumbing command l=
ike
update-ref that takes an extra parameter for safety of the last step in
read, operate, verify-and-update sequence.

Although it is not a reason _bad enough_ to make your patch a bad idea,
perhaps you should rethink the problem at the same time?  Whatever you =
are
trying to do cannot be done without manually invoking update-ref direct=
ly
by the end user, perhaps that needs to be addressed?
