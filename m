From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/3] clone: add t5614 to test cloning submodules with
 shallowness involved
Date: Mon, 25 Apr 2016 10:41:48 -0700
Message-ID: <CAGZ79kbL7VyimptOtOkrx=OvVw_Zdbfxq=J+JSUJXanFweYzNQ@mail.gmail.com>
References: <1460504929-19208-1-git-send-email-sbeller@google.com>
	<1460504929-19208-4-git-send-email-sbeller@google.com>
	<CA+P7+xppaK9d77h74j-4K=oWftdkeJE7048+PMzLS6gBS3E_uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:41:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aukWB-0006h5-9c
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbcDYRlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:41:51 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36877 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbcDYRlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:41:50 -0400
Received: by mail-ig0-f177.google.com with SMTP id g8so80890698igr.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LFll1SC3ja/8gGwb0F3fJOJgHbVpydxMiNHw99Rg1Ek=;
        b=DURlwcERfEjdmC1b5aJYHGnwweZxRv/NLK4I7yFfbwBvuPfyAYs2Sguwd65VhlhgEL
         B1rIvC/Ur2SUcqvOMqhMX6kv+79jPorvJ2MGCFEU9euNeqAQ98J1019DG5iqyxO1rnbD
         2iSA5RAq7+W9vOYf6tqctenJXmtbx2qIj/oGVHL52Y9wx31dirkoOaX6+ECVtAu0R8m9
         jsxHdW7ZigUlW7Jvpj+grt1kImRzrZ/yyfzdXoKWWr2lgUyP+t+ahxlYyWPP0bxRXg4X
         p3m4NuMYL9WMNdCgUpfxH7PIg1jlZmUkXcSoWYCkBKS76cSePmVrSBzp0NQBC3MN4WM4
         F/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LFll1SC3ja/8gGwb0F3fJOJgHbVpydxMiNHw99Rg1Ek=;
        b=SG0hGfDO91e4YaNsszgPpYf4xCjklV4zGr3ikZ3xcQ5Pqk45XEhKZ31wLyQafub6lx
         /S4nQhOmpHvpibfxMs+6PK4g0kkl0QDR/iTaVmhWQMjnmQDdE8jUz1w7ujsFAyN3EC5J
         +vuatL9/Q/2lZuVykUy4k0zF1Xqla6FsgvgwKAwCcTg6gXptda8BFmhTpWHJ095blRR/
         tXxp3x+b02ZzN/LJoipDd397PXWNKWol84eHF3cSqs1FtPVlo5g19TTrARjL3BG96o35
         7MfJWCJG001fji3nqZuLV9BxSRXtugJKjEkUz5qYGM35y1/iTs06PKw5eZIDdzM1jMLK
         k9mA==
X-Gm-Message-State: AOPr4FV5KD/Ikw98B8N4uxen1x3l7odE9Wt2hVsP8wd8bMnhca1dde5zQYFm6BFx6ROIOvvWJbHAqYAEsIAMKapK
X-Received: by 10.50.57.50 with SMTP id f18mr14203673igq.93.1461606109021;
 Mon, 25 Apr 2016 10:41:49 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 10:41:48 -0700 (PDT)
In-Reply-To: <CA+P7+xppaK9d77h74j-4K=oWftdkeJE7048+PMzLS6gBS3E_uQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292532>

On Tue, Apr 12, 2016 at 11:52 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Apr 12, 2016 at 4:48 PM, Stefan Beller <sbeller@google.com> wrote:
>> There are some inherent issues with shallow clones and submodules, such
>> as having not having a commit available the superproject may point to
>> in the submodule due to being shallow. Use the new file t5614 to document
>> and test expectations in this area.
>>
>
> The description seems to imply that there will be
> "test_expect_failure" tests to indicate what needs to be improved...
> Maybe I am just mis-reading it?

That commit message certainly reads like that. I'll tone it down to
just say it's testing
the shallowness.

Lars wrote:
>> +test_expect_success 'shallow clone implies shallow submodule' '
>> +     test_when_finished "rm -rf super_clone" &&
>> +     git clone --recurse-submodules --no-local --depth 1 . super_clone &&
>
> You could add another commit to the super repo and then clone with "--depth 2".
> The super repo would then contain 2 lines and the submodule still just 1.
> This would make it more obvious that shallow submodules always have a depth of 1.

ok will fix.
