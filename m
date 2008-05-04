From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: merge renamed files/directories?
Date: Sun, 04 May 2008 02:34:23 -0700 (PDT)
Message-ID: <m3zlr65s6j.fsf@localhost.localdomain>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com>
	<32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com>
	<20080501153457.GB11469@sigill.intra.peff.net>
	<D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com>
	<20080501231427.GD21731@sigill.intra.peff.net>
	<481CA742.4080909@tikalk.com>
	<32541b130805031111r4cbea8e1l19c34ac05016a89b@mail.gmail.com>
	<481D52CC.1030503@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsacn-0005Hg-H4
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbYEDJe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 05:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbYEDJe3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:34:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:19106 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbYEDJe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 05:34:28 -0400
Received: by ug-out-1314.google.com with SMTP id h3so488377ugf.16
        for <git@vger.kernel.org>; Sun, 04 May 2008 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=JPg9SM+9f4iwUxpQWdRbRkVn711k7ysRxNIY+eczDc4=;
        b=TXvi/hGoM43wYY0lk7pwai6MO5G9ATAFA6gKPgZWrefsV0xF3WTgm/DZw17j/X0LOGNBTCphVkaZrC78hIFmOsN41rKKVFmGAlB0BMuYtrZj42o1y7Rn1wV4sfj/nvce5SiL7quW35HqmvMk7HIkqMCQncftcpBZM20Do5+vSLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=EVio/GTvDZyrVlme7LisoppVYqUig1CFohtvz21hw/Ws1n8teSocwwakpp45winNLE8aGcQnTJud3N/6c9lIh9YDDsi4+q+XV4hkol/ZimvShqQbiUaAtfaSH5OB7ztJRn6mW4IhQ13fgVIsiHbk6YpS7r1RQMRudtA/lCoy+Vk=
Received: by 10.67.40.15 with SMTP id s15mr2761183ugj.53.1209893664648;
        Sun, 04 May 2008 02:34:24 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.224.254])
        by mx.google.com with ESMTPS id b36sm8779156ika.5.2008.05.04.02.34.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 May 2008 02:34:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m449YGEb032691;
	Sun, 4 May 2008 11:34:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m449YCER032687;
	Sun, 4 May 2008 11:34:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <481D52CC.1030503@tikalk.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81155>

Ittay Dror <ittayd@tikalk.com> writes:
> Avery Pennarun wrote:

> > Git already works fine for renames.  The only situation where
> > something funny happens is if you rename a whole directory and someone
> > else creates a file in the old directory.  (In that case, the new file
> > ends up in the old place instead of the new place.)  However, even in
> > that case, there is still no conflict and no manual merging necessary.
>
> Sorry, but this is not the situation as I have experienced it with a
> local repository I have. I renamed a directory (without changing any
> files in it). 'git diff <commit>^ <commit>' shows the rename fine, but
> 'git log -p -M -C <initial commit>..' does not (that is, the history
> for files in that directory is shown from the rename commit
> only). Obviously git-diff is not any better.

This is one thing where git differs from other SCMs.  In "git log --
<path>" (that is what I assume you have used) the <path> argument is
path limiter.  It allows to specify more than one directory or a file.

Unfortunately currently "git log --follow=<file>" works only for single
files, and doesn't yet work for directories; which is caused, among
other things, by the lack of directory rename detection in git.

> [...] Also, what happens if I change the file in the new location
> and someone else changes it in the old location? Will I need to do a
> manual merge?

No, rename detection should make automatic merge possible.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
