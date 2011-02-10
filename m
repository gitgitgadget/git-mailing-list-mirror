From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] Remove deprecated commands
Date: Thu, 10 Feb 2011 14:56:20 -0600
Message-ID: <20110210205620.GD21144@elie>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <4D4852EE.6080605@lsrfire.ath.cx>
 <20110202005748.GA13803@elie>
 <4D543FB4.1040709@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Feb 10 21:56:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PndZ2-0008Dn-Gc
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 21:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab1BJU41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 15:56:27 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43723 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1BJU40 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Feb 2011 15:56:26 -0500
Received: by wyb28 with SMTP id 28so1786665wyb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ifenEhHbkGne7Hhph7oxKSBapoEv6ggDs0y7PyMlQUM=;
        b=VkRMy3z5qARwcU4hpo99SgfQMqShuMfZS9os104zKmop+7phpgUxD4Mh0qELgImPeR
         M0paL2DXW/IQcRQU1XrJZD92PXyJsv4OMpV7iRZth3xmuwTyahxjQGxADFM8lmJkmJ60
         PsUYJjwls2BWiv2d6i4POkqjDTGyPsqmIv+ew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aB1trPsj2B8kU4Web1YXf98ILhk57xexf6FGGR3v8N+0YGpGL8ofN3wjZo59g2csuC
         VOz8Iw4n5kSt+R9+cVtEOMmLvv12g3zSicXeQJMZuVIcxzvdJBeG6oub2IqIuPRUnqvU
         8NprKiFGqbj+//bkol3+eOPciJFbIi4htP2hA=
Received: by 10.216.174.69 with SMTP id w47mr117340wel.41.1297371385522;
        Thu, 10 Feb 2011 12:56:25 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id t11sm11765wes.41.2011.02.10.12.56.23
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 12:56:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D543FB4.1040709@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166498>

Ren=C3=A9 Scharfe wrote:

> How did you search for current usage?  How comprehensive are the resu=
lts?

By searching for "peek-remote" at http://www.google.com/codesearch

I tried to check out all hits that weren't just enumerating git
commands, but that doesn't rule out unindexed or non-public use.
No interesting hits.

But that's pretty weird, given that there was no deprecation
notice, nor anything else to encourage a transition.

*checks history*

Ah, peek-remote and ls-remote seem to have been introduced at the same
time.  ls-remote could use all git-supported protocols, while
peek-remote could only use git protocol.  So very few people had
reason to use peek-remote, anyway.

> Am 02.02.2011 01:57, schrieb Jonathan Nieder:

>>>    git-repo-config  2008-01-17       git config
>>
>> giggle[1] still uses it
[...]
>> Likewise darcs2git[2] and the stgit testsuite.
[...]
> Well, the release notes for 1.5.4 promised that the "next feature
> release will remove it".  Perhaps notifying the developers of the
> projects you discovered is enough?

The list is probably not exhaustive.  On the bright side, repo-config
tends to be run in user-visible contexts, so I think a deprecation
notice could be effective.

> That said, the benefit for final removal of this command, which is
> effectively just an alias, is the smallest of the four.

After adding a deprecation notice and filing some bugs, I think we
can forget about it and wait another year. ;-)

>>>    git-tar-tree     2007-11-08       git archive
[...]
>> pilgrim[3] uses tar-tree in its "make dist" target.  I wouldn't be
>> surprised if some other projects use it in a similar way.
>
> Possibly, and this shows that deprecation warnings don't fully solve
> the problem of educating users to switch to the replacements.
>
> I think it's relatively safe to remove the command anyway because
> the users in this case are developers and packagers

I agree.  The remaining users look like holdouts that will be hard to
get at by other means.
