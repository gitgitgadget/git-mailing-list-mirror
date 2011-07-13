From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/17] revert: Don't check lone argument in get_encoding
Date: Wed, 13 Jul 2011 01:30:11 -0500
Message-ID: <20110713063011.GB31003@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-4-git-send-email-artagnon@gmail.com>
 <20110712165949.GB13578@elie>
 <CALkWK0mWFvDFdOhQuZK-E-_78YGdXve42NX=Zj6S4BTDu+pTzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 08:30:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgsxp-0002bM-BL
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 08:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928Ab1GMGaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 02:30:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54470 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab1GMGaV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 02:30:21 -0400
Received: by iwn6 with SMTP id 6so5293486iwn.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2n4+kOCvgjSbPiNLlZ++9iwTmfHUrAjXRPNr0upPnqY=;
        b=HzuyvGBM9duvZsyToNoratmXLvAMuym1WLUbAV6tf1eNqhpuQc2Mhhi4DEr4fLwKDg
         Tg5PuPUkDmbCpk99At+EOormfVIccQ+bWqQxlvarQk2tQzK3NhxlIEMzb2qpUwDvOQDI
         FAnw+RI1HqITd6/QNJI/Ze0LysPZAldejB2E4=
Received: by 10.43.59.142 with SMTP id wo14mr754727icb.373.1310538620584;
        Tue, 12 Jul 2011 23:30:20 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id e1sm15655405icv.20.2011.07.12.23.30.18
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 23:30:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mWFvDFdOhQuZK-E-_78YGdXve42NX=Zj6S4BTDu+pTzA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176994>

Ramkumar Ramachandra wrote:

> I should have done this earlier.  Thanks for being so patient :)
>
> revert: Don't check lone argument in get_encoding
>
> The get_encoding function has only one callsite, and its caller makes
> sure that a NULL argument isn't passed.  Don't unnecessarily double
> check the same argument in get_encoding.  As a result, avoid passing
> "commit" around, and remove a string marked for translation that will
> never be shown.

Getting closer.  This still leaves the motivation unclear --- when I
read it it sounds to me like you're saying that avoiding unnecessary
code is the motivation, and that not passing "commit" around and
removing a string marked for translation are means to that end.
