From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 18:38:37 +0800
Message-ID: <49083D2D.4020202@gmail.com>
References: <49082514.9050405@gmail.com> <20081029100313.GP3612@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 11:39:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv8T1-000877-5C
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 11:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYJ2Kio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 06:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYJ2Kio
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 06:38:44 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:61648 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbYJ2Kin convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Oct 2008 06:38:43 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1656635tic.23
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=3mjb4gHP51bMDO9tOLLH4tirnr75Ey4qNNGiKkT5PW4=;
        b=JDeR3+BMC9XP+pjM3tgyhIuj4XxIPSv6FUClhRcp/+yaJmav7HxoBYBCWe1OhkLQ7g
         qI+LXFzM6Sc1b9cwNc/6osjUDSJyLmVvl/qfBfPkoSCh6bJWOGx0yVn2pWF7wNIpVrIM
         icY4jONKGVFSh6BVpJxYjOcGqmvC3ZWRjvUyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Qpp78Su/6/7X3dARaDuZkrAWx1z4ZJN5ob0f88CQwl6EsXi7uLpoFZoSC35cqQu904
         W9SqXMAKtMRPSTHIJajxy36vXA/Vs8k3Dpu5uw1m/HVcjmt0/H3NYLvVg1/xDWACMXvu
         6q5cX+HPiQUavYmihdHV9kTnXHJ8uqA6wslmE=
Received: by 10.110.84.2 with SMTP id h2mr5674764tib.0.1225276721539;
        Wed, 29 Oct 2008 03:38:41 -0700 (PDT)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id y5sm5581889tia.15.2008.10.29.03.38.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 03:38:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081029100313.GP3612@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99360>

Bj=F6rn Steinbrink wrote:
> On 2008.10.29 16:55:48 +0800, Liu Yubao wrote:
>> Hi,
>>
>> I often feel tracking branches are useless to me, because there are =
remote
>> branches and I work on my private branch in most time.
>>
>>    repos
>>      |
>>      |-- my               (private branch, do my dirty work)
>>      |-- master           (tracking branch)
>>      |-- origin/master    (remote branch)
>=20
> Actually, origin/master is the "[remote] tracking branch". master is
> just a branch that has config settings for "git pull" defaults. ;-)
>=20
> "Remote branches" are the actual branches on a remote repository.
>=20
Oh, I'm misguided by the --track option, thank you for clarifying it!

> In your case, you probably want:
> git checkout -b my-stuff origin/master
> git config branch.my-stuff.rebase true
>=20
> and then you can do:
> git pull
>=20
> Instead of:
> git fetch origin
> git rebase origin/master
>=20
> You can also setup branch.autosetuprebase, to automatically get the
> rebase setup, so you can skip the call to "git config" above.
A new config setting, git amazes me again @_@

It's great, thanks!
>=20
> And you can just delete the "master" branch if you don't use it. Ther=
e's
> nothing that forces you to keep any branches around that you don't us=
e.
> But that doesn't affect the usefulness of tracking branches or branch=
es
> that have "git pull" defaults :-)
>=20
>> BTW: I feel the terminalogy "remote branch" is confused, because I m=
ust
>> synchronize it with `git fetch`. I feel it's better to call it "trac=
king
>> branch" // seems will lead to bigger confusion to experienced git us=
ers:-(
>=20
> See above, that's already the case ;-)
>=20

Got it, --rebase and config.<branch>.rebase and config.autosetuprebase,=
 thank
you again:-)

> Bj=F6rn
>=20
