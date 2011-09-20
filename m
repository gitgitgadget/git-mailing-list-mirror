From: Frederic Heitzmann <frederic.heitzmann@gmail.com>
Subject: Re: [Bug report] git fetch/push fails from sub-directory
Date: Wed, 21 Sep 2011 00:25:13 +0200
Message-ID: <4E7912C9.7000908@gmail.com>
References: <j5b1qa$pki$1@dough.gmane.org> <7v62km6fjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 00:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R68km-0006LU-F7
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 00:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317Ab1ITWZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 18:25:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43064 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab1ITWZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 18:25:18 -0400
Received: by wyg34 with SMTP id 34so957370wyg.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=e5aeC2LnGFpMwOpQGjS5l2tbD6ScolSFsDImgRjelXA=;
        b=Haj3YaqDhHX0OomQ4rbg1ICUu2wq8kbFrvVgZOERP+fl3VSlT+QUR2r0RfMY0AGnJz
         xahQkLH6uRiryLwGLK4ipsj/11l2Teh5Ll07QWs+dvN/LQls6BjV8N7uuMILKiCvWUti
         aNZ0j9sUfAUTbzamicL459YHxrmwjIvOSe5F4=
Received: by 10.227.27.209 with SMTP id j17mr4754273wbc.114.1316557516958;
        Tue, 20 Sep 2011 15:25:16 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net. [88.179.84.80])
        by mx.google.com with ESMTPS id r27sm4343925wbn.10.2011.09.20.15.25.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Sep 2011 15:25:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v62km6fjl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181799>

Le 20/09/2011 23:59, Junio C Hamano a =E9crit :
> Frederic Heitzmann<frederic.heitzmann@gmail.com>  writes:
>
>> I found a bug in git fetch, with local repositories.
>
>> cd repo2
>> git fetch ../repo1	# OK
>> cd d
>> git fetch ../../repo1	# failed
>
> It has always been like this.  You can give a full path to the reposi=
tory
> from the root, or perhaps define a nickname to refer to the remote (s=
ee
> "git remote add") and use it instead.

Is it supposed to be normal ?!
I mean : OK I can use git-remote, but this leads to differents results=20
for similar usages and similar commands.
Let's compare following cases :

_Case 1:_

|
|_repo1
|   |
|   \_dir
|
\_repo2
     |
     \_dir


cd repo2/dir
git fetch ../../repo1	# FAILURE

_Case 2:_

|
|_repo1
|
\_temp
     |
     \_repo2

cd temp/repo2
git fetch ../../repo1	# SUCCESS

=46or sure, one can argue that I should better organize my file tree ;-=
)

--
=46red
