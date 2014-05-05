From: David Turner <dturner@twopensource.com>
Subject: RE: Watchman support for git
Date: Mon, 05 May 2014 11:08:14 -0700
Organization: Twitter
Message-ID: <1399313294.5310.59.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <536428224adfb_200c12912f010@nysa.notmuch> <1399083897.5310.0.camel@stross>
	 <5364654088dc4_4d2010fb2ec7d@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:39:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi6N-0006KZ-3c
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbaEESIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 14:08:21 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:46824 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaEESIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 14:08:18 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so7178224qab.18
        for <git@vger.kernel.org>; Mon, 05 May 2014 11:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=rJgNRyXMdjsj+D6KYhCeTqSlPcFQcs0NINmfFR1dQz4=;
        b=WuhS5TXQK7LdgD9FyCjS6Toq+sCVXr+3xhkoDMTlurJxFGxUQ5fNcXWncTZ/2VN+xQ
         Hf21IDBfD2P5TzbA9TEnfR4a7DiBIo1mbJj75AtPXAiU+08o+3xr+W0KSl8Q0dUXU/JW
         WhHvcLzu9wRE5kqVgBhVoANdH0IKbkiuLssRkHzvsVA6rQ/gumJke8t9/PzPqxzlunI3
         /Cn2zWeh5vbynWZtFhKQthOWE5TbcQ2c2gET/nED9clLaw3ODJDIwTupuNI0YiDqAa5B
         0R3SZARFk26c/PyJDAIsH5ZDYCIwY89AX//vftpMY6FkefSdjBVk58e2WBWO9sWqILSB
         Ve/Q==
X-Gm-Message-State: ALoCoQlY2nPED2XV6xiqfWtdpSSJrX9vZtrwGYY6+Tl7QQZLnbuLsGOsvDm/hNPyePgcWutADKak
X-Received: by 10.224.60.71 with SMTP id o7mr48039737qah.38.1399313297599;
        Mon, 05 May 2014 11:08:17 -0700 (PDT)
Received: from [172.25.143.182] ([8.25.197.27])
        by mx.google.com with ESMTPSA id q5sm18385795qam.37.2014.05.05.11.08.15
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 05 May 2014 11:08:16 -0700 (PDT)
In-Reply-To: <5364654088dc4_4d2010fb2ec7d@nysa.notmuch>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248145>

On Fri, 2014-05-02 at 22:40 -0500, Felipe Contreras wrote:
> David Turner wrote:
> > On Fri, 2014-05-02 at 18:20 -0500, Felipe Contreras wrote:
> > > dturner@ wrote:
> > > > Test repository 1: Linux
> > > > 
> > > > Linux is about 45k files in 3k directories.  The average length of a
> > > > filename is about 32 bytes.
> > > > 
> > > > Git status timing:
> > > > no watchman: 125ms
> > > > watchman: 90ms
> > > 
> > > That's very interesting. Do you get similar improvements when doing
> > > something similar in Merurial (watchman vs . no watchman).
> > 
> > I have not tried it.  My understanding is that this is why Facebook
> > wrote Watchman and added support for it to Mercurial, so I would assume
> > that the improvements are at least this good.
> 
> Yeah, my bet is that they are actually much better (because Mercurial
> can't be so optimized as Git).
>
> I'm interested in this number because if watchman in Git is improving it
> by 30%, but in Mercurial it's improving it by 100% (made up number),
> therefore it makes sens that you might want it more if you are using hg,
> but not so much if you are using git.
> 
> Also, if similar repositories with Mercurial+watchman are actually
> faster than Git+watchman, that means that there's room for improvement
> in your implementation. This is not a big issue at this point of the
> process, just something nice to know.

Converting git repos to hg seems to be incredibly slow.  (I have not yet
tried doing it with git-remote-hg).  But I did find a hg repository for
linux: https://bitbucket.org/orzel/linux-kernel-stable

On this repo, I get:
hg without watchman: 620ms
hg with watchman: 264ms
(compared to 125ms/90ms for git).

The number of syscalls is, perhaps also interesting:
no watchman / with watchman
hg  77773   /  5421
git 59180   /  599 

(About 1/3 of hg's syscalls with watchman seem to be loading Python
stuff)
