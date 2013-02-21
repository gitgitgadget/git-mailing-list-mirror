From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v4.1 09/12] sequencer.c: teach append_signoff to avoid
 adding a duplicate newline
Date: Thu, 21 Feb 2013 12:29:03 -0800
Message-ID: <CA+sFfMcnqJUmpk3OGgYTQxfgZWpZTfhVUZhyhFaf7eJL0t3SRQ@mail.gmail.com>
References: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
	<1360665222-3166-1-git-send-email-drafnel@gmail.com>
	<7vip5lv6tv.fsf@alter.siamese.dyndns.org>
	<CA+sFfMcNWvPKuQpNWnacegbfgN0ZP=zfuDPDRkXs1G2FMrb+iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:42:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8cy1-0004DL-GY
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 21:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325Ab3BUU3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 15:29:06 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:42945 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757306Ab3BUU3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 15:29:04 -0500
Received: by mail-wi0-f182.google.com with SMTP id hi18so120433wib.3
        for <git@vger.kernel.org>; Thu, 21 Feb 2013 12:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=wIPzpwlrFMarfv5w/zIP83eke374KH1dRiy8DCT1EiU=;
        b=wlNUnwZaAnO/beJNP4Ov56e46fA/Q7YDdnbmovlaCUyJ+6awFHqjKEIEYOYZvoXtgY
         wy2raZjYkxXg2MWvNJawUhp0gQnC4wQdzhGJUVkzzNpIeaC5NwKyAtRjjjXqQWjY7FcQ
         XYoo3qMCmo0U3hjzNXDibMxT+REe9+RF8xljJeBW2L9qMoalN3TaCYh+tYMrmfXJ5CN1
         5/M4xHo7E+M7B7GiOgzfvk27EVOtYa533EN9OFRIwODTp6M8aiwSHuhgD2g7XIoTwyrx
         veIBY/npAaZQ5iRxuIJAbH8PsERTn6d5EDaY5b4oC6f0rspwCPZFvmvppzTtxMxdqB74
         74aw==
X-Received: by 10.194.92.65 with SMTP id ck1mr44352760wjb.54.1361478543761;
 Thu, 21 Feb 2013 12:29:03 -0800 (PST)
Received: by 10.194.63.46 with HTTP; Thu, 21 Feb 2013 12:29:03 -0800 (PST)
In-Reply-To: <CA+sFfMcNWvPKuQpNWnacegbfgN0ZP=zfuDPDRkXs1G2FMrb+iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216796>

On Thu, Feb 21, 2013 at 12:26 PM, Brandon Casey <drafnel@gmail.com> wrote:

> But, this does not fix the same problem for 'cherry-pick --edit -s'
> when used to cherry-pick a commit without a sob.

Correction: "when used to cherry-pick a commit with an empty commit message."
