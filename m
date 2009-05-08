From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix sample update hook, disable overwriting of existing tags
Date: Thu, 07 May 2009 17:05:49 -0700
Message-ID: <7vzldobgrm.fsf@alter.siamese.dyndns.org>
References: <20090507164023.GB5807@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 08 02:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2DbE-00087i-8A
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 02:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbZEHAFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 20:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbZEHAFu
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 20:05:50 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53282 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZEHAFu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 20:05:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508000549.VYCE17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 7 May 2009 20:05:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id oo5p1b00B4aMwMQ04o5pdh; Thu, 07 May 2009 20:05:50 -0400
X-Authority-Analysis: v=1.0 c=1 a=DDZ8OFPOQrIA:10 a=24aJhmwt_BcA:10
 a=Y7828TS4AAAA:8 a=YeKHguMFrNvrlW_G2kQA:9 a=F6MS-xbsimFycrd5m-rvi49GmTMA:4
 a=IUdvcfx5MVUA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118548>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Because no special rule for this existed it was allowed by default

I do not disagree that it is a good thing to be able to reject
overwriting, but I do not think it is a _fix_.  allowdeletetag is about
_deletion_ and it already is covered by the code, isn't it?

I think it would make more sense to introduce $allowmodifytag and reject
such pushes in the codepath you touched.
