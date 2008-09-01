From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: add ignore non-existent files option.
Date: Mon, 01 Sep 2008 16:04:19 -0700
Message-ID: <7v63pftqmk.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530809011501n651c42c8xebb5cc39a93aac4c@mail.gmail.com>
 <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 01:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaISj-0007ht-82
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 01:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbYIAXE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 19:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbYIAXE0
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 19:04:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYIAXEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 19:04:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A8D56F776;
	Mon,  1 Sep 2008 19:04:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ACA036F775; Mon,  1 Sep 2008 19:04:21 -0400 (EDT)
In-Reply-To: <1220308173-20392-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 2 Sep 2008 01:30:08 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51D00494-787A-11DD-B5A4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94624>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This is useful for SCMs that don't have proper changesets in each
> revision (monotone).

I am still not convinced this is a proper workaround for the issue.  Why
shouldn't the feeder of fast-import be able to do this?

> @@ -1993,8 +1994,15 @@ static void file_change_cr(struct branch *b, int rename)
> ...

Also what happened to the missing warning() for 'D'elete codepath?
