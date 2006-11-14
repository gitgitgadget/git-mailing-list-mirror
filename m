X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Tue, 14 Nov 2006 11:40:50 +0100
Message-ID: <45599D32.10904@b-i-t.de>
References: <45530CEE.6030008@b-i-t.de>	 <7vvelnjd4p.fsf@assigned-by-dhcp.cox.net> <45587A09.3020605@b-i-t.de> <46a038f90611131022l105b5df3ycdf7aa33016b336e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 10:41:29 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <46a038f90611131022l105b5df3ycdf7aa33016b336e@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31340>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjviu-0005S4-JZ for gcvg-git@gmane.org; Tue, 14 Nov
 2006 11:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933394AbWKNKk5 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 05:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933395AbWKNKk5
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 05:40:57 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:1728 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S933394AbWKNKk4
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006
 05:40:56 -0500
Received: (qmail 14792 invoked by uid 1011); 14 Nov 2006 10:40:55 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.1809 secs); 14 Nov 2006 10:40:55 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 14 Nov 2006 10:40:55
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id 25FAD183D2; Tue, 14 Nov 2006 11:40:51
 +0100 (CET)
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:
> On 11/13/06, sf <sf@b-i-t.de> wrote:
>> Martin, are you sure your patch is needed? (see below)
>=20
> Not 100% sure. I was just making sure we crossed all the Ts and dotte=
d
> the Is. I gather you have tried my patch and it didn't make any
> difference. What SQLite and Perl versions are you using?

Your patch did make a difference but the outcome is not good:

+ WORK=3D/tmp/gittest
+ FILE=3D$'\303\244'
+ mkdir /tmp/gittest
+ mkdir /tmp/gittest/git
+ cd /tmp/gittest/git
+ git init-db
defaulting to local storage area
+ git repo-config gitcvs.enabled 1
+ git repo-config gitcvs.logfile /tmp/gittest/git/.git/cvslog.txt
+ touch $'\303\244'
+ git add $'\303\244'
+ git commit -a -mx
Committing initial tree 23d6145738bba135994775c19d6e8ae707d399ee
+ cd /tmp/gittest
+ CVS_SERVER=3Dgit-cvsserver
+ export CVS_SERVER
+ cvs -d :fork:/tmp/gittest/git/.git co master
cvs checkout: Updating master
U master/=C3=A4
+ ls master
=C3=A4  CVS


The pathname has been UTF-8 encoded _twice_!

Perl's version is 5.8.8. How do I get the version of SQLite? Do you mea=
n=20
DBD-SQLite-1.11?

Regards

Stephan
