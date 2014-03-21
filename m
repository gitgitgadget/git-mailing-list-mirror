From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Fri, 21 Mar 2014 14:59:41 +0700
Message-ID: <CACsJy8DpnfmyDevqBVpJVwSig2QaeQe9EpjdCk92E1zTeTKKyQ@mail.gmail.com>
References: <1395232712-6412-1-git-send-email-dak@gnu.org> <xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
 <87ob11g9st.fsf@fencepost.gnu.org> <xmqqlhw5260l.fsf@gitster.dls.corp.google.com>
 <CACsJy8C3=bz1HmVgQuJRdixMhhb-JKouM7b1L7M047L_4PBViA@mail.gmail.com>
 <xmqqsiqcztu8.fsf@gitster.dls.corp.google.com> <87lhw4er2b.fsf@fencepost.gnu.org>
 <xmqqob10wlac.fsf@gitster.dls.corp.google.com> <87y504ccke.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 09:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQuNJ-000654-5g
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 09:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbaCUIAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 04:00:13 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:61432 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaCUIAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 04:00:12 -0400
Received: by mail-qa0-f50.google.com with SMTP id o15so2086101qap.9
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 01:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0ej39u3nAsTwWaoZYFOrxQ31a4fK2cbx7DtUWVmEFtc=;
        b=VdQhc6kVcy02YqMdmGn51TffOmAseOns0Iv3nTSbs0KW5c3vYv6ORFeNC+LyztNI7b
         ks4PTIg1UiwQNVxmfl4yheodSfcMyKqrHNHyAGpK/VQ+y8sX5hpyb4lE1T1JnQzSV9Yl
         ljjXCSF5Fm5x51wdgzbBGN9DGtayNCtiDzRA+z0h2aU/E4MGVgDbvnRT9MPnSFyFfsTl
         JtUUkkrkUlY64SQgeuAC56P1shrY8M4zsHiROg6/ctk+AMQOx/2s9krHtysQC6LApigh
         rDo/ixGyqTtSl2LmB01MJuQhi4KdGLqxY8e2IxCzSe+Pr5eXmNYOsnSE5AxGd2av6wv7
         0+zg==
X-Received: by 10.229.216.72 with SMTP id hh8mr14402644qcb.9.1395388811138;
 Fri, 21 Mar 2014 01:00:11 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 21 Mar 2014 00:59:41 -0700 (PDT)
In-Reply-To: <87y504ccke.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244678>

On Fri, Mar 21, 2014 at 1:04 PM, David Kastrup <dak@gnu.org> wrote:
>> Hmm, doesn't packing need to read existing data?
>
> Judging from the frequent out-of-memory conditions of git gc
> --aggressive, packing is not restrained by deltaBaseCacheLimit.

pack-objects memory usage is more controlled by pack.windowmemory,
which defaults to unlimited. Does it make sense to default to half
physical memory or something?
-- 
Duy
