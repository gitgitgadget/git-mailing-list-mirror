From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Fix git_mkstemp to return an error when path is too long.
Date: Thu, 26 Jul 2007 21:42:24 +0200
Message-ID: <1b46aba20707261242j722ab827w6ff17ccbca47737d@mail.gmail.com>
References: <46A7F9C4.7030004@gmail.com>
	 <7vabtjbxip.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE9EY-0004kO-Rc
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 21:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765908AbXGZTm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 15:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764506AbXGZTm0
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 15:42:26 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:44052 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765727AbXGZTmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 15:42:25 -0400
Received: by nz-out-0506.google.com with SMTP id s18so564304nze
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 12:42:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bg5LIlwo6E2k1M3UIAprp7onDlMXZV/EnoAE9gIpkNOaFOZpdwt/zCgxkx6uDyoHmAilNJzUA8EdqOYeu+PL0d8wXwHi5D0WtRfcwsXFHYSvbEMb2JDzf0TOvsV1mnt/TSg1mh2ug24lSgCCaGgXZFnsA6hWARlb/XZTqNM35XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZkVDpIJK7yxkk9Y1jqgXuLZAt8QM46e9bsLMGsZsCLnAe19liIkUQzmXLySaWv8+nyC4s+5tcgClNSgBYy91CUPs0R1TXTB7anwmKOJNPLAHks9T0yEKHmi+Ra2QX58feqQQyXzXw+JE37JdcNyny+V+gLpMQ/OR2RA86arSgyI=
Received: by 10.115.94.1 with SMTP id w1mr2144900wal.1185478944333;
        Thu, 26 Jul 2007 12:42:24 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Thu, 26 Jul 2007 12:42:24 -0700 (PDT)
In-Reply-To: <7vabtjbxip.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53862>

I like that new solution. ENAMETOOLONG is fantastic!

Usually, the function is called using the long PATH_MAX constant,
however, the function doesn't force you to supply an insanely long
buffer like that, and therefore is nice to say when the limit is exceeded.
