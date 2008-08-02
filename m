From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Sat, 2 Aug 2008 13:50:23 +0200
Message-ID: <cb7bb73a0808020450h18cd3fdbn7a90e31e3274191b@mail.gmail.com>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
	 <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
	 <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org>
	 <cb7bb73a0808012241s80a06fq1ac54a3350169f6c@mail.gmail.com>
	 <C871A30D-F2AF-4385-ABD4-C57F474D7F01@sb.org>
	 <cb7bb73a0808012306y5672dad9nd0a21f861f181e5b@mail.gmail.com>
	 <alpine.DEB.1.00.0808021336050.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kevin Ballard" <kevin@sb.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 02 13:52:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPFeX-0002ey-5P
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 13:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbYHBLuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 07:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYHBLuZ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 07:50:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:36649 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbYHBLuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 07:50:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so828510ywe.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vvxMyLLjiM1vlZPVxGfng6m67jcjM20YG1OkdBOk/FA=;
        b=oa7MU2J+LsfV5wiTNMdLDkngwHHcFuus3+saIZiPu6kaeK6EJumwvroh09ZVgiM6vv
         l9c7vQTe4Ft/K/XleQvLid/HTosdzVZQT6pXKdZ0u+QQ5FLMwqvrbwiTwzWyI4YQTU+h
         lRNHHxIARqGLJC9KY6eqSv6lRI3eFHLfxsLsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xQinib9+5FJITtNzNkw+toCmMQu+4sjqxDVg+YE/uV3lFc1BH49ZMd+rH41jUQTD7Y
         yse8xBaVhcUcbtjsh4L+pNes6B+kQoDwcO9kWN7e8kkpn04QDt0FtmvbZdBQTMw4Odoi
         eVDJyJM2C+EpNzKLPUsvh4ecaDy2oDY04jNKU=
Received: by 10.150.181.7 with SMTP id d7mr4892744ybf.98.1217677823719;
        Sat, 02 Aug 2008 04:50:23 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Sat, 2 Aug 2008 04:50:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0808021336050.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91143>

Hello,

On Sat, Aug 2, 2008 at 1:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> The funcname thing was introduced by us, in Git.  I do not know if Davide
> picked the changes up; at least for the merge stuff he seemed to be pretty
> reluctant.

Ah, it's a Git-only thing? didn't know about that. I guess that
knowing that git's libxdiff is already hacked up from the original
means I can think more freely about hacking it up some more, if I can
come up with a proper solution 8-)

>> The matchit plugin for vim seems to manage (even user-defined) code
>> blocks very well, even for multi-state blocks (if ... else ... end),
>> using regexps; so maybe a reimplementation in C for libxdiff could be a
>> solution.
>
> Bzzt.  You say vi manages it with regexps, and then you go on and say that
> you therefore do _not_ want to use a regexp?
>
> BTW having funcname calculation in C was shot down by Junio as being too
> inflexible, as the user cannot add new languages without recompiling.
> That's why we have regexps now.

Sorry, I think there's a misunderstanding here ... I have all
intentions to use regexps. What I was planning on reimplementing in C
was the way matchit uses the regexps to determine the blocks (because,
obviously, it being a vim script means it's coded in vim's own
langauge instead of C). The actual definitions for the start and end
of the block would still be done via regexps. 8-)

-- 
Giuseppe "Oblomov" Bilotta
