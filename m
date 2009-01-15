From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [STGIT][PATCH] new: translate non word characters in patch name to '-'
Date: Thu, 15 Jan 2009 15:53:10 +0100
Message-ID: <873afkei3t.fsf@krank.kagedal.org>
References: <49562413.0437560a.287d.5133@mx.google.com> <20081228204938.GA13143@diana.vm.bytemark.co.uk> <154e089b0812291215h72dfe04aod080f665eb7f5592@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 15:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTcQ-0006Gh-QC
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763142AbZAOOxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 09:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762748AbZAOOxZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:53:25 -0500
Received: from main.gmane.org ([80.91.229.2]:60128 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762057AbZAOOxY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:53:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LNTax-0002gD-A8
	for git@vger.kernel.org; Thu, 15 Jan 2009 14:53:19 +0000
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:53:19 +0000
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 14:53:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:k78ojhhBU2ejEuE7ROsPT1PuFs8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105826>

"Hannes Eder" <hannes@hanneseder.net> writes:

> On 12/28/08, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>> On 2008-12-27 13:37:20 +0100, Hannes Eder wrote:
>>
>>  > This allows following usage:
>>  >
>>  > $ stg new full/path/file-fix-foobar
>>  > Now at patch "full-path-file-fix-foobar"
>>  >
>>  > Signed-off-by: Hannes Eder <hannes@hanneseder.net>
>>  > ---
>>  >
>>  > I ran into as a '/' in a patch messed up stgit.
>>  >
>>  > I find this useful as 'stg uncommit' does the same translation.
>>
>>
>> Clearly, bad path names shouldn't mess anything up -- see
>>
>>   https://gna.org/bugs/?10919
>>
>>  But I would prefer "stg new" to quit with an error message when giv=
en
>>  an illegal patch name, not silently mangle it. (Of course, the
>>  commands that generate patch names from commit messages -- such as
>>  "stg new" when not given an explicit patch name -- should mangle th=
e
>>  commit message as much as necessary. But when the user gives us a
>>  patch name, we should either use that as is or fail with an
>>  informative message.)
>>
>>  I think the right thing to do would be to construct a function that
>>  validates patch names (I don't think we have one right now), and th=
en
>>  call it whenever we need to check if a patch name is OK. Such as wh=
en
>>  the user gives us the name of a new patch. And when we've
>>  auto-generated a patch name from a commit message, we should probab=
ly
>>  assert that that the check function is OK with the name.
>
> What about instead of 'fail with an informative message', just issue =
a
> warning that
> the name has been mangled. I use pathnames in patch names frequently,
> so this would be very handy.

No, I agree with Karl. For example, a tool (such as the Emacs
frontend) might want to do a "stg new foobar" and then do something
with the patch it now knows is called "foobar". And if it was called
something else the tool will fail.

--=20
David K=C3=A5gedal
