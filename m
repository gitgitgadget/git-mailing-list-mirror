From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 4/4] git-am: add am.threeWay config variable
Date: Tue, 02 Jun 2015 13:19:21 -0700
Message-ID: <xmqqy4k12792.fsf@gitster.dls.corp.google.com>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433266446-2845-4-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:19:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzseo-0000Fx-ET
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 22:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbbFBUTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 16:19:25 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34801 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbFBUTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 16:19:23 -0400
Received: by ieczm2 with SMTP id zm2so142078008iec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ty1SCl5lO/l/qwy4PEMmmkH49IfHKyh0qhFTwHYnqNs=;
        b=cICyJickVW9swuEeIFy+ta2coPyf9GxWTtlz2rfE+NnV28VFRllt0N3YObwngdxEiR
         JoAUJGbRTqLBRhwqyeQu/YSRvK3CSps5XqJOBZdAYRKLiDLIM3isMba3qLgMlQyRLvjU
         7XWOAQQ1s+XMp86guvlI3+9OCmlQ/hmOaTJJ3D0JmSPd74kixaMCQchzuxzh+JcpK8kr
         nDQdRPFlIWP+zQwAYbLvrQJEvtZz/hYUH2udBcU8NAKh3V2tDOr2nqXGFQFNnk83x4yA
         HF3LDJKmmb/vl34Ur679hlHrnBL0nirq9C7Ru31C7f8iHTLMsshg5KToFyk4akw+2jxa
         mreg==
X-Received: by 10.50.2.3 with SMTP id 3mr22646248igq.34.1433276362947;
        Tue, 02 Jun 2015 13:19:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id w124sm12393227iod.3.2015.06.02.13.19.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 13:19:22 -0700 (PDT)
In-Reply-To: <1433266446-2845-4-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 2 Jun 2015 19:34:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270594>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index d412f6b..0472182 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> ...
> +am.threeWay::
> +	By default, git-am will fail if the patch does not apply cleanly. When
> +	set to true, this setting tells git-am to fall back on 3-way merge if
> +	the patch records the identity of blobs it is supposed to apply to and
> +	we have those blobs available locally (equivalent to giving the --3way
> +	option from the command line).
> +	See linkgit:git-am[1].

Same comment as 2/4 applies here.
