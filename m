From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [RFH] On a script for submodules
Date: Sun, 6 Jan 2008 10:06:08 +0600
Message-ID: <7bfdc29a0801052006g4d01ebc9mfb26f3829fc2a27f@mail.gmail.com>
References: <7bfdc29a0801030107t54ca45dbq167666b337f59a01@mail.gmail.com>
	 <7vsl1fs0xa.fsf@gitster.siamese.dyndns.org>
	 <7bfdc29a0801030152t25de6889wc21b9c933f5b9ab9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24115_2446703.1199592368814"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 05:06:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBMmX-0003qT-9r
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 05:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbYAFEGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 23:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbYAFEGM
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 23:06:12 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:54956 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYAFEGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 23:06:10 -0500
Received: by fk-out-0910.google.com with SMTP id z23so7907504fkz.5
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 20:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        bh=6NIVxVnxSv5eMLy4DSI+VrcHV9PM5xDf25AYWZFShxw=;
        b=lr1NMYxj1gsok75hW7DISr4bIByI9PZHYgq5IYoSSuIYkq701EV7A2lP43XJ3W2r7lJEKO6kKyWsEr7cwoNQ1nQf5FwQbj7h2GDQ7trvEUTYALoTIgk/OC5en65w+xvGqgeainELbApKWc/761LRQaPyN+DYrLEQJFdQz+O7eE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=JdeDzFOyKN3g2X5YJD5Y47eYKtC4zU4BgqQWApPfGQhagCjJFGeNG+hDUVq6/3euNtdOntHWo9BhK1ZhxSD/jIqZut1HOeHottkyOhZlXRDdS0vAjgzwRvrOfK9a+unKhjfBQJ12XnjOPWgdMQyD/8l79Iht9M0XJvgqJprqjDA=
Received: by 10.78.156.6 with SMTP id d6mr19496477hue.22.1199592368821;
        Sat, 05 Jan 2008 20:06:08 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Sat, 5 Jan 2008 20:06:08 -0800 (PST)
In-Reply-To: <7bfdc29a0801030152t25de6889wc21b9c933f5b9ab9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69710>

------=_Part_24115_2446703.1199592368814
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I updated the script to do git submodule init and update if not done
already while recursing; fixed some issues and converted it into sh
script from bash. Hopefully by tomorrow I will be email a merge of
this script with git submodule by adding a recurse command in addition
to the ones existing and also add a parameter --init-submodules to the
git-clone command so that when cloning the git submodule init and git
submodule update is done internally.

I would be grateful if you would kindly provide your feedback.

Best regards,

Imran

On Jan 3, 2008 3:52 PM, Imran M Yousuf <imyousuf@gmail.com> wrote:
> Hi all,
>
> Sorry for referring to the blog. I am writing the details here again
> and also attached the script in the email.
>
> I am fairly a new git user; I started working around with GIT on
> Framework development project and I noticed that GIT commands executed
> on the parent module is not propagated to the child modules. In some
> use cases it would be extremely useful (at least for me) to be able to
> be propagate a command from the master module to all its child at all
> depth. I wrote the bash shell script (in the attachment) to simply
> propagate commands from parent to its child. To use this script one
> can simply do the following (I am assuming that the file will have the
> name git-modules and will be an executable in $PATH):
>
>     for: git-pull
>     do: git-modules pull
>
>     for: git-status
>     do: git-modules status
>
>     for: git-commit -a -m "This is a test commit"
>     do: git-modules commit -a -m "This is a test commit"
>
>     for: git-checkout master
>     do: git-modules checkout master
>
> Basically any git-X command can be simply be done as "git-modules X
> args-as-usual".
>
> It is mainly different from the git-submodule command in its usage. I
> mainly wrote it to propagate commands. It could be extended for
> further usage as well.
>
> I would really appreciate and welcome criticism, feedback and addition
> to the script.
>
> Thank you,
>
> On Jan 3, 2008 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> > "Imran M Yousuf" <imyousuf@gmail.com> writes:
> >
> > > ... I would really appreciate if someone would take their time to
> > > suggest me improvements. I would also like to get some feedbacks as
> > > what else could be added here. A brief description can be found in the
> > > following posting.
> >
> > Around here, it is customary to have discussion on-list, not
> > pointing at external web pages and repositories.  I would
> > suggest starting by stating what the overall design is and how
> > it meshes with existing git-submodule command and its design.
> >
> >
> >
>
>
>
> --
> Imran M Yousuf
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557

------=_Part_24115_2446703.1199592368814
Content-Type: application/octet-stream; name=git-modules
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fb3226rr1
Content-Disposition: attachment; filename=git-modules

IyEvYmluL3NoCgpBUkdTPTEKaWYgWyAkIyAtbHQgIiRBUkdTIiBdOyB0aGVuCgllY2hvIE5vdCBl
bm91Z2ggYXJndW1lbnRzLgoJZWNobyBFeGFtcGxlIFwiXDx0aGlzIHNjcmlwdFw+IHN0YXR1c1wi
IGZvciBcImdpdC1zdGF0dXNcIiAtIGdpdC1tb2R1bGVzIHN0YXR1cwoJZXhpdCA2NTsKZmkKCmlu
aXRpYWxpemVTdWJNb2R1bGUoKSB7CglpZiBbICEgLWQgIiQxIi8uZ2l0IF07IHRoZW4KCQllY2hv
IEluaXRpYWxpemluZyBhbmQgdXBkYXRpbmcgIiQxIgoJCWdpdC1zdWJtb2R1bGUgaW5pdCAiJDEi
OyBnaXQtc3VibW9kdWxlIHVwZGF0ZSAiJDEiCglmaQp9Cgp0cmF2ZXJzZU1vZHVsZSgpIHsKCWN1
cnJlbnRfZGlyPWBwd2RgCglkaXJfcGF0aD0iJGN1cnJlbnRfZGlyOiRkaXJfcGF0aCIKCWluaXRp
YWxpemVTdWJNb2R1bGUgIiQxIgogICAgICAgIGNkICIkMSIKCWVjaG8gV29ya2luZyBpbiBtb2Qg
JDEgQCBgcHdkYCB3aXRoICQyCiAgICAgICAgZXZhbCAiJDIiCglpZiBbIC1mIC5naXRtb2R1bGVz
IF07IHRoZW4KICAgICAgICAgICAgICAgIGZvciBtb2RfcGF0aCBpbiBgZ3JlcCAicGF0aCA9IiAu
Z2l0bW9kdWxlcyB8IGF3ayAne3ByaW50ICQzfSdgOyBkbwogICAgICAgICAgICAgICAgICAgICAg
ICB0cmF2ZXJzZU1vZHVsZSAiJG1vZF9wYXRoIiAiJDIiCiAgICAgICAgICAgICAgICBkb25lCiAg
ICAgICAgZmkKCW9sZF9kaXI9JChlY2hvICRkaXJfcGF0aCB8IGN1dCAtZCc6JyAtZjEtMSkKCWxl
bmd0aF9vbGRfZGlyPWBleHByICIkb2xkX2RpciIgOiAnLionYAoJY2QgJG9sZF9kaXIKCWluZGV4
PSQoZWNobyAiJGxlbmd0aF9vbGRfZGlyKzIiIHwgYmMpCglkaXJfcGF0aD1gZWNobyAkZGlyX3Bh
dGggJGluZGV4IHwgYXdrICd7cHJpbnQgc3Vic3RyKCQxLCAkMil9J2AKfQoKcHJvcGFnYXRlKCkg
ewoJcHJvamVjdF9ob21lPWBwd2RgCgllY2hvIFByb2plY3QgSG9tZTogJHByb2plY3RfaG9tZQoJ
aWYgWyAtZCAkcHJvamVjdF9ob21lLy5naXQvIF07IHRoZW4KCQlnaXRfY29tbWFuZD0kMQoJCXNo
aWZ0CgkJY29tbWFuZF9hcmd1bWVudHM9IiIKCQlmb3IgYXJnIGluICIkQCI7IGRvCgkJCWlmIFsg
YGV4cHIgaW5kZXggIiRhcmciICcgJ2AgLWd0IDAgXTsgdGhlbgoJCQkJYXJnPSJcIiRhcmdcIiIK
CQkJZmkgCgkJCWNvbW1hbmRfYXJndW1lbnRzPSIkY29tbWFuZF9hcmd1bWVudHMgJGFyZyIKCQlk
b25lCgkJZWNobyBHSVQgQ29tbWFuZCBnaXQtJGdpdF9jb21tYW5kIHdpdGggYXJndW1lbnRzXCgk
I1wpICIkY29tbWFuZF9hcmd1bWVudHMiCgkJbWFpbl9jb21tYW5kPSJnaXQtJGdpdF9jb21tYW5k
ICRjb21tYW5kX2FyZ3VtZW50cyIKCQlldmFsICRtYWluX2NvbW1hbmQKCQlpZiBbIC1mIC5naXRt
b2R1bGVzIF07IHRoZW4KCQkJZm9yIG1vZF9wYXRoIGluIGBncmVwICJwYXRoID0iIC5naXRtb2R1
bGVzIHwgYXdrICd7cHJpbnQgJDN9J2A7IGRvCgkJCQl0cmF2ZXJzZU1vZHVsZSAkbW9kX3BhdGgg
IiRtYWluX2NvbW1hbmQiCgkJCWRvbmUKCQlmaQoJZWxzZQoJCWVjaG8gJHByb2plY3RfaG9tZSBu
b3QgYSBnaXQgcmVwbyB0aHVzIGV4aXRpbmcKCQlleGl0CglmaQp9Cgpwcm9wYWdhdGUgIiRAIgo=

------=_Part_24115_2446703.1199592368814--
