From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: git rebase -p doesn't understand -X
Date: Fri, 15 Apr 2011 12:21:24 -0500
Message-ID: <4DA87E94.2050700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 19:25:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAmm6-0000Y1-JF
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 19:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab1DORZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 13:25:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41775 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab1DORZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 13:25:36 -0400
Received: by wya21 with SMTP id 21so2428966wya.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=iuAI7ZJdV+7HaMDuDAi4a8eiHdtiqJPHKHde9H1XJ+g=;
        b=VcyUO6HR8b9UP4+uInmGq8N8hobdjl4Y7JfB983Nyuv18D1Ut54/oIzxD7I/aj8K7Z
         d4VmgP8r+tMC36iPkcF8l9cIYOQK9Y3qVNlgqnyiOI9whL9do6vZwgQMTc68wCoJGCGy
         sTOFMCQkTFqF0WlrgWr16Iry5cGIh6cQKW1xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=jBrbYuVKasdC/DzdRcUJWOSz6z47GzGC7dILsJ9m2a5Qf3GY487YsuawwWkMw+fk57
         PIupeMuIy+Fn8ea5ghSKUH2VuYAJvncjYLbxzRaAmxm+bk8RsfjjEe0BCkn+kacemIeg
         VPaZh4jD0eH/WBkAla0O/+vGbcbLlLR4cEbNA=
Received: by 10.227.169.2 with SMTP id w2mr2266415wby.77.1302888335365;
        Fri, 15 Apr 2011 10:25:35 -0700 (PDT)
Received: from [192.168.1.103] (24-155-176-18.dyn.grandenetworks.net [24.155.176.18])
        by mx.google.com with ESMTPS id h11sm1744165wbc.26.2011.04.15.10.25.31
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 10:25:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171620>

Hi,

I'm trying to rebase a rather large series of patches, which also 
contains a couple of merges which I'd like to recreate in the rebase, 
and for the other conflicts I'd like git to automatically choose 'ours'.

So, I run
     git rebase -p -X ours -X patience -X ignore-all-space --onto foo 
bar baz
and I get
     error: unknown switch `X'

Clearly this is because when you use the -p option, everything goes 
through the --interactive engine, instead of the normal procedure. I 
would still like to maintain that this is a bug, and that even though -p 
uses a different engine, to be able to recreate the merges, it should 
still be able to let me tune the overall merge strategy.

Is there any work around to allow me to achieve the same result?

Thanks!

-- 
.marius
