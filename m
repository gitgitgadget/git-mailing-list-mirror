From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/4] Documentation: warn prominently against merging
 with dirty trees
Date: Sun, 10 Jan 2010 22:13:18 -0600
Message-ID: <20100111041318.GA9806@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
 <20100110044949.GA8974@progeny.tock>
 <7vskaefp2v.fsf@alter.siamese.dyndns.org>
 <20100111021322.GA8480@progeny.tock>
 <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 05:16:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUBhj-0002T0-0B
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 05:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233Ab0AKEN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 23:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169Ab0AKEN0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 23:13:26 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:43321 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab0AKENZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 23:13:25 -0500
Received: by gxk3 with SMTP id 3so10045883gxk.1
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 20:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bllQi29/wQieco7A7Pqv0d1sxkjxrz1vhESpLLRiN5E=;
        b=oVYOZ5S2oQkSEUFtbnTAn0KFZQMI47x9vxsqjq4IPyhbkP7bGEnL3NT3JKxpSLHxuN
         k545pZ6wh8LrypxocYmdWv1lhtTUCXEMSf4/pg7k7z2RKI6JAp+Vk5lhQE0fTACjG2ev
         i7mIeO9FcetiLM53hXDN+QeqnklsUcm6b7BiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RBX1LQWJhWmiUd6BmjIAUTLu8FNmfFsXdcBOQI+BB0Qh38kXOyJ/lk3DrcUaYA2aZZ
         gD2988EO9Onam50RnytiULSv7H3kUZ5pM6rhz2pNpKNzWZVv+OrGdbtS3txCfzSDpRrL
         l3ZU8nTzmgPIJ2D7s+jGdsUmjWADDmIWKnCfc=
Received: by 10.150.169.14 with SMTP id r14mr10701575ybe.121.1263183204951;
        Sun, 10 Jan 2010 20:13:24 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4134672iwn.15.2010.01.10.20.13.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 20:13:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136601>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Here is a scenario I worry about:
>>
>> Suppose I have a change to main.c staged, to add a feature that othe=
rs
>> have discussed as well.  After a short distraction, I return and run
>> =E2=80=98git pull=E2=80=99 to see what upstream has been working on.
>
> If your index is dirty, any "mergy" operation will refuse to work *be=
fore*
> touching anything, so you won't use "git reset --merge" to begin with=
=2E

Yes, that is true.  And I was not worried about that.

As the git-merge manual explains:

| A merge is always between the current HEAD and one or more commits
| (usually, branch head or tag), and the index file must match the tree=
 of
| HEAD commit (i.e. the contents of the last commit) when it starts out=
=2E In
| other words, git diff --cached HEAD must report no changes. (One exce=
ption
| is when the changed index entries are already in the same state that =
would
| result from the merge anyway.)

The potentially problematic scenario for "git reset --merge" is this
last one, where a changed index entry is already in the same state
that would result from the merge.  Would a "git reset --merge" reset
the changed contents away?

> You are allowed to have local modifications only in your work tree.
> Furthermore, even git experts limit them to something they feel they =
can
> afford to lose and recreate easily if necessary.

Sadly, even a small change disappearing can be unnerving for an expert
and dangerous for a novice.

> You need to be able to tell the two ways in which a "mergy" operation=
 can
> "fail" apart [*1*].

Thanks for bringing this up.  The manual does not emphasize that
point at all, but it should.

Jonathan
