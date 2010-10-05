From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] Add git-remote-svn
Date: Mon, 4 Oct 2010 21:26:23 -0500
Message-ID: <20101005022623.GE10818@burratino>
References: <4CA86A12.6080905@dbservice.com>
 <1286108511-55876-6-git-send-email-tom@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 04:29:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2xHm-0001W4-FJ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 04:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab0JEC3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 22:29:41 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53556 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184Ab0JEC3l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 22:29:41 -0400
Received: by qyk10 with SMTP id 10so2029643qyk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bdJAJt/Jtuic7QCuFCH3xF5jzjgcuZSSKGWiDqJh6hc=;
        b=B283r7HaRm7GS5HHDu37elYfHJ7ztUERhUhjd+xfwICJS3sGFTMh99VVIR9L1TlmT4
         y2YFhGMVLfwnk+/d0Khp6KGzrBPO++qBqbi8jr47ntqsc/riAN6qQMmDdyXh1IevAYcq
         j+BTKX/YXVBwaTUK1Zj3+NBsy18Ua6yNIrUNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AZ5k0f+LgN09TUjndmIhuxIKEb1UseBPBoIk9BLj2BGjjeFzlDUNuHh1RSu8cKWGCi
         zyNoPgyffESiQU/YKIndPhIyyD5PiVFjHE/eX5VmJ3p5E1qBUV457gaeiMgo+XFj/lvq
         1cSBgVEgghLuB7LowtgTXwX191/zCVJQvM1VQ=
Received: by 10.220.199.66 with SMTP id er2mr19385vcb.185.1286245780133;
        Mon, 04 Oct 2010 19:29:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id p28sm2452844vcr.22.2010.10.04.19.29.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 19:29:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286108511-55876-6-git-send-email-tom@dbservice.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158161>

Tomas Carnecky wrote:

> This is an experimental git remote helper for svn repositories. It uses
> the new git fast-import-helper.

Not sure how to review this without some sense of how the fast-import-helper
works.

> It uses notes to save the git commit -> svn revision
> mapping (refs/notes/svn).

Good. :)

Caching the mapping back in the other direction would be very simple.
A simple array of commit hashes indexed by svn revision number would
not take up much space in memory and could easily be randomly accessed
on disk.
