From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 15:26:15 -0500
Message-ID: <536a96e762dc4_76ff7a52ec44@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
 <20140507080558.GH23935@serenity.lan>
 <xmqqvbtha04t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 07 22:37:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8aT-0002dk-Ll
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbaEGUhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:37:05 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:64537 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaEGUhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:37:04 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so1925127oag.20
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ZValr/izWg17D0ovTU2Okaih4EKcPKGK/+OYN6NDL9Y=;
        b=gjU4IxFWcddIZ7vvv4Tg0bRX7SbIVHikgjaaoLDTOtRTm5HoRDIBghdxswgQssGPVw
         LkixiazSGyQmG09bqoVhPDi6ges/dRBuRI0hNzbsUwwkwUOhbwqr402LeT8iqeD70Kkd
         5+Lm5wE+ZqLlsOYFY85ivRMU3c2UYlK7Aq6JJe/EWCL21MhNFVBDnjxmeQN1nfeng+AX
         nMgXPyOchBCOLeXjwj0bI3EzBiFAODOcehXkMCfJOy4gQXzdoFsnbJCIpX7jok+jPGLQ
         lBvvbGrW7acUoonLlvXbG/eGcGoudKav7XiAZdOmr6ELkoyJBaKP0Jm/g0oU359JXRU7
         EgLQ==
X-Received: by 10.182.18.102 with SMTP id v6mr5733096obd.71.1399495023220;
        Wed, 07 May 2014 13:37:03 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm36662048obc.16.2014.05.07.13.36.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 13:37:01 -0700 (PDT)
In-Reply-To: <xmqqvbtha04t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248362>

Junio C Hamano wrote:
> That "when I manually" part is what I meant by "we give a good way for
> these third-party tools" above, and "make it really easy to install
> these third-party tools" in the remaining part of the message you are
> responding to.

We need two things:

  1) Provied a pkg-config, as all sane shared components do
  2) Split the testing framework so third-parties don't have to rely on
     yet another third-parth (shareness)

> Your git-integrate might turn into something I could augment my
> workflow with with some additions.
> 
>  - specifying a merge strategy per branch being merged;

git-reintegrate[1] supports this.

>  - support evil merges or picking a fix-up commit;

git-reintegrate supports this.

>  - leaving an empty commit only to leave comment in the history.

Done[2].


> and until that happens, I'll keep using the Reintegrate script found
> in my 'todo' branch.

My git-reintegrate supports everything John's git-integrate and in
addition it supports generating the commands from an existing branch,
like your Reintegrate. IOW; it's superior.

[1] https://github.com/felipec/git-reintegrate
[2] https://github.com/felipec/git-reintegrate/commit/332412470c6e084f10ac2f8dc11e86ab4680974a

-- 
Felipe Contreras
