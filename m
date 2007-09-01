From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag: Fix -l option to use better shell style globs.
Date: Fri, 31 Aug 2007 22:39:32 -0700
Message-ID: <7vd4x3uep7.fsf@gitster.siamese.dyndns.org>
References: <46D8F431.70801@gmail.com> <20070901053158.GF18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 07:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRLiM-00077q-0E
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 07:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbXIAFjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 01:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbXIAFjl
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 01:39:41 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbXIAFjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 01:39:40 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3DAE212AA5C;
	Sat,  1 Sep 2007 01:39:56 -0400 (EDT)
In-Reply-To: <20070901053158.GF18160@spearce.org> (Shawn O. Pearce's message
	of "Sat, 1 Sep 2007 01:31:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57254>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Carlos Rica <jasampler@gmail.com> wrote:
>> This patch removes certain behaviour of "git tag -l foo", currently
>> listing every tag name having "foo" as a substring.  The same
>> thing now could be achieved doing "git tag -l '*foo*'".
>
> Even though this is a behavior change, I think its the right thing
> to do.  The current behavior of searching "*$arg*" is downright
> annoying.

Yes, I concur.  It is very annoying that "git tag -l gui"
matches "gitgui-0.7.0".

Let's fix this.
