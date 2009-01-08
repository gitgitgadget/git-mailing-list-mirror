From: "James Pickens" <jepicken@gmail.com>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects that are corrupted in a pack file
Date: Wed, 7 Jan 2009 19:21:18 -0700
Message-ID: <885649360901071821t2ea481b5k83ab800f6aeb897@mail.gmail.com>
References: <20081209093627.77039a1f@perceptron>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
	 <1231368935.8870.584.camel@starfruit>
	 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
	 <1231374514.8870.621.camel@starfruit>
	 <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"=?UTF-8?Q?Jan_Kr=C3=BCger?=" <jk@jk.gs>, kb@slide.com,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Git ML" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 03:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKkXj-0006RG-Cp
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 03:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbZAHCVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 21:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbZAHCVU
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 21:21:20 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:30253 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbZAHCVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 21:21:19 -0500
Received: by rv-out-0506.google.com with SMTP id k40so8168407rvb.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 18:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sveZeXPbhABRttvUiRl0N9HyNMfpXhNoM4otZP5Y+/c=;
        b=N0RFYTup2mWGX9W98Htt9g+5duYV0/cFEQI8x9PywrL0Xi0HZ/kKaMOLkKzGFwLirW
         XEMbFIHEKlu/C/JBhHkS/v6YrlJ69l05lveYlpEVnqybdOCynKKdFt4WJloyHKskmGzF
         FOM7GDNETwN6Iy+WSJS8RzYGQWCxVKHeGS9/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=O1TxMJTyxyQb2uNqrsuzzyYLIbl7371Ykub2f8jTEaLcqlM+joznrKRcoeN1Vmkg3S
         foQ+BFmmsAK7/dqWLCQ6y0ACxZIl3D0kACgqSiEffRurEyty1A1x2Ryj0tEl+nclEoM9
         0c/5qMdqeKju0XCYVLEStEO5z2UQnXLFnoL8w=
Received: by 10.114.67.2 with SMTP id p2mr15692934waa.208.1231381278642;
        Wed, 07 Jan 2009 18:21:18 -0800 (PST)
Received: by 10.114.80.15 with HTTP; Wed, 7 Jan 2009 18:21:18 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104873>

On Wed, Jan 7, 2009, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Can you cnfirm that your "reproducible" case starts working with that
> addition to your ~/.gitconfig? If so, the solution is pretty simple: we
> should just lower the default pack windowsize.

Umm... isn't that more of a workaround than a solution?  I.e., if you lower
the default pack windowsize, couldn't the corruption still happen under the
right conditions?

James
