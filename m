From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 14:15:05 -0400
Message-ID: <201405281815.s4SIF5hF025886@hobgoblin.ariadne.com>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com> <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:15:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpiNg-0002sw-Mc
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbaE1SPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:15:10 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:42245
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020AbaE1SPI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 14:15:08 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id 7Uop1o0050EZKEL51WF6G8; Wed, 28 May 2014 18:15:06 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id 7WF61o00H1KKtkw3MWF6Si; Wed, 28 May 2014 18:15:06 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s4SIF6ap025887;
	Wed, 28 May 2014 14:15:06 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s4SIF5hF025886;
	Wed, 28 May 2014 14:15:05 -0400
In-reply-to: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
	(pclouds@gmail.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401300906;
	bh=6yyCnC6PMl1UOa4W48I70zIqwvD19AKgkMCnHg3jgzw=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=BDZJ/fERxZN4Lap62C82+ER/xFAdBxeeDLsdwARx5cBNxjNkNsO2vmtICL9m1AWBG
	 12cB0oHc5EZxG7zC4tOjvxkXLlAvdxuAIb4RfW7n72h3ADRwVmXlbp7fxrG9X0b0mt
	 r6+ID920wuUyLllj7CZ0P4uQnkdKnW9fuq15eBgSQPR6W0iJmZ5x2GQuFcL8XX88d9
	 2HSnlCFwesBci/DUHc7sdDxRbLckXurm6Zz4sOgydPlvvShCfYwymIQWYbe7MLEQA6
	 Qd3hsXUuCUTYmZ/HwcSR8JQgWAPLSMs/qK66JDHATKuRsJu+6JquUMM0EOSkWSGM07
	 ceTk+Cp/KsacA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250305>

> From: Duy Nguyen <pclouds@gmail.com>

> I don't know how many commands are hit by this. If you have time and
> gdb, please put a break point in die_builtin() function and send
> backtraces for those that fail. You could speed up the process by
> creating a smaller file and set the environment variable
> GIT_ALLOC_LIMIT (in kilobytes) to a number lower than that size. If
> git attempts to allocate a block larger than that limit it'll die.

I don't use Git enough to exercise it well.  And there are dozens of
commands with hundreds of options.

As someone else has noted, if I run 'git commit -q --no-status', it
doesn't crash.

It seems that much of Git was coded under the assumption that any file
could always be held entirely in RAM.  Who made that mistake?  Are
people so out of touch with reality?

Dale
