From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: Re: [PATCH v2] clean: add --null option
Date: Wed, 18 Apr 2012 18:59:14 +0200
Message-ID: <4F8EF2E2.2080807@gmail.com>
References: <1334480962-18778-1-git-send-email-rosslagerwall@gmail.com> <7vehrntowg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:59:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKYE3-00065V-3E
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 18:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab2DRQ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 12:59:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51023 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab2DRQ7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 12:59:21 -0400
Received: by bkcik5 with SMTP id ik5so5673567bkc.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=5RbW0/ulMrSlvkojvo3vyOlu/btvDhpmynTufevOQPM=;
        b=hv2hxHqsFkuQsxxQGLEl/9kYSrLtfDC88OPGSW5C0poXISgiNQ2fv++S+ZxgjFxa3F
         g/tvFhYXNa/IebOqA920tJsb5SjIROnTFiOuqW00BTctI0VLlk8Mi+NyqAsWrQKIAIxU
         F2PqIgR8ZfOpcuvq60hefqSe6+X3ZZQtebaW5Nc5A/RbDvZ9AQXyNaA72mo5K4mMfh+l
         G3KvXmKcQZ1gnZqGQM2RMezjid/v3TBNiFbhCt/zqAHTNcmC8bzkWDmGK/L3sX4f3x+T
         tQx01OcUe5rvaUDPrhWE/qR5NesqUH1TnRRJryNDHwhDXo+1u0rmN93KYhWCihWFMJLP
         Akxg==
Received: by 10.204.157.145 with SMTP id b17mr989443bkx.112.1334768360612;
        Wed, 18 Apr 2012 09:59:20 -0700 (PDT)
Received: from [192.168.1.90] (41-135-191-151.dsl.mweb.co.za. [41.135.191.151])
        by mx.google.com with ESMTPS id iv11sm45553942bkc.16.2012.04.18.09.59.18
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 09:59:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <7vehrntowg.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195875>

On 04/16/2012 10:14 PM, Junio C Hamano wrote:
> I suspect that older days "git clean" was a scripted Porcelain around a
> plumbing (perhaps ls-files?---I didn't bother digging its history as I do
> not care too deeply about "git clean" which I do not use myself).

Do you just use ls-files directly?

>  If we
> have piled so many features into "git clean" after the rewrite-to-C to
> make it impossible to express what "git clean" _would_ do in terms of
> "ls-files", perhaps that is what needs to be fixed, so that we can express
> "git clean --some-set-of-options" as:
> 
>     git ls-files -z --set-of-options-equivalent-to-what-is-given-to-clean |
>     xargs -0 rm -fr
> 

I agree that a --null option to git-clean is unnecessary if git-ls-files
is used. It seems like they can be made pretty much equivalent except
that git-ls-files doesn't seem to have a way of listing "only files" or
"only directories"?

-- 
Ross Lagerwall
