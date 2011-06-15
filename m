From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Wed, 15 Jun 2011 04:48:42 -0500
Message-ID: <20110615094842.GA16411@elie>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-3-git-send-email-mduft@gentoo.org>
 <20110526022045.GA8172@elie>
 <7vhb8hzcm8.fsf@alter.siamese.dyndns.org>
 <20110526163921.GD24931@elie>
 <4DE33E55.6090505@gentoo.org>
 <4DF87C0D.3050108@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tor Arntsen <tor@spacetec.no>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Markus Duft <mduft@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 11:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWmiZ-0003aF-6F
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 11:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab1FOJsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 05:48:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45959 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab1FOJsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 05:48:53 -0400
Received: by iwn34 with SMTP id 34so135984iwn.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jI9VyG4Zb0KVfil8cQSN2zNqTolfzRNoZDjCMAK/hmU=;
        b=wN04zlKmeCcLvTKrFCoXdnhh3ycNaQq+e5MsN+WXiFhScO8A7tMqzRnzGeoogOLf85
         jlScTDWmozHdBaLKSPmhSHUm2fgJs6mft8W8lnpxVtBge+KZmZg0j1HjGDaV8pi/t0xN
         n8m/pF0HJv8/78oH/Gdxz+McM0U1PvaXe6kWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Imy7tetjYbdypPer6RWiFBPRGI8Jf+0TnydX8GTXnjym/UWraKDe1aDV+wTOHKZ3LQ
         NZGUnLndVlxCDq4phHSTzDwCuWSxN1R80VDiW3XnSg1AEbLyuz1DtBm2Crx/Pb7MEuqr
         22wYOL/BlBCIw72W6IRVWhYZ4x9ePQSvJPKJo=
Received: by 10.42.167.200 with SMTP id t8mr347791icy.270.1308131333218;
        Wed, 15 Jun 2011 02:48:53 -0700 (PDT)
Received: from elie (adsl-68-255-110-0.dsl.chcgil.sbcglobal.net [68.255.110.0])
        by mx.google.com with ESMTPS id w8sm155892ibh.18.2011.06.15.02.48.51
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 02:48:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DF87C0D.3050108@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175817>

Hi Markus,

Markus Duft wrote:
>>> Junio C Hamano wrote:

>>>> +++ b/compat/fnmatch/fnmatch.c
>>>> @@ -127,6 +127,10 @@ extern char *getenv ();
>>>>  extern int errno;
>>>>  # endif
>>>> +
>>>> +# ifndef NULL
>>>> +#  define NULL 0
>>>> +# endif
[...]
> ping... is this one ok now?

Hopefully yes. :)  "git log --grep=Interix origin/pu | git name-rev
--stdin" tells me that Junio applied it as v1.7.6-rc0~30
(compat/fnmatch/fnmatch.c: give a fall-back definition for NULL,
2011-05-26).

> http://thread.gmane.org/gmane.comp.version-control.git/174407/focus=174600

That one I know less about, but I assume writing a hypothetical blurb
for the release notes (as part of the commit message) would help.

The main question I have is what the positive effect of removing the
NO_SYS_POLL_H and NO_INTTYPES_H settings from the Makefile is --- does
new Gentoo not work with those settings?  Is this a preparatory step
before giving people time to upgrade and then removing support for
those settings from elsewhere in the codebase?  Whatever the answer
is, the log message would be nice to document it.

Thanks and hope that helps,
Jonathan
