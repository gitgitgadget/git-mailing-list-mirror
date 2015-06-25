From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 09:01:21 -0700
Message-ID: <xmqq4mlv22we.fsf@gitster.dls.corp.google.com>
References: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com>
	<xmqqlhf725xy.fsf@gitster.dls.corp.google.com>
	<CADstYCamTxaLnZeYUma6t=KP3Fx2rQH3svqgCYP4WpAR9k_USg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:01:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z89ai-0006N9-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbbFYQBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:01:24 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34238 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbFYQBX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:01:23 -0400
Received: by igcsj18 with SMTP id sj18so11962334igc.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IBdGlg+b3rCOF6sWTyAe475zVSWxbJ40lb3kf+aGWWg=;
        b=JWPiJDl6wrazUrRge/XFB8atNQfsEAWQhtdTIOcejJVoPYkij8wFuxFquBF/pwkq6d
         FBpGOzXxUWDHbIjHshFYHpLY7hgZ//GQJGyKvdt2jMRtI9uS6vweFlkno2KSy83aBZzE
         4GMqOwcrq4rUftANL5vUgZTiY4QpnxkeOPlPs4GK25JwUcBln4DVVcWriHJR9hB9hPsh
         nv6+1GJ+SEhz2qkDPBgMsMKL2Kp75OBnmvwC24tnYp81t/vHFsApsi0wtm7b2mSxU7pA
         aOp+ddwEWX+HDWJCpdH/EMcOGTRQtZsOve5OgcR2eeXvKiJ+Flmsz4d+9wFdrRdnofDB
         neYQ==
X-Received: by 10.50.87.74 with SMTP id v10mr4952933igz.37.1435248083026;
        Thu, 25 Jun 2015 09:01:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id j192sm19842218ioe.27.2015.06.25.09.01.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 09:01:22 -0700 (PDT)
In-Reply-To: <CADstYCamTxaLnZeYUma6t=KP3Fx2rQH3svqgCYP4WpAR9k_USg@mail.gmail.com>
	(Caio Marcelo de Oliveira Filho's message of "Thu, 25 Jun 2015
	12:19:22 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272690>

Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com> writes:

> A similar concern probably applies to format.signOff option. Would
> be sufficient to add a note about conscious act (like
> format.signOff has) to the config description?

I am generally in negative on automating this.  This is not just you
but makes everybody else's S-o-b less and less meaningful ("Their
tool have ways to add that string randomly, and many of these ways
the user ends up adding that string without even conciously thinking
what they are doing.  Does that string even mean anything anymore?").

One solution might be to make this not a straight-forward boolean,
but an option that superficially takes a string and treats one
specific value as "true" and everything else as "false", e.g.

[commit]
    signoff = "I certify that all my work is licenseable under DCO"

I dunno.
