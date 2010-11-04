From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] rebase: teach --autosquash to match on sha1 in
 addition to message
Date: Thu, 4 Nov 2010 11:44:46 +0100
Message-ID: <AANLkTikA_46ZdrRBCnh-1Rx1jfqGb377jeg=9OO5T3Tr@mail.gmail.com>
References: <1288838504-69114-1-git-send-email-kevin@sb.org>
 <1288838504-69114-2-git-send-email-kevin@sb.org> <5CCA000B-2178-4DF7-8D72-29F95A9BB360@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 11:45:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDxJi-0003d0-H9
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 11:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab0KDKpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 06:45:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56834 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab0KDKpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 06:45:07 -0400
Received: by gwj21 with SMTP id 21so1242000gwj.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=h5Z8QZRa1gs0gQSNR6w9Olj5jSi0zsjVe6O3FP9HO3A=;
        b=B+xbZmDmRg5gxxBpDe1WfKqfjXEWxTOFvB6vNPL6n+h1ayt+99hz1wDyR2hkUH0FO2
         jnsCba1qBMoKftjrokk3sLlvAR1Mq7bzlLcwFQ4YW88Ivrpb7e1jOUM7CCcRtO9MdLeZ
         EUjkoqugZITtl+Hx6C5bhS4TW8bhIgBeeD6tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iSNyWf6YDQjJY7/gjr9X/gSWjtAUwlz1Bth/xzWLpB5anoGRPux2Fibg9Hj+N3jw/i
         KsQeoMIysxjLeZeS4OMOGuvvi4eAdkT6z0aRJpJo2ckDET8oM3dkWCVfJziCy62WkowH
         M6evXEm0AjXZ3DocRpuKvLsDCfm17SYZ5eYVA=
Received: by 10.150.206.11 with SMTP id d11mr1004318ybg.369.1288867506984;
 Thu, 04 Nov 2010 03:45:06 -0700 (PDT)
Received: by 10.150.58.11 with HTTP; Thu, 4 Nov 2010 03:44:46 -0700 (PDT)
In-Reply-To: <5CCA000B-2178-4DF7-8D72-29F95A9BB360@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160716>

Heya,

On Thu, Nov 4, 2010 at 05:49, Kevin Ballard <kevin@sb.org> wrote:
> I just realized that this only works for sha1's of up to 7 characters.
> If you provide more it won't match, as it's comparing against the sha1
> given in the todo list. I wonder if it's worth resolving all sha1s to
> their full length if the provided string is longer than 7 characters?

Well, not if you're resolving them based on the 7-character string
from the rebase todo list. If you run in to ambiguity with those
7-length hash we should instead increase the length of the hashes in
the todo list.

So I'd say, solve this by doing a prefix match?

-- 
Cheers,

Sverre Rabbelier
