From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG?] git-cvsimport: path to cvspsfile
Date: Thu, 24 Sep 2009 07:59:43 +0200
Message-ID: <4ABB0ACF.5040508@viscovery.net>
References: <20090923182756.GA12430@onyx.camk.edu.pl> <20090923191428.GA30104@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 24 07:59:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqhMt-0006s2-RY
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 07:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbZIXF7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 01:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbZIXF7n
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 01:59:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50791 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbZIXF7m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 01:59:42 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MqhMm-00035E-3v; Thu, 24 Sep 2009 07:59:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F2D8B4E4; Thu, 24 Sep 2009 07:59:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20090923191428.GA30104@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129020>

Jeff King schrieb:
> Bug. The script does a chdir() and then looks at the cvspsfile later. I
> think "-A" would have the same problem. Here is a totally untested patch
> to address the issue. Johannes, will this is_absolute_path actually work
> on Windows? I think The Right Way would be to use
> File::Spec::file_name_is_absolute, but I haven't checked whether that is
> part of core perl and if so, which version it appeared in.

We have File::Spec::file_name_is_absolute in the msysgit installation. I
suggest you use it. It sounds like a very basic feature, and I'd be
surprised if it were not part of core perl.

-- Hannes
