From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] merge: warn --no-commit merge when no new commit is created
Date: Tue, 26 Apr 2016 21:39:22 -0400
Message-ID: <CAPig+cTo09ECiPrtzHAHrr1a15khcYkL8QQpe_AjX2tEhRum2A@mail.gmail.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	<xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
	<xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
	<xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 03:40:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avET5-0006G3-64
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 03:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbcD0BjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 21:39:24 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36351 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbcD0BjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 21:39:23 -0400
Received: by mail-ig0-f193.google.com with SMTP id c3so4176584igl.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 18:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=W4q2Al7y4GEhEXF6QYGVUz/+ppivGshYomVMy/7aNGI=;
        b=vpxUbeTFLn+ukE5axWGQcoue1hM4QTelYfsDyfXOjnoY8Ji5bFHTVEfhJzra5rOSM4
         CJ6+Mo40uCU5cbLNFcc5TbAhdwuw2c3saXQ5B9NWWQ2N9e7L5x+t16eLuRzxroaWBsK6
         x+y2oiQ1+EmCSWE73AyzNs3Gn4iHqL5foWNOB8G7xUL7oJ/7zDEq/zVdqCCg3Ji3JU3Y
         WtsrF98AeDxXWU121aTO/dGLbRoRIK10mD1cBb3w2rwzNMtMHNeg967zhiY8k8Y39JO2
         025mZ+yC1CwQ+bRk7NHK2EMWNFh70s40NUALK93hd3LMx+yT2RtCyq0e0SS/bLlvfnjg
         GfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=W4q2Al7y4GEhEXF6QYGVUz/+ppivGshYomVMy/7aNGI=;
        b=Oa6euEcjyJ8YIErymK75QvQHnAF6nvBu3kObHIcQTLCZQMU7xB1XRK7TrNishJMxyM
         iqFU1HQO+tgfrqgAL/RcOuLaxYKAGNcCqACdAyhr0IklSPSDq4lQ+bCIP7AoNYmEzIE6
         f1kwUa+Y5sacu04wvgFZl4b6i0OpymhVXmdUC/0Jm9lC3Fo8SD6ckFkxdX6HpoBlCo9L
         xKL7IcNInnl09vFOTKLhYQ76nqiaj2+Mx4ZBxQdRSV50dJ2qhmWSBGlOsY2zZ7aEKUKp
         GkyReuoAsAR8rDRuIVbl68oXkTT473pkwaz5jTvLzcIMKptyT9uBrgd/b7FLBYlwYSJH
         epYw==
X-Gm-Message-State: AOPr4FVsVcgLS5oo62Gg/RE0FQC8VEDlgLlF9AHpHYfDUMABSgYYQsVdYWI2SB3lDcgA6Wtr7psITOMSN64v2w==
X-Received: by 10.50.205.42 with SMTP id ld10mr22829635igc.17.1461721162961;
 Tue, 26 Apr 2016 18:39:22 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 26 Apr 2016 18:39:22 -0700 (PDT)
In-Reply-To: <xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: OXPDUCx_Rg1YdsF2sa-szEhlJJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292700>

On Tue, Apr 26, 2016 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> A user who uses "--no-commit" does so with the intention to record a
> resulting merge after amending the merge result in the working tree.
> But there is nothing to amend and record, if the same "git merge"
> without "--no-commit" wouldn't have created a merge commit (there
> are two cases: (1) the other branch is a descendant of the current
> branch, (2) the other branch is an ancestor of the current branch).
>
> The user would want to know that before doing further damange to his

s/damange/damage/

> history.  When "merge --no-commit" fast-forwarded or succeeded with
> "already up-to-date" or "fast-forward", give a warning message.
>
> We may want to turn this into a die() after a transition period.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
