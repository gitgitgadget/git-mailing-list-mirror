From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] git-rebase documentation: explain the exit code of custom commands
Date: Tue, 30 Dec 2014 11:36:48 -0800
Message-ID: <CAGZ79kZ8WgR2SxnX9TheUhpJqX50OhTGOi-jnjw5TDySyr4YWg@mail.gmail.com>
References: <1419892207-26687-1-git-send-email-sbeller@google.com>
	<xmqqr3vhrqjn.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZsQpvNzGPYuS64Cx2hFoozcb2HxU9Chd1__5=kkE-WjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 20:36:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y62b8-0005kv-BN
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 20:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbaL3Tgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 14:36:50 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36530 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaL3Tgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 14:36:49 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so12894149igi.12
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+nOxYIR2r9s4jKRmOjPwahC0a0o/7CE8euET7M/D5xA=;
        b=UiFFDuKIUrYl30g9llQNJhukqhKCHNNIj4yf3GtefV3s8XmVUj7MB8hjPROC9O2oBM
         Pwfbp0ZQpsE/X0bXC85M4n3YWFSEEGnje5NEcHySTT4bA+GWy9n1Zq++PSwdlDUljY4B
         OL5BYHrHGE23+ZaO2k+ozt7SXuMKvx57gHjXwyvqi7v7jp6igY9VRPAEnSbP+nohcTCW
         KWcE/MR4Ko+gZe5NA9I+Ah0EnUsGC59KW3xSuvq2cXC28VTzoC/XhRMhkYGI7odW5O9E
         Q9zumLewlD/o4/PDx5y+3n0+sHSrDWIXYCSS/f8vKqaQ6UU2H+fyqM2RRwhPXfaP10aT
         Bs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+nOxYIR2r9s4jKRmOjPwahC0a0o/7CE8euET7M/D5xA=;
        b=RglZODWh8DmhN73tPJ5yjNObxOrRuonIxL7QgZm5qao/3wJrv9Hqqo7ejHzrOFdgKo
         R5OWbNhHLgtlevh9tfay3LFLSAsZZCfZlzls1BoxtQnMTOMiFS2UGW+6wBA9q3K0ujT/
         qJ6J79cTIRIE0BTPmPu6gvme7LZ0v1G5APb2RbZbU81QyBltt27GjrtoEkxrQAOzaXXZ
         yYLOp54yOXcMrwagJfWaX0ls24Kjkd/bMKPv50QQe66wVfKOZnHb1OqixWW5bs6n5RTp
         YJCjd+VzWfL174gRUf2jzCaIDT8cDrBJvo0+8ARJk5A+nq+lzjaQ0CeG6ZDXbyNd+d3J
         wP+Q==
X-Gm-Message-State: ALoCoQk54GjO6rB37RsKNjn1r0itAngBd2Nevv0bvwxUrOcfWsqH42js71g5aOgqho4Ywx+Wdig4
X-Received: by 10.50.134.195 with SMTP id pm3mr51634421igb.0.1419968208796;
 Tue, 30 Dec 2014 11:36:48 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 30 Dec 2014 11:36:48 -0800 (PST)
In-Reply-To: <CAGZ79kZsQpvNzGPYuS64Cx2hFoozcb2HxU9Chd1__5=kkE-WjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261937>

On Tue, Dec 30, 2014 at 10:25 AM, Stefan Beller <sbeller@google.com> wrote:
> Should this be s/current/previous/. Technically the current commit seems
> correct to me, but it was crafted in the previous lines of the instruction sheet
> so it feels like it's a commit which is already done and we're
> currently looking at the
> commit which should be squashed into the HEAD.

This would also support consistency with the help given in the
instruction sheet.
    #  s, squash = use commit, but meld into previous commit
