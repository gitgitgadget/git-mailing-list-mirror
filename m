From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH v2] compat: Add another rudimentary poll() emulation
Date: Sun, 30 May 2010 15:39:42 -0700
Message-ID: <67A778DE-DB7E-40A3-9BE8-4D17F09B847F@gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org> <1274948384-167-2-git-send-email-abcd@gentoo.org> <20100527101043.GA4390@progeny.tock> <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com> <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com> <20100530003718.GA27024@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, Jonathan Callen <abcd@gentoo.org>,
	git@vger.kernel.org, mduft@gentoo.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>,
	Marko Kreen <markokr@gmail.com>,
	Albert Dvornik <dvornik+git@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 00:39:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIrAk-0003oG-4g
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 00:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228Ab0E3Wjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 18:39:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56963 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab0E3Wjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 18:39:46 -0400
Received: by pvg11 with SMTP id 11so1090807pvg.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 15:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references
         :mime-version:content-type:message-id:cc:content-transfer-encoding
         :from:subject:date:to:x-mailer;
        bh=W3WU5xPTqQ5cBrF0zyrOiDtD3TyQ9Ml12uI1uam7LTo=;
        b=aKwG/ntCCeJJIDshUUjhsOxWxMwUObKDn9sSqNfasu9DLrmufG6Z25PUfg+KOV8Cga
         jMTR6OFXYli3O7fKKsOm6TufTQnUsOvhvSnHndwQlxbp6fzER7/6XYs7iRMBbj9JbwYN
         3enGo7CBWQ0DHbU8OK8A2qXeDBHw0wU1Oen64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc
         :content-transfer-encoding:from:subject:date:to:x-mailer;
        b=BelvmOKTcoOhIcWc6LTiNNLJAf89ozmVmiI4gMipHaZJnQnlvgxsz9DLLfC6lSC2Vm
         2w/h22XCHVm1dzYMHXdMwkPgrJTyVSuMfKz/POObWTO8xEN3J7A/izf08tIK/8jwEYb4
         Y7mE5Eef2L2hzME3dKbwGufhW8nppYWSyQfAg=
Received: by 10.143.153.42 with SMTP id f42mr2371319wfo.299.1275259185686;
        Sun, 30 May 2010 15:39:45 -0700 (PDT)
Received: from [192.168.1.24] (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 22sm3507349pzk.9.2010.05.30.15.39.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 15:39:44 -0700 (PDT)
In-Reply-To: <20100530003718.GA27024@progeny.tock>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148027>

On May 29, 2010, at 5:37 PM, Jonathan Nieder wrote:

> Implement the subset of poll() semantics needed by git in terms of
> select(), for use by the Interix port.  Inspired by commit 6ed807f
> (Windows: A rudimentary poll() emulation, 2007-12-01).
>
> I would be interested to hear whether this works on msysgit and  
> Interix.

For what it's worth, after creating a poll_compat library for Lamp  
(Lamp ain't Mac POSIX) from the original plproxy code and linking git  
against it, I'm able to serve fetch requests from git daemon.  I  
haven't tried simultaneous connections, though.

http://github.com/jjuran/git/

Josh
