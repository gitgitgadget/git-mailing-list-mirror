From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 09/11] config: add core.untrackedCache
Date: Fri, 22 Jan 2016 16:56:38 -0800
Message-ID: <CAGZ79kZzPOQ=w98bvGNMtb_AMd4+GvNBiDop14J6rp3aW6z72g@mail.gmail.com>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
	<1453283984-8979-10-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 01:56:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMmVc-00087B-Ov
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbcAWA4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:56:47 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35929 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcAWA4j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:56:39 -0500
Received: by mail-ig0-f173.google.com with SMTP id z14so2776820igp.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n+la0FhkvZ6eve2/PPYvRjzyvPlmKIn0/xxBoRDgQQE=;
        b=nfvXCDWMcepdWIS7FmUygWG/S873Xj3CFgFTqREjzTcO5SRjTzNGlQ9BZKBOST9G7c
         PHrY0mKzWTtjupYmosM/8UWadgfaZ6ANcZvrRMvic+mj+YXflYvdTf15FEaqVw8ZGAr4
         Vm7RgYQBMthvxM0Hxa6LPaz4/p1+n8Vhv4O6SqskVfru+lLljBVdWozTiZnRL4e1YgnR
         ZXwYhhjcp3ToOk3p5fumVfHq8kA2GqBFJyDNHVstiQaWLinbv2hyWONQQ+Ob60cCTzBk
         bmI7RVTpkZQ5FT3ev5xd/I4i0WAluxHh8rsFq5LVZSi4ZRgI5ZJScYKhvvLChxIN3ofH
         +HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=n+la0FhkvZ6eve2/PPYvRjzyvPlmKIn0/xxBoRDgQQE=;
        b=MrjFuQWzaX6q7A63DwnDXVdb237xLQch7reR4U4PEv+qbmkNiLYt76H9EzeShKrULE
         31a0vGutjcSNeXH9Hh6x+zkWKmwVYL7/uhDpCtG0xIm0NNnte9vLUhe4QWcIOKlbuXSY
         eyduw8Qa18I2uDCCtT/FhVeXr8K3/cL+nTgOefpWSHGpdN/WoODYbbdgsAB7iT7NddLI
         OwxCI+BuqRnNW/qcXTB9Nhv2JT+z2bA4Y6y8nMBuERbpKL/TYZgASEFZHcjTeF1PzMc0
         fQk/xdXz/fPWKeYWzA7ACZsOgNN7wl9iE9m7quHSf84uhhC4xbNzF1Dw55fT2auV/9U7
         wc3w==
X-Gm-Message-State: AG10YOQF9mlf34baqUvrBY3H4aFsapGlxrK8zVwpwhxYunOJxEFz0u+RXstfCnUCVzmqJ3JRD+RAejeqfBHoyojN
X-Received: by 10.50.28.105 with SMTP id a9mr6668207igh.94.1453510598345; Fri,
 22 Jan 2016 16:56:38 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Fri, 22 Jan 2016 16:56:38 -0800 (PST)
In-Reply-To: <1453283984-8979-10-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284619>

On Wed, Jan 20, 2016 at 1:59 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> When we know that mtime on directory the environment gives us is
> usable for the purpose of untracked cache, we may want the
> untracked cache to be always used by default without any mtime
> test or kernel name check being performed.

I had to read this twice to understand, how about:

    When we know that mtime on directory as given by the environment
    is usable for the purpose of untracked cache, we may want the
    untracked cache to be always used without any mtime
    test or kernel name check being performed.
