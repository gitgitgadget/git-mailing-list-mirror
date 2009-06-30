From: Andreas Ericsson <ae@op5.se>
Subject: Re: Does CVS has a easy way to compare file with its previous version?
Date: Tue, 30 Jun 2009 13:32:15 +0200
Message-ID: <4A49F7BF.9070209@op5.se>
References: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: dtletmn <dtletmedn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 13:33:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward1.uio.no ([129.240.10.70])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLbaL-0004HC-L7
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 13:33:13 +0200
Received: from exim by mail-out1.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLbZn-00042D-3f
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 13:32:39 +0200
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLbZn-00042A-2V
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 13:32:39 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLbZl-0007KU-Fk
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 13:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZF3LcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 07:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbZF3LcR
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 07:32:17 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59804 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751195AbZF3LcR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 07:32:17 -0400
Received: from source ([74.125.78.27]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkn3w0zYF7/j2yiH6wPHYUV7yiz0cnEo@postini.com; Tue, 30 Jun 2009 04:32:20 PDT
Received: by ey-out-2122.google.com with SMTP id 22so41066eye.23
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 04:32:18 -0700 (PDT)
Received: by 10.210.92.5 with SMTP id p5mr1029173ebb.64.1246361538236;
        Tue, 30 Jun 2009 04:32:18 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 10sm2032201eyz.41.2009.06.30.04.32.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 04:32:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3,URIBL_BLACK=1.961, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: F3AD7F657DC5955258DF192E55967CAFB58930D8
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 92 total 2547349 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122507>

dtletmn wrote:
> Hi,All,
> 
>      I am wondering if cvs has an easy way to compare a file with its
> previous version.
> 
>      In clearcase,I can use  :
>        cleartool diff -pred file.cc
> 
>      how can I acheive it in CVS?
>      any help would be highly appreciated!
> 

Why you're posting this to the git mailing list I have no idea, but
assuming you mean "how do I compare a file in git with the content
it had in the previous snapshot?", the answer would be:

  git diff HEAD^ -- path/to/file

This command works equally well on directories or multiple paths.
Note that if there are no differences, the program will just exit
silently.

If you want to see the differences compared to the *latest* commit,
you'd do

  git diff HEAD -- path/to/file

If you want to see the differences compared to what you've staged
for committing next, you'd do

  git diff -- path/to/file

If you want to see the differences between what you've already
staged and the latest snapshot, you'd do

  git diff --staged -- path/to/file

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
