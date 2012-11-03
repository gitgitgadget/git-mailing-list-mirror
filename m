From: Matt Arsenault <arsenm2@gmail.com>
Subject: Re: [PATCH] git p4: catch p4 describe errors
Date: Sat, 3 Nov 2012 16:12:07 -0700
Message-ID: <5747DA7F-485C-4AF3-88A4-B19F517C1E11@gmail.com>
References: <1351593879401-7570219.post@n2.nabble.com> <20121103140946.GB4651@padd.com> <20121103230701.GA11267@padd.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Arthur <a.foulon@amesys.fr>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 00:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUmt6-0007KT-DY
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 00:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab2KCXMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 19:12:12 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54129 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab2KCXML convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2012 19:12:11 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3162938pad.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=uVmKz3MEqCWMAe0ATfSOhD1IzheYbzONWZERsoOFttA=;
        b=Kknwlj1JKtEHReV0DbjOujlm5W8cRr4h/jK4LIsLmXrmtLc5J/UtRZII4LLwu4F/8q
         1I73z3uzQGSdxyvOBmqPm167SWKvlTcxFG2v3YwKpICfPhoqZGHFC3dsEkhYLj2w237S
         ogIIww+u1llM9bGr3L0ier00RziiIXRs8u2wKTbDCV59dOCK0YHT612EXeRY87w68i6w
         0GK4JI8pUAiCdy87jUa97R1UaOw3/ji+VXa0jUkTrG4In0yBxzVkQyfWlLxDlrMxPCqY
         xDm4xMsEWCfPxTqb6HwFty+AwXG1qlJ0xZIi8BShFlme02QyxMDlJMiRgON67BGz04a9
         2mGQ==
Received: by 10.68.137.234 with SMTP id ql10mr18097406pbb.158.1351984330735;
        Sat, 03 Nov 2012 16:12:10 -0700 (PDT)
Received: from [192.168.1.13] (c-76-102-117-203.hsd1.ca.comcast.net. [76.102.117.203])
        by mx.google.com with ESMTPS id iu8sm7985413pbc.71.2012.11.03.16.12.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 16:12:10 -0700 (PDT)
In-Reply-To: <20121103230701.GA11267@padd.com>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208986>


On Nov 3, 2012, at 16:07 , Pete Wyckoff <pw@padd.com> wrote:
> 
> Arthur and Matt, you've both had intermittent "p4 describe"
> errors.  I've not been able to repeat this or come up with
> a possible root cause.  But it is clear that the error handling
> in this area is weak.
I tried this week to find the commit that caused the problem, but there were too many to sift through so I haven't managed to see it again either