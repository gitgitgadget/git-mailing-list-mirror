From: Junio C Hamano <gitster@pobox.com>
Subject: Re: symbolic link management in git-archive
Date: Thu, 27 Mar 2008 09:31:23 -0700
Message-ID: <7v3aqcb02s.fsf@gitster.siamese.dyndns.org>
References: <loom.20080327T112740-539@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:32:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jev1U-0000vM-SC
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 17:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407AbYC0Qbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 12:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758363AbYC0Qbd
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 12:31:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758280AbYC0Qbc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 12:31:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 800EE5289;
	Thu, 27 Mar 2008 12:31:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D2E7D5287; Thu, 27 Mar 2008 12:31:26 -0400 (EDT)
In-Reply-To: <loom.20080327T112740-539@post.gmane.org> (Sergio Callegari's
 message of "Thu, 27 Mar 2008 11:29:28 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78353>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> I guess the answer is "no" or "not yet", but is there a way to tell the zip
> backend of git-archive to follow symbolic links rather than to store them?

I am not sure what you mean.  Are you tracking a symbolic link X that
points at Y in your revision and expecting git-archive to include whatever
happens to be at Y (which may or may not even exist) when you run the
command?

If that is the case, the answer is "no" and "will never happen".  If you
are tracking a symbolic link X that points at Y, the information git
tracks is the fact that there is a symbolic link X that points at Y, and
not what Y happens to look like at a random moment.  Change to Y is not
tracked by git so why should you get different output from git-archive of
the same revision before and after you modify Y which is not part of the
revision to begin with?

If that is not what you are asking, please restate the question.
