From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Mon, 18 Aug 2014 19:23:29 +0200
Message-ID: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
	<xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFcJ5FFeJP=0-oG59fs=3ztenoPOGWOZKfZDdHpLGOYeA@mail.gmail.com>
	<xmqqiolw2dqc.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFJiUt1p_OfefswS8O8_BA6mQy=PStmYyNw=ABZCOQprQ@mail.gmail.com>
	<xmqqmwb5zatx.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NEE0d_5Vj3MSGEJCtFBFOe75Rb+q9fk7q1YC-WcvAMb4A@mail.gmail.com>
	<xmqqppfxycxj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 19:23:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJQeh-00017m-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 19:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbaHRRXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 13:23:35 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:45230 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbaHRRXe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 13:23:34 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so7942141pde.11
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O/EuVwrbmhoLASm0vVuKpQrxd32ifXXvmgeaxQD2cl4=;
        b=meQBMLzxOFaN9pphw+QFiXC7Zzh9mr/iwJN4BMHunY+CImobNn/ondQK07lCZBDNpu
         er9BEcq4QcZUUa+L9ZLmxIERTWu6i4r+hG1Od5F2CCgbW02Y1gjMtg7k23ugqaxwFeQi
         puJ7UpjtdUcPELOBulYirYdyuSYLJSJfr0Ak2sm5GRe2FWpRq3l05oSodu865WGdXXuG
         QDMoOPYYp72flokYQyRW90WlH1m12DRyLRb1pMx4Cf9Axi5JuajJLDiPdITjgqVFIIBa
         bzfiI0o3VrJLUYJCpXc5i3Qc1DOJQBsTLbwnWNasiJtmbZK72gcJvwNuX3oN1P67MU4Z
         oRjg==
X-Received: by 10.68.172.162 with SMTP id bd2mr30473137pbc.47.1408382609403;
 Mon, 18 Aug 2014 10:23:29 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Mon, 18 Aug 2014 10:23:29 -0700 (PDT)
In-Reply-To: <xmqqppfxycxj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255404>

Yes, --index-info worked for this purpouse, thanks!

https://github.com/jsoriano/git/blob/remove-unmerged-index-entry/t/t9904-unmerged-file-with-merged-entry.sh#L25

I'll try to send the patches to the mailing lists later today or tomorrow.

On Mon, Aug 18, 2014 at 6:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:
>
>> I'd like to add some tests too for this, but I don't know how to
>> reproduce this state with git commands only, is there any way to add
>> entries to the index without checkings?
>
> Perhaps feeding "update-index --index-info" four input lines would work?
