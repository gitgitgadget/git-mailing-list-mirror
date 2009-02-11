From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 21:34:07 +0200
Message-ID: <8e04b5820902111134o73f0cbc9gc25aeaae9a267f9a@mail.gmail.com>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
	 <20090211180559.GC19749@coredump.intra.peff.net>
	 <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
	 <20090211184429.GA27896@coredump.intra.peff.net>
	 <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
	 <20090211191445.GU30949@spearce.org>
	 <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
	 <7vd4doepvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:35:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKs5-0001vO-HD
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbZBKTeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120AbZBKTeL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:34:11 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:55173 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZBKTeK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:34:10 -0500
Received: by bwz5 with SMTP id 5so523890bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 11:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nkgMtQTsb43LBBgkP3Cm/RsLkIus1XRknB6EiWgqR5U=;
        b=EgvZbmGBhXblzvgRgVGgtji3ByXknWCYgm5izJbfXAAvEVM1Qp4sfzQdfb/3d27Fok
         lryqZ4duUGDKaEaRFVOElPjBaBgaGuGidBU2IcEvbobgoOVhbST18bo6woxi5GA1gJUE
         Qz5gtmQ2VKY8L8o8lPAH+cStNQ8Js97TXcsfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U/7k/VH1Pp/wVqV/OAdyu4MN1x/T3JGIwJR7G31P9CnKF2kthez/ZLxm5Ujy6wiXLH
         8mYddLwFXvIKyfFqVhBCvVx1ZGg/o2Sxe4JTVPICjdyG+gZrbwuWkj/VpXrsGjCxaRj5
         EXYHFkZdmGDcFTalc/JQtyq6q7FQOL/MLcNWI=
Received: by 10.181.193.15 with SMTP id v15mr1616862bkp.168.1234380847196; 
	Wed, 11 Feb 2009 11:34:07 -0800 (PST)
In-Reply-To: <7vd4doepvb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109513>

On Wed, Feb 11, 2009 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> writes:
>
>> On Wed, Feb 11, 2009 at 9:14 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>> "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> wrote:
>>>>
>>>>     Here is what I'm trying to accomplish: I want to add to the git
>>>> search path also the folder ${GIT_DIR}/bin if this already exists...
>>>> (This allows me to have repository specific commands...)
>>>
>>> for f in `cd $(git rev-parse --git-dir)/bin && ls *`; do
>>>  git config alias.$f '!$(git rev-parse --git-dir)/bin/'$f
>>> done
>>>
>>> No need to patch git.
>>>
>>> --
>>> Shawn.
>>
>>     :) Yes I know about the alias trick...
>>
>>     But I find it easier to just create a bin folder and drop my
>> scripts there... (For example git-branch-import that takes a new
>> branch name and an URL and creates the branch with no ancestry and
>> knows http, ftp, svn, tar.{gz,bz2}, zip, etc...)
>
> And why isn't it in $HOME/bin/?

    No, it is inside .git/bin folder. I like to think to my bin folder
like the hooks folder... This way when I move a repository I move the
hooks and the specific commands.

    Ciprian.
