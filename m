From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 19:47:28 +0700
Message-ID: <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com> <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 14:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V33v6-0005TV-Mr
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 14:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617Ab3G0Mr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 08:47:59 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36774 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab3G0Mr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 08:47:58 -0400
Received: by mail-ob0-f172.google.com with SMTP id uz6so2668628obc.31
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TOV1c0NxpzubWjAf4+3OCqh3fjV3uT6C/kFnhpm+M8w=;
        b=iSPcT7Z+T7mvs4bvxkLya+NjgmeYA6IQKRBIIC/J5Wd7TG+d7iRpTPpLl697piqZT4
         lTyYgAXU9rN2R0cV1s5V0xcECXhelaoTmM7AY1mHRUIdU3szNGHLmTI8zcMkdEronfX6
         IN/Efmz1jLfS4jvWqiaJn3Rfjmc2ZVTCXHD0ODd50NOtSSb7gYo9DMDfnqCHGguN4f0p
         BO5Gxx8PuGxrSfkg5XuvCczOqz5XZ3JJfZeBnMy2GDnUvESLmy37b6VnLkOqig/XIrr/
         e2qAOIpYbpe4Blc1TtvpNDOCEjDbSOOxrFeboYI1weIWj3MnOdAy0skeagqV2lThbWKm
         SNYQ==
X-Received: by 10.182.34.166 with SMTP id a6mr46327767obj.102.1374929278059;
 Sat, 27 Jul 2013 05:47:58 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Sat, 27 Jul 2013 05:47:28 -0700 (PDT)
In-Reply-To: <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231243>

On Sat, Jul 27, 2013 at 7:31 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> e02ca72 (path.c: refactor relative_path(), not only strip prefix,
>> 2013-06-25) is the offender.
>
> The problem is the callsite in setup.c:setup_work_tree(). When
> relative_path() is called with
> "/home/artagnon/dotfiles/.git/modules/.elisp/flx" and
> "/home/artagnon/dotfiles/.elisp/flx" as the first and second
> arguments, it sets sb to "../../.git/modules/.elisp/flx".
>
> Makes me wonder why setup_git_dir() doesn't just use git_dir; why does
> it need a relative path at all?

044bbbc (Make git_dir a path relative to work_tree in
setup_work_tree() - 2008-06-19)
-- 
Duy
