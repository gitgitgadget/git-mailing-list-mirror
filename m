From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 24/34] mailinfo: move content/content_top to struct mailinfo
Date: Wed, 21 Oct 2015 14:08:59 -0700
Message-ID: <CAGZ79kY95wfbktyEji+jcyB3sbdyVCmmJajnBQTr3Hrg_PFvpA@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-25-git-send-email-gitster@pobox.com>
	<CAGZ79kbRLVaNNR=ZuMZNtJD2vorV5K1-wZ+R9CY5FY_zS3i95Q@mail.gmail.com>
	<xmqqzizcszke.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:09:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp0d9-0003cZ-UB
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 23:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbbJUVJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 17:09:00 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36429 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbJUVI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 17:08:59 -0400
Received: by ykba4 with SMTP id a4so57098119ykb.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=odQooOITBU+e1PvKh55HDfBN7DhJuswrhnFv/zkr9xs=;
        b=l2IYvQjRTabCk4MrR+z3ZgRydzhifqgvCMBONrkhhsHleS6mUwmSd6ln34xMHHRIn6
         vk7f8130vBxMuFrjCuT7CDwo63NipgqWUGY02oQZfJvu174pv7htnN8n6DrzPsv9iJg7
         fConDEmBh+To0E+YLNqaqDqtgEtL36gxC1XJDe5K86LGOo5WGfksn9USLr/sD5CukANT
         ihkbdZN+kaZqT33pTj9KqFtmw2hcy1SAfjKwE+UxioFfO1RbIjzpJxte5F9hBw0awp//
         0gSzqO3psu5KvNXpRt/S5G3EVvbJcQmASaUjdptoiccVZ3+0VKylmo/G5r/2oFBI4Pkx
         7ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=odQooOITBU+e1PvKh55HDfBN7DhJuswrhnFv/zkr9xs=;
        b=JWxhDuc7SGu2zrcHGG5lsufv6FDk0rbCL8dNd6a+IPLiv0q12Oxjv7tUfiRkWegSVO
         Uv2XlxoxZsPhdW4dPuzXOi022zyupGSB8IE6In7aEms34XwK+aQ1DLTx85tptwtKg8Yc
         d9EL3sYsjErkPcTHbEkk/eUkCSMPI1Ro6flmTL1z5P3TvzD2lcfxAIAW82hpAwwaeQWe
         rsSlWyC6IHp9WV60l+U1cP/jee9q8eIYKjfzPUNEDCaA/C3wZ96CoJrs3f6E6qrJ01W3
         RsOj8Bh/8GB75ewpfHJVMsZU+CVZ3oO5cJ37u/jdgYgfz4YnWwkyExcXmA2vllG1CI6P
         EM/g==
X-Gm-Message-State: ALoCoQk1Ro0NwxypjGVHyoDV96CWe3zDLMMFOg5vABTqj2RpCWEs7p3CswZtr2ojPiCO3A6oYmni
X-Received: by 10.129.124.8 with SMTP id x8mr8525353ywc.44.1445461739151; Wed,
 21 Oct 2015 14:08:59 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 21 Oct 2015 14:08:59 -0700 (PDT)
In-Reply-To: <xmqqzizcszke.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280023>

On Wed, Oct 21, 2015 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Looking at their final resting place, I do not think so.

Right, I comment along the way without looking ahead, so this was a bad comment.
