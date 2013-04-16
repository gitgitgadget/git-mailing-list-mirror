From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git log - crash and core dump
Date: Tue, 16 Apr 2013 23:24:43 +0200
Message-ID: <CALWbr2xpweZOYo6szAJL5axdBBrV-c1-X_yuh6FAZQbq4iVcTw@mail.gmail.com>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
	<516D93C4.1000100@lsrfire.ath.cx>
	<7v61zml0ow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Ivan Lyapunov <dront78@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:24:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USDMu-0007mf-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965411Ab3DPVYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 17:24:44 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:43096 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965262Ab3DPVYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 17:24:43 -0400
Received: by mail-qa0-f49.google.com with SMTP id bs12so560027qab.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XMQyK8idVWGb1wkeVUIi77BpuVWCIeB2oLbwZt4rJWc=;
        b=gjGWyeaWy3sj9FTlTsbQMKgsPki0U9KrBIzXYikNtrq4flbllhkEyBENQirQrnfe/B
         IGfy0hcLjKRnkEwoUviAfOj5ibOfr+lB1YmW00jp+l5tZT2NTfa1UfPG8sMMxtcYzFEl
         BhKQ1ZM3H0ebElSnJZNAllSriH/GLQwy8MtWkpjfQsrBFN5GfNIXPDTV+75vutBhCfRG
         LSWLH4EvZ0LqAccYWDzmqCxluPN8my878WMmFnKIVF3d6LGQce2dSYx8tVXkRQ8+EVUR
         nMj5jw4thdj/FH0CwXHVtUBergp0KG79xrqr8SzB0SWcIuadr1tJtkCYNs7JaldslIq/
         lWRg==
X-Received: by 10.49.61.226 with SMTP id t2mr5029173qer.40.1366147483109; Tue,
 16 Apr 2013 14:24:43 -0700 (PDT)
Received: by 10.49.118.42 with HTTP; Tue, 16 Apr 2013 14:24:43 -0700 (PDT)
In-Reply-To: <7v61zml0ow.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221475>

On Tue, Apr 16, 2013 at 9:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> It still is curious how a malformed line was created in the first
> place.  I wouldn't worry if a private tool used hash-object to
> create such a commit, but if it is something that is commonly used
> (e.g. "git commit"), others may suffer from the same and the tool
> needs to be tightened a bit.

I already happened to see one like that, and it was clearly imported
through remote-hg. I've not been able to reproduce though, and the
parser in git-fast-import seemed already robust enough to me to not
allow this kind of messed-up line. I will see if I can find some time
to reproduce/investigate this deeper.
