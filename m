From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 17:23:27 +0100
Message-ID: <200712191723.29591.jnareb@gmail.com>
References: <20071214105238.18066.23281.stgit@krank> <200712191144.59747.jnareb@gmail.com> <20071219114021.GB5565@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?iso-8859-1?q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 17:24:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J51iT-0006xQ-E2
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 17:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbXLSQXh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 11:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbXLSQXh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 11:23:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:3839 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbXLSQXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 11:23:36 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1585589nfb.21
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=5NwrJ89d0q+5NdsU5cpPc6YTEdS0/zMdmkE5j1naLUw=;
        b=jQ0P4OQ2fmPVgxFrzmUT6J36lz0YxtMF6MVtw23xt1nnkUz3BHg9OEFx1uykJgAI2kzCmayiypSlKSid60xqVapEsrPERrRLX+D8taHrBuUPNHRYpdWtp69lxknOAImEOQMuBsasFtuqa+invGXyI0bjmkiZRKYSHw0O71FKzxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=hyXu/Z8Z28EutiwIEkLu+5ewRHud53hb83nEC+XOLglYP/8sIs10T1AL7weN7Lh8YVRWm72glEg/sOuIagzi1TKKpHS9IqQMSJf6I6sumgmQQwuHl0EujkW64GONm1Z181DiHizsorqoG16TX2Jl6Q3qObO7qlaVnpPYgcPdy18=
Received: by 10.78.138.6 with SMTP id l6mr9410588hud.32.1198081413947;
        Wed, 19 Dec 2007 08:23:33 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.93])
        by mx.google.com with ESMTPS id 35sm176440nfu.2007.12.19.08.23.30
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Dec 2007 08:23:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071219114021.GB5565@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68918>

Karl Hasselstr=F6m wrote:
> On 2007-12-19 11:44:57 +0100, Jakub Narebski wrote:
>> On Wed, 19 Dec 2007, Karl Hasselstr=F6m wrote:
>>> On 2007-12-18 08:39:52 -0800, Jakub Narebski wrote:
>>>
>>>> I also would like to have this command kept (and shown in 'stg
>>>> help'!). Contrary to 'git add' it can check and add to index /
>>>> update index only for files with conflict; we have -r
>>>> (ancestor|current|patched) to choose one side, and we could add
>>>> --check to check if there are no conflict markers with files
>>>> (useful with -a/--all).
>>>
>>> This too sounds like stuff that could profitably be added to "git
>>> add". Except for the ancestor/current/patched words, it is not
>>> specific to patch stacks, so the implementation should be in git
>>> and not in stg.
>>
>> No it cannot, at least the '-r (ancestor|current|patched)' part for
>> resetting file to given version, even if we change the wording to
>> ancestor, ours and theirs. The git-add command is about adding
>> contents, which updates index, which almost as a intended
>> side-effect clears merge state, i.e. stages; and not about resetting
>> to stage.
>=20
>   git checkout-index --stage=3D1|2|3 <filename>
>=20
> does what you want. But "git cat-file" knows this handy syntax for
> getting at particular index stages:
>=20
>   :stage:<filename>

I always forget which stage is which. It would be nice if=20
git-checkout-index implemented human-friendly names, just like=20
git-diff-files has --base, --ours, --theirs, i.e. if it would be=20
possible to write

  git checkout-index --stage=3Dbase|ours|theirs <filename>

and perhaps even

  :base|ours|theirs:<filename>.

(but there is a problem with files containing ':'...).

> It would be very convenient to be able to do
>=20
>   git checkout :stage:<filename>
>=20
> but it doesn't seem to work currently. Does anyone know the "best" wa=
y
> of manually checking out a particular index stage in git?

It's a pity it doesn't work. Or if not this, then perhaps

  git checkout --stage=3Dours -- <filename>

>> Besides with "stg resolved" you can update index _only_ for files
>> which were in the conflict, also for -a/--all, and not all the files
>> not only those which were in the conflict like "git add -u" does.
>=20
> This sounds like a straightforward addition to "git add".
>=20
>> "stg resolved --check" could happily ignore things that only look
>> like conflict markers, but must have been intended, because they are
>> in files not in conflict.
>=20
> git knows about conflicting files too.
>=20
>> Unless you are talking about adding "resolve"/"resolved" command to
>> git-core, as a porcelain wrapper around git-update-index, like "git
>> add"...
>=20
> Yes, that's what I want. You and others like what "stg resolved" does=
,
> but I don't want it in StGit because it's a generic git enhancement
> that has nothing to with patch stacks. People who don't use StGit
> would presumably like it as well.

You mean adding another option to git-add, similar to '-u' option, but
updating only the files which were (are) in merge conflict;=20
'-c'/'-r'/'-s' perhaps? This would be replacement for=20
"stg resolved --all", wouldn't it (and with filename replacement for=20
"stg resolved <filename>", of course)?


P.S. Sidenote: it would be nice if git-mergetool was updated to=20
understand StGIT style interactive 2-way and 3-way merge configuration,
and not offer only limited choice of pre-defined interactive merge tool=
s=20
(although pre-defined are nice, too).

--=20
Jakub Narebski
Poland
