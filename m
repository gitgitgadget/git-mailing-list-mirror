From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Thu, 10 Apr 2014 17:36:59 -0500
Message-ID: <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 00:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYNko-0006l5-DL
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 00:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbaDJWrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 18:47:00 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:41431 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbaDJWq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 18:46:58 -0400
Received: by mail-ob0-f172.google.com with SMTP id wm4so5187632obc.17
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=cl/NP0VRZ0DhEKE19e5bcQZ2IvzYBDvYELl06o0z3ZE=;
        b=CBuyI2MAH4RkijDqQeNoX61hEf+qc8+JMTmFE5OdLNS1AmmhxGBTSzJiLbe+hspc/r
         JFvJffQSCX6Ze9kTIYaMd5zxAM6vyrOCWCCchuBb6H6UxSISAQ3otb6qX90VYavepQDT
         7HqMS0L4ItRF+eZs7tn2cXa9FO8WE1d9YGPY8FpRXI8koTP+40qvBB8e5PD2nQxw4NpI
         azq6dt4sQTJh9XGsO5KS0ZpOluIjMxHyOFxB41jUvlXMZ8BXD8R4cuc0sppktOqYyYtq
         f1ZE5XB7sT4WWTemNK/4xT8NG56Fruph/XORQuJTYy6g3QeEIg8BIOfbojCubjvSSr9+
         U0vg==
X-Received: by 10.60.83.234 with SMTP id t10mr16207373oey.4.1397170018439;
        Thu, 10 Apr 2014 15:46:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pr4sm23346494oeb.8.2014.04.10.15.46.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 15:46:57 -0700 (PDT)
In-Reply-To: <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246063>

Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Please write a commit message, preferably showing the new git-branch output.

Yeah... this has been sitting in git-fc for quite a while, I wasn't expecting
to send this patch series again given that nobody commented on v1.

> I noticed that this only picks up a publish-branch if
> branch.*.pushremote is configured. What happened to the case when
> remote.pushdefault is configured?

What happens when branch.*.remote is not configured for @{upstream}? The same
thing.

It might be useful to visualize what would be the name of the branch when
pushing it (without a refspec) even if the publish branch hasn't been
configured, but I think the code would be much more coplicated, and it would
break symetry with @{upstream}, besides, the user can just do 'git push -p
branch', and from that moment on it will be visible.

-- 
Felipe Contreras
