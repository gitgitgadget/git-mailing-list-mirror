From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] preparatory patches for the submodule groups
Date: Tue, 3 May 2016 13:53:30 -0700
Message-ID: <CAGZ79kakayOhPkCK4hbRkj-h2Bt+PqD69EgHk-chbu4xCA8_pA@mail.gmail.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<xmqqwpnalwf8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:53:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhK4-0004hj-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 22:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388AbcECUxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 16:53:32 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36569 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbcECUxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 16:53:31 -0400
Received: by mail-io0-f180.google.com with SMTP id u185so40319821iod.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iohJFouasCwiMpyr80UNvIBAqb6xehHGZuXcdjmLcFk=;
        b=JMAutWfWvfF8APIVXyAEUCegBKuu8cQSCFPqrbCko6d+e2u4VS1mP3voCr7Xx0hVxK
         6QOQtXYj7rJmMCVgLm1EkHB0NRo2WrJbRC55IOHHyTyYahaZPhGhRkAMfcTg+n7gl+2U
         t1XG+CVqls8Zsc4sS8vgS3Zi4LjlEROIjVOAgdCrPnwkstiPdOu8+8d3qbo5ArU3z1xi
         HGxkwNdVqGUQwDj48hbDQFBpz84C/ObrDEMQYzQOhuIAeu7c/FOaBhgsDTnjjyLbh/L6
         NH78cxR/IDhjjUDh2vcpNrcXXD/ehq5YefpyfFfSzpGpDCq37VUqxYiwGgv3hRIE1++Y
         Giyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iohJFouasCwiMpyr80UNvIBAqb6xehHGZuXcdjmLcFk=;
        b=LJ/8tOunFwQf9ryKFrUbfCbDRwZz3IrylDbQfu7ZuSDq9wlX/DjwXiTvugq29tFIle
         6R1G3by7OpNR4qTw86cbIHkpnTislW4UjUhB9+k8MYOItdl7KwdSKY8UbLqn1ijgIpdK
         DeMiY1wXxt70fwzzcgNmdZvUTmdA+TRPJqMjRArf40CmnqiplQMC9i3nOGq1RAWIzcrr
         ugctvL+/MCgiiO1MqrVe4Xs7lcGNdUHNBwbT2i3JdUSlZoFJA7M6PDNYlXtnL3s1tJci
         xxHRGI15vKaMg4ymeHo58kKRsC3h7fn3xL+YSPRlwd6B2IIyY1oAjd+CwUccpB4qAdhS
         Ge4A==
X-Gm-Message-State: AOPr4FWXJBRUz8wXEvMvCF1x8OWlar0f1TTLC0rKT6cSaLivZrSBVjspjtWRhZlteagfUq1umjFm9dK7ekeH1QmS
X-Received: by 10.107.174.205 with SMTP id n74mr5858824ioo.96.1462308810492;
 Tue, 03 May 2016 13:53:30 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 13:53:30 -0700 (PDT)
In-Reply-To: <xmqqwpnalwf8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293453>

On Tue, May 3, 2016 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Stefan Beller (3):
>>   submodule deinit test: fix broken && chain in subshell
>>   submodule deinit: lose requirement for giving '.'
>>   submodule init: redirect stdout to stderr
>
> So...
>
>  * I'll take "&&-chain" patch on a separate topic on 84ba959, to be
>    later merged to 'master' and probably to 'maint'.
>
>  * I'll queue the "send diag message to stderr" patch on top of
>    sb/submodule-init.
>
>  * As to the second one, I prefer to hear opinions from others
>    before choosing the possible two approaches.  Perhaps losing the
>    "safety" is acceptable.  Otherwise, we could use the one I sent
>    but with a "-a and pathspec are incompatible" fix.  That can be
>    on its own separate topic.

I have your patch here and have a "-a and pathspec are incompatible" fix
build on top.
* I do wonder if we want to have the shortform '-a' though.
* I think we want to head for consistency, eventually.
   e.g. commands with no arguments such as tag, branch
   give a list of their respective domain.

   Subcommands do not give lists by default, e.g.
   `git stash clear`, `git remote prune`
   which are the moral equivalent to
   `git submodule deinit` just work as they were told, no --switch needed.
   However Jonathan suggests we may want to reserve the no arguments space
   for future use and use the '--all' instead.
