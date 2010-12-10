From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] Re: transport-helper: avoid dependency on thread-utils.h
Date: Fri, 10 Dec 2010 13:46:37 -0600
Message-ID: <20101210194637.GA6801@burratino>
References: <20101210114839.GA5771@burratino>
 <7vhbeleber.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 20:48:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR8wu-000507-R8
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 20:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855Ab0LJTrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 14:47:00 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:43415 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab0LJTq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 14:46:59 -0500
Received: by vws15 with SMTP id 15so648221vws.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 11:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MHSdmPTkOV14s/Hv91fEk868bQmyl95CCI6cUoxaoe8=;
        b=pT5ZVxS/8QCT6zIiZeI9DiYmmWUTZfLIqZCUwfZQOZ+6hH7wiKPxT00P9HIW5XS0Qn
         jJBtwe6wdK6e6k2b7m8tS55mNRiyqKkSgTqzu0xipfitItrZJxumaXNzwKYWh44cFGSR
         r/eZZHDc43mNHPXKFNKwGGwWDE+sq/no/H77I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DQqX3UIxYOw+T0cCMrUJh7sSDps4PBXINrsQXE6AqPSrsxY+CAo/wNVQAtlSHkJqut
         4Frrx78wNgLsNQ4iOZ5Ez2N4sqFAR6mI79YP22axqXyfU0p21+MDChGMzkiMLiaLFhr9
         b/F/joTo3nEmKQLBJnHyOCL4C4eshiulYQZIA=
Received: by 10.220.178.135 with SMTP id bm7mr29784vcb.19.1292010418652;
        Fri, 10 Dec 2010 11:46:58 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id w15sm562938vbx.10.2010.12.10.11.46.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 11:46:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhbeleber.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163433>

Junio C Hamano wrote:

> I wonder if it is better to do something like this instead.

Yes, I think so.  How about this?

Jonathan Nieder (1):
  Makefile: transport-helper uses thread-utils.h

Junio C Hamano (1):
  simplify inclusion of pthread.h

 Makefile               |    3 +--
 builtin/grep.c         |    4 ----
 builtin/pack-objects.c |    4 ----
 thread-utils.h         |    4 ++++
 transport-helper.c     |    4 ----
 5 files changed, 5 insertions(+), 14 deletions(-)

-- 
1.7.2.4
