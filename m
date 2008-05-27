From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: only display "next" links in logs if there is
 a next page
Date: Wed, 28 May 2008 01:30:42 +0200
Message-ID: <483C99A2.90909@gmail.com>
References: <483C97E7.2020504@gmail.com> <1211930742-24978-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 01:31:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K18dk-0001nE-4u
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 01:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbYE0Xao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 19:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbYE0Xao
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 19:30:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:47268 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbYE0Xan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 19:30:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1635680fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=VfdOZVAdNXg+WWN/65CFawCJDav+M62fre4MNMQEIvU=;
        b=guMlhh0zhNjoM5eVk28SnLfbJ5vBavis8no2CG79bH0d55NwL3t2m/mJ8smtx0tEfZihPUM9bDL1TIqte5b+eEMQ58+JG35ZjrVYP4tL7K3nKnt2y+10Jd1PBYfXVmk2hPZQeY+HSErTNSxJw754xIrr6dUw/Fpmu6uCy8iEA/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HnKjp5WjI0YJggAMUfUvAYgM5zy5hxB4F5HQK3Cu2KJkHB4LdShAjdIaduqbu9gM7kzhAM49pIEeGAXZZ86WxqX8OwgosA0QuGGVOcfH1JeIfVtHJuiBrE0jTiwQ9M024JGceS/6MURkYhPjrEiFcQebRtDClaFo1C3RVY3pSeE=
Received: by 10.86.95.20 with SMTP id s20mr6058259fgb.70.1211931042557;
        Tue, 27 May 2008 16:30:42 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.209.73])
        by mx.google.com with ESMTPS id d6sm16022865fga.2.2008.05.27.16.30.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 16:30:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1211930742-24978-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83063>

Lea Wiemann wrote:
> There was a bug in the implementation of the "next" links in
> format_paging_nav (for log and shortlog), which caused the next links
> to always be displayed, even if there is no next page.  This fixes it.

Oh, one more thing I forgot to mention: I've tested this with a small 
(single-page) log page and a long log page.  In both cases the "next" 
links get formatted correctly, and they stop linking to the next page on 
the correct (= last) page.  The only thing I haven't tested for is 
off-by-one errors, but I'm reasonably sure that $#commitlist >= 100 is 
right.

-- Lea
