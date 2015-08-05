From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] gitweb: Don't pass --full-history to git-log(1)
Date: Wed, 05 Aug 2015 09:54:14 -0700
Message-ID: <xmqqr3nh4qx5.fsf@gitster.dls.corp.google.com>
References: <1438784487-9176-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 18:54:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN1xN-0006m3-Vz
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 18:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbbHEQyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2015 12:54:18 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34375 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbbHEQyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 12:54:17 -0400
Received: by pdber20 with SMTP id er20so20718936pdb.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=tQzijgNZTsd6ZwJQRCTaSLp33x8G5L7DdVkhPPgdqkI=;
        b=hJkHl/a8jMA0sJzepeUDjMx0NTs7QQBFqrwkeWvvBjtknLK1+z6Rd6Ev328kB7d8wt
         P05sis5nIn5DA7pqBxfX++poEYfD1YaW9CftRjuv2/J6AwqY3yIERPGgKspwpTwLA3bS
         8X1QTOq3dfwnN53rPhEvK5/qxCtpx9Yv5Y/3HHAITJVzgeYMcsTAiNadu5KFYvrXO4Dh
         I1JJdtSEOPHt6VR+QlnXELYa/aVCucUugr7woyLedmBJIIxJxQo20xMLvmHvMm8K8kIS
         X1r130DhQorXG4+DKjPdXCetUX78p5rE8x+AwXhATiwt/Ls1bE1Dtp+E/1nJ9iBgY42N
         WoZA==
X-Received: by 10.70.55.1 with SMTP id n1mr20886113pdp.21.1438793656709;
        Wed, 05 Aug 2015 09:54:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id hb1sm3484417pbd.36.2015.08.05.09.54.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 09:54:16 -0700 (PDT)
In-Reply-To: <1438784487-9176-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 5 Aug
 2015 14:21:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275375>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When you look at the history for a file via "git log" we don't show
> --full-history by default, but the Gitweb UI does so, which can be ve=
ry
> confusing for all the reasons discussed in "History Simplification" i=
n
> git-log(1) and in
> http://thread.gmane.org/gmane.comp.version-control.git/89400/focus=3D=
90659
>
> We've been doing history via --full-history since pretty much forever=
,
> but I think this is much more usable, and on a typical project with l=
ots
> of branches being merged it makes for a much less confusing view. We =
do
> this for git log by default, why wouldn't Gitweb follow suit?

http://thread.gmane.org/gmane.comp.version-control.git/89400/focus=3D90=
758=20

seems to agree with you in principle that this would be what gitweb
should do if it were written today.
