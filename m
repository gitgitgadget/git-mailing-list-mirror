From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git-p4 issue
Date: Fri, 15 Apr 2011 16:39:54 -0400
Message-ID: <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
	<BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QApoJ-0006fE-Dc
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 22:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab1DOUj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 16:39:56 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43590 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784Ab1DOUjz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 16:39:55 -0400
Received: by qwk3 with SMTP id 3so1616049qwk.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Naijk0VvzeO3ebKqeTT0ovY4B0ukFH4pT7dB32hD/qg=;
        b=oXCR1GlgSbqYueK/5afQS5ktHrMKMxPo5O3IGF+BSixV5Proz7zfr8/g58+4BhMVJ1
         +WsITj8rTGxALeyW9MrW5bY8p1ZWXFYiV22Le50v75cXHFjSVAzedGBfnzaHXOwJVhyc
         UgJZAOAySdupotlGJ5wzooIyJw8JSBVpuJSFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ZNBQUuy9cMcUco8yFoiwbPTGhTcsLeCrEjoabzcSf9d3TaaTtJcPGKERiWQS2uRfdi
         YeLJb8Zfi+bwJQO9wEU9JG/3ajq7iMQBLDSHYaHmIrP8Uqs2wM8tw/qub+iXZy+34iDV
         YYgbmbFUFhqX1PhhW72mmEk71Jx/d96b9Dfqw=
Received: by 10.229.49.140 with SMTP id v12mr1835482qcf.80.1302899994657; Fri,
 15 Apr 2011 13:39:54 -0700 (PDT)
Received: by 10.229.247.204 with HTTP; Fri, 15 Apr 2011 13:39:54 -0700 (PDT)
In-Reply-To: <BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com>
X-Google-Sender-Auth: TjnYql35xspMaxAg_qCcPSYCl3s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171640>

I am sure that is a common mistake people make, but not in this case.
I have been using it successfully for a while now, it just suddenly
stopped working, not sure what changed.  I am not seeing anything on
remotes/p4/master either, and I was originally doing rebase and went
back to sync so I could run "--verbose" and see if it was even
downloading those changes.  I can clearly see it says it is
downloading them, but then they just don't end up in git.

Since I don't see an error message about it failing to sync, I am at a
loss to figure out why it says it succeeded, but it didn't.  Could
there be one step in the code that is not catching an error condition?
 I am not all that familiar with Python, but if someone could point me
where to put some debug messages, I can do some testing.

Thanks,

Mike



On Fri, Apr 15, 2011 at 4:22 PM, Tor Arvid Lund <torarvid@gmail.com> wr=
ote:
>
> On Fri, Apr 15, 2011 at 5:00 AM, Michael Horowitz
> <michael.horowitz@ieee.org> wrote:
> > Pete,
> >
> > I was hoping you could help me out again.=A0 After using git-p4 for=
 a
> > while without a problem, it has suddenly stopped working for me.=A0=
 I am
> > using the latest master.=A0 I haven't seen any recent changes that =
I
> > think could have caused this, but maybe you'll have some insight.
> >
> > The issue is that when I do a git-p4 sync on my existing repository=
,
> > it reports success, but seems to do nothing.=A0 It does not downloa=
d the
> > latest changes from p4.=A0 If I delete my repository and start over=
, it
> > will download all the latest changes, even the ones it was not
> > downloading previously, but if I try to sync again later, it does n=
ot
> > do anything.=A0 I tried running it with the "--verbose" mode, and I=
 see
> > it says it is loading each of the changes, but they are not ending =
up
> > in the git repository, and it is not reporting any errors.
>
> Hi, Michael.
>
> Is it possible that you expect that 'git p4 sync' should update your
> working branch and/or working tree? Assuming a simple clone with a
> local master branch, running 'git-p4 sync' will update the branch
> remotes/p4/master, but it won't do anything on my working master
> branch...
>
> Maybe you want to call 'git rebase p4/master' afterwards, or use the
> shorthand 'git p4 rebase' to do a sync+rebase.
>
> Regards,
> Tor Arvid.
>
> > Any ideas of what this could be?=A0 Is there anything else I can ru=
n to
> > help debug this?
> >
> > Thanks,
> >
> > Mike
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
