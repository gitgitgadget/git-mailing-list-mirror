From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [RFC/PATCH 1/2] config: Add safe-include directive
Date: Mon, 06 Oct 2014 11:28:43 +0200
Organization: D03
Message-ID: <878uktwnqs.fsf@rasmusvillemoes.dk>
References: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
	<1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
	<1412300254-11281-2-git-send-email-rv@rasmusvillemoes.dk>
	<CAPc5daV_txE9NrwvH5VWhXK+UmE7Avy8R2QaZaX0SsTC_+TU-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 11:28:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xb4b5-0003h7-Eg
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 11:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbaJFJ2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2014 05:28:47 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:65083 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaJFJ2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2014 05:28:46 -0400
Received: by mail-lb0-f180.google.com with SMTP id f15so3823530lbj.25
        for <git@vger.kernel.org>; Mon, 06 Oct 2014 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=OHbIs06h5I1WN2WOqkpVI2Qm8rP+3/qsDzuUwH5ENwc=;
        b=MXHcLWo/C9h5KufbR+f9IM04V5zl838P/9RkiNafJoBenlRnn/SSPgW3PDyYIQna6C
         4CQ2AJGK9UfUnisLaAn5ZrNLzunHXuPIsvnhgg6b5H1G2DLlPEtXa7x80xGr9TVVaBep
         8i7rh6ukAtktkDjNG99yosuBr8TLinTJEu1FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=OHbIs06h5I1WN2WOqkpVI2Qm8rP+3/qsDzuUwH5ENwc=;
        b=DV1Vzbho95AMWZvAOXvlS2HBo+VBY47Nl4DJnatp+yrOMumEuo0dBYdNs53wixzPVB
         74DT6ulR/dbnsEloVk2qA1++4F38WNYqNDtfyDZVsWaG00oIyLyLkN6X2jfbjp5GO7St
         2DFfosh2l9suyF7RodldRzQ5EOTcG0U0+MnYzb05jmt8pDoqjRsDKilDWUgSNNOkxEBw
         4edbken24oBYugdkO45xmrl+DQES0FqHa8QI4LtVi8Lr9Ug012Nxe8rbnecw7N9a8MAX
         Wfz/0y29q/32VSpesB30/yVaW07yXgDYRWWQt6DBv2P06zI0DM5QDcUVODso8F7uy39G
         C75A==
X-Gm-Message-State: ALoCoQn5ZOAXR+TUSzGCTIx1rQZVVz14slWe23t/s85gwbBd7TiLD6WTbyMpbAnfry/M8bOs0Dth
X-Received: by 10.152.18.130 with SMTP id w2mr1785247lad.89.1412587724595;
        Mon, 06 Oct 2014 02:28:44 -0700 (PDT)
Received: from morgan.rasmusvillemoes.dk ([130.225.20.51])
        by mx.google.com with ESMTPSA id n7sm5535901lae.47.2014.10.06.02.28.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Oct 2014 02:28:44 -0700 (PDT)
X-Hashcash: 1:20:141006:gregkh@linuxfoundation.org::5yXC75V7drNZlZib:000000000000000000000000000000000000GrX
X-Hashcash: 1:20:141006:gitster@pobox.com::JGvXc+fbnvMPZJD4:000000000000000000000000000000000000000000001OCL
X-Hashcash: 1:20:141006:git@vger.kernel.org::e6j/H6s8gQ42Jzv8:0000000000000000000000000000000000000000002Fmy
X-Hashcash: 1:20:141006:peff@peff.net::Ykk8R//t6+MALiC5:000043TJ
X-Hashcash: 1:20:141006:joe@perches.com::V1MVWt+MLcR+fiN0:006BA9
In-Reply-To: <CAPc5daV_txE9NrwvH5VWhXK+UmE7Avy8R2QaZaX0SsTC_+TU-A@mail.gmail.com>
	(Junio C. Hamano's message of "Thu, 2 Oct 2014 22:27:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257909>

Junio C Hamano <gitster@pobox.com> wrote:

> (by the way, we do not do dashes in names for configuration by
> convention)

OK. Actually, I now think I'd prefer a subsection [include "safe"], but
I don't have any strong preferences regarding the names.

> That syntax _could_ be just a relative path (e.g. project.gitconfig names
> the file with that name at the top-level of the working tree), and if we are
> to do so, we should forbid any relative path that escapes from the working
> tree (e.g. ../project.gitconfig is forbidden, but down/down/../../.gitconfig
> could be OK as it is the same as .gitconfig). For that matter, anything with
> /./ and /../ in it can safely be forbidden without losing functionality.

I agree that it would be most useful to interpret relative paths as
being relative to the working tree. I'm not sure what would be gained by
checking for ./ and ../ components, a symlink could easily be used to
circumvent that.

> And we can allow absolute path, e.g. /etc/gitconfig, of course, but I'd
> prefer to at least initially forbid an absolute path, due to the same worries
> I have against the "unset some variables defined in /etc/gitconfig" topic
> we discussed earlier today in a separate thread.

One might (ab)use the feature to only use some settings from a global
file, e.g.

[include "safe"]
    whitelist = !foo.*
    path = ~/extra.gitconfig

But I'm fine with forbidding absolute paths until someone actually comes
with such a use case.

> Another design decision we would need to make is if it should be
> allowed for a safe-included file to use safe-include directive to
> include other files. Offhand I do not think of a reason we absolutely
> need to support it, but there may be an interesting workflow enabled
> if we did so. I dunno.

After one level of safe-include, any safe-include can also be done as a
normal include (but one may need to spell the path differently if the
two included files are not both at the top of the working tree). One
could imagine a project supplying lots of defaults and splitting those
into separate files, each included from a single project.gitconfig.

Anyway, my proposal allows nesting includes and safe-includes inside
safe-includes; forbidding it would just be a matter of adding a
safe_include_depth == 0 check in two places. (Then safe_include_depth
probably could/should be renamed in_safe_include.) I think I have a
slight preference to allowing nested includes, but if absolute paths are
forbidden for safe-includes, they should also be forbidden for
include-inside-safe-include.

Rasmus
