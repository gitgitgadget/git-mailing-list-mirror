From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Wed, 04 Jun 2008 02:39:58 +0200
Message-ID: <4845E45E.9030504@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806032224.08714.jnareb@gmail.com> <4845CF9F.10604@gmail.com> <200806040211.29430.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 02:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3h2r-0007PX-Qp
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 02:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYFDAjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 20:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYFDAjN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 20:39:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:23093 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbYFDAjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 20:39:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1179265fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 17:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=lQ+f6+aKqZH6/DkhM2QmT4Zv3zCveHDX8nNchFzgk8o=;
        b=opslM5m4RIpQihwjhNviw/H/dSLcepC9o/V2PxnVBYMXmJNTQS+aDhZEtq5oLyQ7EeC6C6UuHiGMgjxZKIT5wutkZkvMz2TT4vEkofPcQ3cc8RWS0zja3rgVBeqrLPlauD+ILG2JvNSMYCqot/vyOQh3J7Aw62DOkRoRa0VSiSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ABBZcpdWjnU000zUXQMPyprnlLCbsMsB5Y4nxVpR96m5RcuM0lDsa2ldJpNlhiY+uIkfw991fMPb8lYZ3Sd2IpieZ0ImAch7FvNPLWBJW9m1ABsJIKR6OJMAnwbedV+imPevMolDhmuFFx8BwS6UucEJGCAG2aY4Dg7J8SPL934=
Received: by 10.86.98.10 with SMTP id v10mr62599fgb.46.1212539951322;
        Tue, 03 Jun 2008 17:39:11 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.209.222])
        by mx.google.com with ESMTPS id 3sm844119fge.3.2008.06.03.17.39.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 17:39:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200806040211.29430.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83737>

Jakub Narebski wrote:
> And snapshots [and blob_plain].  We certainly want to stream snapshots, as
> they can be quite large.

Yup.  I suppose that those need to be cached on disk rather than in 
memory, so they need a separate cache.

> [Parents in blame output:]
> It perhaps makes no difference performance wise (solution with
> "git rev-list --parents --no-walk" has one fork more), but it might
> make code unnecessarily more complicated.

A few lines.  *shrugs*  Probably actually easier than adding stuff to 
git-blame's output, but I won't argue against the latter if you want it.

> use AJAX together with "git blame --incremental" to reduce latency.
> It was done by having JavaScript check if browser is AJAX-capable,

Unfortunately there is no such check (and I doubt it's doable without 
cookie or redirect trickery) -- you'll find that the blames on 
repo.or.cz don't work without JavaScript.

-- Lea
