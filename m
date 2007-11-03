From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGIT fails to clean patch series, and to go to a patch
Date: Sat, 3 Nov 2007 14:17:47 +0100
Message-ID: <200711031417.47388.jnareb@gmail.com>
References: <200711031045.21506.jnareb@gmail.com> <b0943d9e0711030332s49877dcep46460121fb6ec712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 14:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoItB-0002a7-CK
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbXKCNR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbXKCNR6
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:17:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:8837 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbXKCNR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:17:57 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1183948wxd
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Qti23V7dG08Vlc4K/iOJZKOb7vbZZzTd5TnppOOYS18=;
        b=ZW6SyanSrsf0qITNvaDyiJlOjLjEaM8K7Hza4r9aQY29S3pR+dsxcEYgJfgptMgst+iAkmTVpTHnkUFu0CZj4L1y1Js2jDCvC+jHLOaCeJl4WBBBZGGnlQFkhUCh71F96gBBa1uAoZibjY235Qi/xRv6DG13vOzHqRoqSTRusys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H4onyQ6S5wjGCUN7gvx2gD6YTB50AkgV4s/OxawsIeUTXEphqzCFASY5kID1V7vB6Yu63wCKxb2udvVf9zE2lco14ziEGhuDzb2w2BqRELcK4qan3ERyyHYv/8gDfi8kBx7j7SfSadGXmaxg5ki1xQrchHfH11Zq/F+mQY2yW9U=
Received: by 10.90.97.19 with SMTP id u19mr1924892agb.1194095876762;
        Sat, 03 Nov 2007 06:17:56 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.198.10])
        by mx.google.com with ESMTPS id 32sm4181674nfu.2007.11.03.06.17.54
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 06:17:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0711030332s49877dcep46460121fb6ec712@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63264>

Catalin Marinas wrote:
> On 03/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
>
>> I have patch series with empty patch in the middle of the stack.
>> After trying to stg-clean (and failing) stack looks like below:
> 
> Does 'stg delete gitweb-Update-INSTALL-file' work?
> 
>> 1164:[gitweb/web!git]$ stg goto gitweb-Use-config-more
>> Checking for changes in the working directory ... done
>> Traceback (most recent call last):
> 
> Does a simple 'stg push' work? I suspect there is something wrong with
> the gitweb-Update-INSTALL-file patch but not sure why or how it could
> get to this inconsistent state?
> 
> It's worth checking the values of 'stg id
> gitweb-Update-INSTALL-file//top' and //bottom and whether they are
> commit ids or something else.

1168:[gitweb/web!git]$ stg id gitweb-Update-INSTALL-file 
None
1169:[gitweb/web!git]$ stg id gitweb-Update-INSTALL-file//top
None
1170:[gitweb/web!git]$ stg id gitweb-Update-INSTALL-file//bottom
None
1171:[gitweb/web!git]$ stg delete gitweb-Update-INSTALL-file 
Traceback (most recent call last):
  File "/usr/bin/stg", line 43, in ?
    main()
  File "/usr/lib/python2.4/site-packages/stgit/main.py", line 284, in main
    command.func(parser, options, args)
  File "/usr/lib/python2.4/site-packages/stgit/commands/delete.py", line 76, in func
    crt_series.delete_patch(patch)
  File "/usr/lib/python2.4/site-packages/stgit/stack.py", line 919, in delete_patch
    patch.delete()
  File "/usr/lib/python2.4/site-packages/stgit/stack.py", line 160, in delete
    for f in os.listdir(self._dir()):
OSError: [Errno 2] No such file or directory: '.git/patches/gitweb/web/patches/gitweb-Update-INSTALL-file'

I wonder how that happened... I'm just interested in recovering
the unapplied commits. There is always reflog, but StGIT does not
create reflog message as it should.

Hmmm... removing gitweb-Update-INSTALL-file line from 'unapplied' file
worked; nice.

-- 
Jakub Narebski
Poland
