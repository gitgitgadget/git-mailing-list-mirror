From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Wed, 29 Jul 2009 13:13:45 +0200
Message-ID: <adf1fd3d0907290413x4aa0d091ldb651537a101a2f8@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
	 <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
	 <adf1fd3d0907290233y78514f98h89a2fca7bf68b4f2@mail.gmail.com>
	 <9b18b3110907290251t4d8c83d3rf12d0ea9268c19bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 13:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW76Z-0004Eo-5x
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 13:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZG2LNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 07:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbZG2LNq
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 07:13:46 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:24210 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbZG2LNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 07:13:46 -0400
Received: by ey-out-2122.google.com with SMTP id 9so178077eyd.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 04:13:45 -0700 (PDT)
Received: by 10.216.3.65 with SMTP id 43mr2313304weg.149.1248866025561; Wed, 
	29 Jul 2009 04:13:45 -0700 (PDT)
In-Reply-To: <9b18b3110907290251t4d8c83d3rf12d0ea9268c19bd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124342>

2009/7/29 demerphq <demerphq@gmail.com>:
> 2009/7/29 Santi B=E9jar <santi@agolina.net>:
>> 2009/7/29 demerphq <demerphq@gmail.com>:
>>> 2009/7/29 Santi B=E9jar <santi@agolina.net>:
>>>> 2009/7/29 demerphq <demerphq@gmail.com>:
>>>>> Another question is whether anyone has any advice on the best way=
 to
>>>>> find out the "best" branch an arbitrary commit is on. Where best =
can
>>>>> be flexibly definied to handle commits that are reachable from
>>>>> multiple branches. =A0I have hacked a solution involving git-log =
and
>>>>> grep, but it performs quite poorly. I was wondering if there is a
>>>>> better solution.
>>>>
>>>> The "best" tag is easy: git describe commit. For branches I think =
you
>>>> could use "git name-ref --refs=3Drefs/heads/* commit", because git
>>>> describe does not have a --branches flag.
>>>
>>> Dang, I guess this is from a newer release than mine. So now i have=
 an
>>> excuse to upgrade.
>>
>> No, it is quite old (the --refs flag since the v1.5.1). If the probl=
em
>> is that you don't find the "git name-ref" command is because it is
>> "git name-rev", oops.
>
> Dang, guess i need a different excuse. :-)
>
> But it doesn't seem to do what i need:
>
> $ git name-rev --refs=3Drefs/heads/* faa7dc9f4d3a618b0ad8b3c95edd54e2=
4c6976e7
> faa7dc9f4d3a618b0ad8b3c95edd54e24c6976e7 undefined
>
> But i think that just because in this case I need remote refs:
>
> git name-rev --refs=3Drefs/remotes/* faa7dc9f4d3a618b0ad8b3c95edd54e2=
4c6976e7
> faa7dc9f4d3a618b0ad8b3c95edd54e24c6976e7 remotes/origin/maint-5.005~2=
5
>
> Which is definitely better. Can I safely strip the ~25 off the end to
> get the real branch name?

Yes, it describes the relation between both, you can strip everything
after ^ or ~ (and you can use the --name-only to remove the sha1).

HTH,
Santi
