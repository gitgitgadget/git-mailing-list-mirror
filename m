From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] rev-parse test: use test_cmp instead of "test" builtin
Date: Tue, 3 Sep 2013 17:01:18 -0500
Message-ID: <CAMP44s0a38N4ruQtgzcAR7e0H9pUscSA1hA355-QE64ZaN8cKw@mail.gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke>
	<20130903170419.GA29921@google.com>
	<20130903170715.GD29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 00:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGyf9-0003Ez-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 00:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761085Ab3ICWBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 18:01:21 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:46808 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760504Ab3ICWBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 18:01:20 -0400
Received: by mail-lb0-f179.google.com with SMTP id x18so5514495lbi.38
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4OKG7/mbsJJQ9EHGse5LslaD0lbrbz5OHmt8ReSCZEU=;
        b=f0lIDUJqSXiagIKdL/Lbwczh+D1ZHE6uPiO0Grc1GIICx3J66PPB/rwl7Buiry3GiW
         k+JwLTH/csJO/1TqDprj926N1aK65QHIWvAcDENqPM0yhAtQgZ12ZYfiYMowqn3ORSmO
         pt3afVoxBwchxfPvqH7/kk5u7YQyDd0PosZAW/nuyll4Xj9LsV7Roqy9hzuyEHUIes/I
         4LYpPfGtMBub+CksCn4vjQm7g84sV350E+HLsS0vStJ1Tvjk8Vhcsrg60POPlSlG5QCo
         9tw5EPmAsaibqRkxy3YpP+7A1wl6x4OyclJ7K0vlQQ0J13NhAXTw2IbNoPoFHY2I4Me9
         cUHw==
X-Received: by 10.152.6.97 with SMTP id z1mr9139694laz.26.1378245678911; Tue,
 03 Sep 2013 15:01:18 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 15:01:18 -0700 (PDT)
In-Reply-To: <20130903170715.GD29921@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233788>

On Tue, Sep 3, 2013 at 12:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>  test_expect_success 'start^0' '
> -       test $(cat .git/refs/tags/start) = $(git rev-parse start^0)
> +       test_cmp_rev_output tags/start "git rev-parse start^0"
>  '

Backwards and yodaish this is.

-- 
Felipe Contreras
