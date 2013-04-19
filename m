From: Ilya Basin <basinilya@gmail.com>
Subject: Does git fast-import support deltas?
Date: Fri, 19 Apr 2013 09:29:31 +0400
Message-ID: <1095757971.20130419092931@gmail.com>
References: <323381594.20130414121834@gmail.com> <673219382.20130414124800@gmail.com> <20130414113351.GA1299@thyrsus.com> <1762779000.20130415215818@gmail.com> <20130418094326.GB11038@thyrsus.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Eric S. Raymond" <esr@thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:31:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3uu-0003Ok-DU
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686Ab3DSFbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:31:08 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:58980 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab3DSFbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:31:07 -0400
Received: by mail-lb0-f170.google.com with SMTP id 13so231563lba.29
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Yb+2+DKmjfYXqA0Jv17auAKYJfJ/0RkJbwUI8CkuUcY=;
        b=jjYeXFJCIvbs7M/sIwWWoIazqu+dCOPguow4HXkZmGohCVVaKJipyDqz2Xr7hhCjYx
         4hDCfZcPxqo7iTeeU/ZTsdVRK3HTCoiOH5tPfwKza4rpCWia6zVv2xpZfqXeNERLzj18
         xo7hJB1L+z0UOko1/wAXCa14/uH7c0CSa42ca47PPhY6SVh3Qa+WHRzLZ+t0Z5tyoi7D
         eK6m+DXRD1EBqI1ZaVCudx1XvV464BFQAM47kbFsIDBaj4EQ3mHL6uck1UokqfN8C3kO
         HhsgItz4MRmkqC7WpJrfnGUM2Ef+KQ8xjfMxAM778vakdCTNlPKIHuFXreaXmh2mmk7C
         25lw==
X-Received: by 10.112.173.39 with SMTP id bh7mr7262565lbc.62.1366349464782;
        Thu, 18 Apr 2013 22:31:04 -0700 (PDT)
Received: from [192.168.0.78] (92-100-234-176.dynamic.avangarddsl.ru. [92.100.234.176])
        by mx.google.com with ESMTPS id sl5sm5258399lbb.10.2013.04.18.22.31.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:31:03 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20130418094326.GB11038@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221737>

Hi list.
Here's what I mean:
1) a created a git repo from a foreign source using git fast-import
2) new commits were added to the foreign source

Can I create a fast-import input stream not containing the commits
already existing in my git repo and import it?

I tried to create such streams with:
    cvsps --fast-export -d ...
and from a shallow git repo, but the new commits are not imported
(unless the import stream contains a new branch)
