From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 14:11:05 -0500
Message-ID: <5363edc954f8e_70ef0f30c24@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:21:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJ1o-0007KS-1P
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbaEBTVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:21:44 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:50308 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaEBTVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 15:21:43 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so3064457oag.26
        for <git@vger.kernel.org>; Fri, 02 May 2014 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qpNquTxXyVRHD89FpKETCdjPBoRpbWmBrHJCXY5+WOA=;
        b=Y+ud+NxsnimFAqSI58axSfwPE9/mW7coNmTcepU4tvterHrjy7n0DSLR4yLlVZ5sbO
         C8eCe/lP2LUETAUiefOi0JsTgKc0pJb5TlOXxOV0RjIKMBvWuonoRutzbWd+DelkWS+H
         o3ZWkNqYoOR21qzV2WGalCyncM05mIa3tkSYKN3XbAF3F4gTTcOuVgtyKZGk9vdSVdqZ
         ECXauCskh6zO0R/Rwii0egnlCFm5hh24CMRKHnYo8Hp6D458k0qeF7CcfcE3faWc2kzE
         o0374zUGmnLPkSiwEJLE0+Q/15pKslBcI/G/4ctpIwyHzoV+ntIhEXIX8V0C1ZrM5Sa9
         GxcA==
X-Received: by 10.182.33.6 with SMTP id n6mr16955851obi.48.1399058503313;
        Fri, 02 May 2014 12:21:43 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm68850382obq.18.2014.05.02.12.21.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 12:21:42 -0700 (PDT)
In-Reply-To: <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247956>

Junio C Hamano wrote:
> If we step back a bit, because we are forcing him to differentiate
> these two pulls in his mental model anyway, perhaps it may help
> people (both new and old) if we had a new command to make the
> distinction stand out more.  What if the command sequence were like
> this instead?
> 
>     $ git checkout maint
>     $ git update [ origin maint ]
> 
>     $ git pull [--no-ff] developer-remote topic-branch
>     $ git push [ origin maint ]
> 
> where the new command 'update' enforces the '--ff-only' update.  And
> then we would stop telling "'git pull' first" when a push does not
> fast-forward.

In addition to barf when it's not a fast-forward, such command can
switch the parents, so it appears 'maint' was merged to 'origin/maint'.
Many people have complained about this order.

> Stepping back even further, and thinking what is different between
> these two pulls, we notice that the first one is pulling from the
> place we push back to.  Perhaps a way to solve this issue, without
> having to introduce a new 'git update' and updating the tutorials,
> may be disallow fetch+merge by default only when pulling from the
> place the result is going to be pushed back to?

Which is basically essentially the same as not specifying anything, or
rather, running `git pull` without arguments.

-- 
Felipe Contreras
