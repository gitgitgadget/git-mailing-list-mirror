From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 09/11] gitweb: git_is_head_detached() function
Date: Fri, 14 Nov 2008 09:52:09 +0100
Message-ID: <cb7bb73a0811140052h1b7aac6cp6b0b376fa59548a9@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vk5b6dd3t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 09:53:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0uR6-0003BF-Fs
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 09:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbYKNIwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 03:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbYKNIwN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 03:52:13 -0500
Received: from qb-out-0506.google.com ([72.14.204.239]:17743 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbYKNIwL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 03:52:11 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1299183qba.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 00:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=o5AQN3dNCGu7GOMmcfYlaGcymcdYjj+b5bl9SK2waQc=;
        b=JQx/CCmgC7MOlnbJKUiVpZSdMcdclnyGWWH2tsQdZxwVdSIH1KIU78/jCwLiIzvi8p
         c7yn/A04hkfEydJr/OPq/lztRwhG/ti235ZOy8gIfuxC8X12Rd1TzuvJfQmPFrhPVFJa
         Whk6fMbZc5NNQySTk8fiLVpnEj+oRfmTFZYgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sieMZ0jH+NHDzO8erIRlEPTJsz9odlx09U4YtCBCk25VhV9aN3ja864elZoekUa0s1
         2o/B8uUfOLteUIy/zp0XLtxGg4glulkWZn9+qNdRVH5rw2VqwJ5C474cfQJTjkLJgz7R
         rijpFQqm1m5YgPY0+4MZOdiySBraLlFKnvAfw=
Received: by 10.210.29.11 with SMTP id c11mr814068ebc.8.1226652729297;
        Fri, 14 Nov 2008 00:52:09 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Fri, 14 Nov 2008 00:52:09 -0800 (PST)
In-Reply-To: <7vk5b6dd3t.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100959>

On Fri, Nov 14, 2008 at 7:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> The function checks if the HEAD for the current project is detached by
>> checking if 'git branch' returns "* (no branch)"
>
> This one looks more like "oops, the way detached HEAD is detected in 08 is
> sucky, let's cover it up by introducing a function as an afterthought."

Half and half: it _is_ an afterthought, and although it's sucky that's
not the reason why I decided to refactor it 8-)

> Have a patch that introduces git_is_head_detached() first, and then use
> that function to implement the feature.  I personally think the user (that
> is, 08/11) is small and isolated enough that these two can be a single
> patch.

Will do. I did some patch squashing while preparing this set, but I
forgot to do this one.

>> +# check if current HEAD is detached
>> +sub git_is_head_detached {
>> +     my @x = (git_cmd(), 'branch');
>> +     my @ret = split("\n", qx(@x));
>> +     return 0 + grep { /^\* \(no branch\)$/ } @ret;
>> +}
>
> Do not read from Porcelain in scripts.
>
> "git symbolic-ref HEAD" should error out when your HEAD is detached, and
> will return refs/heads/frotz when you are on frotz branch.

Eh, I was, like, 100% sure this was the wrong way to do it, but I
didn't have any idea on how to do it using the plumbing. Thanks, I'll
look into that.

> But realistically speaking, what does it mean to have a detached HEAD in a
> repository published via gitweb?  First of all these things are supposed
> to be bare and there would be no checkout.

You know what's funny, when I first started working on the 'show
remote branches in gitweb' patchset, you had a similar objection, but
as you yourself pointed out

> But obviously people use gitweb/instaweb as a way to view their
> own live repository, and I think it makes sense to show and
> support remotes/ in such a case.  It also would make sense to
> support detached HEAD there as well.

http://kerneltrap.org/mailarchive/git/2007/8/30/256411

and that's exactly the reason why I added the part about the detached head 8-)

I have been thinking about making this detached HEAD thing an
additional option, but it _really_ seemed like overkill.

-- 
Giuseppe "Oblomov" Bilotta
