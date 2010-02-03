From: Eugene Sajine <euguess@gmail.com>
Subject: Re: aborting rebase -i right at the start, was Re: [BUG] - "git 
	commit --amend" commits, when exiting the editor with no changes written
Date: Wed, 3 Feb 2010 11:02:35 -0500
Message-ID: <76c5b8581002030802h7be8c1b2k6aa41ba7e9db0f2b@mail.gmail.com>
References: <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	 <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	 <40aa078e1002021616s3098bf53la6af93ab0949e7e@mail.gmail.com>
	 <76c5b8581002021655k5f63b81h1c55ae87625fbfc5@mail.gmail.com>
	 <20100203015947.GA4280@neumann> <vpqaavqkc1s.fsf@bauges.imag.fr>
	 <alpine.DEB.1.00.1002031006570.3099@intel-tinevez-2-302>
	 <20100203094144.GM15202@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	kusmabite@gmail.com, Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 17:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nchgf-00022Y-M5
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 17:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374Ab0BCQCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 11:02:36 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:61456 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747Ab0BCQCg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 11:02:36 -0500
Received: by iwn1 with SMTP id 1so786060iwn.24
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aRtIZMwKLsP9f8USoP7DUMpgSKXNbe20WgtBAfHG7cs=;
        b=l3Eg0wWTQ4bLZTMUvGPjQIYMMVBQk2hzW1TAWEOOK6yRYSTYqWkVLc+RW9Qq26tRsD
         grMZGMlTzIpuetkd43qU46OTifN35GzpLgFF1KmnXgSrIiBCjfrDF6Qz8P/FI/OpIS+A
         RYzmezG1RrS04TBcu9DKvkmV3Qk+Vt4s7VZgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MjvI4P4ebSbCPCju6KSpr/C3uVUU/8/3RBcjeiFz9d4IE7F1yqtKRrR9uoe5OG/TxV
         3NuUIYav0x1DcNDFQcB5mHI/k3dXf3jvlt24CoO/l25UslmY3/Us/yPb3aWKU82e/P93
         7SivHxuan1tNUvcIS2Z5RAlrfF6WKlBS6ReXI=
Received: by 10.231.150.2 with SMTP id w2mr6209784ibv.83.1265212955226; Wed, 
	03 Feb 2010 08:02:35 -0800 (PST)
In-Reply-To: <20100203094144.GM15202@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138843>

2010/2/3 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Wed, Feb 03, 2010 at 10:08:50AM +0100, Johannes Schindelin wrote:
>> Hi,
>>
>> On Wed, 3 Feb 2010, Matthieu Moy wrote:
>>
>> > Strictly speaking, an empty [rebase -i] todolist should mean to dr=
op all
>> > the patches (like a todolist with just one line would mean to drop=
 all
>> > the others). But a user never wants to do that (otherwise, "git re=
set"
>> > would be the right command), so "git rebase -i" considers it as a
>> > special case.
>>
>> Actually, it is a design bug, but it was the only sane way I could t=
hink
>> of aborting the rebase.
>>
>> Note that there _are_ users who want to do that ("let me see what co=
mmits
>> I have, ah, oh, okay, I want none of them"). I am one of those.
>
> I regularly mess up the todo file so badly that I don't want to bothe=
r
> with undo but rather start over from the beginning.
>
>
> Best,
> G=C3=A1bor
>
>

I already described the solution which i think should be implemented
in old thread I will just repeat it here for easier tracking:

The solution should be as Avery proposed - to monitor file
modification timestamp as well as the content.
Timestamp should be remembered by git when editor is fired up and then
checked when you're exiting the editor. If it is the same - it means
that user canceled the whole operation by *not* confirming the file
content by save. If the timestamp is bigger than the saved one and the
message is not empty - we can proceed.

I.e. in case of rebase -i you will be able to abort the operation by
simply exiting the editor without save in any state at any moment and
start from the beginning.

Thanks,
Eugene
