From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Git's database structure
Date: Fri, 7 Sep 2007 12:33:57 +1200
Message-ID: <46a038f90709061733s3b8f15b7se3e4002c1f69a04d@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
	 <20070904212507.GA24434@thunk.org>
	 <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
	 <46DE5861.4050201@op5.se>
	 <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
	 <46DEC26E.7030809@op5.se>
	 <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>
	 <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk>
	 <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andreas Ericsson" <ae@op5.se>, "Theodore Tso" <tytso@mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 02:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITRnT-0006BB-NF
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 02:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbXIGAeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 20:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbXIGAeB
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 20:34:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:50934 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964785AbXIGAeA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 20:34:00 -0400
Received: by ug-out-1314.google.com with SMTP id z38so238135ugc
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qvgnkDCsFek+nl9X+EcHP72qpv/ft7I+zjXTG4oZotA=;
        b=tQDks1iH9kNDB9Cwa2ZHBH+v3MfoYqBWIil4QHwN8f+J9Y0Fti88WF08yj+L332gA0HQGPTFFHSWR3+Emb6+LsCnLGrbCrYjVDOd9fe4sbx83M9SdSROLaj+92xFvnO/GGry1qT3tymZRJr86CYyKuKCXEGcXMQwO1WmnPNbIEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tuO7NbLLjZoE0sl7VMmRYAtXI1V4WsMpcNlOqV4NeIxrgtrDOUitT2ETupooeji51lIzgJTPfS1PNSzZrA/70aC5NBROYE/IHlq/wxxzrgX+2hkqQMBE4cY/lZ8eKNoFYgYwj4bZNVE7xW+b6JUf5kLR65PijdTpkrx3zvTTd74=
Received: by 10.66.219.20 with SMTP id r20mr719475ugg.1189125238072;
        Thu, 06 Sep 2007 17:33:58 -0700 (PDT)
Received: by 10.67.40.9 with HTTP; Thu, 6 Sep 2007 17:33:57 -0700 (PDT)
In-Reply-To: <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57955>

On 9/6/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Use blame for an example. Blame has to crawl every commit to see if it

Sure. Build a quick dedicated index for that and measure

 - cost (size and commit/fetch costs)
 - benefit
 - frequency of usage

git is a special-purpouse DB that does great for certain access
patterns. Have a look at monotone for a design that looks a lot like
git but is backed by a general purpouse DB and does equally poorly for
all access patterns ;-)

> It keeps doing this until it figures out the last
> author for every line in the file. Worse case blame has to crawl every
> commit in the data store.

Yep. Can we get a minimal-cost index with just enough hints that can
speed up blame, and perhaps git log with/very/deep/path? Probably!

That's worth pursuing sure.


martin
