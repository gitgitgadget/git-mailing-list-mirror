X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: David Tweed <tweed314@yahoo.co.uk>
Subject: clarification on "racy-git" & very fast change+commit
Date: Mon, 18 Dec 2006 15:30:34 +0000 (GMT)
Message-ID: <20061218153034.41722.qmail@web86906.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 19 Dec 2006 00:16:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RnZoR9cAnKsSXYLHfCnzTSpZWSBS2Uuwf5A6N+BAPQwiQzKfSjoyW7AYqehZEm8T4MWex0WNyqtj6Lt+Aa+EBz6OVidykq9U3als3zbozF6J38kIvHHxA15rnY2kcjeMw/1xmLCEfL203UFS9YQBoUArGPVmQ3JIjChBqEIeF5Y=  ;
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34772>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwKSZ-0001cc-57 for gcvg-git@gmane.org; Mon, 18 Dec
 2006 16:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754146AbWLRPah convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006 10:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbWLRPah
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 10:30:37 -0500
Received: from web86906.mail.ukl.yahoo.com ([217.12.13.58]:38892 "HELO
 web86906.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S1754146AbWLRPah convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 10:30:37 -0500
Received: (qmail 41725 invoked by uid 60001); 18 Dec 2006 15:30:34 -0000
Received: from [134.225.1.161] by web86906.mail.ukl.yahoo.com via HTTP; Mon,
 18 Dec 2006 15:30:34 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi, I'm getting prepared to do a trial migration my "selected files chr=
onological database"
(think plan9's venti but not on every single file) to git and I'd just =
like to check something.

I'm still don't understand lots of stuff about git but I've read "racy-=
git.txt" in
Documentation for git-1.4.4.2. It appears to be saying that there used =
to be a race (involving
1-second timestamp limitations of filesystems) but now
things are done with a slow path fallback for would-race situations so =
that there is no race in
any operations any more? If the race is there, the file suggests it isn=
't a problem
for commiting?

I'm just checking because the way I'm planning to migrate is by using a=
 script to
loop, checking out each snapshot from my existing backup system and com=
mit it into git. I've got
quite a fast PC with a reasonable amount of memory but using ext3 as fi=
lesystem (which
still has 1 second timestamp resolution AIUI),
so it seems entirely plausible that I could get checkouts which alter o=
nly a few files
taking much, much less than a second. I don't know if any of them also =
happen to
have the same filesize, if they do this pattern seems more likely to me=
et the condtions of the
"race" than natural, normal git usage, so I want to see if I need to th=
ink about this dealing
with this issue. My understanding from racy-git.txt is that I don't.

Many thanks for any insight,

cheers, dave tweed





	=09
___________________________________________________________=20
Try the all-new Yahoo! Mail. "The New Version is radically easier to us=
e" =96 The Wall Street Journal=20
