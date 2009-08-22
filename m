From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: hitting home directory's parent
Date: Sat, 22 Aug 2009 11:10:18 +0700
Message-ID: <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com>
References: <20090821200503.GA19660@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 06:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mei1V-0006lc-Ap
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 06:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbZHVEKi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 00:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbZHVEKh
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 00:10:37 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:43567 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZHVEKh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Aug 2009 00:10:37 -0400
Received: by ywh3 with SMTP id 3so1646923ywh.22
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 21:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0czX6Wm2LZC7NWrrECrZ9xwKQIXgUQimroOoN+Th6Jc=;
        b=l2woYfB+jhBKiBU/o0U2P2GNNvEBY7z0qBG/r7+B+fHQmSji2swqu4y7HvH1jNPiTq
         4gG9tRcaJY5ZI35L4ra7Gum73QpuGN5XmuM5G8y57HiV8DSecmrlEtshKltFJbNtgb8r
         huzIRELSTcAiz35i4XWwt2ReNFcltyT6EXC1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QKmPmYI76Ox7Y8yQNxcEkHgFDhw9QoUm0eSPShCvKXrcyQ5aMY/nrJQz/EIc59GTFp
         9fOWb0Ha+6f83PNm9h6fuNE0GkZn4cFXfuYza3NMNBN/ZnLUHzIsQfaZjmDoMuyUEdUh
         t2KQ0IMj8inbpC/1EIQqI8A1HWFgzkM3k5W2k=
Received: by 10.101.88.1 with SMTP id q1mr2011922anl.177.1250914238217; Fri, 
	21 Aug 2009 21:10:38 -0700 (PDT)
In-Reply-To: <20090821200503.GA19660@panix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126782>

On Sat, Aug 22, 2009 at 3:05 AM, Daniel
Convissor<danielc@analysisandsolutions.com> wrote:
> Hi:
>
> I just installed git in my Cygwin installation for the first time. =C2=
=A0The
> git version is 1.6.1.2, which is the latest version they have. =C2=A0=
When I
> enter one of the following commands:
> =C2=A0 =C2=A0git --help
> =C2=A0 =C2=A0git config --global user.name "Daniel Convissor"
>
> I get this error:
> =C2=A0 =C2=A0fatal: Cannot change to /home/danielc/..: Permission den=
ied
>
> Though "git --version" executes fine.
>
> I've been using Cygwin for many years and no other program has ever
> produced this issue for me. =C2=A0For example, svn --help, ls --help,=
 etc work
> just fine.
>
> Why is git venturing into to the home directory's parent directory? =C2=
=A0Is
> this a bug? =C2=A0If not, is this really necessary?

I guess it tried to find .git directory upward. I think you can set
GIT_CEILING_DIRECTORIES to make it stop at /home/danielc. Excerpt from
git.txt

-'GIT_CEILING_DIRECTORIES'::
        This should be a colon-separated list of absolute paths.
        If set, it is a list of directories that git should not chdir
        up into while looking for a repository directory.
        It will not exclude the current working directory or
        a GIT_DIR set on the command line or in the environment.
        (Useful for excluding slow-loading network directories.)
-
Duy
