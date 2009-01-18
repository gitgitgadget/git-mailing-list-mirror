From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http-push: remove MOVE step after PUT when sending
 objects to server
Date: Sun, 18 Jan 2009 13:43:25 -0800
Message-ID: <7vvdscthmq.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>
 <7viqod5thi.fsf@gitster.siamese.dyndns.org>
 <be6fef0d0901171919ub28dda7ref6443abec3627aa@mail.gmail.com>
 <alpine.DEB.1.00.0901181425420.3586@pacific.mpi-cbg.de>
 <7vocy4wfb2.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182214180.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOfRx-00043Q-NX
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbZARVnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbZARVnd
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:43:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbZARVnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:43:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D3F5911BD;
	Sun, 18 Jan 2009 16:43:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 92A40911BC; Sun,
 18 Jan 2009 16:43:27 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901182214180.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 18 Jan 2009 22:14:44 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0CA99564-E5A9-11DD-BCB5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106289>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 18 Jan 2009, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Which unfortunately means that put && move must stay.
>> 
>> I still do not understand why it is unfortunate.
>
> Because it is slow.

If "slow" is a problem, why are you using http to begin with ;-)?

I'd take slow but reliable any day over fast and mostly works but
unreliable.
