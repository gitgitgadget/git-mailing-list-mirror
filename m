From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] get_pathspec(): die when an out-of-tree path is given
Date: Fri, 07 Mar 2008 10:51:00 -0800
Message-ID: <7vskz21i7f.fsf@gitster.siamese.dyndns.org>
References: <1204879119-7528-1-git-send-email-gitster@pobox.com>
 <1204879119-7528-2-git-send-email-gitster@pobox.com>
 <200803071929.42499.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:52:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhfY-0008Sy-AG
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761006AbYCGSvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760945AbYCGSvI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:51:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760727AbYCGSvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:51:07 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3C483FB0;
	Fri,  7 Mar 2008 13:51:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4ECA63FAF; Fri,  7 Mar 2008 13:51:03 -0500 (EST)
In-Reply-To: <200803071929.42499.robin.rosenberg@dewire.com> (Robin
 Rosenberg's message of "Fri, 7 Mar 2008 19:29:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76516>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> My gcc refuses to cooperate, giving me SEGV at line 666 or combine-diff, so 
> I'll ask instead of testing.
>
> Do absolute paths to diff still work without exiting?

They should, as long as they name inside work tree paths.

As far as I know, the bolted-on "work on files outside" code does not feed
the paths to get_pathspec() (and it shouldn't --- that mode is not a git
operation to begin with, and should work even without having a work tree,
so there is no valid base to make the paths relative to).

But it needs to be checked.

