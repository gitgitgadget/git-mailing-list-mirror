From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Discuss] soften warning message after cloning "void"
Date: Wed, 18 Feb 2015 16:25:25 -0800
Message-ID: <CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com>
References: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com> <CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:25:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOEwG-0004US-V4
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 01:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbbBSAZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 19:25:48 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:45125 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbbBSAZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 19:25:46 -0500
Received: by mail-ob0-f171.google.com with SMTP id gq1so8950342obb.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 16:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=z/YD3R5Ri7bHYyOg56kvJqFFUq7dTxyZnJCCN3YvSSA=;
        b=br2lBhc7s9+FDGhms35rEEPCIzBYnw2Z0x9jc0Cp1qvumGkCtPcMbaHCneRZs7nBEm
         jXPIj38zaaVXbPzbAnjXr6mnYz2vS+ltl/OdsGfv7rG9GYMEOQSKmDbGC1cGXTOUYEwN
         ogc+nkdgjpLxLgxakj21KIijjLp0qgh66XdGMPZIUk6v7s0wQAxdq7U2SI7/WsmawiLk
         6GHqEsS6gB8ExJSPrXbKCBZF1rQRqJsaomoiRUQYKJFC52wtw/TVoOuxHmDd1+pMdS83
         oR0qzbwYJNATqIkmomKjWEIyVbtud+M9FJHE1+YB2Ww987xGZwC60j1ui0LXV9MmS4jW
         3VlA==
X-Received: by 10.60.58.137 with SMTP id r9mr1260150oeq.1.1424305545648; Wed,
 18 Feb 2015 16:25:45 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Wed, 18 Feb 2015 16:25:25 -0800 (PST)
In-Reply-To: <CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
X-Google-Sender-Auth: ijg8rIepVJ72RGHh6qL_oyruH3I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264076>

On Wed, Feb 18, 2015 at 4:13 PM, Stefan Beller <sbeller@google.com> wrote:
>> +               warning(_("remote HEAD refers to nonexistent ref; "
>> +                         "leaving the current branch unborn.\n"));
>
> Personally I find that more confusing, because I have an idea of
> what checkout may refer to. The notion of an unborn branch is not
> clear to me.
> Maybe
>
>> -               warning(_("remote HEAD refers to nonexistent ref, "
>> -                         "unable to checkout.\n"));
>> +               warning(_("remote HEAD refers to nonexistent ref; "
>> +                         "Checking out $branch instead.\n"));
>
> with $branch being master in the example above. I'd have no idea
> how to come up with a good heuristic which branch to checkout.
> (It would need to match current behavior)

Checking out a random branch is absolutely the worst thing you can
do. Personally, I would think that the best thing you can do is to
educate your users not to clone from a void. Create some history
that is worth sharing, and then push into an empty repository.
