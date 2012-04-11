From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why can't git open empty branches ?
Date: Wed, 11 Apr 2012 07:19:07 -0500
Message-ID: <20120411121907.GA30340@burratino>
References: <4F855E6B.4010504@danisch.de>
 <20120411105906.GA19823@burratino>
 <4F8565BC.1070701@danisch.de>
 <vpq7gxmzf75.fsf@bauges.imag.fr>
 <4F856F67.4000609@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Hadmut Danisch <hadmut@danisch.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 14:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHwWB-0002aA-EP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 14:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760113Ab2DKMTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 08:19:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36074 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2DKMTS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 08:19:18 -0400
Received: by yenl12 with SMTP id l12so363891yen.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5Gb9pbfIFy2wyczys5LkToTgxzY3DGx1oCKXIO1Nokk=;
        b=VsYGX4ymomxKMvM788uHOHFoz+dQQsMuwInarT+DHYsIfzceGrNPmVgq0iTglvKBJZ
         MfqZQpaEdQN3ZwgipfC3RERwp3MPn91Y8g9IpyaunwaOZ5j58nEb3jpvy/B0dw7kZs2k
         fykrDuxCUSiwXVkgIOTIKrKHnCMMbZetk3Z+fMWx1Y1WXAdrrjNU4KI6k9VUnk7q91Sr
         v5iIzkAyzc/JFjM6DSu9wIIefYBAsAzxiODJ4inPxDgjHLr9NESCCLyv53TbWRxBqJzg
         TP2Rlt+1KOs5qvCsPJAiQ9xLfMVi/Nnle/62OlG2WdSb87ISZzapR+mLWz9nWgiRb53z
         X24w==
Received: by 10.50.46.194 with SMTP id x2mr5265495igm.60.1334146757538;
        Wed, 11 Apr 2012 05:19:17 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l9sm7339149iga.6.2012.04.11.05.19.16
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 05:19:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F856F67.4000609@danisch.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195176>

Hadmut Danisch wrote:

> Creating independent branches by pushing two separates into a single
> remote bare is a nice idea, but if I understood git correctly, the very
> first commit in a repos is always to the master branch, where you have
> two masters trying to push into the shared remote bare. This is
> obviously solvable if you use the correct commands and maybe delete and
> re-clone the repos, but this is all overcomplicated and non-trivial.
> Nothing I could do without reading manuals.

I suppose you had to read the manual to learn the "git commit" and
"git branch -m" commands, yes.  But what's wrong with that, or how
could we fix it?

	git init code
	cd code
	... hack away ...
	git remote add origin <url>
	git push -u origin master
	cd ..

	git init website
	cd website
	... hack away ...
	git branch -m website
	git remote add origin <url>
	git push -u origin website
	cd ..

I wonder if there is a potential documentation or error message update
lurking behind these questions.

Hope that helps,
Jonathan
