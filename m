From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v2 0/3] add strnncmp() function
Date: Tue, 17 Jun 2014 12:09:12 -0700
Message-ID: <20140617190912.GA23557@hudson.localdomain>
References: <cover.1402990051.git.jmmahler@gmail.com>
 <53A02195.8080202@web.de>
 <20140617154953.GC5162@hudson.localdomain>
 <20140617174817.GQ8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 21:09:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwykz-00080g-VC
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbaFQTJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:09:17 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:57534 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281AbaFQTJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 15:09:16 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4365452pdj.8
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 12:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SdybHmQo4T4vEy7GgxTAwyit3qoggSMKlUJyjBJwuCU=;
        b=0wm6p3FJv1qYfoOzP0yaFIdc66b+//z3SY+bMiGRuif2DbIScioNHaf3iPNqH9GrA0
         ive+lrfu+zjq/mcxwJVoSKgjyPO7AVv5J4FcA9GoKFlIXP0eD6i+mKySyc97WQu8T/I1
         9cxwnbYXmLEw5gGBd385pGSCia58xxl4qES+HTKJssJYalCMySn9yRswXIkN4SBur9Bx
         7W+TSO2k2Qb/RV9/n9/S+CcFihod+myrXdArEjvkO3F6PkNAeP1bCEO2u/GM4VKWRSJx
         gAKdBWCqrSs9uZqSdVM/8/ymIcxwa3IXwR3x0TaUBqDr3+bhOsMN2djBnuLy+vFTq/PB
         JYRg==
X-Received: by 10.66.235.34 with SMTP id uj2mr35129923pac.28.1403032156172;
        Tue, 17 Jun 2014 12:09:16 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bz4sm25269040pbb.12.2014.06.17.12.09.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 12:09:14 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140617174817.GQ8557@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251938>

Jonathan,

On Tue, Jun 17, 2014 at 10:48:17AM -0700, Jonathan Nieder wrote:
> >> On 2014-06-17 09.34, Jeremiah Mahler wrote:
> 
> >>> Also, strnncmp() was switched from using memcmp() to strncmp()
> >>> internally to make it clear that this is meant for strings, not
> >>> general buffers.
> 
> Why shouldn't I want to use this helper on arbitrary data?  One of the
> advantages of other helpers in git that take a pointer and a length
> (e.g., the strbuf library) are that they are 8-bit clean and can work
> on binary data when it's useful.
> 
> Thanks,
> Jonathan

Yes, along with the performance of strncmp() being worse than memcmp(),
and Junios explanation of "counted strings", I think this was a bad idea.
I will switch back to the memcmp() version.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
