From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] post-receive-email: defend against non UTF-8
 i18n.logoutputencoding setting
Date: Wed, 14 Mar 2012 14:55:09 -0500
Message-ID: <20120314195509.GA31686@burratino>
References: <20120308115119.GA2604@burratino>
 <20120308115957.GB2750@burratino>
 <20120314233609.04a2a37b@zappedws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Jensen <jon@endpoint.com>
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:55:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7uI7-0002n9-O7
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030942Ab2CNTzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:55:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57861 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757802Ab2CNTzS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:55:18 -0400
Received: by eaaq12 with SMTP id q12so1261423eaa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wjL5RlmDadGgIvehXCeKHS5d4jjX8b+aMVJR2Gn+CV0=;
        b=OzUtcF7j1NxLmZJzV88bc5PeIHGEodt4cvuakOhE3ZWmC0Ny5deV6PIXO5sQlT5/NQ
         crCNurx6j7/9d9cdQqwrwaHMVrPHraR+7folqG4LUEoLGLmjcljSijoYc4C1dCFA6G7j
         d/b6LunY5BoagMa2p77ExokwWBF945pVU1/R2YWkQX3a/MU2+RfeodQ0oNnWFVQpU7Vz
         0aRBYNxcAM0gsyW8btsSkRA2zpPx4O+TqcslbmE9u2H9QGmVeZxVMMrHnOZz0SVKyAOF
         qUDAUw1i+hIpSVohNam4bhj5teJYModjRP8jRQCvurH8Dgl0ZcQGyVic+nl137SA94sj
         yXyw==
Received: by 10.50.159.161 with SMTP id xd1mr14099299igb.15.1331754916298;
        Wed, 14 Mar 2012 12:55:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id md6sm4066442igc.0.2012.03.14.12.55.15
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 12:55:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120314233609.04a2a37b@zappedws>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193158>

Alexey Shumkin wrote:

> I'd like to remind then following aspect
>
>> My proposition was in to send email message in explicitly defined
>> custom encoding. Why? In development process under Windows non-UTF-8
>> encoding is used (cp1251 in my case). So, filenames have this
>> encoding, and as we know Git stores their names as is
[...]
>>                                                                 with
>> core.quotepath= false

Sure.  Do you think this patch makes that problem worse, and if so, do
you have any ideas about how that could be prevented?  Otherwise:

>>            Making the email charset configurable is left as an
>> exercise for the interested reader.

I did not want to do that part because I do not trust myself to
understand the needs of people using non-utf8 and test it
appropriately, but I tried to make sure the patch was structured in a
way that would make it easy.

Hoping clarifies a little,
Jonathan
