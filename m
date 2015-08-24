From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v4] git-p4: fix faulty paths for case insensitive systems
Date: Mon, 24 Aug 2015 14:49:43 +0100
Message-ID: <CAE5ih78OAm=i6BEGpZc40EQ6MwJOcEgLHEBsEPq5XyDw6xcu2A@mail.gmail.com>
References: <1440177578-5317-1-git-send-email-larsxschneider@gmail.com>
	<CAE5ih7_zTP-5WFtPfEcgVsG-sV6k2BhfYh5Z_ttS0oVvJx4NgA@mail.gmail.com>
	<24F604FE-6052-4250-80CD-3C366FE5D8DC@gmail.com>
	<CAE5ih78P2-oiZTY-d_5NYgchG3mh4FVy8GaNmBhicmmceU2k8w@mail.gmail.com>
	<FB860908-F176-4EA3-A2D1-962E97BD12F7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 15:50:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTs8P-0002X0-QM
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 15:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbbHXNtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 09:49:45 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35288 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbbHXNtn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 09:49:43 -0400
Received: by oiew67 with SMTP id w67so80529463oie.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uPFS1xW3NAEa2wwzyaFHGFVpd0eJe9OWiCof7h19L/g=;
        b=KHCGvNe7xGJTivStlDVgIrH9DDuMZnjh6ZsLQ1Phx7DRJuG6zAJxhyWHlO4Zd+XQMZ
         2SIP+bhUksTrZtsujRDJ0dse4TOqv5XAfwchBG66nzAEZN5toxRIno2L5/azEA0NA6ou
         RS5h9CJd98YnW3fgGoKNEKVnBkDd3xFxQHZTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uPFS1xW3NAEa2wwzyaFHGFVpd0eJe9OWiCof7h19L/g=;
        b=mz+pKynPFM+0i4Fm9CernoLTY92s9pn3MOQylroJxZDj5Gt1ZpF8yObzz7czAh3YnM
         cH3Ffcxxm0X9VzCYcmSqPZN7QlFSHaSppTBxuvHeQ8j6kXxthi6Gm6mYxA4kGrZP1D1S
         sLR+5rLB+Vk4Fz7JXnNhMQ3R4np9xh4wQlg6OepEtZhe2hQ3oqKQ9WSpvuhnMb3jcUNv
         yR4C/3hfNSBoVtUU8BQscCZNvafEWLqqJJty0WnMcX95x1OBB/PhzD52v0VOfzXbqxA3
         n2RhZsFerNrZ9bXCpS9wPGkwYb1AkNf2BJ3T67q8QkwEOYVCVByCFks7CBuJzE+FteD0
         ZFow==
X-Gm-Message-State: ALoCoQnC1pkV5wDv+Ch4HCLlEKpRWuglU39ki93YRKOZ59pqg6Do9P5gsreq5F9GMXTUDI7kx8nx
X-Received: by 10.202.198.212 with SMTP id w203mr20243571oif.72.1440424183429;
 Mon, 24 Aug 2015 06:49:43 -0700 (PDT)
Received: by 10.60.162.5 with HTTP; Mon, 24 Aug 2015 06:49:43 -0700 (PDT)
In-Reply-To: <FB860908-F176-4EA3-A2D1-962E97BD12F7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276447>

On 24 August 2015 at 13:43, Lars Schneider <larsxschneider@gmail.com> w=
rote:
>>
>> https://github.com/luked99/quick-git-p4-case-folding-test
> As mentioned I realized that the problem occurs only if you use clien=
t specs. Can you take a look at this test case / run it?
> https://github.com/larsxschneider/git/blob/d3a191cb5fb4d8f5f48ca9314c=
772169d5dbf65b/t/t9821-git-p4-path-variations.sh#L112-L127
>
> Does this make sense to you? If you want to I could also modify =E2=80=
=9Cquick-git-p4-case-folding-test=E2=80=9D to show the problem.

If you're able to fix my hacky test to show the problem that would be v=
ery kind.

If the problem only shows up when using client specs, is it possible
that the core.ignorecase logic is just missing a code path somewhere?

Glancing through the code, stripRepoPath() could perhaps be the
culprit? If self.useClientSpec is FALSE, it will do the
core.ignorecase trick by calling p4PathStartsWith, but if it is TRUE,
it won't.

Thanks!
Luke
