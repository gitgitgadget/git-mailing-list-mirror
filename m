From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 01:03:17 +0530
Message-ID: <CALkWK0n_qTThL+_k3tcD_R4PMddBROqZDEaRHUy=GHOO_Q1keQ@mail.gmail.com>
References: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org> <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org> <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org> <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:34:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0mR-0001Rh-8t
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765136Ab3DJTd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:33:59 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:42733 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762176Ab3DJTd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:33:58 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so1063655iea.10
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NP95VvZvlbjsXdNlSSPS4zw/5IJiaeRsGOCkWQokUOs=;
        b=OpPOCulS7AqfpSVWgjDMmq1lYkrJW2F6/kfKZrprRf9R2EqHErrTREimHnYJwWM+3l
         /5v6jmgvZQ6giRPTjlBYxye0EjsNigG7gkV1Rpsmmj9bvaQcjUdFYMNQfLGHDivj7iwq
         cLSjbC5Ni+QAp2MLm89Mbue5RBlGPw2fWO1GYOAy/hkMhs8vQtqpqHbYZjwhytJTtYQK
         Tlq5I0W/iko+KXtDZVb8xlQ/WbyyqMr+xKS2GeiLlzQnbruVWpJ3YURftI/BdmLu7aFB
         HCUNgSr8qx1VvzD8Asm6LjIBoV+Qf9TrvKlHQNFCE6GqKuaUjrdSPXRhV8k3RwOgC9Ji
         UMoQ==
X-Received: by 10.50.108.235 with SMTP id hn11mr2288993igb.107.1365622437686;
 Wed, 10 Apr 2013 12:33:57 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 12:33:17 -0700 (PDT)
In-Reply-To: <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220734>

Ramkumar Ramachandra wrote:
> Otherwise, I think we're consistent.  git push master; pushes the
> refspec master (with no explicit :<dst> counterpart) to the "default
> place to push to" (either depending on which branch I am, or global).
> I think Junio was mixing up refspecs with refs (branches, and hence
> branch configuration) earlier.  git push origin; pushes to "default
> refspecs" on the remote origin.  By extension, git push; should push
> "default respecs" to the "default place to push to".  The "default
> refspecs" in this context is determined by push.default, which is the
> problem.

Major thinko here.  The problem is git push master; choosing the
"default place to push to" depending on what branch I'm in.  A plain
git push; is just fine.
