From: Stefan Beller <sbeller@google.com>
Subject: Re: What's the ".git/gitdir" file?
Date: Tue, 27 Oct 2015 15:54:02 -0700
Message-ID: <CAGZ79kaXdjxT2jbHGHYPN0Bnk_4ZFrPo0sXKUrVvynoMfLPjCQ@mail.gmail.com>
References: <87a8r4ary9.fsf@kyleam.com>
	<CAGZ79ka0XvmvVpX5WrpeEBXBWKA41RTZm4p7q=QtUTFy18hkoA@mail.gmail.com>
	<017901d11108$ceb2cd10$6c186730$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Kyle Meyer <kyle@kyleam.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 23:54:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrD86-0004Je-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 23:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbbJ0WyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 18:54:05 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36740 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbbJ0WyE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 18:54:04 -0400
Received: by ykba4 with SMTP id a4so229126563ykb.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TOFvUtTpSZQYQv3TpDRP9kVtH5o12KXMo9MY6xIO2DQ=;
        b=LdtuT6YDWRhIYN3OIaRbFmNjHqh3YllA/wG+vO3Tbmgvu/ChGVrLzm3jCfVlgjJMJH
         PrpSVgDjsyupFtTd6oxkUr3e9eakUGMDvBc2ZBXdDmJd1lF/hPqga+7FzvFD27wkvBZy
         gjM8mNE31w06ungTfvnA23t6uHjUY9ZO4ChVVU/eZTYpoBj4CQqUGH8G1dtQWa9xWeTN
         owytoMF1+0/JXoxaNnFj6n1mSfVArXNWs2kBa/+VWcPiRHXZT1Q2qz7NLNrkssWKAQiE
         y3y7okZVcUpKBzTQkBbaepU+LppG+CQX77icULeqoZjAwpwbfV4sZOqQE5gkKMnKLAj7
         a73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TOFvUtTpSZQYQv3TpDRP9kVtH5o12KXMo9MY6xIO2DQ=;
        b=kEQ5HnCzHGPz5RBIccNtwzZ85K0aRlb3eyxLaXJF5cOSHzE01lyiB4x2AtsRbixSPv
         C2GsDe/MsCocsJqjqSRmsP3S59vlmjgifjPnpLe22tnnq7d6LwlEJqTzqTdc/cLMr3qw
         UdjRVveOcBiVxgS5ru80KAUXzVvtIfRXGuG6QaxYKVqMewtO4OrRss2uXYNkTJSXR633
         w9rvFVMgVmFLmLD0PEwSDo3zl6ZTB36bZJYhkSPV6P9NGmzS6sZhPugRNtwlR+EEbmHy
         11TTTWhUbOk0024E0OPj3lay7yTA+oEVcI+mb7TWQcEkA5GtoI/1dlV21hXaCOULakji
         bTfw==
X-Gm-Message-State: ALoCoQmuTL2k86xoYDahtuZiwJuceq7HYGfMLM3BNxckdHki0pfl+Upg1+b6uE+skMv5faHg88Kf
X-Received: by 10.129.40.18 with SMTP id o18mr31774624ywo.199.1445986442799;
 Tue, 27 Oct 2015 15:54:02 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 27 Oct 2015 15:54:02 -0700 (PDT)
In-Reply-To: <017901d11108$ceb2cd10$6c186730$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280312>

On Tue, Oct 27, 2015 at 3:42 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> Slightly OT: Is there any way of avoiding having that file in the first place? I'm hoping to have a git repository in a normal file system (Posix) and a working area in a rather less-than-normal one where dots in file names are bad (actually a dot is a separator).

As said before, I would not expect a file .git/gitdir to be there if
not using submodules.
For your OT question, I'd presume you'd have environment variables setup
    export GIT_DIR=path_with_no_dots_and_git_repo_in_it # you mention
that is in your posix FS
    export GIT_WORK_TREE=/some.place.with.dot.separators
and you'd be good to go.


>
> Cheers,
> Randall
>
