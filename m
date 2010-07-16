From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git am mangles commit author name.
Date: Fri, 16 Jul 2010 14:19:54 -0500
Message-ID: <20100716191954.GB16371@burratino>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
 <20100713054949.GB2425@burratino>
 <AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
 <AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
 <AANLkTim6Ax-4SVJU_LvR86SyD5q3VhCfGBlGOkSPTocL@mail.gmail.com>
 <AANLkTilZJ0g-XbkOsMh3Q1Jo7XQ2dbT1cY-YP_BdXvuh@mail.gmail.com>
 <AANLkTimIkepwy93dYCu5mkdSMHNuh3dbMyxcHPl4hGmt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Tor Arntsen <tor@spacetec.no>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel F <nanotube@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 21:20:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZqSt-0008F8-IB
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 21:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759046Ab0GPTUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 15:20:50 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45789 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759016Ab0GPTUt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 15:20:49 -0400
Received: by gxk23 with SMTP id 23so1438046gxk.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BqhLxFIKgu/pZESNeKI8n18UtcaiUZ4hnCCN1WrbBdw=;
        b=Yjj9N3oIADer6I0aTuHgu1gi/W0jqHAiTE3Y4FAvQT8Aa5xZW1Cc9JQIUAW1h7TETC
         ojxTllQ+CwFL0RQKivZ+lgTOV5f0d5qQ5TRjsP4/xxqSxpliuxdlOfMNTgf3Hcb5jJGG
         /DI+6JSlF2FfI94uZxw9zIexlhXbgy43XnQqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U8eZYdmTwE943H9d027ubPLld80LU1OIFxuh03GJD8/M5197qgyLzEyE6RpyuHF8S5
         L7uQrEGY4HPGKUGlx7+HjwjRInhLXIqvX329vkjN4ltRn3/xsr+0E8ET3A3DtvSbuzNi
         tdSCtNc2SCaLdAd7Ydls+n7ZlilGatw1a8NDg=
Received: by 10.224.72.37 with SMTP id k37mr1295702qaj.398.1279308048648;
        Fri, 16 Jul 2010 12:20:48 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id m24sm11304450qck.29.2010.07.16.12.20.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 12:20:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimIkepwy93dYCu5mkdSMHNuh3dbMyxcHPl4hGmt@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151166>

Hi Daniel,

Daniel F wrote: 

> would simply setting minimum length to 1 have any negative
> side effects?

I am not a git maintainer, but I would suggest writing a patch to do
that.  Then you can try it and see, and send us a copy of the patch
when reporting the results.

My guess is Linus wanted to make sure he had meaningful names in
patches he applies[1].  There is no technical limit I know of that would
lead one to forbid an author name longer than 60 characters, either.
So the questions are:

 - did any code learn to rely on those limits later?
 - are any _people_ relying on those limits now?

I suspect the answer to question 2, at least for the lower bound,
is no.

Hope that helps,
Jonathan

[1] See v0.99.2~51^2~21 (Start of early patch applicator tools for
git., 2005-04-11) for the original script.
