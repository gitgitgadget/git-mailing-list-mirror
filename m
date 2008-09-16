From: "Michael Kerrisk" <michael.kerrisk@googlemail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 01:40:36 +0200
Message-ID: <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
	 <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mtk.manpages@gmail.com, git@vger.kernel.org,
	michael.kerrisk@gmail.com
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:41:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfkB0-0004X0-1V
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbYIPXki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbYIPXki
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:40:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:44718 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbYIPXkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:40:37 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1866068waf.23
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ePUbAN7D7liTXXSCDDxcPcsAqn1w9/c2x5E9500R2U4=;
        b=P+1238dA3RMGCqTk5mTdCRiifWPr8p/FPpFF7VM1/21asHXcmACwALafm2ZiEk10mQ
         S8Ie7Sgu6/POedheypKzITWRayyZjodJ6MJ00QCRU8kU+RwCynzNJ1A7b8YZhgKbVknl
         QRJbsxe1i58Yp36cBwsmJqHgbPxXnd2/tWNIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=v50RUXwGwlahF/ApkY7Aio3maAgFFMA3MYCMVcYXCfxid4Vxsyrwgh+TM2pY3purvw
         45YBif0B9tZkMrvw81jp7vPaoAWYiGv2UThUv7oMQN+KFm0eXqSEdqZ0Owfy2Ui07G3S
         RlGBCCElpDJ4i6yxrV45vxlXs/EaxoOgmqQCk=
Received: by 10.114.196.1 with SMTP id t1mr1496398waf.80.1221608437184;
        Tue, 16 Sep 2008 16:40:37 -0700 (PDT)
Received: by 10.114.88.9 with HTTP; Tue, 16 Sep 2008 16:40:36 -0700 (PDT)
In-Reply-To: <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96050>

Hello Dmitry,

On Wed, Sep 17, 2008 at 1:20 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Wed, Sep 17, 2008 at 2:05 AM, Michael Kerrisk
> <mtk.manpages@googlemail.com> wrote:
>>
>> I'm currently trying to import an svn repository, along with its tags,
>> into git, and everything seems okay except that after the import I
>> expect to have the following structure to my checked out repository:
>>
>>    [root-dir]
>>        .git
>>        <checked-out-files>
>>
>> But instead I end up with
>>
>>    [root-dir]
>>        .git
>>        man-pages               <-- name of my svn project
>>            <checked-out-files>
>>
>> I've tried out a few different command-line flag settings but so far I
>> haven't managed to get the desired layout.  I guess that I'm missing
>> something trivial, but I haven't worked out what it is so far.
>>
>> The commands I'm using to do the import are:
>>
>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches
>
> Probably, you want to run:
>
> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T
> trunk/man-pages -b branches

I had wondered about this.  And I haven't yet had a chance to verify
the result.  The reason is that whereas the command:

$ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches

takes about half an hour to run, the other command (which I already
started yesterday) seems to be taking (far) more than a day!
Therefore, so far, I have not had a chance to run the command to
completion to see if it gives the desired result.  The greatly
increased tun time also made me suspicious about whether the command
was going to do the right thing.  And, I end up with a lot of strange
looking tags in the (as yet incompletely) imported tree:

$ git branch -a
  tags/man-pages-2.00
  tags/man-pages-2.00@117
  tags/man-pages-2.01
  tags/man-pages-2.01@145
  tags/man-pages-2.02
  tags/man-pages-2.02@184
  tags/man-pages-2.03
  tags/man-pages-2.03@232
  tags/man-pages-2.04
  tags/man-pages-2.04@283

What are the @nnn tags about?

By tomorrow, probably the command will complete and I can see whether
it produces the desired result.  But why does it take so much longer
to run this version of the command?

Cheers,

Michael
