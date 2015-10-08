From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: Allow treeish expressions as notes ref
Date: Thu, 08 Oct 2015 12:03:29 -0700
Message-ID: <xmqqziztqj26.fsf@gitster.mtv.corp.google.com>
References: <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
	<1436517551-12172-1-git-send-email-mh@glandium.org>
	<xmqqzj30yq03.fsf@gitster.dls.corp.google.com>
	<20151008025018.GA29722@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:03:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGTX-00042z-S0
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbbJHTDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 15:03:31 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34424 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756138AbbJHTDb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:03:31 -0400
Received: by padhy16 with SMTP id hy16so62344014pad.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ydMdJZqO3VVzb6HvFmY3NJ0D+aAENFXr8lcJIH5eEW4=;
        b=Lnpi8+LpIYccCmDCLizQ70a/57rLUbbse787sYXboTLUj02ZRoB1RWRH5FgrnKwUGl
         EFwAmehCY7UHJDnFQg4SHzwJ9pbiLpp6buy/VygBdgjmaND37H3VQt6m8eISYb4GRioE
         k6Annri4C3rfin+Lal1qesSkdJeWI4u5auel5k/U3OUA4Uym0Bi0kyEmElCLL98h6stP
         ebrWFqEcG/uURon4tTey/uHCkMEn+Z2iDovf/e+ZFIXS71WM6rw+uUN7LpODvc7CEiUs
         ocKTSqAvXUVf8NJRxU5QhUTfhznCts5eHs2OAlcPPZd/vhMpXwmzJf08xDvBhwVe4sUt
         oiMg==
X-Received: by 10.68.216.193 with SMTP id os1mr9768934pbc.110.1444331010546;
        Thu, 08 Oct 2015 12:03:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id ci2sm19147987pbc.66.2015.10.08.12.03.29
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 12:03:29 -0700 (PDT)
In-Reply-To: <20151008025018.GA29722@glandium.org> (Mike Hommey's message of
	"Thu, 8 Oct 2015 11:50:18 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279262>

Mike Hommey <mh@glandium.org> writes:

> After refreshing the patch against current "next", it appears that
> there is such a distinction:
>
> $ ./git-log --notes=fdsfgsfdg HEAD^! --pretty=short
> warning: notes ref refs/notes/fdsfgsfdg is invalid
> commit e5b68b2e879608d881c2e3600ce84962fcdefc88
> Author: Mike Hommey <mh@glandium.org>
>
>     notes: allow treeish expressions as notes ref
>
> $ ./git-log --notes=foo HEAD^! --pretty=short
> commit e5b68b2e879608d881c2e3600ce84962fcdefc88
> Author: Mike Hommey <mh@glandium.org>
>
>     notes: allow treeish expressions as notes ref

Good; thanks for checking.
