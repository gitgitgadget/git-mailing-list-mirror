From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-describe only works on full tags
Date: Sun, 16 Mar 2008 19:13:09 -0700
Message-ID: <7vhcf6cd3e.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0803170137300.14822@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Mon Mar 17 03:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb4rT-0005T7-9b
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 03:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbYCQCNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 22:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbYCQCNY
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 22:13:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYCQCNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 22:13:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4401C1C69;
	Sun, 16 Mar 2008 22:13:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6537C1C67; Sun, 16 Mar 2008 22:13:17 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0803170137300.14822@fbirervta.pbzchgretzou.qr>
 (Jan Engelhardt's message of "Mon, 17 Mar 2008 01:41:03 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77410>

Jan Engelhardt <jengelh@computergmbh.de> writes:

> For some reason, git-describe only prints a description relative to 
> the last tag that was a tag object (and not just a ref).
> This is kinda a bug to me, what do others think?

There is an option to tell git-describe to allow using non annotated
tags, but that is not a defult.

This is a very deliberate design decision.  Annotated tags are meant for
public consumption, but lightweight tags are often used to locally mark
points that are interesting during this current development session
(e.g. "I am trying to improve by first breaking and then enhancing, and
this one was the last-known working one"), and it is mighty annoying if
such a tag is used in describe output.
