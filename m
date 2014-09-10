From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-notes.txt: Explain how to transfer notes between repos
Date: Wed, 10 Sep 2014 15:59:00 -0400
Message-ID: <CAPig+cQeJz2DZ+=qdAM-grOC=kQ+DSTL8gsycyq8djrGoaPVJg@mail.gmail.com>
References: <1410357414-691-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 21:59:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRo2k-0001co-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 21:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbaIJT7C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 15:59:02 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:62034 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbaIJT7B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2014 15:59:01 -0400
Received: by mail-yk0-f171.google.com with SMTP id 79so3269729ykr.16
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=uojiQo9R0uz+oOc2XYPPxfTilrMVzmUG+WRBHEIUOZo=;
        b=GLwC1Plq+cJRdRZ+6knlksuZz8Pj6h27xxFjsxpq/OATyZ+uz7qU9Jp8ai+mfLdC83
         cs+f7sY3cVVjxhQafSglExhK7Opn1xvmNEmFZC9QPO7O1/auGFdntsFGYPXDxLFmC4Ks
         Z0RlyOVpLOQvuKAo3liPpd7CcNDF5Ld8wMnbPC8Px5CG53VuueU0Y3eJyRbTwRUyt2fm
         RqK4GuMs2/+CKRdNnCIhWXQVBWUvR1EGkWzpd2toqI81MQsJyrbneWrcosOlmoFcmlJl
         sgnglJ0GPd7Jb2EA01TS/10F7TEGdCYyx/seiZ23I88aVCwnH5OjLPjNGHa00iJadkqo
         Jn8w==
X-Received: by 10.236.44.147 with SMTP id n19mr64072214yhb.82.1410379140579;
 Wed, 10 Sep 2014 12:59:00 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Wed, 10 Sep 2014 12:59:00 -0700 (PDT)
In-Reply-To: <1410357414-691-1-git-send-email-sunny@sunbase.org>
X-Google-Sender-Auth: 5YLkpAdS0acEe2B1wIKmiUCzWc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256762>

On Wed, Sep 10, 2014 at 9:56 AM, =C3=98yvind A. Holm <sunny@sunbase.org=
> wrote:
> The documentation for git notes did not mention anywhere how to trans=
fer
> notes between repositories, create a section that explains this topic=
=2E
>
> Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
> ---
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.tx=
t
> index 310f0a5..4237bec 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -264,6 +264,45 @@ prior to the merge, these will also be removed b=
y this notes merge
>  strategy.
>
>
> +TRANSFERRING NOTES ACROSS REPOSITORIES
> +--------------------------------------
> +
> +Notes are not transferred by default when using the standard
> +fetch/push commands, but has be done explicitly. To fetch all notes

At minimum: s/has be/has to be/

Slightly improved phrasing, perhaps:

    Notes are not transferred, by default, when using the standard
    fetch/push commands, thus must be transferred explicitly.

> +from a particular remote, use

s/use/use:/

> +------------
> +$ git fetch origin refs/notes/*:refs/notes/*
> +------------
> +
> +`git fetch` can be configured to automatically fetch notes from a
> +remote with this command:
> +
> +------------
> +$ git config --add remote.origin.fetch +refs/notes/*:refs/notes/*
> +------------
> +
> +To transfer notes to a remote repository:
> +
> +------------
> +$ git push origin refs/notes/*
> +------------
> +
> +If you don't want to fetch or push all notes stored under
> +`refs/notes/`, replace the asterisk with the specific type of notes
> +you want to transfer:
> +
> +------------
> +$ git fetch origin refs/notes/commits:refs/notes/commits
> +------------
> +
> +or
> +
> +------------
> +$ git push origin refs/notes/commits
> +------------
> +
> +
>  EXAMPLES
>  --------
>
> --
> 2.1.0.127.g0c72b98
