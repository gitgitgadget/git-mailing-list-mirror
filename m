From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Best way to merge two repos with same content, different history
Date: Fri, 5 Jun 2009 19:15:55 +0200
Message-ID: <200906051915.56115.markus.heidelberg@web.de>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:16:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCd1O-0002En-Mq
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 19:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZFERPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 13:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbZFERPx
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 13:15:53 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:39740 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZFERPw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 13:15:52 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 46C5DFEDE7FA;
	Fri,  5 Jun 2009 19:15:54 +0200 (CEST)
Received: from [89.59.73.102] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MCd1G-0004vO-00; Fri, 05 Jun 2009 19:15:54 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19S6++qJ4zJSxkA+4Qw6bYXjHsdljMf09ORDVNz
	MlVvTgb2HIIsAcz2Pi20a013QSxu/lSdtnJEarx4HjN6iErbMT
	AiF9vI+7iw2EXnHFa9cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120814>

Kelly F. Hickel, 05.06.2009:
> 	Other than using manually format-patch on every branch in new,
> then applying the patches (presumably with regular old patch, since the
> ancestor commit IDs won't match), is there any "good" way to merge "new"
> into "old"?

If rebasing 'new' on top of 'old' isn't an option, then you could try:

    $ git checkout new
    $ git merge -s ours old

It's the other way round (not merging 'new' into 'old', but vice versa),
but there is now merge strategy "theirs".

Markus
