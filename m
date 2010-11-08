From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Mon, 8 Nov 2010 12:18:51 +0100
Message-ID: <AANLkTikK1C5zzfOKSucPhOAQV3E=mrOunpyv4NhN+Od6@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201011041141.58334.jnareb@gmail.com> <AANLkTimxspcGLnv+F6uKAnFAhUO++iB10b5GxnLVg_v3@mail.gmail.com>
 <201011081205.12191.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 12:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPks-0002jr-9n
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 12:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab0KHLTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 06:19:13 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35395 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0KHLTM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 06:19:12 -0500
Received: by iwn41 with SMTP id 41so3962643iwn.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 03:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TVR7OzGiWPcQsFOMJBRCAvhY4ZnF+kqkSXwjA3lggbI=;
        b=p6flk6GknqnGN0/cITr7QYWNta6pRiZFZYz2/AczA3Z7neBe9W7wBHOWoTPpXrMrVy
         /xQDTfEJSZyrA8fK9igc6rHwJyFqRovIVdnnsi1N2Iyw3OTIUJPc4UI+aPDt1hgGx1mz
         K05tZNZMzSPwKR1g0Usl5pFE+bhs20lZDUA3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KWXGnwhsb/PMp4a7giVRQ0T0oO7MNjiMpWCNgUtGnqdBpsKbK+G2RFAf4PbZAD2dV6
         Uh7ScYQLdVDXef9nZpkm5le4DfcDrPPquu0JG3nCDT9qUi+mgZcJSEc9CP0sJlrnArJP
         z0PW30u9gZa9OAsEcqhtHm8o46LJ/EUNdrbRw=
Received: by 10.42.174.2 with SMTP id t2mr3111832icz.104.1289215151662; Mon,
 08 Nov 2010 03:19:11 -0800 (PST)
Received: by 10.231.160.210 with HTTP; Mon, 8 Nov 2010 03:18:51 -0800 (PST)
In-Reply-To: <201011081205.12191.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160927>

On Mon, Nov 8, 2010 at 12:05 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Mon, 8 Nov 2010, Giuseppe Bilotta wrote:
>> On Thu, Nov 4, 2010 at 11:41 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>> On Wed, 3 Nov 2010, Giuseppe Bilotta wrote:
>
>>> I think remote_heads feature is more important for _local_ use, for
>>> example browsing one own repository using git-instaweb. =A0In such =
cases
>>> number of remotes and of remote-tracking branches might be large (I=
 have
>>> 11 remotes, not all active, and 58 remote-tracking branches).
>>>
>>> BTW. would next version of this series include patch to git-instawe=
b
>>> enabling 'remote_heads' feature for it (gitweb_conf function)?
>>
>> I will look into that.
>
> It can be as simple as
>
> diff --git i/git-instaweb.sh w/git-instaweb.sh
> index e6f6ecd..50f65b1 100755
> --- i/git-instaweb.sh
> +++ w/git-instaweb.sh
> @@ -580,6 +580,8 @@ gitweb_conf() {
> =A0our \$projectroot =3D "$(dirname "$fqgitdir")";
> =A0our \$git_temp =3D "$fqgitdir/gitweb/tmp";
> =A0our \$projects_list =3D \$projectroot;
> +
> +$feature{'remote_heads'}{'default'} =3D [1]
> =A0EOF
> =A0}

Thanks.

> We might want to enable more features for git-instaweb, but I think
> it would out of scope for planned commit (for 'remote heads' series).

Definitely 8-)

>> Either solution is fine, but it would require grabbing all the remot=
e
>> heads. The real issue here is, I think understanding what is the
>> purpose of limiting in gitweb. Is it to reduce runtime? is it to
>> reduce clutter on the screen? In the first case, the limiting should
>> be done as early as possible (i.e. during the git call that retrieve=
s
>> the data); in the latter case, is it _really_ needed at all?
>
> It is to reduce clutter on the screen, or rather have 'summary' view
> for a project (for a repository) to be really a _summary_. =A0That's =
why
> there is limit of 15 commits in shortlog, of 15 branches in heads, of
> 15 tags. =A0This action is meant to present balanced overview of
> repository.

Ok.

> Regarding gitweb performance, it is quite important to pass limit to
> git-log / git-rev-list needed also for 'summary' view; passing limit
> to git command really matters here.
>
> git_get_heads_list passes '--count=3D'.($limit+1) to git-for-each-ref=
,
> but I don't think that it improves performance in any measurable way.
> Similar with saving a memory: it is negligible amount. =A0So if we ca=
n
> do better at the cost of running git_get_heads_list without a limit,
> I say go for it.

The gain in performance is, I believe, related to the number of heads
and the number of remotes that are to be enumerated. 11 remotes with a
total of 58 remote branches (the case you mentioned, for example)
might not feel much of a difference between pre- and post-filtering,
but something bigger might start to feel the effect.

I think the strongest point in favour of post-filtering is that the
feature is intended for use mostly for local repositories anyway.

> Note that the costly part of git_get_heads_list is forking git comman=
d,
> so it makes absolutely no sense to run git_get_heads_list once per
> remote instead of doing limiting per-remote in Perl. =A0The former wo=
uld
> affect performance badly, I can guess.

That is indeed the reason why I chose to go the single call way, even
though it meant having the limit end up being used somewhat
incorrectly.

--=20
Giuseppe "Oblomov" Bilotta
