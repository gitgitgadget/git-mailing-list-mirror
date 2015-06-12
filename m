From: Panagiotis Astithas <pastith@gmail.com>
Subject: Re: [PATCH] Fix power checking on OS X
Date: Fri, 12 Jun 2015 11:53:32 +0300
Message-ID: <CACvVhd7sKiz+gTDY_RVjFf1i3Rt2pYWVsgjewyPHL1ajS5LTcQ@mail.gmail.com>
References: <1434033445-35903-1-git-send-email-pastith@gmail.com> <CAPig+cRzKpCePO0gXy7Rok4X7=r6tas28tv48g92YzP9tVP2AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jun 12 10:54:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Kit-0001m9-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 10:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbbFLIxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 04:53:55 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:36117 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbbFLIxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 04:53:53 -0400
Received: by yhan67 with SMTP id n67so11496301yha.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc
         :content-type;
        bh=UhULOjNGggTtWUbDbQ1PBX0GHmZdKFYGFfl5569wBQE=;
        b=tKleTS9iT2CdAAowAjdj2wv1YR2tK3uGohsWB1YAM8Dxa0BWiPDmzbGluwwR8rCJUI
         /H4QcxuZWL9mlErDuy0EjF4GyXCewIl6hBSVKj4bS6xdreRPwfb5PBCo+vJR2OBhq87+
         FxzuczJ0bJgZcsY2xdTe60msEXmnVDbcS1YQti0KP6RByyWXo+nRvJY15xoxbZ1RYvt5
         HgJxRJDLe45D8uiuOTsLgN75gbI3N9EUYl2q3WwAx6tnkFINvJG5I4MP7Y3L2Zk3ROkc
         /7AkCYr5e107BvDt4ROkQXOR2Tajg9IYCO5OG95AyNQF7VqZd98osnDpt4Up6KrrKgXe
         0bxA==
X-Received: by 10.170.87.193 with SMTP id e184mr17473551yka.94.1434099232386;
 Fri, 12 Jun 2015 01:53:52 -0700 (PDT)
Received: by 10.37.203.77 with HTTP; Fri, 12 Jun 2015 01:53:32 -0700 (PDT)
In-Reply-To: <CAPig+cRzKpCePO0gXy7Rok4X7=r6tas28tv48g92YzP9tVP2AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271475>

On Fri, Jun 12, 2015 at 6:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jun 11, 2015 at 10:37 AM, Panagiotis Astithas <pastith@gmail.com> wrote:
>> The output of "pmset -g batt" changed at some point from
>> "Currently drawing from 'AC Power'" to the slightly different
>> "Now drawing from 'AC Power'". Starting the match from "drawing"
>> makes the check work in both old and new versions of OS X.
>
> Would it make sense to try to future-proof this further by searching
> only for "'AC" (including the leading single-quote) or just "AC"
> (without the leading quote)?
>
> (Genuine question. I don't have a strong feeling about it.)

It's a reasonable idea, although I'm wondering what are the odds of
pmset changing to output a string when running on battery in the
future, containing something like "no longer on 'AC Power'". That's
probably too far out though.
