From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: Handling empty directories in Git
Date: Fri, 11 Apr 2014 14:34:10 +0200
Message-ID: <CAA787rmfWqjkBe0cT4-aXD0uPi-pWhjK0K0g2Vm8V0bJ7TLoMg@mail.gmail.com>
References: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Olivier LE ROY <olivier_le_roy@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 14:34:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYaex-0000by-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 14:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbaDKMeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2014 08:34:13 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:59859 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbaDKMeM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2014 08:34:12 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so3465060lbg.11
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=BSM5mwNjqNDkW93WRFnCK3SVOcbli06hdFjw2fhuojM=;
        b=S1pWe91fJqH+wQ4mXtUoRfV/A24O4xpO95i9BUnBYOivcDcdz3l4lDY5tikPvonq5+
         w8pzIY42bkIfoYxPwNGoqGVgjTkjN/pS7B/FjrFU7s0nOzfKyaErhcTeOTg4CfnDW24x
         fHZHvMZLrzH8VXERi2C0ZdpI2Q5PROG7BJSrRcJmUBoJ7azGbxrr6cCMoSZlTHY44bWE
         8k/xCmMdsM+0rostq30gQhlv9WlErkHmbFiLHZ85U1M71qoun1dq06whpC6fiiSmOXkB
         yDnBbTyk9FY83bCmAuM2uTQ1ERiHXfN7n2G1hS0YvvpsQFjlDwhev+zL78RnmX5XcpJA
         IMCA==
X-Received: by 10.152.42.164 with SMTP id p4mr16535171lal.5.1397219650436;
 Fri, 11 Apr 2014 05:34:10 -0700 (PDT)
Received: by 10.112.13.102 with HTTP; Fri, 11 Apr 2014 05:34:10 -0700 (PDT)
In-Reply-To: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com>
X-Google-Sender-Auth: vM6QBD3dlxmLl49V0vggv9rV3Dw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246082>

On 8 April 2014 16:47, Olivier LE ROY <olivier_le_roy@yahoo.com> wrote:
> Hello,
>
> I have a project under SVN with contains empty directories.
>
> I would like to move this project on a Git server, still handling emp=
ty directories.
>
> The solution: put a .gitignore file in each empty directory to have t=
hem recognized by the Git database cannot work, because some scripts in=
 my projects test the actual emptiness of the directories.
>
> Is there any expert able to tell me: this cannot be done in Git, or t=
his can be done by the following trick, or why there is no valuable rea=
son to maintain empty directories under version control?

Git doesn't support storage of empty directories, but there are ways
around it. As you say, you could place empty files in every directory,
but I've never liked this concept. Instead, I use a couple of scripts
to store/restore empty directories:

https://gist.github.com/sunny256/419015

This creates a file called ".emptydirs" at the top of the repo, and it
can easily be implemented into scripts and build processes.

Greetings,
=C3=98yvind
