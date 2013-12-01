From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git stash doesn't honor --work-tree or GIT_WORK_TREE
Date: Sun, 1 Dec 2013 18:50:14 +0700
Message-ID: <CACsJy8BFqqy8T1zwZd7Ly1-sAKGoxh0YfhFBgX6fBMTt_b5Dbw@mail.gmail.com>
References: <CABL6xpD9jvJWjUj0n+mgC419fGzA2N-b_yJho9zharCD6YTSiw@mail.gmail.com>
 <loom.20131130T221443-682@post.gmane.org> <874n6sddu7.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Dec 01 12:51:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn5YK-0004JK-CO
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 12:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab3LALvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 06:51:01 -0500
Received: from mail-qe0-f41.google.com ([209.85.128.41]:50163 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3LALuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Dec 2013 06:50:44 -0500
Received: by mail-qe0-f41.google.com with SMTP id gh4so9688696qeb.0
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 03:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=f2ImEdsONMMiWZgvkqcx+MBDpJJQvgmHh2MBAlH93uk=;
        b=GMVh7NGDyfqAS0z/QzT4AS17jjhrm6QzEqkj4nqI9c89JAssTx8IUmf4unH+X2UkuO
         CAREJOotPf48CvAdDtt+QWO1Z7j1mZrYbtKjX7CRCo8gyjcSEU7/UMwA+gfy5ivQ+Hok
         S8aXjDsU7la2DAwsQeSGkF/clIvHiilg8Abb757I3mHLInuQI0I+iPnylYBsESS0ABd7
         xKzav3Rj2YefkyaT87FJnM57PJynySNI4uBpijd7Mhz47fGmOYx7lkPTjn9FP24V3ITa
         PEjIonAuXz90d3KTnj4iwKoxHHatC3SIgwJGxa3aV21ndLtp6YdcFqGVOchgqjGg0sjR
         ChCA==
X-Received: by 10.224.50.84 with SMTP id y20mr3367069qaf.74.1385898644095;
 Sun, 01 Dec 2013 03:50:44 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Sun, 1 Dec 2013 03:50:14 -0800 (PST)
In-Reply-To: <874n6sddu7.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238587>

On Sun, Dec 1, 2013 at 6:12 PM, Thomas Rast <tr@thomasrast.ch> wrote:
> =C3=98ystein Walle <oystwa@gmail.com> writes:
>> The problem seems to be that git rev-parse --is-inside-work-tree doe=
s
>> not honor these. In fact it doesn't even honor --git-dir or --work-t=
ree.
>> Judging by the name this may be intentional.
>
> Thanks for investigating this.
>
> Duy, you are the expert on the worktree detection logic.  Do you know=
 if
> there is a reason for --is-inside-work-tree to not honor the
> GIT_WORK_TREE / GIT_DIR overrides?

It should. At the beginning of cmd_rev_parse(), setup_git_directory()
is called, which will check and follow all GIT_* or their command line
equivalent. I'll look into this some time later.
--=20
Duy
