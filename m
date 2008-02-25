From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] builtin-fsck: reports missing parent commits
Date: Sun, 24 Feb 2008 19:08:52 -0800
Message-ID: <7vlk59pwaj.fsf@gitster.siamese.dyndns.org>
References: <12038867362489-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 25 04:09:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTTir-0003ox-Qk
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 04:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbYBYDJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 22:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbYBYDJH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 22:09:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbYBYDJG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 22:09:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52F2A15B6;
	Sun, 24 Feb 2008 22:09:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7A7E415B5; Sun, 24 Feb 2008 22:09:00 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74987>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>

As far as I can tell, the new test is not testing the commit
object we are looking at from the object database.  What it is
testing is if the code that parsed and prepared the information
in "struct commit" found the same number of parents an extra
check we are doing here by hand (if not grafted --- but
presumably whoever gave the struct commit we are handling here
would have obtained that information by doing the same parsing),
or the parsing of the graft file (when grafted --- but
presumably whoever gave the struct commit we are handling here
would have obtained that information by calling the same
llokup_commit_graft()).

So I am not sure what problems in the repository objects these
new checks are designed to catch.

This needs a lot of explanation than what's in your commit log
message.
