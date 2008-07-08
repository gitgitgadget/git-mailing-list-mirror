From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add branch options --contains --merged
 --no-merged
Date: Mon, 07 Jul 2008 22:30:17 -0700
Message-ID: <7vprppvt7a.fsf@gitster.siamese.dyndns.org>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com>
 <20080708044922.GD2542@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, szeder@ira.uka.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 07:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG5nR-0001mt-HL
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 07:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbYGHFa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 01:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbYGHFa1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 01:30:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYGHFa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 01:30:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE6FC28870;
	Tue,  8 Jul 2008 01:30:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1ACD72886D; Tue,  8 Jul 2008 01:30:19 -0400 (EDT)
In-Reply-To: <20080708044922.GD2542@spearce.org> (Shawn O. Pearce's message
 of "Tue, 8 Jul 2008 04:49:22 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F751A6F4-4CAE-11DD-B073-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87716>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Eric Raible <raible@gmail.com> wrote:
>> Signed-off-by: Eric Raible <raible@gmail.com>
>
> Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
> ;-)
>
> More completion support that probably should go to maint, as the
> functionality in git-branch is in 1.5.6 but we (again) forgot to
> make sure the completion was up-to-date prior to release.

I am actually getting more worried about completion code getting larger
and larger without its performance impact not being looked at nor
addressed adequately.  In my regular working tree:

	$ echo Docu<TAB>

completes "mentation/" instantly, but:

	$ git log -- Docu<TAB>

takes about 1.5 to 2 seconds to complete the same.
