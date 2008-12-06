From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Sat, 6 Dec 2008 14:46:30 +0100
Message-ID: <cb7bb73a0812060546l23b39154q27c636220f6aae81@mail.gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200812060134.22959.jnareb@gmail.com>
	 <cb7bb73a0812060434r2b48fd1ev359020fb1e0d1603@mail.gmail.com>
	 <200812061409.02730.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 14:47:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8xVd-0002bM-HD
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 14:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbYLFNqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 08:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbYLFNqc
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 08:46:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:6211 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbYLFNqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 08:46:31 -0500
Received: by nf-out-0910.google.com with SMTP id d3so209116nfc.21
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 05:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y+V/kBGlYg7Ds2Q9tCMNYM4Gy/9cYLDublejzpWYsHQ=;
        b=Ljo/UhNKTd3Uk9B+y80DnJrPjEqPjegLr818ASCi5SVSJSMajkfsXj58gLDPMTy948
         IANztfKmiGb30DDpenjr2DvZqsqyq50mIw65fQX5g3lFA7waVNTjZTcs8SN7yguPvAh0
         aopLcK+eqTT4SEsDFceVWobvmzaidDdi3Qb6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T4zKjKMoJL/RWHzjidj65GkMmlBJQWKWIAoM6C83m6l2iyP8Spe0S7Pfz2nR1lmnUf
         bGT2TVH/6X54TUD5JsJLosTiiwRnnTq7qjGU6WI775/9sLZUbOgjwf/O7bmmMavJDQtw
         0roFTzE3KR4/B1ZJStQv2VOYkUJnmTeHTnoOw=
Received: by 10.210.63.6 with SMTP id l6mr827074eba.151.1228571190132;
        Sat, 06 Dec 2008 05:46:30 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 6 Dec 2008 05:46:30 -0800 (PST)
In-Reply-To: <200812061409.02730.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102457>

On Sat, Dec 6, 2008 at 2:09 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, Dec 6, 2008 at 13:34, Giuseppe Bilotta wrote:
>> On Sat, Dec 6, 2008 at 1:34 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:
>>>
>>>> The manually-built email format in commitdiff_plain output is not
>>>> appropriate for feeding git-am, because of two limitations:
>>>>  * when a range of commits is specified, commitdiff_plain publishes a
>>>>    single patch with the message from the first commit, instead of a
>>>>    patchset,
>>>
>>> This is because 'commitdiff_plain' wasn't _meant_ as patch series view,
>>> to be fed to git-am. Actually it is a bit cross between "git show"
>>> result with '--pretty=email' format, and "git diff" between two commits,
>>> to be fed to git-apply or GNU patch.
>>>
>>> Nevertheless the above reasoning doesn't need to be put in a commit
>>> message. But it explains why new 'patch' / 'patchset' view is needed:
>>> because there was no equivalent.
>>
>> I'll remove it.
>
> Errr... sorry, I haven't made myself clear. I meant here that *my*
> comment should not be added; your explanation about adding 'patch'
> view should IMHO stay, perhaps reworked a bit: commitdiff is not
> about generating patch series.

Oops, ok, I'll just rewrite it better 8-)

>>>>  * in either case, the patch summary is replicated both as email subject
>>>>    and as first line of the email itself, resulting in a doubled summary
>>>>    if the output is fed to git-am.
>>>
>>> This is independent issue which is I think worth correcting anyway,
>>> unless we decide to scrap 'commitdiff_plain' view altogether.
>>> But I think we would want some text/plain patch view to be applied
>>> by GNU patch (for example in RPM .spec file).
>>
>> I don't think we should scrap commitdiff either, but the subject
>> replication is not really an issue if the view is not fed to git am.
>
> Well, there is it.

Considering the comments on the second patch too, I've been thinking
that it might worth it to merge commitdiff_plain and patch view for
single commits. Some changes for multi-commits commitdiff_plain can be
considered too, but as I mentioned this is a major changes and should
be dealt with on its own.

>>>> +     # The maximum number of patches in a patchset generated in patch
>>>> +     # view. Set this to 0 or undef to disable patch view, or to a
>>>> +     # negative number to remove any limit.
>>>> +     'patches' => {
>>>> +             'override' => 1,
>>>> +             'default' => [16]},
>>>>  );
>>>
>>> You need to set "'sub' => \&feature_patches" for feature to be
>>> override-able at all.  Also features are usually not overridable
>>> by default, which reduces load a tiny bit (by _possibly_ not reading
>>> config, although that shouldn't matter much now with reading whole
>>> commit using single call to git-config, and not one call per variable).
>>
>> I think I'll make the feature non-overridable. I'll also make it
>> default to disabled, although I'm not particularly happy with the
>> choice.
>
> I think that having 'patches' feature to be able to override is a good
> idea, as limit on number of patches might depend on _repository_, for
> example being lower for repository with large commits (large in sense
> of diff size).
>
> Default with override unset seems to be precedence... as to having it
> disabled by default: having feature which require configuration enabled
> by default serves as an example of configuration; on the other hand the
> example might be in comments, like for 'actions' %feature.

I've added the feature_patches sub. Also, considering that there are
now basically 3 votes against 1 for enabling the feature by default,
I'll keep it enabled.

>>> And I think the default might be set larger: 'log' view generates
>>> as big if not bigger load, and it is split into 100 commits long
>>> pages.
>>
>> Hm, I would say the load of patch view is much higher than the load of
>> log view, both in terms of bandwidth and in terms of load on the
>> server, because of the diffs.
>
> Ah, I forgot about that. Limit to 16-25 seems to be reasonable, then.

I'll go with 16 for the time being, I think it's large enough to
accomodate most patchsets.

-- 
Giuseppe "Oblomov" Bilotta
