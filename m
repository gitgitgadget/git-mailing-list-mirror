From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/19] fsck: Offer a function to demote fsck errors to warnings
Date: Sun, 21 Jun 2015 11:47:32 -0700
Message-ID: <xmqq616gkiez.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<44acafb2cf0a98e5ad75e3da24ba0e7453e6118f.1434720655.git.johannes.schindelin@gmx.de>
	<xmqqzj3v7b58.fsf@gitster.dls.corp.google.com>
	<bc06c48f005ad1c32dea2edbfa466208@www.dscho.org>
	<xmqqegl5j75m.fsf@gitster.dls.corp.google.com>
	<8545f1b636f157b280f15c615c1e1756@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 21 20:47:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6kHO-0005O1-0r
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 20:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbbFUSri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 14:47:38 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37235 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbbFUSrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 14:47:36 -0400
Received: by igblr2 with SMTP id lr2so40982565igb.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bzW2t1GCdObFnW0/uwGR3Uo5TF+jtTa7icICNF5Zrlg=;
        b=sBSSBpcOb1YLzxiwIBpC3eiYCCpdBTsjtfP2Pr1ulHddMd3Z7KLgdAL/BrVTjItaiq
         oBe1etv/yblEn8e5muaXFsGAjnlniAYzMIV0N7P+e/oVTOop515/lV+Z/0/hfCiIyZVE
         hImeiVVIrqa6XqBbeChNsa13dVhbL3xxTgwJv9KKrkWiA1EzRhCx7tlOn73ydRBgipQK
         2riE6ifERHiiBVkudfPNiGPRb0+yCph1SF3o06wqMt8LUlaBHCysPD5HaAMH74wgG6L4
         reobmPOUuxNcwS0O2bj0ASQdTo/fG4UsCjeeAxZ2E1BBRPZpESaw9TE1RMPBmSMWrm7U
         SGqw==
X-Received: by 10.107.137.228 with SMTP id t97mr22423717ioi.16.1434912455689;
        Sun, 21 Jun 2015 11:47:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:990b:778:aa29:b388])
        by mx.google.com with ESMTPSA id p8sm6116575iga.13.2015.06.21.11.47.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jun 2015 11:47:33 -0700 (PDT)
In-Reply-To: <8545f1b636f157b280f15c615c1e1756@www.dscho.org> (Johannes
	Schindelin's message of "Sun, 21 Jun 2015 20:23:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272280>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> How about I implement your suggestion tomorrow, then show the diff
> between the two versions and we can assess what looks to be simpler
> (i.e. more maintainable)?

I'm indifferent at this point, partly because as we agree that what
you have as long as it works is ok, and more importantly, Michael's
suggestion to turn "check unconditionally and only control if we
ignore or warn or error out the result" into "do not even check if
we are told to ignore" is a much more prouctive thing to spend your
time on.
