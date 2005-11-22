From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Tue, 22 Nov 2005 11:40:36 +0100
Message-ID: <cda58cb80511220240u45267b18o@mail.gmail.com>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	 <cda58cb80511171347yef4f090g@mail.gmail.com>
	 <Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
	 <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	 <Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
	 <7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80511211211l2ff6ff12j@mail.gmail.com>
	 <7vhda5pw6l.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80511220122r76ca69a2y@mail.gmail.com>
	 <7vfyppf1va.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 11:42:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeVZp-0005eg-No
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 11:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbVKVKki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 05:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVKVKki
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 05:40:38 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:52104 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964904AbVKVKkh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 05:40:37 -0500
Received: by zproxy.gmail.com with SMTP id 14so1098677nzn
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 02:40:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQgTFY3kpHlBjTCkANZKA/Toa74hAN8OdApqvC2Q54zNYiRa+hW/RkulFR+Kvv7dubkH/YLuGNUCUtnIKeBb+Go2htxJIXR+dhZH3sDcpGD900mhxEp/je+lSPnhx4MAUH042Ee0XPH2TjB0YUqfkCHKXF1xN3oEYPHoT70GP24=
Received: by 10.37.13.31 with SMTP id q31mr3848536nzi;
        Tue, 22 Nov 2005 02:40:36 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Tue, 22 Nov 2005 02:40:36 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyppf1va.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12543>

2005/11/22, Junio C Hamano <junkio@cox.net>:
> I was not talking about _your_ case specifically.  If you happen
> to have based your partial history on top of a single commit
> then the set of "such and such commits" might be only one, but
> you could for example clone from Linus tip, merge in a couple of
> jgarzik branch heads, put your own commits on top of them and
> then cauterize your history, stopping at those foreign commits.
> In such a case you obviously need to tell others where you
> chopped your history off.
>

I built the lite repository and got an error depending on which
original repo I used to push the lite one. Here is the history:

--------------------------------------------------------------
#
# building my pub repo from the "lite" repository
#

$ git checkout -b lite

$ git-show-branch
* [lite] Merge with Linux 2.6.14.
 ! [master] Merge with Linux 2.6.14.
  ! [origin] Merge with db93a82fa9d8b4d6e31c227922eaae829253bb88.
---

# push the initial commit object

$ git push /home/franck/pub/linux/git/linux-lite.git lite
updating 'refs/heads/lite'
  from 0000000000000000000000000000000000000000
  to   8643db584b46a61c968ae230897869f789bae020
Packing 19558 objects
Unpacking 19558 objects
 100% (19558/19558) done
refs/heads/lite: 0000000000000000000000000000000000000000 ->
8643db584b46a61c968ae230897869f789bae020

#
# push first changes from lite repositoy -> KO
#
$ making some hard work

$ git commit -m "Did some hard work"
$ git push /home/franck/pub/linux/git/linux-lite.git lite
updating 'refs/heads/lite'
  from 8643db584b46a61c968ae230897869f789bae020
  to   730518eea7523afd5b7891bb7849973cab52d963
Packing 0 objects
Unpacking 0 objects

error: unpack should have generated
730518eea7523afd5b7891bb7849973cab52d963, but I can't find it!
$

#
# push first changes from "full" repository -> OK
#

# go to full repository and checkout linux.2.6.14

$ git commit -m "Did some hard work"
$ git push /home/franck/pub/linux/git/linux-lite.git lite
updating 'refs/heads/lite'
  from 8643db584b46a61c968ae230897869f789bae020
  to   067d05600fe7251b8c923fbeb9ba0068ee272110
Packing 108 objects
Unpacking 108 objects
 100% (108/108) done
refs/heads/lite: 8643db584b46a61c968ae230897869f789bae020 ->
067d05600fe7251b8c923fbeb9ba0068ee272110
--------------------------------------------------------------

It seems that the "lite" repository can't be used as a working
repository. And If I use the last method to push some work, I can only
pull that changes from a full repository. From a lite one (without any
changes of course) I get this error:

$ git pull /home/franck/pub/linux/git/linux-lite.git lite
Packing 108 objects
Unpacking 108 objects
 100% (108/108) done
Merging HEAD with f42aaff3bf8041c2d43f1ff6fdfe5df6e8a5b00b
Merging:
8643db584b46a61c968ae230897869f789bae020 Merge with Linux 2.6.14.
f42aaff3bf8041c2d43f1ff6fdfe5df6e8a5b00b Did some hard work
found 0 common ancestor(s):
Traceback (most recent call last):
  File "/home/fbuihuu/bin/git-merge-recursive", line 870, in ?
    firstBranch, secondBranch, graph)
  File "/home/fbuihuu/bin/git-merge-recursive", line 67, in merge
    mergedCA = ca[0]
IndexError: list index out of range
No merge strategy handled the merge.

Do you have any clues ?

Thanks
--
               Franck
