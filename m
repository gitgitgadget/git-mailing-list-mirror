From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 02/21] path.c: rename vsnpath() to git_vsnpath()
Date: Mon, 16 Dec 2013 14:21:08 +0700
Message-ID: <CACsJy8AJT5XXyJvVi_6Gjrn=AqA1M9KWY_62p=d3CPjg7nXFWw@mail.gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com> <1387018507-21999-3-git-send-email-pclouds@gmail.com>
 <52ACBE2B.3040909@ramsay1.demon.co.uk> <CACsJy8BdLt8ZUU2z4LAgTcfXUjruFaOFsvrv6dSziZVizAopGA@mail.gmail.com>
 <52AE1B5E.6020506@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Dec 16 08:21:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsSUp-0003dR-Kp
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 08:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab3LPHVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 02:21:39 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42424 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab3LPHVj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 02:21:39 -0500
Received: by mail-qc0-f174.google.com with SMTP id n7so3329244qcx.5
        for <git@vger.kernel.org>; Sun, 15 Dec 2013 23:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SDbo4juQNovz7wZ/uMQ/rCyOilyK7lBOjt8RKYHGyDw=;
        b=FADvAQ8qmOAg61da4qqXnG9cjv9JjyUl3ynoHfQVPmyQTRcCJd817yhBsFYWL9FVsN
         p6zTo3c1gxx2/KcAt+0C9E5HNN6BtTCW12IcxWq4uZUzgm/GKxgajtZhu4snbSPeT8fG
         DNPP6TwUJjpFU2sIsYQsnejvxRekYM+OJhaG/rwKoaCzSokJZ4J1Hpr/YpNeWLTUA0vI
         ltgEcK0UFCpgrs8WMC4XgfJ3Df+P+vd3sC/zcLoPZF6PBWItxJhaytpHTigs+iKIQNkv
         tJnllk/vL+iFz2nfp2hX+D0qYddStut7FjxHCk13CC5aOt8pLl6BboyWEwh4IdIX20wu
         HYYA==
X-Received: by 10.224.157.19 with SMTP id z19mr29827468qaw.102.1387178498516;
 Sun, 15 Dec 2013 23:21:38 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Sun, 15 Dec 2013 23:21:08 -0800 (PST)
In-Reply-To: <52AE1B5E.6020506@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239330>

On Mon, Dec 16, 2013 at 4:13 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>>>> -static char *vsnpath(char *buf, size_t n, const char *fmt, va_list args)
>>>> +static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_list args)
>>>
>>> :-D I renamed this _from_ git_vsnpath() in commit 5b3b8fa2 ("path.c: Remove the
>>> 'git_' prefix from a file scope function", 04-09-2012), because ... well it's a
>>> file scope function! (i.e. the git_ prefix implies greater than file scope).
>>> I'm not very good at naming things, so ...
>>
>> maybe gitdir_vsnpath() then to avoid the global scope prefix git_?
>
> Sounds fine to me (but then so does vsnpath ;-) ).

OK I go with this. I think it makes sense

vsnpath -> do_git_path

its three callers are

git_vsnpath -> strbuf_git_path (it's updated to take strbuf)
git_path
git_pathdup

In the end all these functions have "git_path" in them :)
-- 
Duy
