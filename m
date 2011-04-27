From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 27 Apr 2011 14:21:35 +0200
Message-ID: <BANLkTimLnggco_+mQZ2_T_myAHsDD-=g1w@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org> <7v62tjs66r.fsf@alter.siamese.dyndns.org>
 <20110120203840.GA11468@sigill.intra.peff.net> <7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
 <20110120215456.GB11468@sigill.intra.peff.net> <AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
 <7vk4hyp38i.fsf@alter.siamese.dyndns.org> <AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
 <AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
 <BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com> <BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
 <BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com> <BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
 <BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:22:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF3km-0003mo-7B
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976Ab1D0MV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 08:21:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54181 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221Ab1D0MVz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 08:21:55 -0400
Received: by pzk9 with SMTP id 9so999204pzk.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=nOfzk+UTrlDdcwC0+msPrSV45tNykagbQxBSPo5zJZw=;
        b=QcGT8sJlO0GnAzYlHXYpUnKzNChpLAowfPvBCIt9XQu9pnh/k72c2damEUIn/tE5FP
         lkY/lnrDvTGmVlHP4QYgAJP9v2IqbxFf0obS2g7+xT8Pp75Zq+qzUzRWcK59np4s3khA
         d546m6A2Ch8UQKN5A6MIYygGK2YWOrZHlFJgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=vhkzVzfeRPLO66MeDLaCG2XkfiKKYN7hTyfNwlBVL3FiZvQM1FzrZtrTWLve76sKp3
         U9y2V6gYJPfEG04JCPzxlD9okIaI3YZ0Ie0i8RC8WdbuO4aagpj7K60rrR/0U4z9o0yY
         MSBbd96txWuUo/Ci6bT/WgOJQ5UwL/FXBUdls=
Received: by 10.68.4.38 with SMTP id h6mr2091854pbh.422.1303906915128; Wed, 27
 Apr 2011 05:21:55 -0700 (PDT)
Received: by 10.68.46.5 with HTTP; Wed, 27 Apr 2011 05:21:35 -0700 (PDT)
In-Reply-To: <BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172229>

On Wed, Apr 27, 2011 at 1:29 PM, Stephen Kelly <steveire@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 11:48 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> No problems here:
>
> I had another go.
>
> mkdir remote
> cd remote/
> git init --bare
> cd ../
> git clone remote/ alice
> cd alice/
> echo test >> file
> git add file
> git commit -am w
> git push origin master
> echo test >> file
> git commit -am w
> git branch HEAD

I'll stop you here. You reproduce the issue a lot simpler:

git init foo &&
cd foo &&
echo "foo" > bar &&
git add bar &&
git commit -m. &&
git branch HEAD &&
gitk

No need to involve remote branches. While remote branches makes the
issue worse, because you can get in a situation where gitk doesn't
when someone else made a nasty branch, and you fetched it.

The real problem is that "git rev-parse HEAD" outputs "warning:
refname 'HEAD' is ambiguous." to stderr (even if stderr is a non-tty),
and gitk does not like that.

This can be fixed by either doing "git -c core.warnambiguousrefs=0
rev-parse HEAD", which strikes me as ugly, or by making sure that we
don't issue this warning when not attached to a tty:

diff --git a/sha1_name.c b/sha1_name.c
index faea58d..c7e855e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -391,7 +391,7 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
 	if (!refs_found)
 		return -1;

-	if (warn_ambiguous_refs && refs_found > 1)
+	if (warn_ambiguous_refs && refs_found > 1 && isatty(2))
 		warning(warn_msg, len, str);

 	if (reflog_len) {
