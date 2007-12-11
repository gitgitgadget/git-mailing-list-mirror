From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Something is broken in repack
Date: Mon, 10 Dec 2007 18:55:26 -0800
Message-ID: <7vlk82hrdt.fsf@gitster.siamese.dyndns.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	<9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 03:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1vIK-0007Xi-79
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 03:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbXLKC4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 21:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbXLKC4E
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 21:56:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbXLKC4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 21:56:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 53915215A;
	Mon, 10 Dec 2007 21:55:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DCBA42154;
	Mon, 10 Dec 2007 21:55:32 -0500 (EST)
In-Reply-To: <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	(Jon Smirl's message of "Mon, 10 Dec 2007 21:25:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67779>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> 95%   530  2.8G - 1,420 total to here, previous was 1,983
> 100% 1390 2.85G
> During the writing phase RAM fell to 1.6G
> What is being freed in the writing phase??

entry->delta_data is the only thing I can think of that are freed
in the function that have been allocated much earlier before entering
the function.
