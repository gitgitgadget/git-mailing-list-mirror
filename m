From: Andrey Loskutov <loskutov@gmx.de>
Subject: Re: Single brackets matching in .gitignore rules
Date: Mon, 28 Sep 2015 19:46:10 +0200
Message-ID: <4259524.1vtm9ffbuH@pinguin>
References: <2606743.RipZrg6Xoz@pinguin> <CACsJy8DiTevhSnkkab-kfvpibitoUMHdjC2UdGT244JwLRxqWQ@mail.gmail.com> <xmqq7fnae92a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 19:46:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgcVU-0006dw-JC
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 19:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934526AbbI1Rq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 13:46:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:63831 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934074AbbI1Rq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 13:46:28 -0400
Received: from pinguin.localnet ([79.247.110.8]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MHbpA-1ZfVVf2fAC-003Jcd; Mon, 28 Sep 2015 19:46:11
 +0200
User-Agent: KMail/4.14.9 (Linux/4.1.7-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <xmqq7fnae92a.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:xi/O7v7aVK/sthZDxvFVkb5liTIgW3UcFXQ4gdS2RPS1Hc5A0MU
 Is6ZlGHOnxciL/KTJPnjVynQAbGBeJTbxTlCiaWikYlZdBRXuXw8dXtI65le2vdpsZTuk9a
 9nAOqxSosYpPrk0LV20Io2OfUCMZZP6Tx9xZw88Yw5qNSzLFWExkWjTy1YYOdJqfAqMQlvR
 evG20MJnpDOsmRC8wyK4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fETwKafWwmk=:LLndEskyQLBDKJY891C/so
 gYpsEkS4KPRLOVuASdMBGYrlCeqYkzcK0kEk4rlCaN9OGk5kNVxPxsVjQ2X/BUaskT/f3RLCr
 yndLmno1us2qNokX0z01ZQx9Stwhlad9q9EFmFZi02mKUNPnHBnxBckfOYgTOGyQi4ON8t6zA
 2981QvUo7TqxTj70XU9ROaP53s5RGaSPZnr8KSqhGgpavPM6PwhgQrWehZzooXVxOZUiqwSWy
 uI6jOfI9wtHIpptid9UmxmbNCNjSbnqvVFde3Y6szUpp473xepXFiHgBQPnbtlrPCjIMbrfQX
 W0VLwvb3aoMM4bR1yxNK4aLYmC4V7t4Czd09Q1y+NnzLiJCAKb/MSMj7N7juxqcRzNQQwGR9B
 wvpS1QIaFfUGAnjqQsEUZhHqifhGvjOfsnG6PRogRU7zaDJV5Ka6KUXaRns+BnstJT09hwqiG
 mO461i4aLIB4fnGclLL4Zw8GyLukWFfgXwX8w2qiMk8QsWoeZveUwirfHHIAAI8UkLiKOeOUT
 82glFBW8P1jRdqwFhy10XEbGW/0IK5Td9UUx7Yg/1p1BpdfUCVJNEzS7OcKHd37fUiELGvkHy
 8pXCMkxpXxWWT5GTDIs0DehLJEha6ZNR+xWKks1syYo5BFUBC5wzXYCSXCJmKbPA9FVyCPLbY
 nHwKvG/yishD5gZs+qLIFCSSNO72wZSiumOSdqvQIsh8zyNwIsQ51jz11CsUdJDWAWKZsjmbz
 1Ppdb8AxG6oS6DovmdiwgcFHiPzm+vwFNNkowQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278736>

On Monday 28 September 2015 10:40 Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > This is already answered. I just want to add that C Git has stopped
> > using system fnmatch for some time (part of the reason is system
> > fnmatch behaves differently in corner cases). If you don't mind C,
> > have a look at dowild() in wildmatch.c, or t/t3070-wildmatch.sh for
> > some corner cases (but your cases aren't there, may be worth adding
> > too)
> 
> What exactly are you suggesting to "fix", though?  Barf when an
> unmatched ] appears as a part of the pattern, instead of taking it
> literally?

I would rather treat the opened but unmatched [ bracket literally, so that it works similar like ]. 
Originally I've implemented this "symmetrical" behavior in JGit without to know that unmatched [ and ] have different behavior in C Git.

-- 
Kind regards,
google.com/+AndreyLoskutov
