From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Fri, 26 Jan 2007 10:36:18 +0000
Message-ID: <200701261036.26012.andyparkins@gmail.com>
References: <20070125173954.GA13276@spearce.org> <Pine.LNX.4.64.0701251830400.3021@xanadu.home> <7vmz4663xq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 11:36:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAOS1-0006Pk-HA
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 11:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbXAZKgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 05:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbXAZKge
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 05:36:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:11609 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbXAZKgc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 05:36:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so680902uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 02:36:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uGMfOrvYKHPwQxNsUrRZViuStR7698JuhAF6ufZ0GPL5I3Yto57tWOzCoaA7s5a7NvkRhtmqcfZSKivmYyzKFU85UDKH9saPZLsQXZoYfax7puPdGWkCEpvTXmu1cF9T0yKMSvr6xhY9j1SDY3LduqkZ3/jFdtWNzsefPkG/RW0=
Received: by 10.66.244.10 with SMTP id r10mr2472078ugh.1169807791407;
        Fri, 26 Jan 2007 02:36:31 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 28sm3499988ugc.2007.01.26.02.36.29;
        Fri, 26 Jan 2007 02:36:29 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vmz4663xq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37834>

On Friday 2007 January 26 00:13, Junio C Hamano wrote:

> Hmph.  And an option --no-number to disable this is probably not
> worth it, as it forces the existing scripts that wants the
> tagname to be updated to pass that new option.  If the users
> need to update their scripts anyway, they can sed/expr the
> number out just as easily as passing the new option.

Actually, the more useful switch would be "--tag-only"; then

x=$(git-describe HEAD | sed 's/-g*//')

In scripts could become

x=$(git-describe --tag-only HEAD)

Then, the suffix can be anything we want, and can change in the future without 
affecting these scripts.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
