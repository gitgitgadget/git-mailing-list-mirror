From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: For first push to a bare repo, using "--tags" prevents creation of master branch
Date: Fri, 29 May 2015 09:05:53 -0700
Message-ID: <xmqqeglze5cu.fsf@gitster.dls.corp.google.com>
References: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
	<vpqbnh4hro7.fsf@anie.imag.fr>
	<xmqq617bflzh.fsf@gitster.dls.corp.google.com>
	<vpq4mmvs7zx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Darling <darlingm@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 18:06:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMnJ-0001VQ-Ab
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbbE2QF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:05:57 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33256 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbbE2QFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 12:05:55 -0400
Received: by igbpi8 with SMTP id pi8so18322187igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rWbICfy0AP7egBRQQWEBlX+FdeyYjf6qexUJ1By9F/k=;
        b=WH398CYisYKgK0CH4+KyqpPlYBzjlcU7DLwT3jqL8YnL1bn345foZJd5mv1KpXYh96
         Il4O3XOsDIz6VOWWv1JGTjxPxEv3SLPgIq74HVP7JP+cYCRoKD6laBMo7QKdrqfJj02/
         c5ID0t0cCXhWL/gBnQApIHPvQH/y+Ad4+bIZa69eogvQZr6tRypQN4roxayJ5QoEGnAj
         tQcfuHjVOLTwnVVl2Il9IhWeKCCOCi04YqD3xrD3TdFRPEZvJl5r7EfWDbN8bazN/D6H
         NeWB2HX8fC+Nolm+8Pw8QJRvtpUF/vEVSz5lq9JxOPHJ9OjiiEfWmjTuPcetxLFbLTws
         1mQQ==
X-Received: by 10.50.114.9 with SMTP id jc9mr4905766igb.49.1432915555086;
        Fri, 29 May 2015 09:05:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id g1sm4471021iog.4.2015.05.29.09.05.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 09:05:54 -0700 (PDT)
In-Reply-To: <vpq4mmvs7zx.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	29 May 2015 17:45:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270251>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Perhaps a justification is that annotated tags are clearly meant to be
> public while lightweight tags can also be used as private bookmarks.

Ah, thanks.  That makes perfect sense.

> In any case, the fact that it's been this way and documented this way
> since 2013 makes it a bit hard to change now.

That too.

I recall "fetch --tags" was updated to become your "--tags-also" by
e66ef7ae (Merge branch 'mh/fetch-tags-in-addition-to-normal-refs',
2013-12-12).  Perhaps we should do the same on the push side.
