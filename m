From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH v5] Add an explicit GIT_DIR to the list of excludes
Date: Mon, 9 Jun 2014 20:18:12 -0700
Message-ID: <CAKpPgveXen9sQefo8dva1Uy4YOyroT6cPXLzgUvxj93Zqw13zw@mail.gmail.com>
References: <1401912909-29654-1-git-send-email-pasha.bolokhov@gmail.com> <CACsJy8AyvkA20mD283=hWp7WFJXBu3-ViXHuS4jtMzz2hpBi2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 05:18:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuCa8-0000iV-Ib
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 05:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbaFJDSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 23:18:34 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:59610 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844AbaFJDSd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 23:18:33 -0400
Received: by mail-ob0-f180.google.com with SMTP id vb8so2847306obc.25
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=USqMJ82plX0/4MAk1u3z7vC47rmAOehDP9acI2NB1Sc=;
        b=U7GCEnnUNtSNbmbTPymIliA7xsl6DBYYPsFmKZJKuWiuLfOdz7s76mrFrNMFsMeOWv
         GvAefs186tgBXO4Bb//EkmLbYK85fjFQvx5VLHi3ASpfF5UXdeeswIUBs9gLyNiapScM
         EmAYfgorTOz2NfU7bGkqM/JAhZWwl87eH50OB4/I8b+Bp8KrvrjKorMV9QaY/X9+y3d7
         CYp9nD2LSUPBOX7U5m1A7GHnSbLrqig9OveXRSMFIWxHym7Z93ZnNrLqDsMVj/TeVly1
         CWSPmWbE3fG9p18VymoLPPb0jw4zt0m2eZeSy44x5nGpU4OE+WMF/byelijmy9OvKPiC
         DX4Q==
X-Received: by 10.60.173.228 with SMTP id bn4mr30619616oec.27.1402370312830;
 Mon, 09 Jun 2014 20:18:32 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Mon, 9 Jun 2014 20:18:12 -0700 (PDT)
In-Reply-To: <CACsJy8AyvkA20mD283=hWp7WFJXBu3-ViXHuS4jtMzz2hpBi2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251153>

> On Thu, Jun 5, 2014 at 3:15 AM, Pasha Bolokhov <pasha.bolokhov@gmail.com> wrote:
>> +       /* only add it if GIT_DIR does not end with '.git' or '/.git' */
>> +       if (len < 4 || strcmp(n_git + len - 4, ".git") ||
>> +           (len > 4 && n_git[len - 5] != '/')) {
>
> Hmm.. should we exclude "foobar.git" as well?

    Why wouldn't we? Everything that has basename ".git" is hard-wired
to be excluded, but everything else, including "foobar.git" should be
added to the excludes manually... How is it better than just "foobar"?
