From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 16:30:57 -0500
Message-ID: <53583111dd8ad_24448772ec17@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <xmqqa9be8i4o.fsf@gitster.dls.corp.google.com>
 <53559b0cc066_6c39e772f09d@nysa.notmuch>
 <xmqqtx9m70fh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:41:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4vE-00081M-6t
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbaDWVl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:41:26 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36961 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaDWVlY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:41:24 -0400
Received: by mail-oa0-f46.google.com with SMTP id m1so1694757oag.5
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=hv+uqjXmzQUgdMittosKE55HMTws1Ajs7hVwQCPog2A=;
        b=I/Tsrdiw4kQOTM37AHzfACMuVkTxHX1Lfs3zkP6Xgu0xlZZTPKvl8AVVnwPE/GxQzL
         SfgKMqc4UC0eo2gYXwhM8xXB9RyluDOkhb2BDSabLH1JuRr7JVXcEqPNxHsR+sjBnLf9
         SMfNHD4/Dy8iqWjz8f3+SMhfJPF3Rl320lSSG/T0UWfxVnCkb6p8WyyT/cEECq7TEUG+
         /DFSXDZaNATTEE3Pkt9IJlQAIFMWTilHvTSy7Vf9WwRy9GP7fsx4igthGUbz8ktEqhIt
         lB2KVNAGbGTMWS4RXDQemqhabe1ZcAOmTtlI49cs7E7yAuYxKwkBdIaQR90gqv4Tr8T1
         Bbkw==
X-Received: by 10.182.32.3 with SMTP id e3mr39522481obi.30.1398289283848;
        Wed, 23 Apr 2014 14:41:23 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pa3sm4236821obb.6.2014.04.23.14.41.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 14:41:22 -0700 (PDT)
In-Reply-To: <xmqqtx9m70fh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246904>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > ... there are _already_ hooks without pre/post.
> 
> Like commit-msg?  Yes, it would have been nicer if it were named
> verify-commit-message or something.

No it wouldn't. I can use the commit-msg hook to change the commit message and
to absolutely no verification, so verify-commit-message would be misleading.

Maybe you would like modify-and-or-verify-commit-message which would be
correct, but I wouldn't, I like short-and-sweet, and commit-msg is just that.

> Old mistakes are harder to change because of inertia.  It is not a
> good excuse to knowingly make a new mistake to add new exceptions
> that the users need to check documentations for, is it?

That's a nifty trick; label something a mistake, and then it suddenly becomes
one.

No, it's not a mistake, first it has to be proven to be mistake and I haven't
seen any arguments that try to do so.

Besides it's a red herring, you said such a name would be original and I've
just proved that it's not original, so the originality is not a concern.

> > And it's not confusing,
> 
> A simple fact that Ilya asked the question tells us otherwise ;-)

It's not any more confusing than these:

applypatch-msg:

When does this happen? Can I return an error?

pre-applypatch:

Again when does it happen? What does the input contains? The whole patch? Including the message?

post-applypatch:

Totally confused.

pre-commit:
prepare-commit-msg:
commit-msg:

What is the difference between these? Doesn't pre-commit contains the message already?

pre-receive:

Before receiving what?

update:

Updating what? When is it called? Can I cancel something?

The fact that somebody asked a question doesn't make a name confusing.

> I personally do not see an immediate need for post-update-branch,
> but if the new hook is about intervening an operation,

It's not about that, I can remove that feature if it would make you happier.

> Otherwise it would be impossible to later add "post-update-branch"

Which is never going to happen.

I'm still waiting for anybody to imagine any reason why we might want
post-udpate-branch.

-- 
Felipe Contreras
