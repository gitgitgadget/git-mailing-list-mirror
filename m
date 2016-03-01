From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Tue, 1 Mar 2016 14:15:57 -0500
Message-ID: <CAPig+cRwEKjGaDA-jy8KJSAhTheJYDmxtPq8SdVs0LA2f9-9Yw@mail.gmail.com>
References: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Lars Schneider <lars.schneider@autodesk.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:16:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aapmA-0005su-BC
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 20:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbcCATQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 14:16:00 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32863 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbcCATP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 14:15:58 -0500
Received: by mail-vk0-f66.google.com with SMTP id c3so12261811vkb.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 11:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Mur0vMYuDE/m5cCMZWvxpfmFuSVyRDAgM/Z7Gg5rtyA=;
        b=cqnKa517eXJXTDeoepDiTMzTlK8dmuM8qQ19dvXn092eb0asj9b6hgrfZ+/sOefO1+
         hninhx3t53sNUYovxPYxxaVSwOkh/0+pGcJ/DoSLrvh9EwY52SH5BNqBrITWw66brXXQ
         aCJk7Qx0mdTsrzzh0g1Ub05osw070qXu71EQMXbge92bvCxQ+xZvv25gZbqKEGMkTRNP
         exMC6Jb9gFY7Xv2dYgNRjPU7mHc5/y4fdyPeO+dAOxGXy2QZOdVh8aA9EFmypfo9As1u
         8sfbNgQtt11tSCPdfJDBJuUBo3LfdSc9z/QMA81H0ze+L4ebidnZuNM4gBpvIWoXACOG
         juyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Mur0vMYuDE/m5cCMZWvxpfmFuSVyRDAgM/Z7Gg5rtyA=;
        b=QJOloUvYy8SCS8VUCpliQuZgFehwpdlSYbMQ2eCM7PVB9D4Bv1LT/wjf3C8b31d1P7
         t10eRAS8ML7qY7rT5Ap1VAM+v2uVc+FBhktMG5r3oimdKbH6WoYErjG8do9dBDM39lnn
         FeKjpj/4jNg1m8EQJ+UAxnkgehRKP2gBriIO8df86l1a2eo/8aZ4MVpnmOceYtXQ3ykl
         wcomBrKhEtGMfo9MctzHOPQo0I/dI/30QuJEUYoqJkZO0Jdz+prSZY3IYSTJ3uF9iC/3
         EAMCszyrP9nl76MXPKIcmQWE2Tcf4Iz/VId20ITMDSpC94F/s5SYFtSvANfCXrDuUPsL
         fzcw==
X-Gm-Message-State: AD7BkJL0d6yPhSkeDO4r8W3NFmTYRqt4LVNkAml5wGB/MsIt1OHaS2JMaHDJpG/I1h1Ip1BBehdW+qMRGvMhLg==
X-Received: by 10.31.8.142 with SMTP id 136mr17384767vki.14.1456859757240;
 Tue, 01 Mar 2016 11:15:57 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 1 Mar 2016 11:15:57 -0800 (PST)
In-Reply-To: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: y2F7Y9PJYQo5UgdAVAZOTovTqsA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288054>

On Tue, Mar 1, 2016 at 5:49 AM,  <larsxschneider@gmail.com> wrote:
> Map a P4 user to a specific name and email address in Git with the
> "git-p4.mapUser" config. The config value must be a string adhering
> to the format "p4user = First Lastname <email@address.com>".
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> +git-p4.mapUser::
> +       Map a P4 user to a name and email address in Git. Use a string
> +       with the following format to create a mapping:
> ++
> +-------------
> +git config --add git-p4.mapUser "p4user = First Last <mail@address.com>"
> +-------------
> ++
> +A mapping will override any user information from P4. Mappings for
> +multiple P4 user can be defined.

Sorry for not paying closer attention the first time, but this needs
to be repeated for each P4 user you want to map, right? One can
imagine this quickly becoming painful if you have a lot of users to
map. Have you considered modeling this after git-svn where you can set
an "authors" file (and name the corresponding option --authors-file)?
