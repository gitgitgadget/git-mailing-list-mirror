From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How to trim the fat on my log graphs
Date: Wed, 23 Apr 2014 14:59:26 -0500
Message-ID: <CAHd499Cw8=FMctRA49MUi+vP2gvMyXH9WgcfCKK_MrKDEOfvjw@mail.gmail.com>
References: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
	<xmqqtx9l2ggp.fsf@gitster.dls.corp.google.com>
	<CAHd499AovROt2fVAvh-ST9Vb7Hq8LpUS68i4eXWZaNszuKeUfg@mail.gmail.com>
	<xmqqha5k0x8c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 21:59:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3KU-0003uU-I6
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758008AbaDWT7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:59:32 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:37567 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462AbaDWT71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:59:27 -0400
Received: by mail-vc0-f171.google.com with SMTP id lg15so1819740vcb.30
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Na19n7+AzkBpyZOdvpTb/YqzYUyqNLdOHmo0CflqMuw=;
        b=qVaauKDqBO7n+/zHHzADL8ganXJGl26KP/WON0rsc93GiywV6xKKmqUG5BCDfnXtEu
         MYagAGptugt356MdkP2VaVlJ+4LiYhKG9miYuDsxTLcuNe9Cu1mvIjGgYgsbQnAseyAv
         KLePfSfVIioWjC6TjrEtlCCzSP3hFS1Z9PVNynM8VCJGbrF4LpS/GEtk678rKqB+Gb4b
         Jau4zk+wrYyWdwKoCxW7v3O3cT5Lw8gHfH8SKcW4PEZZH1tZ+Un7GiSHUvW5L0FHbDzI
         PfyZ7+lClgM1hjW1yWXRgaMogYjtPiIcpc3LKnRF5bHbZ76OGpdeUuYUSlQHV3mlWs0N
         qB9A==
X-Received: by 10.220.12.66 with SMTP id w2mr41638924vcw.15.1398283166906;
 Wed, 23 Apr 2014 12:59:26 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Wed, 23 Apr 2014 12:59:26 -0700 (PDT)
In-Reply-To: <xmqqha5k0x8c.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: r2Q24MxPSdAVbJDDdzizYqtReEs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246879>

On Wed, Apr 23, 2014 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
> [Administrivia: because people read from top to bottom / why is it
> bad to top-post? / please do not top-post.]
>
>> On Tue, Apr 22, 2014 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Robert Dailey <rcdailey.lists@gmail.com> writes:
>>>
>>>> git log log --graph --abbrev-commit --decorate --date=relative
>>>> --format=format:'%C(bold blue)%h%C(reset)%x09%C(bold
>>>> green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
>>>> white)%an%C(reset) - %C(white)%s%C(reset)' --branches --remotes
>>>> ...
>>>> The goal is to weed out the really distant and irrelevant commits. I
>>>> really just want to see the commits that are closely related to my
>>>> current branch. Thanks in advance.
>>>
>>> For a starter, how about dropping "--branches --remotes" from that
>>> command line?  A merge from elsewhere will show as "Merge branch foo"
>>> which should be sufficient without the decoration.
>>
>> Thanks, removing those two options did help quite a bit already.
>> However, the history can still get pretty crazy. Is there a way to
>> hide all tags from the log graph? Really I just want the LABELS to be
>> hidden.
>
> As you had --decorate and a lot of %C(cruft), I was assuming that
> you do want to see all the bells and whistles when I suggested to
> omit --branches and --remotes.
>
> If you do not want --decorate, I think you can omit that from the
> command line without changing what the output means.

I referred back to the documentation for --decorate:

--decorate[=short|full|no]
Print out the ref names of any commits that are shown. If short is
specified, the ref name prefixesrefs/heads/, refs/tags/ and
refs/remotes/ will not be printed. If full is specified, the full ref
name (including prefix) will be printed. The default option is short.

since default is short, and its documented to exclude tag names, I
would expect them to not be there. I also tried removing it to test
but i saw no difference; tag names are still visible.
