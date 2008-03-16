From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver: handle change type T
Date: Sun, 16 Mar 2008 14:21:24 -0700
Message-ID: <7v63vmicvf.fsf@gitster.siamese.dyndns.org>
References: <E1Jay7s-0000dO-IX@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, beuc@gnu.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:22:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb0J5-0000b9-Am
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 22:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbYCPVVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 17:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbYCPVVg
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 17:21:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbYCPVVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 17:21:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E416140F;
	Sun, 16 Mar 2008 17:21:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2A782140E; Sun, 16 Mar 2008 17:21:29 -0400 (EDT)
In-Reply-To: <E1Jay7s-0000dO-IX@fencepost.gnu.org> (Paolo Bonzini's message
 of "Sun, 16 Mar 2008 20:00:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77387>

Paolo Bonzini <bonzini@gnu.org> writes:

> git-cvsserver does not support changes of type T (file type change,
> e.g. symlink->real file).  This patch treats them the same as changes
> of type M.

Hmm.

Do cvs clients even know how to handle symlinks, or will this patch just
start sending the readlink(2) result as if it is just a regular file
contents?
