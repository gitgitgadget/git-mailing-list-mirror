From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v5.1 0/3] Make git-completion Bash 4 compatible
Date: Wed, 15 Dec 2010 00:24:03 -0600
Message-ID: <20101215062403.GA20492@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
 <20101202210207.GA4994@burratino>
 <20101207160747.GD1867@neumann>
 <20101207194923.GD22587@burratino>
 <7v1v5tpa7b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 07:24:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSkml-0004Do-Ib
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 07:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab0LOGYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 01:24:20 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45689 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0LOGYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 01:24:19 -0500
Received: by yxt3 with SMTP id 3so854256yxt.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 22:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eZm3pCMjTP6TBTpDj180F1mT7NKvxG4VzkkFIl0vA1Q=;
        b=SasFSwws4zbnz0SPYNAPLQ5Ny3/Vox41oxThND2Ub/CeLnmtfZtfEzl5Gi+c5NyKQ1
         1uvOtUU8lRziwg/IdfscgYz9DLzNt4vUf08eobqsVwlLr1Sk2bj3Rkubsk94BaYhBU8a
         XZG06iHu1QpIOAI423Gsst0JwodoWdc6SmTkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RjcnlQEL/JVDt60F6byDUjgnG7RPV//HyzTH5CZLL/TiQ8ZPxcRVuxXo5iJoJ1RlkD
         PZd6/7Lb743x+6EsVI53IbcCjamrtOMGo2ZqLZkq26JxojDv8YyPZ7KOetlpLzfJj/iK
         4BUZw+RRP9rzk5m1TR7VYXN750RHkZnEbWTB4=
Received: by 10.151.142.4 with SMTP id u4mr9485728ybn.65.1292394258640;
        Tue, 14 Dec 2010 22:24:18 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id u31sm637363yba.21.2010.12.14.22.24.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 22:24:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v1v5tpa7b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163733>

Junio C Hamano wrote:
>>> On Thu, Dec 02, 2010 at 03:02:07PM -0600, Jonathan Nieder wrote:

>>>> Add a minimal implementation of _get_comp_words_by_ref,
>>>> the routine used to work around bash 4.0's COMP_WORDS semantics.
>>>>
>>>> Based on bash-completion 2.x (commit bf763033, 2010-10-26) but
>>>> tweaked for simplicity and to allow zsh to at least parse the
>>>> code.
[...]
> Sorry, but whose repository does that object live in?

Agh, sorry for the mess.  Please fetch

  git://repo.or.cz/git/jrn.git pd/bash-4-completion 

to receive the following history:

  o [maint-1.7.2] --- A --- B --- M [FETCH_HEAD]
                                 /
                                o [master (early part)]

[A] bash: get --pretty=m<tab> completion to work with bash v4
(by Peter)

[B] bash: simple reimplementation of _get_comp_words_by_ref
(discussed above)

[M] Merge branch 'master' (early part) into pd/bash-4-completion
(zsh compatibility)

[master (early part)] completion: fix zsh check under bash with 'set -u'
(2010-10-28 11:45:00 -0700).

A and B are the patches sent previously in this thread, rebased on an
older code base to avoid the zsh support.  A combined diff for the
merge 'M' will follow.  Thoughts, suggestions, acks, test reports
would be welcome.

Thanks for your patience.
Jonathan
