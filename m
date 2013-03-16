From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Sat, 16 Mar 2013 08:51:22 +0700
Message-ID: <CACsJy8CoHJ-rGf8LLQZMgVN4rcZOA2eFRy=7oBDtpDbFksVSeg@mail.gmail.com>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com> <7vehfj46mu.fsf@alter.siamese.dyndns.org>
 <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, artagnon@gmail.com,
	robert.allan.zeh@gmail.com, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Mar 16 02:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgIG-0007T7-39
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 02:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab3CPBvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 21:51:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57806 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab3CPBvw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 21:51:52 -0400
Received: by mail-ob0-f174.google.com with SMTP id 16so3860187obc.5
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 18:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4Z19Gi5SbQ40c307zVIbyRmBrPL3dJoWruPrzyc5PyU=;
        b=LMxxHmv8c2MYP/9T8JT6Brdpr/3VU0IgiQNrtiGpVNcLcUysaQR4VVOs1jLtOJ7gbW
         gJlO6jckllng6jJWmycPAYse859/mN09gVP+HmHQWy2I2uhklGEbUqmOlgyNFQgFCu1F
         N5QsnpgVDOwpsvxyuoRsNii2OO+TjBS7/WdXj5zk3fDioFEXuMfXttGUjk8stzl7sh40
         dTJodR1CtccZ/KSegB2cZEkHJEqZVqJ8xjARyx43DoNkFzu3FJX46t4ucXRYWb9eBSEo
         UUAjnIdcm5VMat27Pr7jhKJDnhHqfyQ7jCR6sU9FEdmgAG0IW9ScV/m/3V3hD/qF63yF
         x7lw==
X-Received: by 10.60.171.167 with SMTP id av7mr3809428oec.77.1363398712182;
 Fri, 15 Mar 2013 18:51:52 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Fri, 15 Mar 2013 18:51:22 -0700 (PDT)
In-Reply-To: <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218271>

On Thu, Mar 14, 2013 at 5:22 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 13, 2013 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The noise this introduces to the test suite is a bit irritating and
>> makes us think twice if this really a good change.
>
> I originally thought of two options, this or add an env flag in git
> binary that turns this off in the test suite. The latter did not sound
> good. But I forgot that we set a fake $HOME in the test suite, we
> could disable this in $HOME/.gitconfig, less clutter in individual
> tests.

fwiw, adding to $HOME/.gitconfig by default in test-libs.sh does not
work. Else where we check "git config --list" and the new global
config key will fail them.
-- 
Duy
