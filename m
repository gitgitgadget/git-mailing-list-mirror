From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Fri, 5 Jul 2013 19:36:14 +0100
Message-ID: <CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
 <CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
 <loom.20130705T195116-413@post.gmane.org> <CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Brucher <matthieu.brucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 20:37:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvAsP-0001eu-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 20:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605Ab3GESgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 14:36:45 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58438 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab3GESgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 14:36:44 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so5889304iea.4
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jP/uuR5wI/W2fgys1YoLmCp1XhKjH7IIgSHr2L88BuI=;
        b=UnlvkluLEiCGj6wmeGSa9QjDZXZ9XzFFgi9YIQBkVrEXnkKKfN4ef8+ZZonv46aez7
         3Qfh9CgH+2xO1rwDcTHMDuN6JSnuQJzdtrIOSe7GYToEOpLpWNNz9w+3E2HoTJMaxpwm
         VLpn2RCFjpzTK3jKcUm7vYocZ2BBkuGyh/cTrqVW/Btc9ALg/SkujY5+vXwO67fzynpZ
         +E7zk7pL9LJa0fRxyBadtavaZHPgwlhHQDHPgf0r602jxH6OTQUdPID0/SVV5wIWvLWQ
         7TQBJUT0ZIBLLwpAhr1SDjWzYsa9v9Hk5OaoCR/a8eeLRrzOn2e5S4SQkjV6k/0k5LxN
         /6UA==
X-Received: by 10.43.74.74 with SMTP id yv10mr4209645icb.67.1373049404055;
 Fri, 05 Jul 2013 11:36:44 -0700 (PDT)
Received: by 10.64.21.103 with HTTP; Fri, 5 Jul 2013 11:36:14 -0700 (PDT)
In-Reply-To: <CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229674>

On Fri, Jul 5, 2013 at 7:11 PM, Matthieu Brucher
<matthieu.brucher@gmail.com> wrote:
>> Hi Matthieu,
>>
>> Could you please try using //Depot/Project<at>all instead of selecting a
>> specific revision?
>
> I can try. Indeed, at this revision, the two other branches do not yet
> exist. But @all will get everything? Last time, I only got head
> (IIRC).

Our P4 server has a limitation on the number of lines returned by "p4
changes" command, so sometimes I have to use @change_start,@change_stop
instead of @all. You might want to use this range limitation to test
git-p4 by limiting to a small number of changelists that allows you to
check if at least one branch is correctly detected.

>> Also, by using that command it means that the following depot paths must
>> exist:
>> //Depot/Project/Branch/Main
>> //Depot/Project/Releases/2013
>> //Depot/Project/Branch/Feature1
>
> Yes, they indeed do.

In this case the problem should not be in branchList configuration.

>> I've never used the --use-client-spec, so I'm not sure if that will not
>> break the branch detection code.
>
> I need to do that because if I don't, the depot is clobbed with
> binaries. Or perhaps if I put some .gitignore stuff, I might not do
> this?

Keep using it, at least for now. If everything else fails we can look at
this again.

Cheers,
Vitor
