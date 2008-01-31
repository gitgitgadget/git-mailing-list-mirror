From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] generic issue with git_config handlers
Date: Thu, 31 Jan 2008 01:25:32 -0800
Message-ID: <7v1w7ye48j.fsf@gitster.siamese.dyndns.org>
References: <20080131091627.GB24403@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVgb-00005C-HG
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbYAaJZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbYAaJZp
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:25:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbYAaJZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:25:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 730832B4E;
	Thu, 31 Jan 2008 04:25:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 064BA2B4C;
	Thu, 31 Jan 2008 04:25:39 -0500 (EST)
In-Reply-To: <20080131091627.GB24403@artemis.madism.org> (Pierre Habouzit's
	message of "Thu, 31 Jan 2008 10:16:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72111>

Pierre Habouzit <madcoder@debian.org> writes:

>   One of my co-workers stumbled upon a misfeature of the git config
> parser. The following syntax is allowed:
>
>     [section]
> 	 foo

Yeah, that is how "truth" value of boolean is spelled.

> [user]
>     name

That's very unfortunate.  Whatever is expecting string value
should check for NULL.  Fix should probably be easy enough for
any git-hacker-wannabe to tackle ;-)
