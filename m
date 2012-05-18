From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Fri, 18 May 2012 17:38:26 +0200
Message-ID: <20120518153826.GB1738@tgummerer.surfnet.iacbox>
References: <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <4FAA2CAF.3040408@alum.mit.edu>
 <20120510121911.GB98491@tgummerer>
 <4FAC0633.90809@alum.mit.edu>
 <20120511171230.GA2107@tgummerer>
 <4FB01080.6010605@alum.mit.edu>
 <20120514150113.GD2107@tgummerer>
 <4FB1746A.6090408@alum.mit.edu>
 <20120515134916.GA2074@tgummerer.unibz.it>
 <4FB2700D.5000900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 18 17:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVPGH-0007xR-1l
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 17:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969Ab2ERPic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 11:38:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50011 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab2ERPib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 11:38:31 -0400
Received: by wgbdr13 with SMTP id dr13so2900674wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3pw6gSP2j7zMgBz1VCh5C7wBxtHCrkYgfB0hUGClf/M=;
        b=HkLhtAGZYZ5Iow93gmnBq3FJE6kGWSSW1hNhQr/DzBz5QGv36JDexiC6KW4KtwZMIf
         mX3Ekz/DF8YAvMEtjHjVHw48mHZ9VuJgYUN9Q+9XfWKJ+lS0govyQQImnXkX6LGEyEer
         jr6TDuU4SxLJHwd7DxXB/zRaOUggwsw26BdZ2kZJUd2XhRXrQXxLVYRLxKALZD+aRWIq
         9Vtpa7EyYEmvBRIbCj3qnL5QBk87vjeioe/KyNosqfDAL6h6VMj8E4/Iy6P2FLA4nPjO
         kBeO9S/Aat3AT671vZp4rOXZhxOlJKlky5Zeq0fXBWbZW2vncTmREEJZfwtxOT7kBDVx
         XRqQ==
Received: by 10.216.143.200 with SMTP id l50mr7689182wej.58.1337355509911;
        Fri, 18 May 2012 08:38:29 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id k8sm2666884wia.6.2012.05.18.08.38.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 08:38:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB2700D.5000900@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197959>


> I suggest that you apply the same kinds of cleanups to
> git-convert-index.py (which I personally haven't looked at yet at
> all).  If you want my feedback on that script, please let me know
> when you think it is ready.

That would be great, if you have the time to do it. I'm not
completely finished with it (docstrings and conflicted data writing
are still missing).

I'm not sure about the read_tree_extensiondata method, if I should
extract a method, which only reads one entry, but I'm not sure that
would make any sense, since there would be a lot of parameters and
return values to the function.

The same thing is in the main method, where I'm not sure if it's
better to extract the read_index and write_index functions, or
just leave the code in the main method. My guess is that it makes
sense in the main method, since there are less calls, but it
doesn't make sense in the read_tree_extensiondata method?

Another thing I'm unsure about is the write_directory_data method,
if there is any way to replace the try/except with something
simpler?

--
Thomas
