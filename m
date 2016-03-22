From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [RFC_PATCHv4 4/7] submodule init: redirect stdout to stderr
Date: Tue, 22 Mar 2016 17:56:38 +0100
Message-ID: <CAHGBnuMJdW=s5nX3c8xFk_Q2cwMb8EZjOpRim+4mULkDAvd11A@mail.gmail.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-5-git-send-email-sbeller@google.com>
	<CAHGBnuMs4D0LeMvdcS0yzKoQgmE+UTb+QFfOkSy7T20PbH86UQ@mail.gmail.com>
	<xmqqd1qmjxrl.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaASKUGs3y9YHUp=QeD=91by4DhJh+tVfj6aNOJSH-3jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 17:56:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiPbo-00035S-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 17:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055AbcCVQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 12:56:41 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33848 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcCVQ4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 12:56:39 -0400
Received: by mail-vk0-f43.google.com with SMTP id e185so262133775vkb.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/a0PZd8dgk/BXJVxlvS1sSp+PWxWgQRRIFUMj0SeEro=;
        b=Ktnp84s0O9oKb89ngumnmxZnVI59HciEt0Ic9oMjlxPWYKyanZIUh8UnjS36TK/PEm
         Qc101M7l/WGWvGRbOGQtgZqwb2RfnRDUzrL3Tv8HpqKUXMnIgJzJvZZEhfiLsvXvkrDG
         FgWzo5fopPslyHJl5B602HFyjAwDua0j+HH7t2f71W/pLvr+iaI98fLnaPkQjAuDN5F/
         acV132eTo1171iSfn+F+cKVDYaYXeVAkF713NC8Ie9JZEMIUcXlqwVW1FVojSzc25+vL
         eXR0aYIJjfiVf3iNk9tNbieM9pbNgcffq5A9p7fyPAE4y7aG5GIhRAMGFKwTkYyaIdmY
         5R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/a0PZd8dgk/BXJVxlvS1sSp+PWxWgQRRIFUMj0SeEro=;
        b=mWzqC3iEFUf8jjA0YmICy6jbXtClzaUWk8kK1OS1k/KgTcF960nC9Mon2JxMEMxXFX
         b6CRYfiHqU6pS52M8X/CsugwyvIs9PIIOjuuA9W0KgWlm4NDHXgycdP/xgIpX8/HJKZs
         PbkRdNWHjF5Hjp2NGEV7q3R7AfYIWhxDUzHTh2otKYXQrm9ck7Ade6+JzvjN8AFtWqk0
         tykizZRahHZAuYzPs1pRxJXqhDYvwH6a+IoKpD8qxZ7rle6W6nGG1HCla44oVhqtY8MY
         6JNLMTsH/SGhBnBbcxFqTJmyx0gumkQH2lnmEaCJo1K+8P7ltMU2gRBgbTNUYnVT4tzg
         xjUw==
X-Gm-Message-State: AD7BkJKERIwdyv9sBQI38HaK043gizI8KoZx2JJe8JQg71G2PeAW/Uv/8P9yKbw51frba0Wzv2yBkD77LiI7qg==
X-Received: by 10.31.160.6 with SMTP id j6mr37615894vke.87.1458665798393; Tue,
 22 Mar 2016 09:56:38 -0700 (PDT)
Received: by 10.176.68.6 with HTTP; Tue, 22 Mar 2016 09:56:38 -0700 (PDT)
In-Reply-To: <CAGZ79kaASKUGs3y9YHUp=QeD=91by4DhJh+tVfj6aNOJSH-3jg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289516>

On Tue, Mar 22, 2016 at 5:47 PM, Stefan Beller <sbeller@google.com> wrote:

> I think the stance of Git is to write only machine readable stuff to stdout,
> and essentially all _(translated) stuff (i.e. human readable) goes to stderr as
> some sort of help or progress indication.

Thanks for the clarification.

-- 
Sebastian Schuberth
