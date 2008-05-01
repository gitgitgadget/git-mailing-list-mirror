From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 2/7] add push line in git-clone
Date: Wed, 30 Apr 2008 23:28:39 -0700
Message-ID: <7vve1yzgfc.fsf@gitster.siamese.dyndns.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org>
 <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org>
 <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 01 08:29:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrSIX-000493-SV
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 08:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbYEAG2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 02:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbYEAG2z
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 02:28:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYEAG2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 02:28:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E725A32D2;
	Thu,  1 May 2008 02:28:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 22A9D32CF; Thu,  1 May 2008 02:28:44 -0400 (EDT)
In-Reply-To: <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org>
 (Paolo Bonzini's message of "Mon, 28 Apr 2008 11:32:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD9FE6B8-1747-11DD-B93B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80891>

Paolo Bonzini <bonzini@gnu.org> writes:

> This patch makes git-clone add a remote.origin.push line, using the
> new ":" special refspec.  This is useful in the following patches that
> modify the behavior of "git push"; right now, it only adds clarity.

Used together with [1/7], this change is Ok in a homogeneous environment,
but it would break people who use git of different vintage on the same
repository (think of a repository on a networked filesystem).  You clone
like this, and older git won't grok the push configuration anymore.

It may look a very minor point, but I think it deserves mentioning.
