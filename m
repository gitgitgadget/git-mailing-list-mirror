From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Sat, 19 Sep 2015 08:44:39 +0000
Message-ID: <1442652278.21964.52.camel@transmode.se>
References: <1440157010.1759.83.camel@transmode.se>
	 <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
	 <1442245035.10125.18.camel@transmode.se>
	 <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
	 <1442508864.21964.26.camel@transmode.se>
	 <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "pclouds@gmail.com" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 10:46:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdDmS-0006RM-7F
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 10:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbbISIpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2015 04:45:24 -0400
Received: from smtp.transmode.se ([31.15.61.139]:65531 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbbISIos convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Sep 2015 04:44:48 -0400
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
	by smtp.transmode.se (Postfix) with ESMTP id 2345511870DA;
	Sat, 19 Sep 2015 10:44:40 +0200 (CEST)
Received: from exch1.transmode.se (192.168.201.16) by exch1.transmode.se
 (192.168.201.16) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Sat, 19 Sep
 2015 10:44:40 +0200
Received: from exch1.transmode.se ([fe80::3029:ce14:7d42:cc5]) by
 exch1.transmode.se ([fe80::3029:ce14:7d42:cc5%17]) with mapi id
 15.00.1076.000; Sat, 19 Sep 2015 10:44:39 +0200
Thread-Topic: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Thread-Index: AQHQ3AWr4MUVkjVcJE+EJNOGRY0lNp4lzPKAgBZf8YCABJAwgIAAPF0AgAIw4oCAAGrxAA==
In-Reply-To: <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.16.5 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.200.4]
Content-ID: <F3E0BB2383DD5D4596431EDB4B128C80@transmode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278237>

On Sat, 2015-09-19 at 09:21 +0700, Duy Nguyen wrote:
> On Thu, Sep 17, 2015 at 11:54 PM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > On Thu, 2015-09-17 at 20:18 +0700, Duy Nguyen wrote:
> > > On Mon, Sep 14, 2015 at 10:37 PM, Joakim Tjernlund
> > > <joakim.tjernlund@transmode.se> wrote:
> > > > On Mon, 2015-08-31 at 16:56 +0700, Duy Nguyen wrote:
> > > > > On Fri, Aug 21, 2015 at 6:36 PM, Joakim Tjernlund
> > > > > <joakim.tjernlund@transmode.se> wrote:
> > > > > > I cannot push:
> > > > > > # > git push origin
> > > > > > Login for jocke@git.transmode.se
> > > > > > Password:
> > > > > > Counting objects: 7, done.
> > > > > > Delta compression using up to 4 threads.
> > > > > > Compressing objects: 100% (7/7), done.
> > > > > > Writing objects: 100% (7/7), 13.73 KiB | 0 bytes/s, done.
> > > > > > Total 7 (delta 4), reused 0 (delta 0)
> > > > > > fatal: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR':
> > > > > > Permission
> > > > > > denied
> 
> I'm about to do it, but now I'm not sure if I should move
> shallow_XXXXXX out of $GIT_DIR. It will not be the only command that
> may write to $GIT_DIR. "git gc --auto" (which can be triggered at the
> server side at push time) can write $GIT_DIR/gc.pid (and soon,
> gc.log). Even if you disable gc --auto and run it periodically (with
> cron or something), it will write gc.pid.
> 
> Is it really necessary to remove write access in $GIT_DIR? Do we (git
> devs) have some guidelines about things in $GIT_DIR?

It feels a lot cleaner to not let everybody create stuff in $GIT_DIR
we have:
# > ls -l
total 24
dr-xr-sr-x   6 apache tm-3000  123 Jun 10 15:30 ./
drwxr-xr-x  36 root   root    4096 Jun 25 11:11 ../
-r--r--r--   1 root   tm-3000  263 Jun 10 15:28 config
-r--r--r--   1 apache tm-3000   73 Jun 10 15:28 description
-rw-r--r--   1 root   tm-3000    0 Jun 10 15:30 git-daemon-export-ok
-r--r--r--   1 apache tm-3000   23 Jun 10 15:28 HEAD
drwxr-sr-x   2 root   tm-3000 4096 Jun 10 15:28 hooks/
drwxrwsr-x   2 apache tm-3000   20 Jun 10 15:28 info/
drwxrwsr-x 157 apache tm-3000 4096 Jul 14 15:06 objects/
drwxrwsr-x   4 apache tm-3000   29 Jun 10 15:28 refs/

Why mess this up with tmp files? Would be cleaner to have a specific tmp dir in $GIT_DIR for that.

 Jocke