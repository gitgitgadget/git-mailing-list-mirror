From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path"
 config var
Date: Tue, 18 Mar 2008 12:02:43 -0700
Message-ID: <7vabkv7t4c.fsf@gitster.siamese.dyndns.org>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:32:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc40x-0006jn-A2
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYCST0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753743AbYCST01
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:26:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbYCSTZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:25:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 484D6164A;
	Tue, 18 Mar 2008 15:02:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EFC261645; Tue, 18 Mar 2008 15:02:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77509>

Christian Couder <chriscool@tuxfamily.org> writes:

> This makes it possible to use different version of the tools
> than the one on the current PATH, or maybe a custom script.
>
> In this patch we also try to launch "konqueror" using
> "kfmclient" even if a path to a konqueror binary is given
> in "man.konqueror.path".

It may be true that allowing customizable paths may be more useful than
not allowing them, so I do not have fundamental objection to this
enhancement.  However, I doubt this s/konqueror/kfmclient/ is a good idea.

As a general rule, if you allow the user to explicitly say "instead of
what you would normally use, use _this_", you should not try to outsmart
the user by using something else that you derived from that "_this_" the
user gave you.

If the user wants to use kfmclient, then the user can say so.  If the user
wants to really launch konq instead of using kfmclient for whatever
reason, the outsmarting code will interfere and make it impossible.
