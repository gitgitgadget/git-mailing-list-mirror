From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH] Fix invalid menubar and toolbar entries in plugin.xml
Date: Thu, 14 Aug 2008 21:13:51 +0200
Message-ID: <48A483EF.10508@gmail.com>
References: <48A3310A.8080306@gmail.com> <200808140747.35753.robin.rosenberg.lists@dewire.com> <200808141942.55448.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 21:15:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTiHt-0001WU-4R
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 21:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbYHNTOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 15:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYHNTOE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 15:14:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:16870 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbYHNTOC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 15:14:02 -0400
Received: by ug-out-1314.google.com with SMTP id h2so440420ugf.16
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6RrR2LEPwJW7HvtJQ30LPGO0MDGPktgNJC9TgQE5iRY=;
        b=wqTiPJTQgrcF+8HLewyUhgPhqQt0wuG8Rc3AtRmltjzdJdNocHjt3Aj2/Dz/K7cXey
         nCwbZwOJHS0aKwikdD/elCHWjAqheuHZaw0rMj7BxLgL3rAXR92yuM0yBu7byCV+pWsQ
         dWlW2xn33Ku17+W1C/ZRXfoUm07Bx5NIxOV9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=snAQl/aIOTzUEcrLN131FmyrjsFy7LETEur0tD75fdtDdfn8+ssWKkcC8BwOFCLNi3
         lGK3uTg/q88cpw9hc6A69mrltuYa24e/pBF+iVq+4wifk5KEMuDzcIzF9yl+xNQ5iklM
         ORWN4/ioPE4/gQ99/7ys+KW8ZPf2vpQbnFz0M=
Received: by 10.210.116.10 with SMTP id o10mr1816748ebc.165.1218741240740;
        Thu, 14 Aug 2008 12:14:00 -0700 (PDT)
Received: from ?192.168.1.20? ( [84.202.12.123])
        by mx.google.com with ESMTPS id z33sm559434ikz.0.2008.08.14.12.13.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 12:13:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <200808141942.55448.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92389>

Robin Rosenberg wrote:
>>> The menu entry was not used, and was causing an extra
>>> empty space in the menu bar.
> 
> When I applied this patch the Git menu disappeared. (3.3)

Ah, I see. It appears the menu was used, but because it had the wrong
path ('org.spearce.egit.ui.gitmenu' instead of 'additions') the four 
entries did not show up in 3.4. 

Either way I suggest the patch is still valid, because it removes
the Git menu from the menu bar. This is consistent with what other 
platform plugins do, ie. not populating the main menu bar with plugin
specific entries, but instead using sub menus, context menus and views.

In the long run we should probably also move the global toolbar entries
to the synchronize view, when I get the chance to look at implementing 
that. 

Tor Arne
