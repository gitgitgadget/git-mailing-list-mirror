From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 0/4] submodule config lookup API
Date: Mon, 10 Aug 2015 12:23:08 -0700
Message-ID: <CAGZ79kakGg6Ejworq5xVr2QuzLHxh=E6tzU_PoW+0M6AWuKJfg@mail.gmail.com>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
	<xmqq8ubk7idb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 21:23:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOsfD-00064U-O0
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 21:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbbHJTXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 15:23:12 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:32863 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbbHJTXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 15:23:09 -0400
Received: by ykaz130 with SMTP id z130so40805982yka.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iup2HUAktzbX3PR7xTpaWV7KgDxQSw/MEQK/W+P+3Lk=;
        b=j5OV1c1+dUnD4D7F9jqpi0emPhaaXtxIS6JJQv30ti2cmib1ocVUHn5THjAPHgn9+H
         sU7WhE26uAVnlAGSDLYCNwlXGx526XbuNl6eQhkS35kAqLstb5+Q0EMhvk6nLdCdJacM
         OruJtjD5Pjtc52czTUbY3fCIBM0gnejSMEErT49sJEBhxHtX5avhm98d4+oZUKIs2Wx8
         kSVDku/BzkXQfmdVoSOwo9Qzos7o4VGop3uAWWnDoUXN6sT2VXLPvGBnpbHxgY/nKmEE
         evRVVD+iGCqFCKbOfcmjbZimulve5ysWpVCRGNiSMRNGtni+hqoWxbq/WFYkh1ibMATI
         ZcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=iup2HUAktzbX3PR7xTpaWV7KgDxQSw/MEQK/W+P+3Lk=;
        b=bB6BP6TgSDLfqs2I0ayorLxPiYLi8lgY67uz5NdbX1SN10NIHrpd2xom/mT4KjulQJ
         Auvn/ojTbn3lWx/j8YevCBdz2bgmFpZf/nUiEnXm/WPsKKUkB9fO77VlPUmyhvRjnr1H
         XLT0rL9wVcDsQzn6BEB98sAH/CHfnrAfymtz7WqLKXD/i6C0KU86ve5eeL/j4rHHbVcN
         s17Re8zLT9ckQUQpOGwSTB7we7NAo0EFk6mufFTP08NlkU8kJmEn7SARTQHo0I90IyyD
         fADSs0+qu8ZOsBEvt6QL4APO3KxKn97HVQ9OWqyRFn+ymugHC96bpVuxc1OhtZvkEPbY
         7LRg==
X-Gm-Message-State: ALoCoQl7VwkA7gKb62hTJAhSh/W6uyWuJSOZkQmDNgu6kNYQglP03HjnOtDKyp1F+j7a5cXWvlEC
X-Received: by 10.13.192.132 with SMTP id b126mr22700874ywd.163.1439234588630;
 Mon, 10 Aug 2015 12:23:08 -0700 (PDT)
Received: by 10.37.214.205 with HTTP; Mon, 10 Aug 2015 12:23:08 -0700 (PDT)
In-Reply-To: <xmqq8ubk7idb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275651>

On Mon, Jun 15, 2015 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  Will replace and wait for comments from others.

I have reviewed the patches carefully and they look good to me.

As Git is a large project and I was active in other parts until now,
I noticed that there are subtle differences in style as when compared
to the refs code. One example would be the way comments are written.
In d378e35d256348f (Patch 1, implement submodule config API for
lookup of .gitmodules values) the comments for the data structures in
submodule-config.c seem to have a non exposed "headline" and if more
is needed proper sentences with capitalized starts and punctuation at the
end. In the refs code there are only sentences IIRC. Most of the commits
touching submodule.{c,h} do not prefix their commit message with
"submodule:"

The style is no show stopper of course, just an observation from someone
moving into a different area of code.

Thanks,
Stefan
