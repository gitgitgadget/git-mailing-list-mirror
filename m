From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/8] vcs-svn: Let caller set up sliding window for delta
 preimage
Date: Sat, 20 Nov 2010 13:31:52 -0600
Message-ID: <20101120193152.GK17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
 <20101120192845.GG17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:32:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJtAO-0004FO-VG
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab0KTTcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:32:05 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60644 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0KTTcB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:32:01 -0500
Received: by yxf34 with SMTP id 34so3370422yxf.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Hg3UUxHNAINmdhCSOOkJaqMFzNxBJOXf4D5SNAujBDk=;
        b=lkOnzFJQ1XTMiqzwVyePRW8LXRt3J3DbDmYDMozlMKlYKzvCNwnCi4NTk7B75xgOI7
         LEIrC9GhGan8WYGwCrY5lI9E+aEwOWRoX6cAjVU1RiQ+8fZ6KKBhiBu2LuTFib3/Lor/
         PoS0nGC1cXtaj2jhpLysNbm8reif63a47YlVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=r6rSvboY02uiGbqVXZ7u7HL4QaQCqBnm05J6p5JJuj8ra9LjALjElShEDi6+wDjVFW
         WWMpHbmqSz3mYnf2HW4k9Sb1YuanD8bDGYx0Y3JhD7OTqdMd3zUKm2Jt43Ml2vNtabX2
         X8fkQNLdYp/cBFLnTLpQyGH7NxiiZHa61f8xU=
Received: by 10.151.79.11 with SMTP id g11mr6058401ybl.196.1290281521173;
        Sat, 20 Nov 2010 11:32:01 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v9sm733002ybe.9.2010.11.20.11.31.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:31:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192845.GG17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161840>

Jonathan Nieder wrote:

> The content of symlinks starts with the word "link " in SVN's
> worldview, so we need to prepend that text the sake of delta
> application.  Move responsibility for setting up the input state from
> svndiff0_apply to the calling program, so programs have a chance to
> seed the sliding window with text of their choice.
> 
> [jn: extracted from the patch "svn-fe: Use the --report-fd feature"]
> 
> Signed-off-by: David Barr <david.barr@cordelta.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

This one is

 From: David Barr <david.barr@cordelta.com>

Sorry, I keep on forgetting to preserve pseudo-header (is there a
format-patch option to move it to the body?).
