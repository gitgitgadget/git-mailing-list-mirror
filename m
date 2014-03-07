From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: gc/repack has no option to lose grafted parents
Date: Fri, 7 Mar 2014 07:47:29 +0700
Message-ID: <CACsJy8BrnKPu=Uf5Qy1KoccorBJ43yo+R9P3PyVAeNU9FuCy6Q@mail.gmail.com>
References: <CACPiFCLqa=ZQM6Azh2G5hwBCMx96Cxa5BMN=-2aCy5x=YhBpGg@mail.gmail.com>
 <xmqqwqg6vrht.fsf@gitster.dls.corp.google.com> <CACPiFCLgoGP59sW73YFCt8Wq4hpxZUb0PBF-DzHz0JdxrYo4rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 01:48:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLixL-0000iY-9I
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 01:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbaCGAsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 19:48:01 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:54292 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbaCGAsA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 19:48:00 -0500
Received: by mail-qc0-f170.google.com with SMTP id e9so4004880qcy.29
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 16:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Vpy+20iKfcaEA3C8dp7rinQ+hzPBsUAk731UCQOrCac=;
        b=upPjH5KGuYZwuxXytScaLJ6XO3/aNdPlT+ZVLFlLobhtkLWeSXnLkAbdzNzD2Ti69h
         JsnNAwhuE4fpcaMvmItVZpO68tFA1ChMLayQFRkloKhXMl0cTwpJceAp1AXxaTlXl2x9
         lV0a4Fqk6ZB40iGtOKX8zEyyu7CsKHd0azRs9yoUTJrX80LbRD6QtEt53kJazfJPOIMD
         uERWrKhX/v0Mq5CdE5mJE3mVEbIAo+QAy0q4iSJtskJfrKcfo9L7pXMwub2ONhxUKE3Z
         nQa+fjquQFZj9oWTvZkmtSCG3N3MnPdzLjHa6Z+KRcM9iDSkSsYAZ1MothdsYBiPmoPS
         XQ1g==
X-Received: by 10.224.36.129 with SMTP id t1mr17454081qad.88.1394153280013;
 Thu, 06 Mar 2014 16:48:00 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Mar 2014 16:47:29 -0800 (PST)
In-Reply-To: <CACPiFCLgoGP59sW73YFCt8Wq4hpxZUb0PBF-DzHz0JdxrYo4rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243579>

On Fri, Mar 7, 2014 at 6:36 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Thu, Mar 6, 2014 at 6:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Given that we in general frown upon long-term use of grafts (or
>> "replace" for that matter), I am not sure if we want to go in that
>> direction.
>>
>> Just a knee-jerk reaction, though.
>
> Fair enough.
>
> If I state my actual goals -- discarding old, uninteresting history,
> in a "rolling" fashion? (periodically using a script that says "forget
> anything older than one month") -- is there a better way?

Convert it to a shallow repository? Either you clone it and do "fetch
--depth=XXX && prune", or you manipulate $GIT_DIR/shallow directly
then prune (no worse than editing grafts, I think).
-- 
Duy
