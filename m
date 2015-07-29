From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Wed, 29 Jul 2015 11:56:18 -0700
Message-ID: <xmqqtwsm94j1.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
	<xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
	<xmqqy4hy973q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 20:56:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKWWf-0006YR-5L
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 20:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbbG2S4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 14:56:21 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35657 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbG2S4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 14:56:20 -0400
Received: by pdrg1 with SMTP id g1so10370343pdr.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=B31s6VBJ3tm0MjL1F345Eh9ewYsl9S9GdOj0DqG1IF0=;
        b=M+0tmdpyT4fIA5FlUq0mBkH+Yl9YfUwaCl+8fGCG3eXlWnZhzzx5prankQjuWZTq25
         PYkwT4pJbGZCCFbPDnI26IQlk9cCxhs8zkFFFKj/NUBUyWSsEoO7xkj/w6mW1pIRCpWl
         lLAes2ANXvIW47XrKtbp2lheqtC3LRDJ7Ad2RxqM4qNTAg7B57xHt3t+KkTPanShbZOn
         0tgBHgKEOJKmo+9AMzPp8ZzVprv489gvAo/oCQY0BaIMERub8kzPsVKCVfGg2a8xvFDZ
         0sDD0d8SQ0MqPUSiAWm9r4+SKD3xOxnMniiBu3HnzoV8RiDnsCKdlK3/qukBweMbbuCp
         9aUQ==
X-Received: by 10.70.128.226 with SMTP id nr2mr97869239pdb.139.1438196179863;
        Wed, 29 Jul 2015 11:56:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id tm3sm42365785pac.44.2015.07.29.11.56.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 11:56:18 -0700 (PDT)
In-Reply-To: <xmqqy4hy973q.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Jul 2015 11:00:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274936>

Junio C Hamano <gitster@pobox.com> writes:

>> Couldn't think of a better replacer, any suggestions would be welcome :)
>
> See below.
> ...
> One way to do all of the above is ...

Note that is just "one way", not the only or not necessarily the
best.  It certainly is not the easiest, I think.

    %(if:atom)...%(endif)

might be easier to implement.
