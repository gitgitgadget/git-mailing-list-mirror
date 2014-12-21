From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] configure.ac: check tv_nsec field in struct stat
Date: Sun, 21 Dec 2014 16:47:02 -0500
Message-ID: <CAPig+cQmFBJYu-fJmOWV5zVRqPphi=aA+fJ8sBAVnHyXPNbAJQ@mail.gmail.com>
References: <1419188016-26134-1-git-send-email-reubenhwk@gmail.com>
	<CAPig+cQWpq12axtJNsjoiKLKTpi6_xreS1fYDXYBtNv0Bj=T2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 22:47:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2oLG-0002oI-EO
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 22:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbaLUVrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 16:47:04 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:58488 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbaLUVrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 16:47:03 -0500
Received: by mail-yh0-f42.google.com with SMTP id v1so1815012yhn.1
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 13:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zL/l7Nrj6RJncJIeY8m1phCJgRFkfWCrXbbT+jaS2Vk=;
        b=mfeo6RSQ0Y265vWJpxp3x6tbdhGWHiOFWT+krFGUUyl9CqZmKH8Q4ym+IjgDpo75gT
         yneV7z3ZPjMqntYxjjcOZzX1UEKe1mDLSrNA44PpuwMmUEHU5qsm7QDmjUpIbpnijjsq
         biiarDJxpWr2zJHtf41iFOuTSiU+cVfcgCXlVpgAXNZtWIRHO7AOteyOxKuPPHv+lhVk
         N3tUyM3E9qcev9PsY99U53pGDY8zgRVaGqlb9taeLMzQ0hj9piHQdGXHehdvY7f+TpsO
         H3ERQJORU+OnSJZ2Ymp0IHgWng4h5NtCf1drax3/LNmcQxOA+CvOHNLEnX+/JjF7Jx1O
         yPTQ==
X-Received: by 10.236.14.36 with SMTP id c24mr15367096yhc.166.1419198422402;
 Sun, 21 Dec 2014 13:47:02 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sun, 21 Dec 2014 13:47:02 -0800 (PST)
In-Reply-To: <CAPig+cQWpq12axtJNsjoiKLKTpi6_xreS1fYDXYBtNv0Bj=T2Q@mail.gmail.com>
X-Google-Sender-Auth: 90g750RUmpsLoUoUoQeRXHrO00E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261632>

On Sun, Dec 21, 2014 at 3:20 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Dec 21, 2014 at 1:53 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
>> +AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec],
>> +[HAVE_ST_MTIM=Yes],
>> +[HAVE_ST_MTIM=No],
>
> In Autoconf, it's customary to use lowercase values (such as "yes"
> rather than "Yes") for these temporary variables. A "no" value is
> usually represented by an empty assignment (HAVE_ST_MTIM=). However,
> AC_CHECK_MEMBER() assigns the test result automatically to a shell
> variable (in this case, named
> ac_cv_member_struct_stat_st_mtim_tv_nsec), so there is no need to
> invent your own (HAVE_ST_MTIM).
>
> So, you can reduce this to:
>
>    AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec])
>
> and later check the value with
>
>     test x$ac_cv_member_struct_stat_st_mtim_tv_nsec = yes

Apple auto-correction strikes again: s/yes/xyes/
