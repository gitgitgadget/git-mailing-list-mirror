From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Sun, 19 Sep 2010 16:03:42 +0200
Message-ID: <4C96183E.7020208@gmail.com>
References: <1jp2d5s.1q4xl2w1f5ufljM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnI/IEJqYXJtYXNvbg==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Sep 19 16:04:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxKUv-0008Cw-74
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 16:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab0ISODr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 10:03:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38786 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab0ISODq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 10:03:46 -0400
Received: by eyb6 with SMTP id 6so1375276eyb.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=bf0H7InFktuDUY7MaS229HHWIob6L9qZI7HSdGUow7Q=;
        b=YfkG9d2cbzHtiUbmiY5kyJB7AUsYhCLczWqDOo8TQ1y+FJuQg3Y72jauV7bNlVmfEf
         z49UXzRFsoTBhBds8f72Vt9R86yUPoEQPM+gttMjvkzsGU0hmD7g/bWmlJiEKRwL+HLu
         Q5yYsDPPzPhT3C2p4MaeHkxy9+7CAumYFXQg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=MBxoeOVbbSBlvBcsUDIXg3LzCXN6K/vRYDpuGpai0zFgIr6+erRxFYcAfLAVWrwvys
         apMfVyn/qD4xXMfh8i5Y8qoBlmwti9fS/kR7xjpb4aotfqTps2jBxx0GLksWRVf+e8C2
         4kkqUv7wUXA73o6ySmQ/1I1BL844jRgxBIewE=
Received: by 10.213.7.81 with SMTP id c17mr5833640ebc.17.1284905024944;
        Sun, 19 Sep 2010 07:03:44 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-123-180.multimo.pl [89.174.123.180])
        by mx.google.com with ESMTPS id v8sm9278230eeh.2.2010.09.19.07.03.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 07:03:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <1jp2d5s.1q4xl2w1f5ufljM%lists@haller-berlin.de>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156497>

On 09/19/10 11:45, Stefan Haller wrote:
> Artur Skawina <art.08.09@gmail.com> wrote:
>=20
>> On 09/18/10 17:26, Stefan Haller wrote:
>>> =C3=86var Arnfj=C3=B6r? Bjarmason <avarab@gmail.com> wrote:
>>>>                      A---B---C topic
>>>>                     /         \
>>>>                D---E---F---G---H master
>>
>>> The question is the same though: if I hit commit B while blaming, h=
ow do
>>> I know what topic it was a part of?  For that, I need to find commi=
t H
>>> which will tell me, right?  How do I do that?
>>
>> git rev-list --ancestry-path --merges --reverse B..master --format=3D=
oneline
>=20
> Thanks, this is helpful.  (However, my co-workers will probably laugh=
 at
> me if I suggest they remember a command such as this for what they th=
ink
> should be a very simple operation.)

An alias such as "git show-merges-since B" might help.

> There's a problem though for commits that are far back in history:
>=20
>                A---B---C topic
>               /         \
>          D---E---F---G---H---I---J---K---L---M---N master
>                                   \         /
>                                    O---P---Q another-topic
>=20
> Your command also shows M, which is not interesting at all in this

But you're only interested in the name of the original topic branch,
right? Then the first merge will tell you that; I omitted "| head -1"
from the cmdline above, just in case the history isn't as simple as
in this graph.

> context.  Ideally it should stop at the first command that's common t=
o
> topic and master.  Is there an easy way to achieve that?

Well, as you've explicitly deleted the 'topic' ref, how is git supposed
to find it?

The above "git rev-list" will give you either the merge w/ the info you
are looking for, or a list of merge commits that you'll have to filter
(grep etc) to find the first one containing the answer.

>> IOW if you know you could still need the old branch info, make an al=
ias
>> that doesn't actually delete the branch after merging, but moves the=
 ref
>> away, eg 'topic-name' -> "merged/topic-name" or just adds a
>> "merged/topic-name" tag. Then simply checking from which "merged/*"
>> branch/tag the offending commit is reachable would be enough.
>=20
> Same problem here: this also shows all branches that were created and
> merged after the original topic was merged.  (In the example above, i=
t
> will also list another-topic.)  This makes it pretty much impossible =
to

Yes. "git merge-base master another-topic" would return 'J' and if 'B'
is still reachable from 'J' then 'another-topic' isn't the answer and
you have to keep looking. So it's a bit more complicated.

artur
