From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 11:53:05 -0500
Message-ID: <CAMP44s1x4Dm2KwyuN=oisSFdoCPxYzu+ZjZjHN45_=i7b=z0_Q@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<20130609184553.GG810@sigill.intra.peff.net>
	<7vppvvnetw.fsf@alter.siamese.dyndns.org>
	<CAMP44s3p1atFz52-mKaKpZkLGp+Uoehc1ovTUQAN-raxWzWd8Q@mail.gmail.com>
	<7v8v2il62c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5LH-0005kN-2K
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab3FJQxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:53:10 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34498 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab3FJQxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:53:09 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so3706277lab.37
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QcGERQfpv4i1QfIVMVJQvHyJxW4V88GXSCmjB+qOzNw=;
        b=pFCYT3DcX40+ugXO2B1jnFm3J1nfks4zNcSAIynmgtwuMeAvA2mk75tl66/5cgrOqx
         ARfeUYtyTvGiNJ4HLai795ontq2FnxS5FZtI+zCfuYDMtvnG1gxDYymYTpTxeUMbrLHZ
         79EH1tOMYp7ZMjrHQo/tUMR5hymV2Vm33C2lUQYjyKmf6V27GY+HgQ0Vh6hdLtp+xPru
         izJzONEhRWAktqaoce4SqDLfBTp1tSnG+gA9h4sZX5qOQem29ovFMdIjZcC4WR642Jgb
         6uMvnN6pd2RQaAMklq1JP0ZDJcpyJpuIRPgDioHxSuPqR57ulwdBrwYUIb3Of4Qhb9mq
         C1MQ==
X-Received: by 10.112.16.163 with SMTP id h3mr6913518lbd.85.1370883185970;
 Mon, 10 Jun 2013 09:53:05 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 09:53:05 -0700 (PDT)
In-Reply-To: <7v8v2il62c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227320>

On Mon, Jun 10, 2013 at 3:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Jun 9, 2013 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> One example of killing the entire thread is when I see "This patch
>>> will not be applied" by Felipe in a thread started with his patch.
>>> I understand that it is his way to say "this patch is retracted"
>>> without having to explicitly say that he now understands that
>>> reviews showed why the patch was wrong or that he thanks the
>>> reviewer for enlightening him.
>>
>> You are wrong. There's nothing wrong with the patch.
>> ...
>> I thought you understood that code should speak, but apparently you don't.
>
> That is exactly the point Peff raised (and I agreed with), isn't it?
>
> Bad behaviour (being difficult to work with) has consequences.

It is not bad behavior. It is bad behavior *in your opinion*, an
opinion that wouldn't be shared by other projects, like the Linux
kernel.

> E.g.
> convincing people that it is not worth their time interacting with
> you, especially when there are better things to do like tending to
> other topics, and you lose the chance to show that your patches are
> good when they indeed are (I don't even know if these patches in
> question are good, and I am not going to find out).

You are hurting the Git project by doing that, and our users,
specially our Windows users.

I thought you were a good maintainer. But apparently you would rather
listen to the people that only complain, rather than actual code, that
actually improves things.

-- 
Felipe Contreras
