Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F1120B1E1
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298210; cv=none; b=PHvqiupeTgq1PmHIBhw0A8K0SJX3eLRaS0I6HBTgPCQX2oc5oQ5QCH263zgDGg2LstFfXT3SHWo108loAhJnhSsFzJrA+uryKuxBgoriDO2m/Wr7QZpQkdbTnufcsSl/C/0w70vGoJob23jj/GUoHnXYM64mY0bFsFBl7Yp3QIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298210; c=relaxed/simple;
	bh=CWmQJPlZ2oo1ZVeim8MgPxS2yoHC8K7VmRc5Xl4t5f0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pc7FsjgnLfghnsNWUXOt9eCiDrQTkbSfty5s0n4yb4PzhtOhCplzY6ppOxur222SLX5p5m25P/eis7G5l9gynVMHCE/d2UdWVC7t2kYYm9wrlwRXG/dnNVMM3cUG43AZA+SOrKw0OCnCYuvDHNVHRwigEkyEcn5bWv9tZ57hPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=q22sH6yz; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="q22sH6yz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742298206; x=1742903006;
	i=oswald.buddenhagen@gmx.de;
	bh=BPHYNCiioHozZvB97DZII1vz+6twtkys9R+UqWSoLj0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q22sH6yzIl8Wka3F/fKyKmdKZbftFWt1D+DVlNgQtGtwpHADXcIRaqXFqvKZr00A
	 C6XUdkCjP4Cyj7zBhUgzWa5hgh/wa7sgVgdHq2cENS4DU7wefPfjBP5XgyCkgnFeW
	 woAp4YRqbY85IKOpiIP3woQXAx4b9hLYvxvFbTKcw5z1PVjVe3Rwj3+9A3tUHl0ib
	 HVf/NC7+Q3jyQMKRaD3+gZthupf2W4fx/kkahczdnUWhMuGCMEOh5+e/Z3UpOu5md
	 e55AT0R+3yNEFFsFaP19OFwtaeZpKETDe640e7QRprXnMY03GTTyAVPIydUeunKu2
	 eAvqr6LPoKAXwrwmBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1tSLg648uR-00b6U1; Tue, 18
 Mar 2025 12:43:26 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1tuVLx-g3H-00; Tue, 18 Mar 2025 12:43:25 +0100
Date: Tue, 18 Mar 2025 12:43:25 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] docs: clarify meaning of core.commentString=auto
Message-ID: <Z9lcXR6sL3UWlL33@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9iVVD988M4XUyYO@nand.local>
 <xmqqv7s78l8t.fsf@gitster.g>
X-Provags-ID: V03:K1:lACTCU6lE7htqvqpy+bx0/1lRZfHoz0v9cCb9i9oqKGHLgDDZw+
 Y/vCxFnHjbjCVh6zHE9UIsZ/ULM5ICdw6YdRVQy9T3ROinW6jkvw6YdYV4nepF8TEsW2OHR
 Y9r4QQ1Wub49nxnMd9v2RMcdztFfff8lJJQjMlparWI8WYL/pn/nD/dTxFO+Oo2daT6Aoa+
 gOwYkQxOYQg92FJ6D3B0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qsOilcaSgE8=;kJp6Xkt660S2w2etoGbWrsPJE2B
 WACKStQdL00WP4dMWvFR2EytpSvKy9S0UHTcZwVE53psKgcG4SdapT6KoAWr+UjzOw3qSqLm1
 DkGSL3jhIy6frjBzXL0oRupEynd5f4rpXIIZzKpmq4F4/6W2MYapWw0LZmhq/M9Z8HytFVnev
 XbyNyP7WvnUUnj1GxGBl1oD8Fp3Hegs1/AgC936xAxyCwemp54YsOxTXl86+rtlgxF4Z1VEem
 CTwnKQL8Ji26QK8tgmz2M9j5lPawJRPDy8yXxDjZZqIPvf1JCDBJQKfmOkIdkDrxBzhcLguRW
 GiG4Wgjf5qTzu1UHdjE8dcsSw5Ex25VuXKdj8zWF+QI87uLSTH4kPVHJ3qbGQBg/UKqLJeyxE
 s6fbGjAd4Asf3vKJTGBMMQmnorQDhSicWj3fU+Z6tNbCrotbzuhmyvSFA5CQ+t5zh9NskbwYC
 xLHIxzBWd10O+bFHC9W2DDEfMgf/AlzdsRfUeLYySOrL0Tbe5dPvWNcvHbzgwri6U431yPAqZ
 IP6lKB5u53FWuEU3GXGwMr2Ur1w93wFMmelWhq/0A0H7brq5GpbEgRjXlsfqh6JhadqePauu6
 I/9NWNdEq6m341WkpdFIghe7q5hoijj7HC/CxPS4S8zKTGJWl+wxV/VE5pHeIey0KUAj0VDSo
 VVJ3ZEz8W0K4jIsa0Ccv144DrmBoLDEis2kLAF6lc7MxFz3d9CObF7Yzwud4yGIuksWSdHbeA
 IDWJqIjlimOVFoxsjybPkWEd6JCjVwlpNC0Uy8zm2GwqAicSTa5Cq/pL/b7J13NaJORflS8Gu
 O5cLHTj9SKduwaMTWprIC+Xp1kK07VA6SZ78HvdD3QaWd84TtM1PVtUuRNyKqc312SuTyixLZ
 YwM2Nnzkuw4RZsKeI/as+93eXl/x/BVc8uTPT2rwpVCp18e2tZvxeiTRLVvynYDs4NpTzcpT4
 oGqm/SN4hoVR4ONSBrY5DkLjeSlhBVldJTCTbuzMrG3BMXlKxoPa9P6s3LkefQD4xk95R0AMo
 xgj4pMJx+wR43jtibXOP/mqaJsXEVt4IyRhXiqonVVG9siwLUZXqu8epQAHgLirkN+gcf1+0o
 2beMAAqOiO0+oZ0Z0Tvu+UPUNxmRHs9a5O1gg5xk/I0BXKYnKq3Y65irUP6jO7wvfidzmVxvD
 CHljnEK4HvGuX7TqDkZCP/IHyvvsM5TLFQoDKtH1DfKMlgkrb2C3nGXZyHhkzh8l/FQev9zLp
 fbubPdAylElkKqBlnMBvlJGcJxgBnkw9E6a5TlOYe7L3J9ZVxq6D4Y+vR/fcYxwzk0Z9KtWKF
 4w1ujyDx1tIkCyNcBErl09+AXjsNTc/dlYQwXhtqtTq1/mzimMGQNETWDY5JAwPbL651rGaxL
 WCHrLxwskQh20o36NvtZpzmg+SBiT3CFPhwl4grm4FTWOl1zmi54uOBve3WgdTduEPTu1HlAW
 jtOxHlVxDDJlnWU/OLqjP3ecnXFJJfDFBi7B4oAitBDiIqNCg
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 01:17:54PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> -If set to "auto", `git-commit` would select a character that is not
>> -the beginning character of any line in existing commit messages.
>
>This is so far in the past but I suspect this was deliberately left
>vague so that we can add (or subtract) the set of possible letters
>to use.
>
no such consideration was voiced at any point.
https://lore.kernel.org/git/CALy3b+m7YkYB+mPEnAQnjKFAwUS_PqCUFtuxzN7hwhmNf=
Mrw3Q@mail.gmail.com/T/#u

On Mon, Mar 17, 2025 at 05:34:12PM -0400, Taylor Blau wrote:
>I had a similar thought while reading. The vague wording of the
>existing
>text gives us freedom to change that set of characters in the code
>without the possibility of the documentation becoming stale.
>
>That's pretty academic, though, so I don't have a strong feeling against
>this portion of the patch, but I do vaguely prefer the existing wording.
>
apart from changing it being academic, the feature is also formally
useless without documenting the candidate comment characters. formally,
because in practice the user would just guess, but that doesn't make the
omission a good thing.

On Mon, Mar 17, 2025 at 01:17:54PM -0700, Junio C Hamano wrote:
>> +Note that this makes it impossible to include comments in the
>> +prepare-commit-msg hook's output or the commit message template.
>
>Care to rephrase?  There are degrees of possibilities and "makes it
>impossible" is being overly broad.
>
>I suspect you are saying that it is not nice to make it the
>responsibility of the end-user who chooses "auto" to ensure that
>they adjust the default '#' comments injected from the template or
>hook output when
>
> - they have a line that begins with '#' in their message;
> - the "auto" mechanism chooses to use ';' as the comment character;
> - the template is written assuming '#' as the comment character and
>   has comments.
>
>before making a commit.  But "this makes it impossible" does not
>quite convey that to casual readers.
>
no, i meant what i wrote: it makes it _literally_ impossible. it follows
from the preceding sentence that _whatever_ is in the template will NOT
be the comment char. the commit that introduced that feature (84c9dc2c5)
already mentioned that limitation.

reading through the thread of the original submission, the feature is a
workaround for `commit -m` and `commit --amend` being inconsistent wrt.
message washing. i find it surprising that this patch didn't get any
push-back, even though the thread mentioned the correct way to enforce
consistency (use --amend with --no-edit), and the fact that the user
should have set the commentChar to non-'#' even if his primary method to
create commit messages was with -m. i don't see how (or why) anyone
would integrate this option into any practical workflow, and therefore
consider it a mis-feature that should be done away with. but knowing how
people here react to such proposals, it seems most practical to document
the feature sufficiently well to enable users to easily draw the
conclusion that it is, in fact, nonsense.

