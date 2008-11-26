From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git checkout: don't warn about unborn branch if -f is
 already passed
Date: Wed, 26 Nov 2008 11:46:42 -0800
Message-ID: <7vr64yfexp.fsf@gitster.siamese.dyndns.org>
References: <1227509722.32583.0.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 20:48:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5QN8-0005I8-Mh
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 20:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbYKZTrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 14:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYKZTrA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 14:47:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbYKZTrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 14:47:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 157B481FD9;
	Wed, 26 Nov 2008 14:46:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F05FA81FD7; Wed,
 26 Nov 2008 14:46:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FCEB8BBC-BBF2-11DD-9BC1-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101762>

Matt McCutchen <matt@mattmccutchen.net> writes:

> I think it's unnecessary to warn that the checkout has been forced due to an
> unborn current branch if -f has been explicitly passed.  For one project, I am
> using git-new-workdir to create workdirs from a bare repository whose HEAD is
> set to an unborn branch, and this warning started to irritate me.

I doubt anybody minds this particular change per-se, but I wonder what the
justification of keeping a dangling HEAD in a bare repository is.

After all, the primary intended purpose of a bare repository is to serve
as a distribution point (i.e. something you can clone from), and I think a
dangling HEAD interferes with the usual operation of clone (although I've
never tested this).

Care to explain why?
