From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] fast-export: add --signed-tags=warn-strip mode
Date: Mon, 15 Apr 2013 22:32:28 -0700
Message-ID: <20130416053228.GB14567@elie.Belkin>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk>
 <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
 <CAGdFq_jCO_+qj87rtcFyFG2tot8Ah2706X2dm82F6=GBV-g6nw@mail.gmail.com>
 <7vk3o3nktl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 07:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URyVS-0007nD-VF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 07:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab3DPFcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 01:32:35 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:39134 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab3DPFce (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 01:32:34 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so77491dad.29
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 22:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bDsrMKSfSHpp5HK6lq0yh6E1M5cUBh4iAYgefK68pX0=;
        b=g2Bo00IOSQ3eunjzu5dFXOWXFIYBAIZ4CQgyoa54GU+S+j8p1ue+rD7GZtEUemRQmR
         bykK3ILq0NSCtHHYCLrLLKO5tw5MKI+WhVyKr753MzAB9Ca0fvhJJJyL0wseD/OG5hHp
         bVXCouHcMCL1ssnmZcTXbpYufJYjJEmHMm1rrl0h0XdSx2zC3xlQE8J93TsecZW02xzv
         DOr0uI3Kc5hXb+6WPrXry+tW4LXMfCsQ2BA1RqU+fZ8iIEXYZ6dTSQWAFwq3KZWiqQm0
         x4k/HR5wkbjRI6eLlArDDCEXKGOThFglZsYz1DhFi5CvjGF/hFX+iDvVjw0dt+RhoSCS
         kU+Q==
X-Received: by 10.66.117.196 with SMTP id kg4mr1557174pab.95.1366090353752;
        Mon, 15 Apr 2013 22:32:33 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id to7sm1187891pab.0.2013.04.15.22.32.31
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 22:32:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk3o3nktl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221368>

Junio C Hamano wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:

>> Perhaps it makes sense to instead count the number of signed tags and
>> emit "Stripped signature from %d tags"? For example, for git.git it
>> would be on the order of a hundred warning lines.
>
> When you see 78 in the output and you know you have 92 tags in the
> repository, is that sufficient to let you go on, or do we also need
> an easy way to tell which ones are those 78 that were stripped and
> the remaining 14 were not stripped?

I suspect the actually relevant information is

	warning: stripping signature before pushing signed tags

The count and the list of signed tags are not too important.
