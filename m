From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for  the given branches
Date: Thu, 18 Jun 2009 06:44:08 -0700 (PDT)
Message-ID: <m3iqithd24.fsf@localhost.localdomain>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	<1245311834-5290-2-git-send-email-santi@agolina.net>
	<alpine.DEB.1.00.0906181433330.4297@intel-tinevez-2-302>
	<adf1fd3d0906180622n25169f51n6aa249e9167cbc38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?iso-8859-15?q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 15:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHHui-0000Kz-Qc
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 15:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbZFRNoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 09:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757591AbZFRNoJ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 09:44:09 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:61524 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbZFRNoI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 09:44:08 -0400
Received: by fxm8 with SMTP id 8so1054348fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=P29rtP5q97yDUO7azF9JGtl/npK9bRBMHG4W0gVAl9I=;
        b=R4eJDBN6Rj2uv0MDq5DPbE8rHP8ht/9zea54bZEpIoUuMbxcwL0+syfeiQGE+7nj41
         VTUEaTHmkZYLE1HBDdM9Yv2mStLafHXzVihOitof1EVKWNtLXqJlmYlRSuW7TpEiDPwI
         B3UkbINWA2KW4WbWDRFp44DYoh9+EXzHbPS6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=PgU0gzPBo/fjb/hPPx1dBWcYB2pIP6mOIdIxSXJxUvnez936fE7OfZPq69Y0KPJRZ2
         H92HXi6rbPqOkgF/wVWSsV/iAPEFd7xzCwhMymjjgdygHX/Bo0QHP1LecDgOtolYkxbo
         syX/LN6T3Se+qjAwspdOETpTQ8fbx2wPq3Ie4=
Received: by 10.103.189.15 with SMTP id r15mr1029378mup.126.1245332649236;
        Thu, 18 Jun 2009 06:44:09 -0700 (PDT)
Received: from localhost.localdomain (abvq34.neoplus.adsl.tpnet.pl [83.8.214.34])
        by mx.google.com with ESMTPS id e8sm1629861muf.6.2009.06.18.06.44.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 06:44:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5IDi6w0023753;
	Thu, 18 Jun 2009 15:44:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5IDi4U7023750;
	Thu, 18 Jun 2009 15:44:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <adf1fd3d0906180622n25169f51n6aa249e9167cbc38@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121841>

Santi B=E9jar <santi@agolina.net> writes:
> 2009/6/18 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> On Thu, 18 Jun 2009, Santi B=E9jar wrote:
>>
>>> diff --git a/Documentation/git-remote.txt b/Documentation/git-remot=
e.txt
>>> index 9e2b4ea..e444899 100644
>>> --- a/Documentation/git-remote.txt
>>> +++ b/Documentation/git-remote.txt
>>> @@ -17,6 +17,7 @@ SYNOPSIS
>>>  'git remote show' [-n] <name>
>>>  'git remote prune' [-n | --dry-run] <name>
>>>  'git remote update' [-p | --prune] [group | remote]...
>>> +'git remote tracking' <name> <branch>...
>>>
>>>  DESCRIPTION
>>>  -----------
>>> @@ -128,6 +129,12 @@ be updated.  (See linkgit:git-config[1]).
>>>  +
>>>  With `--prune` option, prune all the remotes that are updated.
>>>
>>> +'tracking'::
>>> +
>>> +Returns the tracking branch for the given remote (<name>) and bran=
ch
>>> +(<branch>). Note that <branch> must exactly match the left hand si=
de of
>>> +the refspec of the given remote.
>>> +
>>
>> From that description, it is not clear to me if the branch is the _r=
emote_
>> branch, the branch _on_ the remote, or the local branch.
>=20
> OK. s/and branch/and remote branch/
>=20
>> If it is the remote branch (or the branch on the remote), I wonder h=
ow you
>> deal with ambiguities, as I can easily create hundreds of branches
>> tracking the same remote branch.
>=20
> AFAICS from remote_find_tracking (and some tests), it picks the first=
 match.
>=20
> So, additional text could be: In case of multiple matches, it picks
> the first one.

Why not have both:

  git remote tracking <remote> <remote branch>

would show all local branches that track <remote branch>, and have
<remote> as default remote, while

  git remote tracking <local branch>

would show <remote> and <remote branch> if <local branch> is following
remote-tracking branch.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
