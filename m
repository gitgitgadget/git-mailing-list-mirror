From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 7/8] update-index: prevent --untracked-cache from
 performing tests
Date: Wed, 2 Dec 2015 20:18:44 +0100
Message-ID: <CACsJy8BhcrOz=JT=ESoG_Jgf=_4VP+kB7wGoofZ7LoVP_t4Vvw@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org> <1449001899-18956-8-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:19:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Cvy-0003Ul-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405AbbLBTTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 14:19:17 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35541 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbbLBTTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:19:16 -0500
Received: by lfdl133 with SMTP id l133so63598132lfd.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TyDlCAPQEr6+qw9Amh6r8sZjtw8JQQA/5HwuW+4oaww=;
        b=ytZVX/MKWhLzh1blsWrbQNjrl8P0/R8QNSwcENLh2fWyDMdslh8Sn1zYU6WHsyk+CA
         UlLZ9NnBkkOXOf1PDyuj/SuxkQC2oUoqe4u+lhFlsRO5jJueQEqRtoIgV+mfgN3T9ZwM
         uv9KG8k5+I1d9GKFKGmJhL32+55GWO5uDLxsNI5VnqfpjyvEEFrSJDnntydHBqEXUofi
         Gyihhg/as0onc2wVdERF0VLl5LB4ZnslKiry4qKMaCjhdEomxhEkLy1NFEaFtmt2m2MJ
         N5Dc/iznmpNeGOu6wBjnsQjMNh8JNbzJvCq8VCDEyaGEWHIYha3Q1dzWrRI3wIBvhP6m
         HxTQ==
X-Received: by 10.112.168.70 with SMTP id zu6mr3981363lbb.26.1449083954439;
 Wed, 02 Dec 2015 11:19:14 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 2 Dec 2015 11:18:44 -0800 (PST)
In-Reply-To: <1449001899-18956-8-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281909>

On Tue, Dec 1, 2015 at 9:31 PM, Christian Couder
<christian.couder@gmail.com> wrote:
 diff --git a/t/t7063-status-untracked-cache.sh
b/t/t7063-status-untracked-cache.sh
> index 0e8d0d4..8c3e703 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -11,7 +11,7 @@ avoid_racy() {
>  # It's fine if git update-index returns an error code other than one,
>  # it'll be caught in the first test.

Notice this comment. You probably have to chance --test-untr.. for the
first test too if it's stilll true, or delete the comment.

>  test_lazy_prereq UNTRACKED_CACHE '
> -       { git update-index --untracked-cache; ret=$?; } &&
> +       { git update-index --test-untracked-cache; ret=$?; } &&
>         test $ret -ne 1
>  '
>
> --
> 2.6.3.391.g95a3a5c
>



-- 
Duy
