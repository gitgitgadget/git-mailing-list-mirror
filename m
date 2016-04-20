From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Is there a "git reset --keep <sha1> || git reset --hard <sha1>" alternative?
Date: Wed, 20 Apr 2016 22:28:44 +0200
Message-ID: <CACBZZX7ELH+5fzkRiZBNyWDwpQgzpEGi15XGz21nQQFh5hiG1g@mail.gmail.com>
References: <CACBZZX6k6sFv2GWOzu0Ow1T+5ci2gmMOvaD37bvbm1_qfetr8Q@mail.gmail.com>
 <xmqqvb3cumpd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 22:29:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asykN-0007uE-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 22:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbcDTU3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 16:29:10 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33197 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbcDTU3H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 16:29:07 -0400
Received: by mail-qg0-f41.google.com with SMTP id v14so36662372qge.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hCTeE8sjBDmN05vHIMuEiA0CPCeIKnP9YC8SbKyFc68=;
        b=HJkojpctAKW2iJcO+2sU1v97gcRwbXNNDLLm1t+DSApQB07Kf0lwBxTXYLjtutH0i2
         FyrhNa+opL3g2pfMvdkeOycqgfWGRdxIC7mG/jimHNwMiOAy60yOGQkTNRyA/zVOiqY4
         pU6gOc2G6CiUeR5Nq4qcBVKlDScnZ91hMsChdnqOG8mQhQdvwakRQD4HMeXkJuDWBBNW
         D2k/xKX9banKPfdJYSd/QhcIsRUZtq79naFegt8bCWvo5Dxuez39K8YON54uavaGjoIM
         ONRILd0mtigRN5wIHgiK/023DVY26XsyoZliKZqLP9gwSwe9tXwwX8yrCWBIQOVL4EmE
         af8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hCTeE8sjBDmN05vHIMuEiA0CPCeIKnP9YC8SbKyFc68=;
        b=USjD80qJOoaGKzpIQ0R+unDsYzoUTTtL/JQAVH5AhBaVaKJ5cdLaPaQw1RTPGUOS3k
         KKXV/Y3XcdgMx3C7ReXPnRIfix03jYVykGirUimgbBeqN8dtxYVf5WYGVZU7qqkYVk77
         6/4lFiemSJbdz5FO1P9mcoh22+Pes+4MeUakwyw0fNy/KcpSQHkz0BwstK9ZLzmf+EQZ
         +uEwh7syV2qjvO2SrcmivDPxVb55VcKMUbN+iXv6p5yx/Ut+P9bj0iwWRwgDY/Q/QpjE
         FaVbsa0hJwHsYm7tnSki+RC3EF+40BmSjSkTqk27GXwAcOUDpVcb9t9ySzEwQwfGug4u
         qrnA==
X-Gm-Message-State: AOPr4FV2BPXVPXgEihi41F900GZ8FHEf2J/fHyoJU4tYWdI6Kcu2Iak7RaqYg7QryxOXMH/dUriQCgkDYy/rFQ==
X-Received: by 10.140.19.6 with SMTP id 6mr13708675qgg.75.1461184143694; Wed,
 20 Apr 2016 13:29:03 -0700 (PDT)
Received: by 10.55.77.82 with HTTP; Wed, 20 Apr 2016 13:28:44 -0700 (PDT)
In-Reply-To: <xmqqvb3cumpd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292072>

On Wed, Apr 20, 2016 at 9:03 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>     $ ls -l INSTALL ; chmod 600 INSTALL ; git reset --hard @{u} ; ls=
 -l INSTALL
>>     -rw-r--r-- 1 avar avar 9147 Apr 20 17:11 INSTALL
>>     HEAD is now at e6ac6e1 Fifth batch for post 2.8 cycle
>>     -rw-r--r-- 1 avar avar 9147 Apr 20 17:12 INSTALL
>
> A quick question.  What happens when you did this instead?
>
>         chmod 600 INSTALL
>         git update-index --refresh
>         git reset --hard
>
> Does it match what you want to see?
>
> The reason I ask is because I recall making a deliberate design
> decision around this area.

The --hard doesn't wipe away the chmod, makes sense:

    $ ls -l INSTALL ; chmod 600 INSTALL ; git update-index --refresh;
git reset --hard @{u} ; ls -l INSTALL
    -rw-r--r-- 1 avar avar 9147 Apr 20 22:27 INSTALL
    HEAD is now at 05045e0 tracing
    -rw------- 1 avar avar 9147 Apr 20 22:27 INSTALL
