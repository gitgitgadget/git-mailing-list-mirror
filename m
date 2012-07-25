From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/5] difftool: Simplify print_tool_help()
Date: Tue, 24 Jul 2012 18:52:00 -0700
Message-ID: <CAJDDKr47F9ZAPPCnFBdPYhQsx8qGGggHHrFWeZw2zpf-mukq5w@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
	<CAFouetjhGChULHa-Ax9oR--TccyEBnqn=UATbMpJxcdm3AOE1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 03:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stqlx-0005w2-PN
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 03:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab2GYBwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 21:52:03 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54090 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab2GYBwC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 21:52:02 -0400
Received: by vcbfk26 with SMTP id fk26so171337vcb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 18:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=klAmP/xTIFB47w4NKFabMjnRJxaYUdaMonU/rlCQfvg=;
        b=XQZ+yhGMLeljZdw9FsiUQ0gM1XAbys64/L6YXnNhh8+Ptl6ZCc4fOmq90iFy5AqNqP
         lVEaT6nXZgpISMbbt6ofKRs5pTJmyGYJuzUclwinL/gZmPhpvyMCU3sgJNrn9NfAi1u9
         qNigBK/63BrWbhVuIbxthKqTNnNoKwXgF1SU3czY9L9/NNU52H26n3YFL37gqgqERoV+
         gCkT8c6Zg1gZuSBd+tz1A2hxYWU/+9wDS3YpBwMTBbHbtMcp82cNOz4OHIjdU9q9AaAj
         hL9jxKDGPLByopXjBGCHGPg2KsYP4RMgsYC6rh985FOYCHf4t+wjAlFyljN5Q941dgSN
         eEjg==
Received: by 10.52.25.70 with SMTP id a6mr14825424vdg.78.1343181120987; Tue,
 24 Jul 2012 18:52:00 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Tue, 24 Jul 2012 18:52:00 -0700 (PDT)
In-Reply-To: <CAFouetjhGChULHa-Ax9oR--TccyEBnqn=UATbMpJxcdm3AOE1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202090>

On Tue, Jul 24, 2012 at 5:43 AM, Tim Henigan <tim.henigan@gmail.com> wrote:
> On Sun, Jul 22, 2012 at 11:42 PM, David Aguilar <davvid@gmail.com> wrote:
>> Eliminate a global variable and File::Find usage by building upon
>> basename() and glob() instead.
>
> glob was used in an early revision of the patch that led to bf73fc2
> (difftool: print list of valid tools with '--tool-help') as well [1].
> However, if the path to git or the path under 'mergetools' includes
> spaces, glob fails.  To work around the problem, File::Find was used
> instead [2].
>
> Does this implementation handle that case?  I'm sorry, but I haven't
> had time to apply and test myself.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/193233/focus=193925
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/194158

Good catch.  Eliminating the globals should be the goal, then.
I'll have to re-roll.
-- 
David
