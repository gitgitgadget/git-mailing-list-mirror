From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 18:41:44 +0200
Message-ID: <CAHGBnuPc+vDwejFOF_o+jr+L_mgrVo=Uxs2vC6C-Feg_uxWPpA@mail.gmail.com>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	<7vzjubtty7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, msysGit Mailinglist <msysgit@googlegroups.com>, 
	Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDZMLEGXWQLBBSOWWGHAKGQEMGRMJUY@googlegroups.com Thu Jun 27 18:41:49 2013
Return-path: <msysgit+bncBDZMLEGXWQLBBSOWWGHAKGQEMGRMJUY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f189.google.com ([209.85.215.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBSOWWGHAKGQEMGRMJUY@googlegroups.com>)
	id 1UsFGW-0002Zp-Lc
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 18:41:48 +0200
Received: by mail-ea0-f189.google.com with SMTP id z7sf212350eaf.26
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:mime-version:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=/mtESj18Dt7EAY/bDQTxvyXLoXVU4bHzsei0AW6g2o0=;
        b=r/r61ek2h4RNkXccps3UPudfVPAvvrVTLEyi7PR6QLfs9dzWhmrG9ra/8m7fbOacR7
         dpCMXWEhs9R67xcWpAAcJ2ofN0Ac7yio64iuSI4QgyQ+ceGI28X30OcT5z6Sic7szoNd
         WDih2BGxRLbSFUgE+hN0Gc8NzIM8fS63/5FB74Mc1Z5A4EiFhHR3EqBMdcl3uj7Cdeda
         YXe6YVdjJdpQZ6Vxfeyi5ghoosd3UdybQGwyNM7ssFn0JwEpPszzJ3itcsXtXhQYx9Oo
         h5PAnRGg/1nTIM3niiCdzpIFHLm9P+BE2IalzGM+OXZe+/W6xyeBVLLjXh9MLvq2LaSY
         WJew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-beenthere:mime-version:in-reply-to:references:date:message-id
         :subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=/mtESj18Dt7EAY/bDQTxvyXLoXVU4bHzsei0AW6g2o0=;
        b=jVaRXLgaz6IEz/3/B+KHd2mo3h4JxWPH+k2wPWPSwFst4S6Rdpvw601oxkeNiG4scY
         3+mtbUiw40+k4YbEp0XGTevgOJuH5dxFIvCk9UvsqAYALt6DNctTHM9V/mhRdWp3fvZb
         BzMwu+07udYtJaKBzscKEdYhPw55PLlodVYYPsL+o8KC7MM10XZPtcjNvuyBrATlafnH
         xl1Sbz5jBeuqaWQwfH7DnEeixLVVdCZ7MfQwiUWKroRUDqq4cRaNSH2AmM9/di+6+gIu
         Y2uQna7B17AWwible3PaxnkM0QQp3XcHopC50vUoqJLcZ6i7b3qj3Il1z7+xsZv70fjU
         P/1A==
X-Received: by 10.180.76.110 with SMTP id j14mr805275wiw.20.1372351308264;
        Thu, 27 Jun 2013 09:41:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.205.202 with SMTP id li10ls1425556wic.44.canary; Thu, 27
 Jun 2013 09:41:45 -0700 (PDT)
X-Received: by 10.204.224.8 with SMTP id im8mr324011bkb.5.1372351305295;
        Thu, 27 Jun 2013 09:41:45 -0700 (PDT)
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com [2a00:1450:4010:c03::236])
        by gmr-mx.google.com with ESMTPS id cx8si157856bkb.0.2013.06.27.09.41.45
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 09:41:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::236 as permitted sender) client-ip=2a00:1450:4010:c03::236;
Received: by mail-la0-x236.google.com with SMTP id ec20so1068648lab.41
        for <msysgit@googlegroups.com>; Thu, 27 Jun 2013 09:41:45 -0700 (PDT)
X-Received: by 10.152.44.170 with SMTP id f10mr4488918lam.68.1372351305115;
 Thu, 27 Jun 2013 09:41:45 -0700 (PDT)
Received: by 10.114.16.161 with HTTP; Thu, 27 Jun 2013 09:41:44 -0700 (PDT)
In-Reply-To: <7vzjubtty7.fsf@alter.siamese.dyndns.org>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c03::236
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229119>

On Thu, Jun 27, 2013 at 6:11 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Call built-in commands via the main executable (non-dashed form) without
>> relying on the aliases (dashed form) to be present. On some platforms,
>> e.g. those that do not properly support file system links, it is
>> inconvenient to ship the built-in aliases, so do not depend on their
>> presence.
>
> In principle I have no problem with this change, if nothing other
> than for consistency reasons.  We tell users to write "git foo", and
> we tell users to say PATH=$(git --exec-path):$PATH if they want to
> write "git-foo", but we do tell them we prefer 'git foo' form.  We
> should do so ourselves where it is reasonable.

Consistency was indeed one of my intentions, though maybe not the primary one.

> I vaguely recall that some people may have argued that git-foo is
> one less exec(2) when we left these in our scripted Porcelains,
> though, so on a platform with poorly performing fork/exec, this
> change may be seen as detrimental.  I do not know it matters that
> much.

But isn't this only true for commands that are not built-ins? I.e., I
can see how calling "git-pull" from a script is more efficient than
calling "git pull" from the same script, because "git pull" would
first execute "git" which in turn would spawn a shell to run the
"git-pull" script. But calling e.g. "git-merge" and "git merge" should
use almost the same code path in the "git" executable and not
fork/exec at all because the merge command is built in, right?

> Having said all that, I do have a huge issue with the justification
> in the proposed log message.  If your plan is to make this:
>
>         $(git --exec-path)/git-ls-files
>
> not to work with your port of Git, that implementation is _broken_
> and is not a Git anymore.

I would at least like to have that option, yes, well knowing that such
a port would not be considered to be a Git anymore. A typical use-case
would be a "portable" Git for Windows, which is surprisingly popular.
Such a portable version usually just ships as an archive without any
kind of installer. The ZIP archive format on Windows does not support
storing any kind of file system links, which means all executables for
built-ins would need to be added as copies to the archive. While that
does not add much to the archive size because all such files are equal
to git.exe and thus compress well, the big surprise comes when
extracting that archive as all the copies of git.exe make such a
portable installation unnecessary big. On Windows, git.exe is about
1,34 MiB in size, which sums up to about 146 MiB of extra storage
required if you have copies for all the built-ins instead of file
system links.

> Git can evolve over time, and if that is really your plan, the first
> step you have to take is to revive the old discussion we had after
> v1.6.0:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/93511/focus=93825
>
> and see if it is now a good idea.  It could be in year 2014.  It was
> not in 2008.

Can I get around that discussion by adjusting the reasoning for the
patch to mention consistency?

> I cannot apply this exact patch for an obvious and unrelated reason;
> it seems to have changes, e.g. "git am" option help, that do not
> have anything to do with the topic.

Well, if the topic was consistency the changes would be related, or?
As you were saying yourself, we tell users to prefer the "git foo"
form, so we should also do so in the "git am" option help, IMHO.

> For a future reroll of this patch with only "git-foo -> 'git foo'",
> I would appreciate an independent review by at least one set of
> eyes.  It is very easy to blindly do this conversion with sed/perl
> and fail to spot misconversion before sending it out.

At least the test suite (running on Linux) did not throw any failures
at me after applying this patch.

-- 
Sebastian Schuberth

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
