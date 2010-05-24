From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 23:11:40 +0200
Message-ID: <986EE696-5997-40AD-929C-D82D40D7242E@gmail.com>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost> <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com> <20100522222746.GA2694@localhost> <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com> <20100523115127.GA20443@localhost> <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com> <20100524094905.GA10811@localhost>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon May 24 23:11:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGewA-0003D9-7l
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 23:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246Ab0EXVLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 17:11:45 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:63034 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116Ab0EXVLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 May 2010 17:11:44 -0400
Received: by ewy8 with SMTP id 8so382837ewy.28
        for <git@vger.kernel.org>; Mon, 24 May 2010 14:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=Z8rDuLeXqhsPdacUmdym5Z6QZr0SqmgdgpTR1q5nX0g=;
        b=vQPRqI+brfCZhdcailIMIE5Vgh/WCtS0qOebQyHIMBbsJ5En/yz7Kv4jU6kbeouXpK
         o1TM5mlQheCni7J80OrI5zTSt5M5sC/2GdU9oOhkh8OVBNl2T7b+f4e/+e3iEI3Bpm0E
         TsxngcJ8EQ4fTh5lZE0I9pJ/5xiOwAdtZGElI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=ZnVEDvVGgTStWifGT6iuC/+D1eYuFeyp2J5WZnWS5o/jQDNAxSYeXZoxB6Gt6wxTxu
         x/vTMUgVksQis7XkBE/pQW/W15gYJK0GXKm4sKtZL7M53Jjwute15/wr1cR+wv05aLT1
         SUlxCf+y4h66xo9K5fPsBgnCzaXy8mAOT8nho=
Received: by 10.213.31.132 with SMTP id y4mr32159ebc.27.1274735503067;
        Mon, 24 May 2010 14:11:43 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm2081440ewy.13.2010.05.24.14.11.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 14:11:42 -0700 (PDT)
In-Reply-To: <20100524094905.GA10811@localhost>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147651>

On 24. mai 2010, at 11.49, Clemens Buchacher wrote:

> With CRLF file in the repository, core.autocrlf=true and
> core.eol=lf, I tested the patches currently in pu (0ed6711a) in the
> following three scenarios:
> 
> 1. no attributes are set
> 2. text attribute is set or auto
> 3. eol attribute is set to lf
> 
> In the first scenario, the behavior is completely asymmetric. LF
> files will be converted to CRLF, if core.eol=crlf, but CRLF files
> will _not_ be converted to LF, even if core.eol=lf. And it will not
> be marked as dirty either. Yet this is the default behavior in
> terms of attributes.

Default in terms of attributes maybe, but not in terms of configuration (you need to explicitly set core.eol to lf to see this).  But I see your point, core.autocrlf just doesn't work very well unless you want CRLFs.

> The only justification I can think of for this behavior is the fact
> that on platforms with LF line endings, most tools can deal with
> CRLF line endings. Not very convincing.

Well, without "safe autocrlf", this would have worked as you expected, marking files as dirty and converting on checkin.  Unfortunately, without "safe autocrlf", core.autocrlf just doesn't work in practice, PRECISELY because the person with core.autocrlf set has to clean up after everybody else.

> In the second scenario, the file is marked as dirty. Neither reset
> --hard nor checkout HEAD . fix the problem. The file has to be
> added and committed, after which the line endings are _still_ CRLF.
> This appears to be the old autocrlf=true behavior. Is this
> intentional?

Yes, since it uses the old autocrlf implementation.  The documentation states that you need to convert your repository when enabling normalization, but is this going to be big problem in practice?

Perhaps the working directory file should be converted to LF, but when?  When it is added?  When it's committed?  If you checkout -f after you commit the change, the file should have the correct line ending, because then it is normalized in the repository and git knows what to do with it.

> The third scenario is similar to the second scenario, only it warns
> me about CRLF conversion during add and commit. The file still ends
> up having CRLF line endings in the work tree. git reset --hard does
> not fix the line endings. touch'ing the file finally makes git diff
> notice that the file is dirty, but git status still does not list
> the file.
> 
> So to me, end of line conversion is still as confusing as it gets.

All of your confusion seems to stem from starting with a repository that is not normalized and adding normalization to it.  Yes, that is a pain, but there is no way to avoid that, and there is a recipe for fixing it in the documentation.

>> This should only be a problem if you set the "text" or "eol"
>> attributes in an existing repository, or if someone adds CRLFs to
>> a normalized file using an older version of git.
> 
> In other words, this will be a problem all the time, since by
> default people will not even know about text or eol.

By default people will not enable core.autocrlf either.  I just don't see the huge problem here.  If your repository does not need normalization, _good_!  Nothing will ever be normalized or converted.  If somebody wants to work on that repository but prefers CRLFs, they can enable core.autocrlf, and it will work sanely (thanks to "safe autocrlf"), converting text files that can safely be normalized back but leaving all other files alone.

If you later discover that you want normalized text files in your repository, you _will_ have to convert all your files.  That's a bit tricky, but it's not the huge problem you're making it out to be, and it only has to be done once.
-- 
Eyvind
