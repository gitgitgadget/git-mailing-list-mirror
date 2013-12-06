From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 11:26:51 -0800
Message-ID: <20131206192651.GK29959@google.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
 <20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
 <20131206210958.59f553060e3802d56f4a53b8@domain007.com>
 <CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
 <20131206215334.1a9031a1450d9c436943ce3d@domain007.com>
 <CAMAQ3nLgnpDo1jWFL1rqtEvmQm8LeEpZ41Uxo0GTQOk8ttpSZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Muzaffer Tolga Ozses <tolga@ozses.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 20:27:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp13F-0006ZU-AR
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 20:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab3LFT05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 14:26:57 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:47730 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab3LFT05 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 14:26:57 -0500
Received: by mail-yh0-f52.google.com with SMTP id i72so823340yha.25
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rDihbX3Uj5dDwt3FIkNEneac9puPdzESpQVDP2REkNI=;
        b=R+Oh8HzcWJ5eM+HFyMJYQ2JCZQ6hBSyzkyCKA4TQX3FGayK4jHaMo4EBI9lVX3TFTL
         QYGeSFXxdbQEYOf52ygdV9MEXsVGLxcoW5EenBrxztSH1MIZnFfRngHWMVrUNsTbPDLT
         USECKrGaLFClSneLVvlf8XZgZmRFqw40zXbor39clDLdysbEJNI+UECYA+O8UIwDTEcr
         J4WRhlsrrZ8qxlRx5yzQcf4aTQZyEy6P8/Mm/XpqLZPaEiyv3L3h6C3F3PvqW5UWZqyJ
         F+wFxdzpCcLE8qvCkvVJegXU7JTFnO7mEl2T0oj74W76hPuxrr46jRmDUOZWHhHafIZj
         iteg==
X-Received: by 10.236.75.202 with SMTP id z50mr4052642yhd.6.1386358014504;
        Fri, 06 Dec 2013 11:26:54 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id k76sm44077899yho.18.2013.12.06.11.26.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Dec 2013 11:26:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMAQ3nLgnpDo1jWFL1rqtEvmQm8LeEpZ41Uxo0GTQOk8ttpSZA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238946>

Muzaffer Tolga Ozses wrote:

> I am cloning over http

I am guessing you are using the "dumb" (plain static file transfer)
HTTP protocol.  With that protocol the server doesn't do anything
other than shuttle out files, so it doesn't need to do its own
progress reporting.

Perhaps the client should do some progress reporting based on file
sizes and amount downloaded so far, but it's hard to get excited
about given the existence of "smart" (transfer only what is needed)
HTTP protocol.  See git-http-backend(1) for details.

Perhaps we can document this better?  (If so, where would it have been
useful to learn about this, and do you have ideas for how it could be
worded?  I'm thinking it might make sense to put a note on this in a
new giturls(7) page with content that used to be in the git-clone(1)
'GIT URLS' section.)  Or if someone wants to work on a progress
display, that would be nice, too. ;-)

Thanks and hope that helps,
Jonathan
