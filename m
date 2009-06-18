From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for 
	the given branches
Date: Thu, 18 Jun 2009 15:22:30 +0200
Message-ID: <adf1fd3d0906180622n25169f51n6aa249e9167cbc38@mail.gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	 <1245311834-5290-2-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0906181433330.4297@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 15:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHHZg-000073-E3
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 15:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761503AbZFRNWa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 09:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761302AbZFRNW3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 09:22:29 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:51915 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761144AbZFRNW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 09:22:28 -0400
Received: by bwz9 with SMTP id 9so1057399bwz.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 06:22:30 -0700 (PDT)
Received: by 10.204.61.209 with SMTP id u17mr1363792bkh.86.1245331350499; Thu, 
	18 Jun 2009 06:22:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0906181433330.4297@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121839>

2009/6/18 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Thu, 18 Jun 2009, Santi B=E9jar wrote:
>
>> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote=
=2Etxt
>> index 9e2b4ea..e444899 100644
>> --- a/Documentation/git-remote.txt
>> +++ b/Documentation/git-remote.txt
>> @@ -17,6 +17,7 @@ SYNOPSIS
>>  'git remote show' [-n] <name>
>>  'git remote prune' [-n | --dry-run] <name>
>>  'git remote update' [-p | --prune] [group | remote]...
>> +'git remote tracking' <name> <branch>...
>>
>>  DESCRIPTION
>>  -----------
>> @@ -128,6 +129,12 @@ be updated.  (See linkgit:git-config[1]).
>>  +
>>  With `--prune` option, prune all the remotes that are updated.
>>
>> +'tracking'::
>> +
>> +Returns the tracking branch for the given remote (<name>) and branc=
h
>> +(<branch>). Note that <branch> must exactly match the left hand sid=
e of
>> +the refspec of the given remote.
>> +
>
> From that description, it is not clear to me if the branch is the _re=
mote_
> branch, the branch _on_ the remote, or the local branch.

OK. s/and branch/and remote branch/

>
> If it is the remote branch (or the branch on the remote), I wonder ho=
w you
> deal with ambiguities, as I can easily create hundreds of branches
> tracking the same remote branch.

AFAICS from remote_find_tracking (and some tests), it picks the first m=
atch.

So, additional text could be: In case of multiple matches, it picks
the first one.

Santi
