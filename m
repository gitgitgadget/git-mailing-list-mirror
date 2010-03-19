From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: About single user setup for lightweights
Date: Thu, 18 Mar 2010 22:13:53 -0400
Message-ID: <32541b131003181913v7319d6a1ydd72c0177729dbf4@mail.gmail.com>
References: <87r5nht6uf.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bazaar@lists.canonical.com,
	mercurial@selenic.com
To: Harry Putnam <reader@newsguy.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 03:14:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsRjC-0001HR-AM
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 03:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab0CSCOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 22:14:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47085 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab0CSCOP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 22:14:15 -0400
Received: by gyg8 with SMTP id 8so1351942gyg.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lf7wVohCgEfryHYgPv2XZ+2u2UbP+q/EZROGwGR84xQ=;
        b=m9FqKWmVoQhsHguTzB5N6d108RDruns4H08iNx61lSaiBz7/RbKogUUaFxpYMcx0f3
         IJ8tD+iZBn/ZUv8zmKVl/zh9zW/N63v9pgNmJeflnqF3iLP8OXl7sdL3R9RGwsWoevWk
         QTy5huJ4CKPgpx+DWWkXxt9gJ52JxHIdp7BSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Xhn2Ut+nSduXRuOrXTO7KdZAFSuzRdeZE+YFwjtCu4vdTC/NVUewHzGvYZtMPYojop
         rkdBRK7jDjZvUVbpniRoeJ4NflvOldPF1PPeUsEvUZ/vpQEapICUnMnaty2VRLVhRdu8
         ieNfUtDEm+i4RY9ScCHxxgKH7WPpbaz8wrupQ=
Received: by 10.150.252.2 with SMTP id z2mr2686166ybh.41.1268964853128; Thu, 
	18 Mar 2010 19:14:13 -0700 (PDT)
In-Reply-To: <87r5nht6uf.fsf@newsguy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142555>

On Thu, Mar 18, 2010 at 9:53 PM, Harry Putnam <reader@newsguy.com> wrot=
e:
> I keep a central cvs repo and on each host I do a check out of the
> entire thing from the base up. =A0Mostly to have copies of various st=
yle
> of rc files the =A0OSs need but also to keep the scripts I've written
> over the years and learned to rely on, available and in sync.
>
> To me, keeping up with cvs is always a PITA. =A0I've never hit on a
> handy and efficient way to do it. Even for a just my light usage.
[...]
> How would a workflow actually go:
> I'd create and populate a repo, then what?. =A0Create clones on each
> machine I guess and if I found a need to change or add files, I'd the=
n
> push back to the original repo? =A0Its sounding a whole lot like cvs =
so far.

Yes.  Or you could skip the central repo and pull directly from one
machine's working tree to another.  If that has any value to you, then
it's the only likely reason a DVCS would do you any good for this
trivial case.

The real question is: what makes your current setup a PITA?  If you
can't answer that concisely, then you don't know what to look for in a
supposedly better solution.

> Anther thing I'm really curious about concerns binary rcs. =A0I'm thi=
nking
> of photo editing and things like flash where I might be changing a
> project over time and want access to past versions.
>
> I'm told cvs is not good for that... consequently I've never tried
> it. =A0Am I likely to find that one of git, mercurial or bazaar is fa=
r
> better for that?

git sucks at handling large binary files (>50 megs or so) unless you
have boatloads of RAM.  If your binary files are moderately sized (a
few megs) then it'll probably be reasonably efficient.  I don't know
about hg and bzr for memory usage.

It's better to store uncompressed binary files (eg *.tar) instead of
compressed ones (*.tar.gz) in order to allow useful delta compression.
 That means raw images instead of png/gif/jpg.  And probably completed
flash files are compressed.  The best thing to do is actually try it
and see if your repository size and memory usage is reasonable.

Have fun,

Avery
