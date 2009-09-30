From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Wed, 30 Sep 2009 13:09:50 +0200
Message-ID: <200909301309.51283.jnareb@gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org> <200909292058.53045.jnareb@gmail.com> <ee2a733e0909291749s71801b29ufa827cab715d0abb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Anteru <newsgroups@catchall.shelter13.net>, git@vger.kernel.org
To: Leo Razoumov <SLONIK.AZ@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 13:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msx3q-0001dt-NO
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 13:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbZI3LJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 07:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZI3LJM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 07:09:12 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:63596 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZI3LJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 07:09:10 -0400
Received: by fxm18 with SMTP id 18so5194646fxm.17
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xi+uBTP+XhnI/PBXG6ISgiXSZmQr5f/26fvfOpJ5F7k=;
        b=SPx3ZDdY0+szvgdWXZVMIV8q9XjU+DiQbH3ybi3mdtlDhd7ls0YCzEeADdljBGh0bG
         qcfCroXCibeQBGGqkd/bxN0Anmu3H3mBcKDPLV/aOF+x0g3ljAu3HsxS79DKESox2RMa
         J9tC79nzK7ErI6mSBw6NyrIJGYAmhWt7RYRhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QJz1PVigwpJ0en3vRr/ww8mJZCr2+qxkkaTH+RgocmeL8+3Cy2Dhl9XnSwvUvUzk1w
         MwR8IMXNQVcmZI4uG5M9hqWLbmDDIn8SIqEeBEpwmf/spTAKjGx0LByejP190UdTuat8
         Kj72KwZQQA7mFLPMrEtyCyvD3ls+A8o0+olFY=
Received: by 10.86.13.7 with SMTP id 7mr5062607fgm.64.1254308953558;
        Wed, 30 Sep 2009 04:09:13 -0700 (PDT)
Received: from ?192.168.1.13? (abvc3.neoplus.adsl.tpnet.pl [83.8.200.3])
        by mx.google.com with ESMTPS id 3sm451664fge.19.2009.09.30.04.09.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 04:09:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <ee2a733e0909291749s71801b29ufa827cab715d0abb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129338>

On Wed, 30 Sep 2009, Leo Razoumov wrote:
> On 2009-09-29, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Tue, 29 Sep 2009, Leo Razoumov wrote:
>>> On 2009-09-28, Jakub Narebski <jnareb@gmail.com> wrote:

>>>> [..snip..]
>>>>  Besides with nonlinear history with
>>>>  revision numbers such as 12678 and 12687 you know that 12678 is older
>>>>  than 12687 if and only if 12678 and 12687 are on the same line of
>>>>  development.
>>>
>>> The statement above is incorrect!! In a Mercurial repo local revision
>>> numbers are strictly ordered in commit time. 12678 < 12687 means that
>>> 12678 was committed prior to 12687. But these two commits could belong
>>> to two completely unrelated lines of development.
>>
>> This is impossible with distributed development.  If the second branch
>>  comes from other repository, with commits _created_ (in that repository)
>>  earlier than commits in current repository, but commits in first
>>  branch (from current repository) were created earlier than _fetching_
>>  those commits in second branch:
>>
>>   .---.---.---.---x---1---2---3---M---.
>>                    \             /
>>                     \-A---B---C-/             <-- from repository B
>>
>>
>>  Either you would have to change commits numbers, and therefore they would
>>  be not stable, or you would have to change commit time to mean 'time this
>>  commit got into current repository', which would kill performance for sure.
> 
> Jakub,
> in Mercurial sequential commit numbers are local to a repo and are not
> unique between the clones. Unique ID is SHA1 as in git. So mercurial
> commit 127:aaf123453dfgdfgddd...
> means commit number 127 in this repo with SHA1 "aaf123453dfgdfgddd..."
> In another clone commit 127 might mean completely different thing.
> Sequential commit numbers are strictly for "local convenience".

Yes, I know that in Mercurial commit numbers are local to repository,
and even written about it (that sequential commit numbers are possible
only either as local identifiers, or in centralized workflow).

The issue I was writing about that sequential commit numbers cannot
tell us if commit was earlier or later than some other commit based
solely on those commit numbers.  As other people in this thread wrote
Mercurial numbers commits not in order of commit creation, but in
order of commit arriving (being present) in given repository.  So
commit numbers are not 'strictly ordered in commit time', but ordered
in 'time commit got into current (local) repository'.


I'd like also to note that this means that at some time Mercurial has
to number all those commit it got on fetch / pull from remote repository.
This can be a lot of work... work which Git doesn't have to do (OTOH Git
creates index for packfile on local side after fetch...).

-- 
Jakub Narebski
Poland
