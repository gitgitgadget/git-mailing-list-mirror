From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] The design of new pathspec features
Date: Tue, 29 Jan 2013 19:17:10 +0700
Message-ID: <CACsJy8A5VJ4EchbeFEC5ikLYgHze47_xyLTtgH=kqVpP15Hogw@mail.gmail.com>
References: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 13:18:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0A8Z-0007Jq-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 13:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab3A2MRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 07:17:42 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:55101 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab3A2MRl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 07:17:41 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so336611obb.14
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 04:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=YfkupyWu2EE6l+iA/BCfLjlqjklSLLuMzqvtFB2twBU=;
        b=wyHfO0XCjvmIT+TyVDX5/OVQSYSf2FM0qu1jcKAlxBbfCJZ5SDhNpacJ+K+wb16/al
         GvQ17ZFvkFVTQTIHDGEnwnhXn49yncs2WMDSGWUftW47YDsyMtOB1HcbAzFGoTe4wyRK
         lzyaZNDiG37aBB07/1pWNQMzCevFnXP3EoCKKdzx8ln/wmO/JL6JGGOkfxA64twm384R
         CAUfsZyBzklY6a9HE1uyopU5MnY8FaApI7llYxT6xsfU2mn2se7XwIr7xDBMGgSDv8de
         wY54li9v9ln8cI6RqB9NnyKNzm4lyOdUqTiZINMSBHy7s4Q2pC+mEtqMV8Tp5zbSBYH6
         SQWg==
X-Received: by 10.60.3.1 with SMTP id 1mr492513oey.138.1359461861044; Tue, 29
 Jan 2013 04:17:41 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 29 Jan 2013 04:17:10 -0800 (PST)
In-Reply-To: <20130129043517.GA2878@duynguyen-vnpc.dek-tpc.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214934>

On Tue, Jan 29, 2013 at 11:35 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> :(glob) magic
> =============
>
> This magic is for people who want globbing. However, it does _not_ use
> the same matching mechanism the non-magic pathspec does today. It uses
> wildmatch(WM_PATHNAME), which basically means '*' does not match
> slashes and "**" does.
>
> Global option --glob-pathspecs is added to add :(glob) to all
> pathspec. :(literal) magic overrides this global option.

I forgot one thing. The current pathspec behavior, the pattern "[a-z]"
would match a file named "[a-z]" (iow, wildcards are also considered
literal characters). Do we want to keep this behavior in :(glob)? To
me it's a surprise factor and therefore not good. But common sense may
be different.
-- 
Duy
