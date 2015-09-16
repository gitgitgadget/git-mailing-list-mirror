From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/67] fsck: don't fsck alternates for connectivity-only check
Date: Wed, 16 Sep 2015 11:04:49 -0700
Message-ID: <xmqqtwquqlz2.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152428.GD29753@sigill.intra.peff.net>
	<f536d3d011ff1943c3cfcf90c9dce664@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:04:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcH4i-0000L3-DE
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbbIPSEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:04:52 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33681 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbIPSEv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:04:51 -0400
Received: by pacex6 with SMTP id ex6so215975888pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 11:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QfRQcDUIKITgFzkfS4dmE6JLTFIDgnugUkqdmCy8HvQ=;
        b=AZdgIjDFq0wuXOT+o9dhKX2lMG6XM1HBeznDriCu3ZThD4d2kvSy0jWVqTo5wnwqV6
         0VIPMOsXMf5ESlsxgNbpU084LG8XJBsDKPXPqafz883Wcjz5+SyG2h4C2p9U8D/p3mRH
         i8UKvar3wVx4y97SBhh+71/hwFI6PsRAuyuACpJRIdWGis/M5JEWYZuXsTfKRlygAIMg
         v9qyxMr7bXD9JAtpEMzSxXyYPdTPDFmNHaYLGN6s4RaLVp7paE9VCCrRi2ZxtwRm0kho
         WMZctrwi2vGjnL672LtEgHL/SMzf7Zcm4lqyNo9AxcUt9+wbdFFllgRUEYMP8CL6A2pX
         Zl0A==
X-Received: by 10.66.228.71 with SMTP id sg7mr34571175pac.70.1442426691115;
        Wed, 16 Sep 2015 11:04:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id d13sm29089694pbu.17.2015.09.16.11.04.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 11:04:50 -0700 (PDT)
In-Reply-To: <f536d3d011ff1943c3cfcf90c9dce664@dscho.org> (Johannes
	Schindelin's message of "Tue, 15 Sep 2015 19:55:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278040>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Peff,
>
> On 2015-09-15 17:24, Jeff King wrote:
>> Commit 02976bf (fsck: introduce `git fsck --connectivity-only`,
>> 2015-06-22) recently gave fsck an option to perform only a
>> subset of the checks, by skipping the fsck_object_dir()
>> call. However, it does so only for the local object
>> directory, and we still do expensive checks on any alternate
>> repos. We should skip them in this case, too.
>> 
>> Signed-off-by: Jeff King <peff@peff.net>
>
> ACK!

Thanks, both.

Peff, I am inclined to take at least 1 and 4 outside the context of
this series and queue them on their own topics.  I do not think
either is too urgent to be in 2.6, but on the other hand they look
both trivially correct (that is a famous last word that often comes
back and haunt us, though), so...
