From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove perl dependant commands if NO_PERL is set
Date: Thu, 03 Sep 2015 12:56:25 -0700
Message-ID: <xmqq37yvjmza.fsf@gitster.mtv.corp.google.com>
References: <1441298147-83601-1-git-send-email-garga@FreeBSD.org>
	<xmqq7fo7jp1e.fsf@gitster.mtv.corp.google.com>
	<2CFFD89E-7059-4C1C-B715-15C5F6C2D295@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Renato Botelho <garga@FreeBSD.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 21:56:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXacZ-0007i0-53
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 21:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbbICT41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 15:56:27 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33563 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbICT41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 15:56:27 -0400
Received: by pacex6 with SMTP id ex6so265290pac.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=f7vxdGeA14anw/kVpvnORgZZxKnDjGW7BI0yR9doy14=;
        b=sADWCG9H3vUv3qTEyIpqSmQjQj+94alPliuvPl0x/klHpl9kjQJ7RugNOLzrieSyLq
         7RexuNUnUTdaa4OUxuQRBLb6HIKkHU2eHrUjHk1dvwVeiVBCqkmUeaHQfzHC7SxrAplT
         oYEnWloxJ0pfRNXmgYJ6YV+7mNoS903h5ov7RZFOEc2I18966xyPNoZ9/+p5nHw6ZO1Y
         kOeD94gf2HSmkpl/sGk9hziIro320CMVQ4EynYu6+GwwGPAkXBG57iacB9gtTq3/c4G2
         HFZQPorMr4M9RoNPCs1my9AsF4M6w+i9qsiTU407sP1zhwmdzrcP5g1g6oZZ9Y6gtLxA
         /k6w==
X-Received: by 10.66.233.97 with SMTP id tv1mr71389867pac.110.1441310186602;
        Thu, 03 Sep 2015 12:56:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id p13sm26215738pdl.82.2015.09.03.12.56.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 12:56:25 -0700 (PDT)
In-Reply-To: <2CFFD89E-7059-4C1C-B715-15C5F6C2D295@FreeBSD.org> (Renato
	Botelho's message of "Thu, 3 Sep 2015 16:39:19 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277246>

Renato Botelho <garga@FreeBSD.org> writes:

>> You also may want to hold off the "git-submodule" bit, as I expect
>> http://thread.gmane.org/gmane.comp.version-control.git/277128/focus=3D=
277129
>> would be one of the first changes to be in 'master' after the
>> upcoming release 2.6 (that is, it is likely that perl dependency
>> would be removed in 2.7).
>
> Can=E2=80=99t we add git-submodule to the list now, for 2.6, and then=
 remove
> it when this change is pushed? This would help to have a sane tarball
> for 2.6. I=E2=80=99m considering this from a package maintainer persp=
ective.

Not really.  Anything brand-new that comes this late in the cycle
will not be in 2.6, so the earliest release this NO_PERL change can
appear in is one after the upcoming release.
