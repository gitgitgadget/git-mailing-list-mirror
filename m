From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add ls-remote --get-push-url option
Date: Fri, 31 Jul 2015 11:40:12 -0700
Message-ID: <xmqqfv445fxv.fsf@gitster.dls.corp.google.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:40:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFEE-0001DX-Jw
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 20:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbbGaSkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 14:40:16 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34284 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbGaSkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 14:40:14 -0400
Received: by pdbbh15 with SMTP id bh15so46556300pdb.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XmsSlzLNLZiog3VSYRkPtLz4dEXvPa9CJ8PZM1u+OEY=;
        b=EkSx5DaVpvimRILzmtA2D0WNb+0hCnCYR8IWT4VoW2fqj3Ca3es3O953yd8pepjlYs
         PZoXmfgL/X6TUjZ16B2KgZD4u79FWOTkfW5pCQzIlv7fbgIEU1+nBBDRR28ZJGIpSx5E
         D0QFqHVL4nE1DtNrbgjRHAsDOvejrhWP6QCwsOwW0Sfe90Pu3x/Kawm9Bs9ygzGlu1e+
         74u52enlC93rZnclUv0nE5aPOp5PtoSouwd43Vq+bgqUgLuoWPjj2hwJTBYPprwIhRdB
         kLzL9tHblM70G+P+/HyE+lzC8U+J3g4aJ5O4vqDepAW3bLfTCsgLGuCTVpVexXNxpGVJ
         zvmg==
X-Received: by 10.70.55.1 with SMTP id n1mr9635483pdp.21.1438368014255;
        Fri, 31 Jul 2015 11:40:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id c8sm8966043pdj.59.2015.07.31.11.40.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 11:40:13 -0700 (PDT)
In-Reply-To: <1438364321-14646-1-git-send-email-mathstuf@gmail.com> (Ben
	Boeckel's message of "Fri, 31 Jul 2015 13:38:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275061>

Ben Boeckel <mathstuf@gmail.com> writes:

> Not sure if it would be better to make a new variable or to reuse the existing
> one. I'm reusing it currently because it makes it easier to ensure they
> are mutually exclusive.
>
> Please keep me CC'd to the list; I'm not subscribed.
>
> Thanks,
>
> --Ben
>
> Ben Boeckel (1):
>   ls-remote: add --get-push-url option
>
>  Documentation/git-ls-remote.txt |  7 ++++++-
>  builtin/ls-remote.c             | 15 +++++++++++++--
>  2 files changed, 19 insertions(+), 3 deletions(-)

Probably get-url makes (some) sense because ls-remote is a "fetch
that does not actually fetch anything".  But "get-push-url" to
ls-remote makes _no_ sense whatsoever.  ls-remote and fetch do not
have to know or care about push-url; they do not even have to know
there exists a thing called "git push" ;-)

Wouldn't "git push -v -n" or something suit your needs already?
