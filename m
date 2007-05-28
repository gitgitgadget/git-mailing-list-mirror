From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Create special from-file/to-file header for combined diff
Date: Mon, 28 May 2007 16:22:06 +0200
Message-ID: <200705281622.07313.jnareb@gmail.com>
References: <11803077771867-git-send-email-jnareb@gmail.com> <200705280850.52323.jnareb@gmail.com> <20070528132959.GT4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon May 28 16:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsg23-0005BX-Br
	for gcvg-git@gmane.org; Mon, 28 May 2007 16:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbXE1ORG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 10:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbXE1ORG
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 10:17:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:45338 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbXE1ORD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 10:17:03 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1637306ugf
        for <git@vger.kernel.org>; Mon, 28 May 2007 07:17:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EZpbHABRBuoMcpips5ruxdZu+ICohQi7t2WW7bh5aVEKIS4kNHgLmj5o0wMFDWbrgPb0azlXF8u2V6JQ0CZp0a/PaveXJUwzeN+9QiryKXwVZJl8jWBdROcehMPBfA4wxtzOjWkBW56O0RT9NIvkLKRIAkhZokwDa6lzLQbuVYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ffIwKOwzHzYbtHAAyzDugr658pGGwIhs9yhzyQ5YJ4mlYvwU354EFq4JnoA3yRDhATEcRQ4GeYMJBC5Wnv2xhxlxRe5JjKEYpgybnURZhnFQFAE32aKGjYk3nV2kwxqdDRwRXfZImK77VhMbLHHJT9Pl8/E/1/KtNptOxwdd6Rg=
Received: by 10.66.218.15 with SMTP id q15mr5301546ugg.1180361822442;
        Mon, 28 May 2007 07:17:02 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id k30sm8665065ugc.2007.05.28.07.17.00;
        Mon, 28 May 2007 07:17:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070528132959.GT4489@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48619>

On Mon, 28 May 2007, Petr Baudis wrote:
> On Mon, May 28, 2007 at 08:50:51AM CEST, Jakub Narebski wrote:
>> Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>> 
>>>> Instead of using default, diff(1) like from-file/to-file header for
>>>> combined diff (for a merge commit), which looks like:
>>>>
>>>>   --- a/git-gui/git-gui.sh
>>>>   +++ b/_git-gui/git-gui.sh_
>>>>
>>>> (where _link_ denotes [hidden] hyperlink), create from-file(n)/to-file
>>>> header, using n/file for each or parents, e.g.:
>>>>
>>>>   --- 1/_git-gui/git-gui.sh_
>>>>   --- 2/_git-gui.sh_
>>>>   +++ b/_git-gui/git-gui.sh_
>>> 
>>> Sounds quite straightforward to implement, and diff with 1/
>>> would be useful to recreate what the person who did the merge
>>> pulled in, for most of the time.  I suspect diff with 2/ is
>>> almost always uninteresting, though.
> 
> I like it too.
> 
>> Errr... it _is_ implemented in this patch, although code is not perfect
>> and has some unnecessary repetitions.
> 
> It just shows links to older versions of the blob, doesn't it? Links to
> diffs themselves would be useful too.

For me most important were those from names (or /dev/null) in the case
of rename or copying (or file which was not present in some branches).

The link is to older version of blob; the links to appropriate blobdiffs
(and with earlier PATCH/RFC "gitweb: Provide links to individual
commitdiffs in difftree for merges" also to appropriate commitdiffs)
are in the difftree / whatchanged table.


Where to put link to diff? Should name be link to diff instead of
link to blob (to version at parent)?

-- 
Jakub Narebski
Poland
