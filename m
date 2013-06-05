From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Wed, 5 Jun 2013 09:52:27 -0500
Message-ID: <CAMP44s1X=M2sV9OiHS_ggVjmu6txBQVSdK+aK6PnQm5-9EpQgw@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
	<7vehcidg1i.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DvtiT6hi-RoPt_bVdGr01S367usz=089E1Ht+Bvh-tA@mail.gmail.com>
	<7vbo7l93t6.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_Xr4bymmDezTF8BMiMKQZFpNuxXpFZd_TGJ3BkJWdGw@mail.gmail.com>
	<7vvc5t7mpm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 16:52:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkF4j-0002us-7T
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 16:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab3FEOw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 10:52:29 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:64154 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab3FEOw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 10:52:28 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so1999970lbh.35
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1TsR//OT93LB4vSo8LWmDD7a8Gs2AEHAMlh3rPs9ke4=;
        b=gEU6R+MXcq8Xc4sh5XAu3q+KmSpFv/3Tx+i2co3RkCT4N2geg3Z4fM9TfKjCb2xSSN
         2tRSez03hlM6ykdzAPFmK7UCJuFgM2MDgnmivk8QiXdomVaIrMheHseMuVAPkii31uyq
         JAPNL2AXEybNhZVTlyvNwiqSoaDPL7UsbCRm+zVnWlWOpzvtQkaMHpIS5O/Q8EZXyHU4
         NDalrhM3MoMHGht6nBzAsoejryjDPEZ8V42nLcSuMzJFJ5XtOlDREuHuYRV7wsMo6WUw
         tYi/k59JLMtmulfWp91j3QQQ1rqLc6h/eB6rmdEQsRACc7Pbp7T74M7pypH9Jfo9f/nK
         xfPg==
X-Received: by 10.112.133.129 with SMTP id pc1mr12261471lbb.49.1370443947219;
 Wed, 05 Jun 2013 07:52:27 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 5 Jun 2013 07:52:27 -0700 (PDT)
In-Reply-To: <7vvc5t7mpm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226451>

On Tue, Jun 4, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> You didn't answer, what happens when you run --skip-empty and --allow-empty?
>
> I'll answer to a slightly different question: What should happen?
>
> I think it should error out, because --allow-empty is about
> "allowing empty commits to be preserved", and --skip-empty is about
> "skipping empty commits (as it says on the package)".

Exactly, so they are related after all. However, --allow-empty says this:

"By default, cherry-picking an empty commit will fail,"

Should we change that too if we introduce --skip-empty?

I don't think so. I think it makes more sense to have a new
--empty-commits=[keep|skip|fail] option, so we don't have to document
how each option affects the other, and what is the default. Or rather;
the option documents that.

In fact, it might make sense to change the default in v2.0 to
--empty-commits=skip. If it makes sense in 'git rebase', why doesn't
it in 'git cherry-pick'?

-- 
Felipe Contreras
