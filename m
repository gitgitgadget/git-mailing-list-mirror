From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git describe bug?
Date: Sat, 10 Apr 2010 17:28:25 -0700
Message-ID: <20100411002825.GA23075@spearce.org>
References: <0B8BD2B7-E6F9-4EFC-BCD6-2B2E876AD1FC@spy.net> <20100402183147.GA20007@spearce.org> <4BBB0377.8080007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dustin Sallings <dustin@spy.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Apr 11 02:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0l2e-00062I-9G
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 02:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab0DKA2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 20:28:30 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:43460 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab0DKA2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 20:28:30 -0400
Received: by yxe1 with SMTP id 1so1965902yxe.33
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 17:28:29 -0700 (PDT)
Received: by 10.150.120.33 with SMTP id s33mr1575387ybc.50.1270945709174;
        Sat, 10 Apr 2010 17:28:29 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 20sm722502ywh.48.2010.04.10.17.28.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 17:28:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BBB0377.8080007@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144615>

Andreas Ericsson <ae@op5.se> wrote:
> Right now the behaviour is inconsistent.
...
> So as you can see, something else is going on. Both tags here are
> stashed as loose objects and both refs are unpacked.

Its the order the names were iterated out of the directory by
readdir().  Or the order they were sorted by lexographical ordering
during for_each_ref().  I can't remember if for_each_ref() sorts
the items before processing.

But either describe uses the first item it found for a given commit
if they have the same priority.  There's no notion of date being
factored into the decision of which tag to keep.

I'll work up a patch right now.

-- 
Shawn.
