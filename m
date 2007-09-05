From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Significant performance waste in git-svn and friends
Date: Wed, 05 Sep 2007 13:40:42 -0700
Message-ID: <7vd4wwj16d.fsf@gitster.siamese.dyndns.org>
References: <20070905184710.GA3632@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 22:40:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT1gC-0001s5-Ek
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 22:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbXIEUkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756246AbXIEUkr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 16:40:47 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbXIEUkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 16:40:47 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 282A212F180;
	Wed,  5 Sep 2007 16:41:06 -0400 (EDT)
In-Reply-To: <20070905184710.GA3632@glandium.org> (Mike Hommey's message of
	"Wed, 5 Sep 2007 20:47:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57761>

Mike Hommey <mh@glandium.org> writes:

> The same things obviously apply to git-cvsimport and other scripts
> calling git-hash-object a lot.

I *obviously* hate this patch, as it makes this Porcelain
command to be aware of the internal representation too much.

I wonder if letting fast-import handle the object creation is an
option, though.
