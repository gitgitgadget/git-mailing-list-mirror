From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 6/7] web--browse: use (x-)www-browser if available
Date: Fri, 3 Dec 2010 18:42:25 -0600
Message-ID: <20101204004225.GA15906@burratino>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com>
 <7vaakmmrkj.fsf@alter.siamese.dyndns.org>
 <AANLkTinWD53M2VjiWgeA0Qwx3OHzR2A09Y+AB2B9o1df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 01:42:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POgDB-0005H1-0z
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 01:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab0LDAmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 19:42:43 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36739 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515Ab0LDAmm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 19:42:42 -0500
Received: by yxt3 with SMTP id 3so4597155yxt.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 16:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JjeqDZm9hcWwM6qycZb9st6GdGb66xKeRxqSloCUEr8=;
        b=ch2SEXtq3IumKyc2ZpbqUJCS1r5SRakDPI9P6bhxmPMxAiamwFOElS88L4tJUuAc62
         19Tfs2vXgnbgQ1C1lMKBwC/7DHNZ8rnf6JxepxQj1aQCuBOxbCPRp6sDGLiBKvthyq8N
         1ufHyzU1b2YGnavKH3/zz3Qx7kD3nk34DiLHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pu1zCWB9LIwFrA4iY5xI9QfqDKgn7LachqYzZiEtNMhazTxRUyswY2z8uOHT6wyfpM
         n8WfQoA+/UtJbUiUk2irATd8N+4c0QHBDM34Lgqy04qhRT2peBOhGc/P+7wh8n4/rDxZ
         CQF/x8V8bTV8Ea2i4MEKLhd+ghWPwMlM7CgD8=
Received: by 10.150.51.10 with SMTP id y10mr2102561yby.286.1291423361861;
        Fri, 03 Dec 2010 16:42:41 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id f46sm1436295yhc.33.2010.12.03.16.42.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 16:42:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinWD53M2VjiWgeA0Qwx3OHzR2A09Y+AB2B9o1df@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162875>

Giuseppe Bilotta wrote:

> I do believe that Debian encourages the use of sensible-browser (that
> does the BROWSER and *www-browser check itself) rather than manually
> going to look at those specifications.

My impression (by analogy with policy =C2=A711.4 "Editors and pagers") =
is
that one is encouraged to make the default configurable at compile
time and use

 - first $BROWSER
 - then something desktop-specific
 - then the configured default

and set that default to www-browser or x-www-browser, depending on
whether your program uses X.  That way, non-Debian systems benefit
from the changes you introduce, too.

> An alternative approach would be to get rid of the *www-browser and
> BROWSER patches, and just use xdg-open if it's available. Which again
> raises the issue of how to enforce opening the page in a new tab.

Yes, in this case that is the ideal (assuming xdg-utils has wide
enough adoption).

I think xdg-open has just as much a reason as we do to encourage
opening the page in a new tab.  Would it be hard to make that happen?
