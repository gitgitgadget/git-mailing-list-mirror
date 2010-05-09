From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Sun, 9 May 2010 10:13:10 +0200
Message-ID: <A5422145-63E1-4AF4-9184-7A6D15E9C2B6@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <alpine.LFD.2.00.1005081600490.3711@i5.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 09 10:13:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB1dx-00083r-Ap
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 10:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab0EIINR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 04:13:17 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:45837 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab0EIINP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 04:13:15 -0400
Received: by ewy20 with SMTP id 20so631557ewy.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=q8OZP4EaLACsw31KUjZ8bsnFtPXadCkffinycwxLVbk=;
        b=ZaE8fkflt6kld+aYhC0mUkw/k2sHcxlrLA8AsC7vAyyra5oNyKwTHyiVXG/u0GtZr0
         kkp85IBufolBZXNCZEJpl31/vOlnsKTu8wZJiix1WVuCAWLf/RDsR9sqUCHkFts/n9Sq
         licDJzkkfTgcBfH2ph/1mo+M19fJ/LWTk5jCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=SoPir5xTovhiz8gDPpJfPt0GM2W3NHulgfn00t1AcOpKfb69/7Hdsj8+LgyF9FVfq+
         4/3bbPG8W4JW3d5jxVAWyhGKw5lscvUi7bV/w4LjqDwTYY2JN92vfMbEBCAtXey2BtWT
         AbBCeFuu71EDbU/PM2TwKViLgLVlsz2OG5dyc=
Received: by 10.213.49.144 with SMTP id v16mr1002958ebf.46.1273392793586;
        Sun, 09 May 2010 01:13:13 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm1944669ewy.0.2010.05.09.01.13.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 01:13:13 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005081600490.3711@i5.linux-foundation.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146710>

On 9. mai 2010, at 01.08, Linus Torvalds wrote:

> On Sun, 9 May 2010, Eyvind Bernhardsen wrote:
>> 
>> Heh. How about "localcrlf={true,false,native}"?
> 
> I really don't understand that. What would it even mean?

Sorry, I should have explained it.  I chided you for "crlf=input" being crazy, but then I realized that "crlf=true" really isn't too bad a config variable for saying that you want CRLFs.  Just "crlf" seems a bit obscure still, so I came up with "localcrlf": if it's "true" it means you want CRLFs locally (in your working directory), if it's "false" you want LFs.

It helps to think about the situations where you're likely to change this. If you're on Linux but you want CRLFs in your working directory, set "localcrlf=true".  If you're on Windows but don't want CRLFs, "localcrlf=false".  Thinking about it, "input" could be an alias for "false", which would make it _exactly_ what you suggested except for a slight clarification in the name.

> An you _do_ realize that like it or not, we already have "crlf=input" as 
> the syntax in our .gitattributes files? So that exact syntax already 
> exists in one place.

I'm sorry.  Are you the same Linus Torvalds who wrote this:

> Btw, since we're discussing this, I do think that our current "crlf=input" 
> syntax for .gitattributes is pretty dubious.

?  I agree with that sentiment.  "crlf=input" is silly; if you have a file that always has to be LF no matter what, just set it to "-crlf" and make sure you don't accidentally introduce any CRs.  That is what you have to do for a file that always has to be CRLF, after all.  As always, I'm not suggesting getting rid of "crlf=input"; I would keep it for backwards compatibility, but not emphasize it in the documentation.

> As mentioned, I really can understand people not liking the name, but we 
> already _have_ that name, and that syntax. I think it makes more sense to 
> try to have a unified syntax than have two different strings for the same 
> thing.

I agree with this!  I just don't agree that the unified syntax should be married to the old, poor syntax, and "crlf=input" is a straw man.  It's both ugly and unnecessary.

> So I think we'd be better off with good documentation with a couple of 
> real examples (and easily findable), so that the naming is at least 
> something people can look up and see the semantics for. The "eol" vs 
> "crlf" thing is just bike shedding, and we already ended up with "crlf". 
> In contrast, making docs understandable is more than bikeshedding.

Making the docs understandable is important.  I have changed the docs, and I will keep trying to improve them.  But making the configuration understandable is _also_ important!  It's not just the colour of the bike shed, it's how it _works_.  This discussion is not a waste of time.

But if you insist, here's how it looks to me: I'm the one trying to build a new bike shed from the parts of the grotty one that nobody really likes to use, and you're the one saying I need to paint it in the same 70s brown-and-mustard colour scheme as the old one.

The frustrating thing is that you're also coming up with some interesting colour combinations elsewhere, but you seem resigned to the idea that we're stuck with the ugliness.  I don't think we are.
-- 
Eyvind
