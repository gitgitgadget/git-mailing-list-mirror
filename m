From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v13 00/11] Add interpret-trailers builtin
Date: Mon, 15 Sep 2014 08:04:29 +0200 (CEST)
Message-ID: <20140915.080429.1739849931027469667.chriscool@tuxfamily.org>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
	<xmqqk35kwfvy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, jnareb@gmail.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	jrnieder@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 15 08:04:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTPOt-000257-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 08:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbaIOGEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 02:04:32 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:61843 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbaIOGEb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 02:04:31 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 62A9173;
	Mon, 15 Sep 2014 08:04:29 +0200 (CEST)
In-Reply-To: <xmqqk35kwfvy.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257046>

From: Junio C Hamano <gitster@pobox.com>

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>>   '=' is always accepted as separator when parsing
>>   "--trailer '<token><sep><value>'" command line arguments, for
>>   compatibility with other git commands
> 
> Hmph.  Which of other commands take "--option foo=bar"?
> 
> Puzzled...

Most commands accept "--option=value". I know that it is different
from "--option foo=bar", but it could reduce user mistakes if we also
accept "--trailer foo=bar".

And if we accept it, then whatever the user has configured in the
"trailer.separators" option, "--trailer foo=bar" will always work and
add the default separator. So it is a generic way to add
"foo<separator> bar" to the trailers whatever the user want as a
separator.

But maybe I should reword the documentation to add this reason. (I did
not do that in the v14 series I just sent.)

Thanks,
Christian.
