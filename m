From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/17] removing questionable uses of git_path
Date: Sat, 15 Aug 2015 16:05:27 +0700
Message-ID: <CACsJy8DPX2Z8zsRjsWoXLMN4V5=HFN7mZSiWPcrUvuyTte3UKA@mail.gmail.com>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 11:06:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQXPf-00074e-TA
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 11:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbHOJF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 05:05:59 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33756 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbHOJF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 05:05:58 -0400
Received: by igfj19 with SMTP id j19so27611622igf.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Lf6vRYWKO9pcDHQh+bbJaRup/40lqjC7A0K78+3506Y=;
        b=S+z5HWfFhe6bxp8qM5WedC1cZNQCbgIy/fS5XUID/RMNjWUt/s3gJpL2wQWEZM1qfT
         UKm3EY+nl0pPa8o4UVnoqk7ak3hy+5zIfo0+oEnkb7wCCPM7KsFf/M7ZfvRGbhB8ysnU
         tEZ7kj1Gbm9ePzYgi6/sJhyntZYxXpRlRFIgOZqaOI/rEM2kKPaDqcKAON4cgBrE1bKO
         0t7Zuur61g24Bc2aZDLYBKUglkkCKzzI5eXRMHwqJnRg33YFhzLp2dSrI5uDz/KLrZko
         hXvAbhRXzOh7K0peV3JKQot0dfFvzRMbkcj1CKQeAaVJhyZv0Kwpvrrq+eNLLtEQxMbE
         ONBg==
X-Received: by 10.50.59.211 with SMTP id b19mr6968427igr.42.1439629557159;
 Sat, 15 Aug 2015 02:05:57 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Sat, 15 Aug 2015 02:05:27 -0700 (PDT)
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275985>

On Mon, Aug 10, 2015 at 4:27 PM, Jeff King <peff@peff.net> wrote:
> The problem is that git_path uses a static buffer that gets overwritten
> by subsequent calls.

resolve_ref() was in the same boat, then we renamed it to
resolve_ref_unsafe(), I believe with an intention to eventually kill
it. But it lives on anyway. I wanted to suggest renaming git_path() to
git_path_unsafe(). But I'm not sure if that will catch reviewer's eyes
when new call sites are added. Probably not..
-- 
Duy
