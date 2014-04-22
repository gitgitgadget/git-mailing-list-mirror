From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Tue, 22 Apr 2014 01:53:46 -0500
Message-ID: <535611fac1b7b_268bd0b308f5@nysa.notmuch>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
 <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
 <20140422045951.GA60610@gmail.com>
 <20140422060120.GA10198@hashpling.org>
 <53560b09bbe96_2400128531085@nysa.notmuch>
 <20140422065549.GA11224@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:04:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUka-0000BT-8J
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 09:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbaDVHEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 03:04:11 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:45717 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaDVHEK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 03:04:10 -0400
Received: by mail-oa0-f44.google.com with SMTP id n16so2511418oag.17
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=TUiOxvCFNZ4veVo/KGgFCwT2nu8DiAkrqysXPWp+rjg=;
        b=xAarn2RsbociiBf9zKm99Zb1X66jqurqgjIATfLNWIPrDGYsrwHRPfR62H85R/6O1/
         F8bpT0K7dlx/a7qMQ3VQVLMl3NPX5eAAgdMad4RVfYGBhbMJhtzrgaSn5z6GM8039hOT
         Hl91w06pg+tjlGuWs0NunaIxA910tEUsaGkTsPhUdjWBJADZtJam03a5GQzLt63lyCDL
         hyLYzl15MbktkOKKcUMuBVYzLqi0AvMjpN69vTVhzwtN0Rlvkh8jjAEs05nfQGRrbuRn
         0WbbxhfEX5lcW4S2zeThaYc3aiJ9i6oQM3V8TdXvMpgvN2KmQQfUsRoCilpm8DkVtaHG
         e1Xg==
X-Received: by 10.60.98.139 with SMTP id ei11mr10638061oeb.43.1398150249357;
        Tue, 22 Apr 2014 00:04:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm75123299obk.4.2014.04.22.00.04.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 00:04:08 -0700 (PDT)
In-Reply-To: <20140422065549.GA11224@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246705>

Charles Bailey wrote:
> On Tue, Apr 22, 2014 at 01:24:09AM -0500, Felipe Contreras wrote:
> > 
> > This is what I get when a tool is not working:
> > 
> >   Documentation/config.txt seems unchanged.
> >   Was the merge successful? [y/n]
> 
> Does this happen now even with merge tools for which we do trust the
> exit code? If so, my original concern is addressed.

Which tools are those?

> > > Personally, I leave mergetool.prompt unset (default true) because one
> > > extra click in a complex merge resolution is relatively low overhead and
> > > to catch myself when I forget that I'm in a no-X environment.
> > > 
> > > I glanced at the patch and it seems to subvert this intent for users
> > > who have  configured a merge tool. Is my understanding correct?
> > 
> > Yes, that's correct. If the user has *manually* configured a tool, why would
> > you ask him again? We are annoying the overwhelming the vast majority of users
> > who already configured the right tool in order to avoid issues with a minute
> > minority that might potentially but unlikely have a problem once or twice.
> > 
> > That's not productive.
> 
> We're asking to user to signal that he's happy to launch the mergetool
> and implicitly giving him an opportunity to break out of the session.
> I don't see anything wrong with having this behaviour.

You don't see anything wrong with asking the user *every single time* he runs
`git mergetool`, even though he *already told us* which tool to use?
 
If so, I'm pretty sure everybody else disagrees with you.

-- 
Felipe Contreras
