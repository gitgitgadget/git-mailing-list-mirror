From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Sun, 22 Jul 2012 13:03:05 +0200
Message-ID: <B0A78CAD-49FA-4E03-86C0-1AA4023E60B7@gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net> <5009892E.9010808@kdbg.org> <20120720170913.GA14057@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 22 13:03:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SstwT-0001ml-6f
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 13:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab2GVLDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 07:03:11 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:37373 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab2GVLDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 07:03:09 -0400
Received: by weyx8 with SMTP id x8so3629937wey.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=zEqtVmn+Yi8J1KPO6krk8CiJFnzWU23Gw1/QvANORA8=;
        b=mwwgfyERV2xkO6aHsUsiYn/IsHTW5q047Yih3C8QwoSVniErC0ZCEtL0pQljWac8JR
         KLOdYUh50EWi8xFmGuFsYoReFt3iBeO6TJaxwxFYxXLIxEpJOUJqNQMfJGj3qbMWiVkf
         lHf1NGpK2LYr/qOHeRSrR3qFOGHuz+ZGvC+JwRzvNfMMqCdC6NC1z7Bg9FhZwqa2H/nA
         fj3w2m8D2fP2FHZvDeB9iy5XAIXNchVMozpegpLgPZllBgDz0cYSG/7lPNpm/NoW/Hn/
         wY8UrSNYatbg5c1eHnrbuYUEvBFmC1EzU1RnVYPXmMFtfe4QA2bEA0yfmrM0QOkMRgAo
         487w==
Received: by 10.216.0.212 with SMTP id 62mr6783601web.92.1342954988331;
        Sun, 22 Jul 2012 04:03:08 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id fu8sm10228878wib.5.2012.07.22.04.03.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 04:03:07 -0700 (PDT)
In-Reply-To: <20120720170913.GA14057@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201845>

On 20 Jul 2012, at 19:09, Jeff King wrote:

> On Fri, Jul 20, 2012 at 06:37:02PM +0200, Johannes Sixt wrote:
> 
>> Am 20.07.2012 17:44, schrieb Jeff King:
>>> So I think a suffix like ":d" is probably the least horrible.
>> 
>> Not so. It does not work on Windows :-( in the expected way. Trying to
>> open a file with a colon-separated suffix either opens a resource fork
>> on NTFS or fails with "invalid path".
> 
> Bleh. It seems that we did too good a job in coming up with a list of
> disallowed ref characters; they really are things you don't want in your
> filenames at all. :)

How about using '@' as an escape character ?

-Alexey.
