From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Print last time and committer a file was touched by for a whole  repo
Date: Sat, 3 Jul 2010 11:13:32 +0200
Message-ID: <201007031113.33231.jnareb@gmail.com>
References: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com> <m3eifnner1.fsf@localhost.localdomain> <AANLkTil2Riz3_iKEREjsERVsBkSZdZ9wa9ujOahxjs4Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 11:13:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUynJ-0004pZ-9B
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 11:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab0GCJNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 05:13:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44086 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab0GCJNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 05:13:45 -0400
Received: by fxm14 with SMTP id 14so2823613fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LmeVgF71jcX88chEC/slHqw0OmhSViXLQ/xzLNzTvAE=;
        b=UmPMZMBaLMfqk5pjgb446HEvCqcUH2cozBtHbKbnpO68EZycp/xA6X3efiG4HGHK2r
         u4r0DLKqnA6jB/NG4otRxCakMVLcQP78zCZiJyNrGMvFYnAlT59k97J+99rZ9gvDrb7m
         ZvdKEVtRLwOQMGYAeKv4084v630DcWJCEy3BE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oEL4wg1JIny9z1stZm0tQw+rU1DY7JUTERSaFNAv6EpE1MIncJ/IjxeMYIs34GoxZ3
         0MOAyzTZYckBwH8p4Stxtii7T2R387Vj6BTtkL2ce1FlTP9kJXBbvyp3cqzirTmDOBDE
         4OQGojfQ16KPQ4hfygBO1KPBBwEK/1ERrU5Fg=
Received: by 10.223.124.202 with SMTP id v10mr65103far.55.1278148423809;
        Sat, 03 Jul 2010 02:13:43 -0700 (PDT)
Received: from [192.168.1.15] (abwj153.neoplus.adsl.tpnet.pl [83.8.233.153])
        by mx.google.com with ESMTPS id g1sm3602716faa.2.2010.07.03.02.13.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Jul 2010 02:13:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTil2Riz3_iKEREjsERVsBkSZdZ9wa9ujOahxjs4Y@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150183>

On Fri, 2 July 2010, Tim Visher wrote:
> Thanks everyone who responded.  I ended up doing
>=20
>     find . -path "./.git*" -prune -o -print -exec git log -n 1 -- '{}=
'
> \;> assets.txt
>=20
> Little roundabout but seems effective.

Sidenote: you might want to use '--follow' on place of '--', just in ra=
re
case you would hit file rename (or copy).

See also: https://git.wiki.kernel.org/index.php/ExampleScripts#Finding_=
which_commits_last_touched_the_files

> On Thu, Jul 1, 2010 at 4:12 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> Tim Visher <tim.visher@gmail.com> writes:
>>
>>> I need to get a listing of the entire contents of my current repo (=
as
>>> in, I don't need deleted files or anything like that, just the curr=
ent
>>> snapshot) with the time the file was committed and who committed it=
=2E
>>>
>>> Thoughts on how to do that?
>>
>> There does not exist a single git command that would do what you wan=
t.
>> You would need to use 'git log -1 --follow' for each file in current
>> snapshot ('git ls-tree -r HEAD'). =C2=A0IIRC there is some example h=
ow to
>> do that in GitFaq or GitTips on git wiki (http://git.wiki.kernel.org=
).
>>
>> Perhaps in the future 'git blame <directory>' would provide such
>> output, or its equivalent (tree blame).
>=20
> That'd be cool.

I am currently working on prototype in Perl, using 'git cat-file --batc=
h'
and 'git diff-tree --stdin', as I don't know git C code/API enought to
write it in C; it is planned to be converted to C after proof of concep=
t
works.
=20
>> By the way, what do you ned this for? =C2=A0Git versions whole proje=
ct at
>> once, not individual files. =C2=A0Is it some legacy from CVS?
>=20
> Ummm...  Little embarrassing but this is apparently a requirement for
> my company.  Every few years they ask for a 'listing of all software
> assets, when they were last touched, who last touched them, and what
> version of software they were touched for.'  Generous assumptions is
> that they're probing us for how effectively we can lay our hands on
> this information.  Cynics would say that someone somewhere decided on=
e
> day that it would be a good idea to have an __Excel Spreadsheet__
> (yep, that's what it goes into) listing every file that every softwar=
e
> project everywhere in the company has, and that now people do it
> because it's on a check list.
>=20
> Anywho... Hooray for `find -exec`.

Why the _files_ granularity, rather than _project_ (repository)=20
granularity?  Unless you have post-CVS / post-Subversion one mega-repo
containing all projects squashed together (yuck!).

IMHVO better solution would be list, for each repository/(sub)project,
list date of last commit on master branch (when it was last touched),
list date of last signed tag / of tagged release (when it was last=20
released), and shortlog or blame-based or diffstat based statistics
of code authorship (replacement of 'who last touched them').  Note
that any code metric / software kwalitee metric is subject to abuse
(numerous examples can be found at TheDailyWTF, and IIRC Joel Spolsky
and Jeff Atwood both described such dangers on their blogs).

--=20
Jakub Narebski
Poland
