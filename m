From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] New send-email option smtpserveroptions.
Date: Sat, 4 Sep 2010 17:57:32 +0000
Message-ID: <AANLkTinnoBUp139iXxA=p1Q3bMJStk=a+FiZbzN9q6rv@mail.gmail.com>
References: <1283616372-3340-1-git-send-email-pascal@obry.net>
	<1283616372-3340-3-git-send-email-pascal@obry.net>
	<7v4oe5xyxd.fsf@alter.siamese.dyndns.org>
	<4C827657.3000508@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sat Sep 04 19:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orwzi-00007g-QA
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 19:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab0IDR5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 13:57:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56648 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab0IDR5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 13:57:33 -0400
Received: by iwn5 with SMTP id 5so2651868iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=2z2KLPaddCsVnUdy4hVdgZJ3ash79owdRM2trtkdpio=;
        b=VYeaczrcsgrnh6UEFgYuUCL99IthmrvWudcWXmhIts1YYPHAS2N3WsEgCw8r1OZw4A
         Zh3t0kT8zfSPe51TnlaTAP+nZvZ1PESNghE6sTW+VbVLOjsOBP0AhePdEsQFRYCjA0re
         Uepq6zLVrqncqHdIQsj2ZpSNEysHns4wZgltY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Cvvo5ku/5XX61Znha/EzUiySPXpyN/Hb072o/J+YEe1XXtnRqd8qGMAp1osUMxbp8d
         OH7LlHrJgt6n8oiZ5X+bFDYxg+vE0OG7WUWFK2NwphqiGvHCprT7ZtGmWeE+7J8dOQvn
         +4yLR7588N3j3x3vqW3hDFktA0jcce1SmOkzc=
Received: by 10.231.85.206 with SMTP id p14mr3161038ibl.89.1283623052346; Sat,
 04 Sep 2010 10:57:32 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 4 Sep 2010 10:57:32 -0700 (PDT)
In-Reply-To: <4C827657.3000508@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155344>

On Sat, Sep 4, 2010 at 16:39, Pascal Obry <pascal.obry@gmail.com> wrote:

> For sure this is above my expertise in Perl. As I said I have never
> worked with Perl. If someone gives me some pointers I can give it a try
> otherwise I surrender :)

The best option, as Junio points out is to accumulate options with
--smtp-server-option=. The alternative is to to to parse shell
syntax. E.g. --options='--foo="bar blah" --foo=..' means you can't
split on \s+.

See the \@to option in GetOptions for how to do that.
