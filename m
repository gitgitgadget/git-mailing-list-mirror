From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix "Use of uninitialized value" error in 'history' view
Date: Sat, 5 Apr 2008 18:38:17 +0100
Message-ID: <200804051938.17855.jnareb@gmail.com>
References: <200804041623.44595.jnareb@gmail.com> <20080405164303.30566.qmail@47fa24fd520dbf.315fe32.mid.smarden.org> <200804051916.14568.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 19:39:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiCMI-0001tq-8L
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 19:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYDERiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 13:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbYDERiX
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 13:38:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:40489 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbYDERiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 13:38:22 -0400
Received: by fg-out-1718.google.com with SMTP id l27so609479fgb.17
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=p5cx+BkUn9///ERRBOTZySACTUnvyaEbsR/i4SLDuuI=;
        b=FCe0jHMbQ/uSyRAoT91U2x2S4ZrBXMxNO/72ZjTVVKL6QWnH4/ZSbxOj3gT6VxQ0Y2b8C32mzh/XfpvjEvBrjb/uGPy9OazCduhq/2319MzxToYuBKeT3QNUNwjPsEjuL5tQz43KgbEvghe5I49gNRXdP+J0mm8PW45ec7M16V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=huDdyq9dS0zVa99kBi9MMbo4+IMR+g8OEFSzhyEXSgNoRxVZTgZelMmEnWwaiU29IAU5rKLEckx4h+MN4fDLdsbMG9FVgTvRL9cd7i2JtYl9NmfMNNHRRmSc3MZBXqiJAe9uaUUsu4jENuyYhbBQfYr9uqapSJRuYycFlzG6wI8=
Received: by 10.82.152.9 with SMTP id z9mr1123356bud.51.1207417100893;
        Sat, 05 Apr 2008 10:38:20 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.198.110])
        by mx.google.com with ESMTPS id p10sm9469359gvf.8.2008.04.05.10.38.17
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Apr 2008 10:38:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200804051916.14568.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78855>

Jakub Narebski wrote:
> On Sat, 5 Apr 2008, Gerrit Pape wrote:
>> On Fri, Apr 04, 2008 at 03:23:42PM +0100, Jakub Narebski wrote:
>>
>> Do you know whether this fixes http://bugs.debian.org/469083 too?  I
>> took a short look back then to fix it, but didn't manage it in a
>> reasonable amount of time.
> 
> No it does not.
> 
> 
> I have found what causes this bug. [...]
> I'd send in a bit patch fixing this bug (making is_deleted() more
> robust).

It should be enough to revert commit 6aa6f92 (gitweb: Add 'status_str'
to parse_difftree_raw_line output); it should fix this bug.

P.S. Mentioned commit was done for micro-optimization: "<str> =~ /D/"
is a bit faster than "<str> eq ('0' x 40)" in the case when it doesn't
match.
-- 
Jakub Narebski
Poland
