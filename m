From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hash-object: don't rely on order of --stdin, -w arguments
Date: Wed, 13 Feb 2008 11:50:41 -0800
Message-ID: <7v7ih8pre6.fsf@gitster.siamese.dyndns.org>
References: <20080213190338.7393.qmail@d70c5cbe18d4bd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:51:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPNdx-0004Pq-W6
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 20:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbYBMTvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 14:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYBMTvL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 14:51:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbYBMTvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 14:51:09 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 450D63BAF;
	Wed, 13 Feb 2008 14:50:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 CC85E3BA5; Wed, 13 Feb 2008 14:50:48 -0500 (EST)
In-Reply-To: <20080213190338.7393.qmail@d70c5cbe18d4bd.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Wed, 13 Feb 2008 19:03:38 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73816>

Gerrit Pape <pape@smarden.org> writes:

> Fix 'git hash-object --stdin -w' to actually write the object, just as
> 'git hash-object -w --stdin' does.

Can we have additions to the test scripts to illustrate:

 - what used to happen if you had "--stdin -w" on the command
   line (presumably you did not get the object written, which is
   a buggy behaviour and the patch should fix it);

 - what used to happen if you had "-w --stdin --stdin" on the
   command line (I imagine you used to be able to feed two
   separate streams when you are on a terminal by typing ^Ds in
   between?);

 - any other combination that may deserve testing.

in order to (1) show existing bugs the patch is trying to
address, (2) demonstrate that the patch fixes them without
regressing, and (3) protect the fix from being broken by future
changes, pretty please?
