From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] --color-words: Make the word characters configurable
Date: Sat, 3 May 2008 17:43:37 +0300
Message-ID: <20080503144337.GA7987@mithlond.arda.local>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com> <1209736766-8029-1-git-send-email-pkufranky@gmail.com> <alpine.DEB.1.00.0805031501290.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 16:44:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsIyg-0005YQ-St
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 16:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbYECOnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 10:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190AbYECOnp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 10:43:45 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:59266 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755600AbYECOno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 10:43:44 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.0.013.9)
        id 481AE2A7000C305A; Sat, 3 May 2008 17:43:41 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JsIxd-0002Tg-CR; Sat, 03 May 2008 17:43:37 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805031501290.30431@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81096>

Johannes Schindelin wrote (2008-05-03 15:03 +0100):

> Now, you can specify which characters are to be interpreted as word
> characters with "--color-words=A-Za-z", or by setting the config
> variable diff.wordCharacters.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	I would have preferred an approach like this.

Unfortunately this does not work at all with other than Ascii
characters. It makes --color-words completely unusable for anything
other than Ascii text. Sorry.

Ping Yin's version has also the problem that UTF-8 multibyte characters
U+0080..U+10FFFF don't work in diff.nonwordchars. Fortunately the most
important word delimiters are in U+0000..U+007F (=Ascii) area so Ping's
version is perfectly usable with Unicode text. (Even the old
--color-words behaviour with only SPACE as non-word char was perfectly
usable with Unicode text.) I, too, would like to see Ping's patch series
merged in.
