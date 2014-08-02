From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: cherry picking and merge
Date: Sat, 2 Aug 2014 12:44:51 +0100
Organization: OPDS
Message-ID: <40F24BA38E03454A9BA152F6AFDE56C4@PhilipOakley>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <CANQwDwc4YPdK+a0Oc-jWPTRyM5GiP-CMuRY1inxJY41GwUGBvQ@mail.gmail.com> <CANQwDwdKbmqLSLGsiyHTfGNZGfbeNZM3TN6Zk0G5G-8twRc_JQ@mail.gmail.com> <13DDD21A-F683-4116-9E07-F0D8AEF06A66@comcast.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git" <git@vger.kernel.org>
To: "Mike Stump" <mikestump@comcast.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 13:51:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDXqU-0002ve-3E
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 13:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbaHBLow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Aug 2014 07:44:52 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:24286 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754324AbaHBLov (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2014 07:44:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApcfAOXN3FMCYJjrPGdsb2JhbABZgw1jAUWCeIQ3gQTLKwECAQEMeRcFAQEBATg2g34FAQEEAQgBARkPAQUeAQEhCwIDBQIBAxUBAgICBSECAhQBBAgSBgcDFAYBEggCAQIDAQqIEwMJDK8lhn+JLQgFhw8XgSyLc4FLEQFQNYJLNoEcBZFciCKQPol2PC+BDQ
X-IPAS-Result: ApcfAOXN3FMCYJjrPGdsb2JhbABZgw1jAUWCeIQ3gQTLKwECAQEMeRcFAQEBATg2g34FAQEEAQgBARkPAQUeAQEhCwIDBQIBAxUBAgICBSECAhQBBAgSBgcDFAYBEggCAQIDAQqIEwMJDK8lhn+JLQgFhw8XgSyLc4FLEQFQNYJLNoEcBZFciCKQPol2PC+BDQ
X-IronPort-AV: E=Sophos;i="5.01,786,1400022000"; 
   d="scan'208";a="642443686"
Received: from host-2-96-152-235.as13285.net (HELO PhilipOakley) ([2.96.152.235])
  by out1.ip06ir2.opaltelecom.net with SMTP; 02 Aug 2014 12:44:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254695>

=46rom: "Mike Stump" <mikestump@comcast.net>
Sent: Friday, August 01, 2014 11:24 PM
> On Aug 1, 2014, at 12:01 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> w=
rote:
>> It can work in Subversion because Subversion stores information abou=
t
>> what was merged in (and this includes cherry-picks, or whatever it i=
s
>> named in svn) in svn:mergeinfo property. Git does not track what was
>> merged in, instead it represent the history as the graph of=20
>> revisions,
>> and tracks merges (by storing that it came from two or more commits)
>> and not merged-in information.
>
> So, as a dumb user that just wants it to work, I am unsympathetic to=20
> the `but software is hard=E2=80=99 excuse.  I am aware that some bugs=
 are=20
> harder to fix than others.  svn took a long time to fix this bug, but=
=20
> they did.  I can wait, the only question is, will it be a week, a=20
> month, a year, or a decade.
>
>> When merging Git uses only what is being merged and its common
>> ancestor (3-point merge). It is simple, and simple works!!!
>
> I gave a solution for git using branches and it works just fine.  It=20
> retains the simple 3-point merge as well.

At the moment there is no formal way for Git to record within the commi=
t=20
metadata the inclusion of the cherry-picked diff (the 'merge' of the=20
fix).

Thinking out of the box, the issue is that the commit parents list does=
=20
not have a formal mechanism to allow the recording that the 'merged'=20
change was the patch change from a specific commit fom somewhere else=20
(which may be missing from the local repo).

Perhaps it needs a style of merging-rebase where a second (last) parent=
=20
is added but it isn't the straight <sha1>, but says 'patch-<sha1>', suc=
h=20
that readers with the capability could check if that <sha1> history is=20
present locally, and if so if it's correct, so that you can now 'track'=
=20
your fixes between releases, and (hopefully) older Gits don't barf on=20
that extra 'fake' parent. Somehow I suspect that older Git's would=20
barf.. (not enough time to create and test such a fake commit)

>
>> Unfortunately, it does not see cherry-picked commits - it is=20
>> invisible
>> to merge as being on the chain from one of merged commits to the
>> common ancestor.
>
> Im the solution that I sketched in my previous email, that informatio=
n=20
> is then exposed so that the right merge happens.
>
>> The rebase command handles
>
> I can=E2=80=99t use rebase as it is unfriendly to coworkers.
>
>> cherry-picked commits by detecting that the
>> change was already applied. I think that git-imerge does the same=20
>> (but
>> I have not used it myself).
>>
>> Have you tried git-imerge?
>
> No, not yet.  I=E2=80=99m not as interested in using it, as I would l=
ike git=20
> itself to just work.

--
Philip=20
